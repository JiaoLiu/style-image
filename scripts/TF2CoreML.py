from matplotlib import pyplot
from matplotlib.pyplot import imshow
import tfcoreml
import numpy as np
import image_utils
import os

tf_model_path = '../protobuf/stylize_quantized.pb'

mlmodel = tfcoreml.convert(
        tf_model_path = tf_model_path,
        mlmodel_path = '../mlmodel/stylize.mlmodel',
        output_feature_names = ['transformer/expand/conv3/conv/Sigmoid:0'],
        input_name_shape_dict = {'input:0':[1,512,512,3], 'style_num:0':[26]})

# test model
newstyle = np.zeros([26], dtype=np.float32)
newstyle[23] = 1
newImage = np.expand_dims(image_utils.load_np_image(os.path.expanduser("../sample.jpg")), 0)
newImage = newImage.reshape((512,512,3))
imshow(newImage)
pyplot.show()

coreml_image_input = np.transpose(newImage, (2,0,1))
coreml_style_index = newstyle[:,np.newaxis,np.newaxis,np.newaxis,np.newaxis]
coreml_input = {'input__0': coreml_image_input, 'style_num__0': coreml_style_index}
coreml_out = mlmodel.predict(coreml_input, useCPUOnly = True)['transformer__expand__conv3__conv__Sigmoid__0']
coreml_out = np.transpose(coreml_out, (1,2,0))
imshow(coreml_out)
pyplot.show()