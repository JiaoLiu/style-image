import numpy as np
import tensorflow as tf
import ast
import os
from tensorflow.python import pywrap_tensorflow

from matplotlib import pyplot
from matplotlib.pyplot import imshow

import image_utils
import model
import ops
import argparse
import sys


num_styles = 32
imgWidth = 512
imgHeight = 512
channel = 3
checkpoint = "/Users/Jiao/Desktop/TFProject/style-image/checkpoint/multistyle-pastiche-generator-varied.ckpt"
newCkp = "/Users/Jiao/Desktop/TFProject/style-image/checkpoint/multistyle-pastiche-generator-varied.ckpt-1"

# inputImage = np.expand_dims(image_utils.load_np_image(os.path.expanduser("/Users/Jiao/Desktop/TFProject/prisma/data/content.jpg")),0)
inputImage = tf.placeholder(tf.float32,shape=[None,imgWidth,imgHeight,channel],name="input")
styles = tf.placeholder(tf.float32,shape=[num_styles],name="style")

def _style_mixture(which_styles, num_styles):
  """Returns a 1-D array mapping style indexes to weights."""
  mixture = np.zeros([num_styles], dtype=np.float32)
  for index in which_styles:
    mixture[index] = which_styles[index]
  return mixture

def print_tensors_in_checkpoint_file(file_name, tensor_name, all_tensors):
  """Prints tensors in a checkpoint file.

  If no `tensor_name` is provided, prints the tensor names and shapes
  in the checkpoint file.

  If `tensor_name` is provided, prints the content of the tensor.

  Args:
    file_name: Name of the checkpoint file.
    tensor_name: Name of the tensor in the checkpoint file to print.
    all_tensors: Boolean indicating whether to print all tensors.
  """
  try:
    reader = pywrap_tensorflow.NewCheckpointReader(file_name)
    if all_tensors:
      var_to_shape_map = reader.get_variable_to_shape_map()
      for key in var_to_shape_map:
        print("tensor_name: ", key)
        tensor = reader.get_tensor(key)
        print(tensor.shape)
        print(reader.get_tensor(key))
    elif not tensor_name:
      print(reader.debug_string().decode("utf-8"))
    else:
      print("tensor_name: ", tensor_name)
      tensor = reader.get_tensor(tensor_name)
      # tf.where(tf.is_nan(tensor), tf.zeros_like(tensor), tensor).eval()
      print(tensor)
  except Exception as e:  # pylint: disable=broad-except
    print(str(e))
    if "corrupted compressed block contents" in str(e):
      print("It's likely that your checkpoint file has been compressed "
            "with SNAPPY.")
    if ("Data loss" in str(e) and
        (any([e in file_name for e in [".index", ".meta", ".data"]]))):
      proposed_file = ".".join(file_name.split(".")[0:-1])
      v2_file_error_template = """
It's likely that this is a V2 checkpoint and you need to provide the filename
*prefix*.  Try removing the '.' and extension.  Try:
inspect checkpoint --file_name = {}"""
      print(v2_file_error_template.format(proposed_file))

with tf.name_scope(""):
    # mixture = _style_mixture({18: 1.0}, num_styles)
    transform = model.transform(inputImage,
                            normalizer_fn=ops.weighted_instance_norm,
                            normalizer_params={
                                # 'weights': tf.constant(mixture),
                                'weights' : styles,
                                'num_categories': num_styles,
                                'center': True,
                                'scale': True})

model_saver = tf.train.Saver(tf.global_variables())

with tf.Session() as sess:
    # for node in sess.graph.as_graph_def().node:
    #     print node
    # print_tensors_in_checkpoint_file(newCkp,tensor_name="transformer/contract/conv1/weights",all_tensors=True)
    # tf.train.write_graph(sess.graph_def, "/Users/Jiao/Desktop/TFProject/style-image/protobuf", "input.pb")
    checkpoint = os.path.expanduser(newCkp)
    if tf.gfile.IsDirectory(checkpoint):
        checkpoint = tf.train.latest_checkpoint(checkpoint)
        tf.logging.info('loading latest checkpoint file: {}'.format(checkpoint))
    model_saver.restore(sess, checkpoint)

    reader = pywrap_tensorflow.NewCheckpointReader(checkpoint)
    var_to_shape_map = reader.get_variable_to_shape_map()
    for key in var_to_shape_map:
        W = sess.graph.as_graph_element(key+":0")
        if (len(W.shape) == 4):
            P = tf.transpose(W, perm=[3, 0, 1, 2])
            Y = tf.where(tf.is_nan(P), tf.zeros(P.get_shape()), P).eval()
            name = key.replace("/", "_")
            print name,Y
            Y.tofile("/Users/Jiao/Desktop/TFProject/style-image/parameters/" + name)
        # Y = tf.constant(0.25,shape=W.get_shape()).eval()
        X = tf.where(tf.is_nan(W), tf.zeros(W.get_shape()), W).eval()
        W = tf.assign(W,X).eval()
        # name = key.replace("/", "_")
        # W.tofile("/Users/Jiao/Desktop/TFProject/style-image/parameters/" + name)
        # W = tf.assign(W, tf.zeros(W.get_shape())).eval()
    # W = sess.graph.get_tensor_by_name("transformer/contract/conv1/weights:0")
    newstyle = np.zeros([num_styles], dtype=np.float32)
    newstyle[31] = 1
    newImage = np.expand_dims(image_utils.load_np_image(os.path.expanduser("/Users/Jiao/Desktop/IMG_0898.JPG")),0)
    # newImage = np.zeros((1,imgWidth,imgHeight,channel))
    # newImage = tf.constant(255,shape=[1,imgWidth,imgHeight,channel]).eval()
    style_image = transform.eval(feed_dict={inputImage:newImage,styles:newstyle})
    # style_image = output.eval(feed_dict={inputImage:newImage})
    # style_image = style_image[0]
    # print(style_image)
    # imshow(style_image)
    # pyplot.show()
    # model_saver.save(sess, newCkp)


