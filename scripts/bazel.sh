cd /Users/Jiao/Desktop/SecurityKeeper/tensorflow

bazel-bin/tensorflow/python/tools/freeze_graph \
--input_graph=/Users/Jiao/Desktop/TFProject/style-image/protobuf/input.pb --input_checkpoint=/Users/Jiao/Desktop/TFProject/style-image/checkpoint/multistyle-pastiche-generator-varied.ckpt-1 \
--output_node_names=transformer/expand/conv3/conv/Sigmoid --input_binary=False \
--output_graph=/Users/Jiao/Desktop/TFProject/style-image/protobuf/frozen.pb

bazel-bin/tensorflow/python/tools/optimize_for_inference \
--input=/Users/Jiao/Desktop/TFProject/style-image/protobuf/frozen.pb --output=/Users/Jiao/Desktop/TFProject/style-image/protobuf/inference.pb \
--input_names=input,style --output_names=transformer/expand/conv3/conv/Sigmoid \
--frozen_graph=True

bazel-bin/tensorflow/tools/quantization/quantize_graph \
--input=/Users/Jiao/Desktop/TFProject/style-image/protobuf/inference.pb \
--output=/Users/Jiao/Desktop/TFProject/style-image/protobuf/rounded_graph.pb \
--output_node_names=transformer/expand/conv3/conv/Sigmoid  \
--mode=eightbit
#--mode=weights_rounded
