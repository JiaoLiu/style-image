node {
  name: "input"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
      }
    }
  }
}
node {
  name: "style"
  op: "Placeholder"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
      }
    }
  }
}
node {
  name: "transformer/contract/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\004\000\000\000\004\000\000\000\004\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/MirrorPad"
  op: "MirrorPad"
  input: "input"
  input: "transformer/contract/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/contract/conv1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\t\000\000\000\t\000\000\000\003\000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/contract/conv1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/contract/conv1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/contract/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/contract/conv1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/contract/conv1/weights/Initializer/random_normal/mul"
  input: "transformer/contract/conv1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 9
        }
        dim {
          size: 9
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv1/weights/Assign"
  op: "Assign"
  input: "transformer/contract/conv1/weights"
  input: "transformer/contract/conv1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/weights/read"
  op: "Identity"
  input: "transformer/contract/conv1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\t\000\000\000\t\000\000\000\003\000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/convolution"
  op: "Conv2D"
  input: "transformer/contract/MirrorPad"
  input: "transformer/contract/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/contract/conv1/InstanceNorm/beta"
  input: "transformer/contract/conv1/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/contract/conv1/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/contract/conv1/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/contract/conv1/InstanceNorm/Reshape"
  input: "transformer/contract/conv1/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/contract/conv1/InstanceNorm/mul"
  input: "transformer/contract/conv1/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/contract/conv1/InstanceNorm/Sum"
  input: "transformer/contract/conv1/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/contract/conv1/InstanceNorm/ExpandDims"
  input: "transformer/contract/conv1/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 32
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/contract/conv1/InstanceNorm/gamma"
  input: "transformer/contract/conv1/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/contract/conv1/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/contract/conv1/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/contract/conv1/InstanceNorm/Reshape_1"
  input: "transformer/contract/conv1/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/contract/conv1/InstanceNorm/mul_1"
  input: "transformer/contract/conv1/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/contract/conv1/InstanceNorm/Sum_1"
  input: "transformer/contract/conv1/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/contract/conv1/InstanceNorm/ExpandDims_2"
  input: "transformer/contract/conv1/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/contract/conv1/convolution"
  input: "transformer/contract/conv1/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/contract/conv1/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 262144.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/contract/conv1/convolution"
  input: "transformer/contract/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/contract/conv1/convolution"
  input: "transformer/contract/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/contract/conv1/InstanceNorm/moments/StopGradient"
  input: "transformer/contract/conv1/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/contract/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/contract/conv1/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/contract/conv1/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/contract/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/contract/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/contract/conv1/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/contract/conv1/InstanceNorm/moments/normalize/Mul"
  input: "transformer/contract/conv1/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/contract/conv1/InstanceNorm/moments/normalize/variance"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/contract/conv1/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/contract/conv1/convolution"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/contract/conv1/InstanceNorm/moments/normalize/mean"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/contract/conv1/InstanceNorm/ExpandDims_1"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/mul_1"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv1/Relu"
  op: "Relu"
  input: "transformer/contract/conv1/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/MirrorPad_1/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/MirrorPad_1"
  op: "MirrorPad"
  input: "transformer/contract/conv1/Relu"
  input: "transformer/contract/MirrorPad_1/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/contract/conv2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000 \000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/contract/conv2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/contract/conv2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/contract/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/contract/conv2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/contract/conv2/weights/Initializer/random_normal/mul"
  input: "transformer/contract/conv2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 32
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv2/weights/Assign"
  op: "Assign"
  input: "transformer/contract/conv2/weights"
  input: "transformer/contract/conv2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/weights/read"
  op: "Identity"
  input: "transformer/contract/conv2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000 \000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/convolution"
  op: "Conv2D"
  input: "transformer/contract/MirrorPad_1"
  input: "transformer/contract/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/contract/conv2/InstanceNorm/beta"
  input: "transformer/contract/conv2/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/contract/conv2/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/contract/conv2/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/contract/conv2/InstanceNorm/Reshape"
  input: "transformer/contract/conv2/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/contract/conv2/InstanceNorm/mul"
  input: "transformer/contract/conv2/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/contract/conv2/InstanceNorm/Sum"
  input: "transformer/contract/conv2/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/contract/conv2/InstanceNorm/ExpandDims"
  input: "transformer/contract/conv2/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 64
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/contract/conv2/InstanceNorm/gamma"
  input: "transformer/contract/conv2/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/contract/conv2/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/contract/conv2/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/contract/conv2/InstanceNorm/Reshape_1"
  input: "transformer/contract/conv2/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/contract/conv2/InstanceNorm/mul_1"
  input: "transformer/contract/conv2/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/contract/conv2/InstanceNorm/Sum_1"
  input: "transformer/contract/conv2/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/contract/conv2/InstanceNorm/ExpandDims_2"
  input: "transformer/contract/conv2/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/contract/conv2/convolution"
  input: "transformer/contract/conv2/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/contract/conv2/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 65536.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/contract/conv2/convolution"
  input: "transformer/contract/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/contract/conv2/convolution"
  input: "transformer/contract/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/contract/conv2/InstanceNorm/moments/StopGradient"
  input: "transformer/contract/conv2/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/contract/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/contract/conv2/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/contract/conv2/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/contract/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/contract/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/contract/conv2/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/contract/conv2/InstanceNorm/moments/normalize/Mul"
  input: "transformer/contract/conv2/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/contract/conv2/InstanceNorm/moments/normalize/variance"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/contract/conv2/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/contract/conv2/convolution"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/contract/conv2/InstanceNorm/moments/normalize/mean"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/contract/conv2/InstanceNorm/ExpandDims_1"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/mul_1"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv2/Relu"
  op: "Relu"
  input: "transformer/contract/conv2/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/MirrorPad_2/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/MirrorPad_2"
  op: "MirrorPad"
  input: "transformer/contract/conv2/Relu"
  input: "transformer/contract/MirrorPad_2/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/contract/conv3/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000@\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/contract/conv3/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/contract/conv3/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/contract/conv3/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/contract/conv3/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/contract/conv3/weights/Initializer/random_normal/mul"
  input: "transformer/contract/conv3/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 64
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv3/weights/Assign"
  op: "Assign"
  input: "transformer/contract/conv3/weights"
  input: "transformer/contract/conv3/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/weights/read"
  op: "Identity"
  input: "transformer/contract/conv3/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000@\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/convolution"
  op: "Conv2D"
  input: "transformer/contract/MirrorPad_2"
  input: "transformer/contract/conv3/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 2
        i: 2
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/contract/conv3/InstanceNorm/beta"
  input: "transformer/contract/conv3/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/contract/conv3/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/contract/conv3/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/contract/conv3/InstanceNorm/Reshape"
  input: "transformer/contract/conv3/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/contract/conv3/InstanceNorm/mul"
  input: "transformer/contract/conv3/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/contract/conv3/InstanceNorm/Sum"
  input: "transformer/contract/conv3/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/contract/conv3/InstanceNorm/ExpandDims"
  input: "transformer/contract/conv3/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/contract/conv3/InstanceNorm/gamma"
  input: "transformer/contract/conv3/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/contract/conv3/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/contract/conv3/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/contract/conv3/InstanceNorm/Reshape_1"
  input: "transformer/contract/conv3/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/contract/conv3/InstanceNorm/mul_1"
  input: "transformer/contract/conv3/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/contract/conv3/InstanceNorm/Sum_1"
  input: "transformer/contract/conv3/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/contract/conv3/InstanceNorm/ExpandDims_2"
  input: "transformer/contract/conv3/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/contract/conv3/convolution"
  input: "transformer/contract/conv3/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/contract/conv3/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/contract/conv3/convolution"
  input: "transformer/contract/conv3/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/contract/conv3/convolution"
  input: "transformer/contract/conv3/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/contract/conv3/InstanceNorm/moments/StopGradient"
  input: "transformer/contract/conv3/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/contract/conv3/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/contract/conv3/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/contract/conv3/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/contract/conv3/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/contract/conv3/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/contract/conv3/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/contract/conv3/InstanceNorm/moments/normalize/Mul"
  input: "transformer/contract/conv3/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/contract/conv3/InstanceNorm/moments/normalize/variance"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/contract/conv3/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/contract/conv3/convolution"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/contract/conv3/InstanceNorm/moments/normalize/mean"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/contract/conv3/InstanceNorm/ExpandDims_1"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/mul_1"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/contract/conv3/Relu"
  op: "Relu"
  input: "transformer/contract/conv3/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/MirrorPad"
  op: "MirrorPad"
  input: "transformer/contract/conv3/Relu"
  input: "transformer/residual/residual1/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual1/conv1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual1/conv1/weights"
  input: "transformer/residual/residual1/conv1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/weights/read"
  op: "Identity"
  input: "transformer/residual/residual1/conv1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual1/MirrorPad"
  input: "transformer/residual/residual1/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual1/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual1/conv1/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual1/conv1/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual1/conv1/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual1/conv1/InstanceNorm/Reshape"
  input: "transformer/residual/residual1/conv1/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual1/conv1/InstanceNorm/mul"
  input: "transformer/residual/residual1/conv1/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual1/conv1/InstanceNorm/Sum"
  input: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual1/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual1/conv1/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual1/conv1/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual1/conv1/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual1/conv1/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual1/conv1/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual1/conv1/InstanceNorm/mul_1"
  input: "transformer/residual/residual1/conv1/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual1/conv1/InstanceNorm/Sum_1"
  input: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual1/conv1/convolution"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual1/conv1/convolution"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual1/conv1/convolution"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual1/conv1/convolution"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual1/conv1/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual1/conv1/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv1/Relu"
  op: "Relu"
  input: "transformer/residual/residual1/conv1/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/MirrorPad_1/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/MirrorPad_1"
  op: "MirrorPad"
  input: "transformer/residual/residual1/conv1/Relu"
  input: "transformer/residual/residual1/MirrorPad_1/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual1/conv2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual1/conv2/weights"
  input: "transformer/residual/residual1/conv2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/weights/read"
  op: "Identity"
  input: "transformer/residual/residual1/conv2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual1/MirrorPad_1"
  input: "transformer/residual/residual1/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual1/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual1/conv2/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual1/conv2/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual1/conv2/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual1/conv2/InstanceNorm/Reshape"
  input: "transformer/residual/residual1/conv2/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual1/conv2/InstanceNorm/mul"
  input: "transformer/residual/residual1/conv2/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual1/conv2/InstanceNorm/Sum"
  input: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual1/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual1/conv2/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual1/conv2/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual1/conv2/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual1/conv2/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual1/conv2/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual1/conv2/InstanceNorm/mul_1"
  input: "transformer/residual/residual1/conv2/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual1/conv2/InstanceNorm/Sum_1"
  input: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual1/conv2/convolution"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual1/conv2/convolution"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual1/conv2/convolution"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual1/conv2/convolution"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual1/conv2/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual1/conv2/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual1/add"
  op: "Add"
  input: "transformer/contract/conv3/Relu"
  input: "transformer/residual/residual1/conv2/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/MirrorPad"
  op: "MirrorPad"
  input: "transformer/residual/residual1/add"
  input: "transformer/residual/residual2/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual2/conv1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual2/conv1/weights"
  input: "transformer/residual/residual2/conv1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/weights/read"
  op: "Identity"
  input: "transformer/residual/residual2/conv1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual2/MirrorPad"
  input: "transformer/residual/residual2/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual2/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual2/conv1/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual2/conv1/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual2/conv1/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual2/conv1/InstanceNorm/Reshape"
  input: "transformer/residual/residual2/conv1/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual2/conv1/InstanceNorm/mul"
  input: "transformer/residual/residual2/conv1/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual2/conv1/InstanceNorm/Sum"
  input: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual2/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual2/conv1/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual2/conv1/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual2/conv1/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual2/conv1/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual2/conv1/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual2/conv1/InstanceNorm/mul_1"
  input: "transformer/residual/residual2/conv1/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual2/conv1/InstanceNorm/Sum_1"
  input: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual2/conv1/convolution"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual2/conv1/convolution"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual2/conv1/convolution"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual2/conv1/convolution"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual2/conv1/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual2/conv1/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv1/Relu"
  op: "Relu"
  input: "transformer/residual/residual2/conv1/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/MirrorPad_1/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/MirrorPad_1"
  op: "MirrorPad"
  input: "transformer/residual/residual2/conv1/Relu"
  input: "transformer/residual/residual2/MirrorPad_1/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual2/conv2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual2/conv2/weights"
  input: "transformer/residual/residual2/conv2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/weights/read"
  op: "Identity"
  input: "transformer/residual/residual2/conv2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual2/MirrorPad_1"
  input: "transformer/residual/residual2/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual2/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual2/conv2/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual2/conv2/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual2/conv2/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual2/conv2/InstanceNorm/Reshape"
  input: "transformer/residual/residual2/conv2/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual2/conv2/InstanceNorm/mul"
  input: "transformer/residual/residual2/conv2/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual2/conv2/InstanceNorm/Sum"
  input: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual2/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual2/conv2/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual2/conv2/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual2/conv2/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual2/conv2/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual2/conv2/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual2/conv2/InstanceNorm/mul_1"
  input: "transformer/residual/residual2/conv2/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual2/conv2/InstanceNorm/Sum_1"
  input: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual2/conv2/convolution"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual2/conv2/convolution"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual2/conv2/convolution"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual2/conv2/convolution"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual2/conv2/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual2/conv2/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual2/add"
  op: "Add"
  input: "transformer/residual/residual1/add"
  input: "transformer/residual/residual2/conv2/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/MirrorPad"
  op: "MirrorPad"
  input: "transformer/residual/residual2/add"
  input: "transformer/residual/residual3/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual3/conv1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual3/conv1/weights"
  input: "transformer/residual/residual3/conv1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/weights/read"
  op: "Identity"
  input: "transformer/residual/residual3/conv1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual3/MirrorPad"
  input: "transformer/residual/residual3/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual3/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual3/conv1/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual3/conv1/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual3/conv1/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual3/conv1/InstanceNorm/Reshape"
  input: "transformer/residual/residual3/conv1/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual3/conv1/InstanceNorm/mul"
  input: "transformer/residual/residual3/conv1/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual3/conv1/InstanceNorm/Sum"
  input: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual3/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual3/conv1/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual3/conv1/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual3/conv1/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual3/conv1/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual3/conv1/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual3/conv1/InstanceNorm/mul_1"
  input: "transformer/residual/residual3/conv1/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual3/conv1/InstanceNorm/Sum_1"
  input: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual3/conv1/convolution"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual3/conv1/convolution"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual3/conv1/convolution"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual3/conv1/convolution"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual3/conv1/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual3/conv1/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv1/Relu"
  op: "Relu"
  input: "transformer/residual/residual3/conv1/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/MirrorPad_1/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/MirrorPad_1"
  op: "MirrorPad"
  input: "transformer/residual/residual3/conv1/Relu"
  input: "transformer/residual/residual3/MirrorPad_1/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual3/conv2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual3/conv2/weights"
  input: "transformer/residual/residual3/conv2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/weights/read"
  op: "Identity"
  input: "transformer/residual/residual3/conv2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual3/MirrorPad_1"
  input: "transformer/residual/residual3/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual3/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual3/conv2/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual3/conv2/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual3/conv2/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual3/conv2/InstanceNorm/Reshape"
  input: "transformer/residual/residual3/conv2/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual3/conv2/InstanceNorm/mul"
  input: "transformer/residual/residual3/conv2/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual3/conv2/InstanceNorm/Sum"
  input: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual3/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual3/conv2/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual3/conv2/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual3/conv2/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual3/conv2/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual3/conv2/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual3/conv2/InstanceNorm/mul_1"
  input: "transformer/residual/residual3/conv2/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual3/conv2/InstanceNorm/Sum_1"
  input: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual3/conv2/convolution"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual3/conv2/convolution"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual3/conv2/convolution"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual3/conv2/convolution"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual3/conv2/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual3/conv2/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual3/add"
  op: "Add"
  input: "transformer/residual/residual2/add"
  input: "transformer/residual/residual3/conv2/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/MirrorPad"
  op: "MirrorPad"
  input: "transformer/residual/residual3/add"
  input: "transformer/residual/residual4/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual4/conv1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual4/conv1/weights"
  input: "transformer/residual/residual4/conv1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/weights/read"
  op: "Identity"
  input: "transformer/residual/residual4/conv1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual4/MirrorPad"
  input: "transformer/residual/residual4/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual4/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual4/conv1/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual4/conv1/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual4/conv1/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual4/conv1/InstanceNorm/Reshape"
  input: "transformer/residual/residual4/conv1/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual4/conv1/InstanceNorm/mul"
  input: "transformer/residual/residual4/conv1/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual4/conv1/InstanceNorm/Sum"
  input: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual4/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual4/conv1/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual4/conv1/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual4/conv1/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual4/conv1/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual4/conv1/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual4/conv1/InstanceNorm/mul_1"
  input: "transformer/residual/residual4/conv1/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual4/conv1/InstanceNorm/Sum_1"
  input: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual4/conv1/convolution"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual4/conv1/convolution"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual4/conv1/convolution"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual4/conv1/convolution"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual4/conv1/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual4/conv1/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv1/Relu"
  op: "Relu"
  input: "transformer/residual/residual4/conv1/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/MirrorPad_1/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/MirrorPad_1"
  op: "MirrorPad"
  input: "transformer/residual/residual4/conv1/Relu"
  input: "transformer/residual/residual4/MirrorPad_1/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual4/conv2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual4/conv2/weights"
  input: "transformer/residual/residual4/conv2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/weights/read"
  op: "Identity"
  input: "transformer/residual/residual4/conv2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual4/MirrorPad_1"
  input: "transformer/residual/residual4/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual4/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual4/conv2/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual4/conv2/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual4/conv2/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual4/conv2/InstanceNorm/Reshape"
  input: "transformer/residual/residual4/conv2/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual4/conv2/InstanceNorm/mul"
  input: "transformer/residual/residual4/conv2/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual4/conv2/InstanceNorm/Sum"
  input: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual4/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual4/conv2/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual4/conv2/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual4/conv2/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual4/conv2/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual4/conv2/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual4/conv2/InstanceNorm/mul_1"
  input: "transformer/residual/residual4/conv2/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual4/conv2/InstanceNorm/Sum_1"
  input: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual4/conv2/convolution"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual4/conv2/convolution"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual4/conv2/convolution"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual4/conv2/convolution"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual4/conv2/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual4/conv2/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual4/add"
  op: "Add"
  input: "transformer/residual/residual3/add"
  input: "transformer/residual/residual4/conv2/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/MirrorPad"
  op: "MirrorPad"
  input: "transformer/residual/residual4/add"
  input: "transformer/residual/residual5/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual5/conv1/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual5/conv1/weights"
  input: "transformer/residual/residual5/conv1/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/weights/read"
  op: "Identity"
  input: "transformer/residual/residual5/conv1/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual5/MirrorPad"
  input: "transformer/residual/residual5/conv1/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual5/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual5/conv1/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual5/conv1/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual5/conv1/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual5/conv1/InstanceNorm/Reshape"
  input: "transformer/residual/residual5/conv1/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual5/conv1/InstanceNorm/mul"
  input: "transformer/residual/residual5/conv1/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual5/conv1/InstanceNorm/Sum"
  input: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual5/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual5/conv1/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual5/conv1/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual5/conv1/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual5/conv1/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual5/conv1/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual5/conv1/InstanceNorm/mul_1"
  input: "transformer/residual/residual5/conv1/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual5/conv1/InstanceNorm/Sum_1"
  input: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual5/conv1/convolution"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual5/conv1/convolution"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual5/conv1/convolution"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual5/conv1/convolution"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual5/conv1/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual5/conv1/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv1/Relu"
  op: "Relu"
  input: "transformer/residual/residual5/conv1/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/MirrorPad_1/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/MirrorPad_1"
  op: "MirrorPad"
  input: "transformer/residual/residual5/conv1/Relu"
  input: "transformer/residual/residual5/MirrorPad_1/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/mul"
  input: "transformer/residual/residual5/conv2/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights/Assign"
  op: "Assign"
  input: "transformer/residual/residual5/conv2/weights"
  input: "transformer/residual/residual5/conv2/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/weights/read"
  op: "Identity"
  input: "transformer/residual/residual5/conv2/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000\200\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/convolution"
  op: "Conv2D"
  input: "transformer/residual/residual5/MirrorPad_1"
  input: "transformer/residual/residual5/conv2/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/residual/residual5/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual5/conv2/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/residual/residual5/conv2/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual5/conv2/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/residual/residual5/conv2/InstanceNorm/Reshape"
  input: "transformer/residual/residual5/conv2/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/residual/residual5/conv2/InstanceNorm/mul"
  input: "transformer/residual/residual5/conv2/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/residual/residual5/conv2/InstanceNorm/Sum"
  input: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims"
  input: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 128
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 128
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/residual/residual5/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual5/conv2/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/residual/residual5/conv2/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/residual/residual5/conv2/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual5/conv2/InstanceNorm/Reshape_1"
  input: "transformer/residual/residual5/conv2/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/residual/residual5/conv2/InstanceNorm/mul_1"
  input: "transformer/residual/residual5/conv2/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/residual/residual5/conv2/InstanceNorm/Sum_1"
  input: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_2"
  input: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/residual/residual5/conv2/convolution"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 16384.0
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/residual/residual5/conv2/convolution"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/residual/residual5/conv2/convolution"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/StopGradient"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/Mul"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/variance"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/residual/residual5/conv2/convolution"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/residual/residual5/conv2/InstanceNorm/moments/normalize/mean"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/residual/residual5/conv2/InstanceNorm/ExpandDims_1"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/mul_1"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/residual/residual5/add"
  op: "Add"
  input: "transformer/residual/residual4/add"
  input: "transformer/residual/residual5/conv2/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/ResizeNearestNeighbor/size"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\001\000\000\000\001\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/ResizeNearestNeighbor"
  op: "ResizeNearestNeighbor"
  input: "transformer/residual/residual5/add"
  input: "transformer/expand/conv1/ResizeNearestNeighbor/size"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "align_corners"
    value {
      b: false
    }
  }
}
node {
  name: "transformer/expand/conv1/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/MirrorPad"
  op: "MirrorPad"
  input: "transformer/expand/conv1/ResizeNearestNeighbor"
  input: "transformer/expand/conv1/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/expand/conv1/conv/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/expand/conv1/conv/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/expand/conv1/conv/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/expand/conv1/conv/weights/Initializer/random_normal/mul"
  input: "transformer/expand/conv1/conv/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 128
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights/Assign"
  op: "Assign"
  input: "transformer/expand/conv1/conv/weights"
  input: "transformer/expand/conv1/conv/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/weights/read"
  op: "Identity"
  input: "transformer/expand/conv1/conv/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000\200\000\000\000@\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/convolution"
  op: "Conv2D"
  input: "transformer/expand/conv1/MirrorPad"
  input: "transformer/expand/conv1/conv/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 64
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/expand/conv1/conv/InstanceNorm/beta"
  input: "transformer/expand/conv1/conv/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/expand/conv1/conv/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/expand/conv1/conv/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/expand/conv1/conv/InstanceNorm/Reshape"
  input: "transformer/expand/conv1/conv/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/expand/conv1/conv/InstanceNorm/mul"
  input: "transformer/expand/conv1/conv/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/expand/conv1/conv/InstanceNorm/Sum"
  input: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims"
  input: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 64
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 64
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/expand/conv1/conv/InstanceNorm/gamma"
  input: "transformer/expand/conv1/conv/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/expand/conv1/conv/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/expand/conv1/conv/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/expand/conv1/conv/InstanceNorm/Reshape_1"
  input: "transformer/expand/conv1/conv/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/expand/conv1/conv/InstanceNorm/mul_1"
  input: "transformer/expand/conv1/conv/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/expand/conv1/conv/InstanceNorm/Sum_1"
  input: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_2"
  input: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/expand/conv1/conv/convolution"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 65536.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/expand/conv1/conv/convolution"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/expand/conv1/conv/convolution"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/StopGradient"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/Mul"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/variance"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/expand/conv1/conv/convolution"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/expand/conv1/conv/InstanceNorm/moments/normalize/mean"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/expand/conv1/conv/InstanceNorm/ExpandDims_1"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/mul_1"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv1/conv/Relu"
  op: "Relu"
  input: "transformer/expand/conv1/conv/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/ResizeNearestNeighbor/size"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/ResizeNearestNeighbor"
  op: "ResizeNearestNeighbor"
  input: "transformer/expand/conv1/conv/Relu"
  input: "transformer/expand/conv2/ResizeNearestNeighbor/size"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "align_corners"
    value {
      b: false
    }
  }
}
node {
  name: "transformer/expand/conv2/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/MirrorPad"
  op: "MirrorPad"
  input: "transformer/expand/conv2/ResizeNearestNeighbor"
  input: "transformer/expand/conv2/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000@\000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/expand/conv2/conv/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/expand/conv2/conv/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/expand/conv2/conv/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/expand/conv2/conv/weights/Initializer/random_normal/mul"
  input: "transformer/expand/conv2/conv/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 3
        }
        dim {
          size: 3
        }
        dim {
          size: 64
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights/Assign"
  op: "Assign"
  input: "transformer/expand/conv2/conv/weights"
  input: "transformer/expand/conv2/conv/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/weights/read"
  op: "Identity"
  input: "transformer/expand/conv2/conv/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\003\000\000\000\003\000\000\000@\000\000\000 \000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/convolution"
  op: "Conv2D"
  input: "transformer/expand/conv2/MirrorPad"
  input: "transformer/expand/conv2/conv/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 32
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/expand/conv2/conv/InstanceNorm/beta"
  input: "transformer/expand/conv2/conv/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/expand/conv2/conv/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/expand/conv2/conv/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/expand/conv2/conv/InstanceNorm/Reshape"
  input: "transformer/expand/conv2/conv/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/expand/conv2/conv/InstanceNorm/mul"
  input: "transformer/expand/conv2/conv/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/expand/conv2/conv/InstanceNorm/Sum"
  input: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims"
  input: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 32
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 32
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/expand/conv2/conv/InstanceNorm/gamma"
  input: "transformer/expand/conv2/conv/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/expand/conv2/conv/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/expand/conv2/conv/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/expand/conv2/conv/InstanceNorm/Reshape_1"
  input: "transformer/expand/conv2/conv/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/expand/conv2/conv/InstanceNorm/mul_1"
  input: "transformer/expand/conv2/conv/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/expand/conv2/conv/InstanceNorm/Sum_1"
  input: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_2"
  input: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/expand/conv2/conv/convolution"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 262144.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/expand/conv2/conv/convolution"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/expand/conv2/conv/convolution"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/StopGradient"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/Mul"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/variance"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/expand/conv2/conv/convolution"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/expand/conv2/conv/InstanceNorm/moments/normalize/mean"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/expand/conv2/conv/InstanceNorm/ExpandDims_1"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/mul_1"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv2/conv/Relu"
  op: "Relu"
  input: "transformer/expand/conv2/conv/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/ResizeNearestNeighbor/size"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\000\002\000\000\000\002\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/ResizeNearestNeighbor"
  op: "ResizeNearestNeighbor"
  input: "transformer/expand/conv2/conv/Relu"
  input: "transformer/expand/conv3/ResizeNearestNeighbor/size"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "align_corners"
    value {
      b: false
    }
  }
}
node {
  name: "transformer/expand/conv3/MirrorPad/paddings"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
          dim {
            size: 2
          }
        }
        tensor_content: "\000\000\000\000\000\000\000\000\004\000\000\000\004\000\000\000\004\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/MirrorPad"
  op: "MirrorPad"
  input: "transformer/expand/conv3/ResizeNearestNeighbor"
  input: "transformer/expand/conv3/MirrorPad/paddings"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tpaddings"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "mode"
    value {
      s: "REFLECT"
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights/Initializer/random_normal/shape"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\t\000\000\000\t\000\000\000 \000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights/Initializer/random_normal/mean"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights/Initializer/random_normal/stddev"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 0.00999999977648
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights/Initializer/random_normal/RandomStandardNormal"
  op: "RandomStandardNormal"
  input: "transformer/expand/conv3/conv/weights/Initializer/random_normal/shape"
  attr {
    key: "T"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "seed"
    value {
      i: 0
    }
  }
  attr {
    key: "seed2"
    value {
      i: 0
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights/Initializer/random_normal/mul"
  op: "Mul"
  input: "transformer/expand/conv3/conv/weights/Initializer/random_normal/RandomStandardNormal"
  input: "transformer/expand/conv3/conv/weights/Initializer/random_normal/stddev"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights/Initializer/random_normal"
  op: "Add"
  input: "transformer/expand/conv3/conv/weights/Initializer/random_normal/mul"
  input: "transformer/expand/conv3/conv/weights/Initializer/random_normal/mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 9
        }
        dim {
          size: 9
        }
        dim {
          size: 32
        }
        dim {
          size: 3
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights/Assign"
  op: "Assign"
  input: "transformer/expand/conv3/conv/weights"
  input: "transformer/expand/conv3/conv/weights/Initializer/random_normal"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/weights/read"
  op: "Identity"
  input: "transformer/expand/conv3/conv/weights"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/convolution/Shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 4
          }
        }
        tensor_content: "\t\000\000\000\t\000\000\000 \000\000\000\003\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/convolution/dilation_rate"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/convolution"
  op: "Conv2D"
  input: "transformer/expand/conv3/MirrorPad"
  input: "transformer/expand/conv3/conv/weights/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "data_format"
    value {
      s: "NHWC"
    }
  }
  attr {
    key: "padding"
    value {
      s: "VALID"
    }
  }
  attr {
    key: "strides"
    value {
      list {
        i: 1
        i: 1
        i: 1
        i: 1
      }
    }
  }
  attr {
    key: "use_cudnn_on_gpu"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/beta/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 3
          }
        }
        float_val: 0.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/beta"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 3
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/beta/Assign"
  op: "Assign"
  input: "transformer/expand/conv3/conv/InstanceNorm/beta"
  input: "transformer/expand/conv3/conv/InstanceNorm/beta/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/beta/read"
  op: "Identity"
  input: "transformer/expand/conv3/conv/InstanceNorm/beta"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/Reshape/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/Reshape"
  op: "Reshape"
  input: "style"
  input: "transformer/expand/conv3/conv/InstanceNorm/Reshape/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/mul"
  op: "Mul"
  input: "transformer/expand/conv3/conv/InstanceNorm/Reshape"
  input: "transformer/expand/conv3/conv/InstanceNorm/beta/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/Sum/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/Sum"
  op: "Sum"
  input: "transformer/expand/conv3/conv/InstanceNorm/mul"
  input: "transformer/expand/conv3/conv/InstanceNorm/Sum/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims"
  op: "ExpandDims"
  input: "transformer/expand/conv3/conv/InstanceNorm/Sum"
  input: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_1/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_1"
  op: "ExpandDims"
  input: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims"
  input: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_1/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/gamma/Initializer/Const"
  op: "Const"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
          dim {
            size: 32
          }
          dim {
            size: 3
          }
        }
        float_val: 1.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/gamma"
  op: "VariableV2"
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "container"
    value {
      s: ""
    }
  }
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "shape"
    value {
      shape {
        dim {
          size: 32
        }
        dim {
          size: 3
        }
      }
    }
  }
  attr {
    key: "shared_name"
    value {
      s: ""
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/gamma/Assign"
  op: "Assign"
  input: "transformer/expand/conv3/conv/InstanceNorm/gamma"
  input: "transformer/expand/conv3/conv/InstanceNorm/gamma/Initializer/Const"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/gamma/read"
  op: "Identity"
  input: "transformer/expand/conv3/conv/InstanceNorm/gamma"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/Reshape_1/shape"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: " \000\000\000\001\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/Reshape_1"
  op: "Reshape"
  input: "style"
  input: "transformer/expand/conv3/conv/InstanceNorm/Reshape_1/shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/mul_1"
  op: "Mul"
  input: "transformer/expand/conv3/conv/InstanceNorm/Reshape_1"
  input: "transformer/expand/conv3/conv/InstanceNorm/gamma/read"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/Sum_1/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 0
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/Sum_1"
  op: "Sum"
  input: "transformer/expand/conv3/conv/InstanceNorm/mul_1"
  input: "transformer/expand/conv3/conv/InstanceNorm/Sum_1/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_2/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_2"
  op: "ExpandDims"
  input: "transformer/expand/conv3/conv/InstanceNorm/Sum_1"
  input: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_2/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_3/dim"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
        }
        int_val: 1
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_3"
  op: "ExpandDims"
  input: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_2"
  input: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_3/dim"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tdim"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/Mean/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/Mean"
  op: "Mean"
  input: "transformer/expand/conv3/conv/convolution"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/Mean/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/StopGradient"
  op: "StopGradient"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/Mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 262144.0
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/Sub"
  op: "Sub"
  input: "transformer/expand/conv3/conv/convolution"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  op: "SquaredDifference"
  input: "transformer/expand/conv3/conv/convolution"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/StopGradient"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  op: "Sum"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/Sub"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/mean_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_INT32
        tensor_shape {
          dim {
            size: 2
          }
        }
        tensor_content: "\001\000\000\000\002\000\000\000"
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  op: "Sum"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/SquaredDifference"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/var_ss/reduction_indices"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tidx"
    value {
      type: DT_INT32
    }
  }
  attr {
    key: "keep_dims"
    value {
      b: true
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/Shape"
  op: "Shape"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "out_type"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/Reshape"
  op: "Reshape"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/StopGradient"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/Shape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "Tshape"
    value {
      type: DT_INT32
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/divisor"
  op: "Reciprocal"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/Const"
  input: "^transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "^transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/shifted_mean"
  op: "Mul"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/mean_ss"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/mean"
  op: "Add"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/shifted_mean"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/Reshape"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/Mul"
  op: "Mul"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/sufficient_statistics/var_ss"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/divisor"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/Square"
  op: "Square"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/shifted_mean"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/variance"
  op: "Sub"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/Mul"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/Square"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/add/y"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_FLOAT
        tensor_shape {
        }
        float_val: 9.99999974738e-06
      }
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/add"
  op: "Add"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/variance"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/add/y"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/Rsqrt"
  op: "Rsqrt"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/add"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/mul"
  op: "Mul"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/Rsqrt"
  input: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/mul_1"
  op: "Mul"
  input: "transformer/expand/conv3/conv/convolution"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/mul_2"
  op: "Mul"
  input: "transformer/expand/conv3/conv/InstanceNorm/moments/normalize/mean"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/mul"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/sub"
  op: "Sub"
  input: "transformer/expand/conv3/conv/InstanceNorm/ExpandDims_1"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/mul_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/add_1"
  op: "Add"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/mul_1"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/sub"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "transformer/expand/conv3/conv/Sigmoid"
  op: "Sigmoid"
  input: "transformer/expand/conv3/conv/InstanceNorm/batchnorm/add_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
}
node {
  name: "save/Const"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
        }
        string_val: "model"
      }
    }
  }
}
node {
  name: "save/SaveV2/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 48
          }
        }
        string_val: "transformer/contract/conv1/InstanceNorm/beta"
        string_val: "transformer/contract/conv1/InstanceNorm/gamma"
        string_val: "transformer/contract/conv1/weights"
        string_val: "transformer/contract/conv2/InstanceNorm/beta"
        string_val: "transformer/contract/conv2/InstanceNorm/gamma"
        string_val: "transformer/contract/conv2/weights"
        string_val: "transformer/contract/conv3/InstanceNorm/beta"
        string_val: "transformer/contract/conv3/InstanceNorm/gamma"
        string_val: "transformer/contract/conv3/weights"
        string_val: "transformer/expand/conv1/conv/InstanceNorm/beta"
        string_val: "transformer/expand/conv1/conv/InstanceNorm/gamma"
        string_val: "transformer/expand/conv1/conv/weights"
        string_val: "transformer/expand/conv2/conv/InstanceNorm/beta"
        string_val: "transformer/expand/conv2/conv/InstanceNorm/gamma"
        string_val: "transformer/expand/conv2/conv/weights"
        string_val: "transformer/expand/conv3/conv/InstanceNorm/beta"
        string_val: "transformer/expand/conv3/conv/InstanceNorm/gamma"
        string_val: "transformer/expand/conv3/conv/weights"
        string_val: "transformer/residual/residual1/conv1/InstanceNorm/beta"
        string_val: "transformer/residual/residual1/conv1/InstanceNorm/gamma"
        string_val: "transformer/residual/residual1/conv1/weights"
        string_val: "transformer/residual/residual1/conv2/InstanceNorm/beta"
        string_val: "transformer/residual/residual1/conv2/InstanceNorm/gamma"
        string_val: "transformer/residual/residual1/conv2/weights"
        string_val: "transformer/residual/residual2/conv1/InstanceNorm/beta"
        string_val: "transformer/residual/residual2/conv1/InstanceNorm/gamma"
        string_val: "transformer/residual/residual2/conv1/weights"
        string_val: "transformer/residual/residual2/conv2/InstanceNorm/beta"
        string_val: "transformer/residual/residual2/conv2/InstanceNorm/gamma"
        string_val: "transformer/residual/residual2/conv2/weights"
        string_val: "transformer/residual/residual3/conv1/InstanceNorm/beta"
        string_val: "transformer/residual/residual3/conv1/InstanceNorm/gamma"
        string_val: "transformer/residual/residual3/conv1/weights"
        string_val: "transformer/residual/residual3/conv2/InstanceNorm/beta"
        string_val: "transformer/residual/residual3/conv2/InstanceNorm/gamma"
        string_val: "transformer/residual/residual3/conv2/weights"
        string_val: "transformer/residual/residual4/conv1/InstanceNorm/beta"
        string_val: "transformer/residual/residual4/conv1/InstanceNorm/gamma"
        string_val: "transformer/residual/residual4/conv1/weights"
        string_val: "transformer/residual/residual4/conv2/InstanceNorm/beta"
        string_val: "transformer/residual/residual4/conv2/InstanceNorm/gamma"
        string_val: "transformer/residual/residual4/conv2/weights"
        string_val: "transformer/residual/residual5/conv1/InstanceNorm/beta"
        string_val: "transformer/residual/residual5/conv1/InstanceNorm/gamma"
        string_val: "transformer/residual/residual5/conv1/weights"
        string_val: "transformer/residual/residual5/conv2/InstanceNorm/beta"
        string_val: "transformer/residual/residual5/conv2/InstanceNorm/gamma"
        string_val: "transformer/residual/residual5/conv2/weights"
      }
    }
  }
}
node {
  name: "save/SaveV2/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 48
          }
        }
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
        string_val: ""
      }
    }
  }
}
node {
  name: "save/SaveV2"
  op: "SaveV2"
  input: "save/Const"
  input: "save/SaveV2/tensor_names"
  input: "save/SaveV2/shape_and_slices"
  input: "transformer/contract/conv1/InstanceNorm/beta"
  input: "transformer/contract/conv1/InstanceNorm/gamma"
  input: "transformer/contract/conv1/weights"
  input: "transformer/contract/conv2/InstanceNorm/beta"
  input: "transformer/contract/conv2/InstanceNorm/gamma"
  input: "transformer/contract/conv2/weights"
  input: "transformer/contract/conv3/InstanceNorm/beta"
  input: "transformer/contract/conv3/InstanceNorm/gamma"
  input: "transformer/contract/conv3/weights"
  input: "transformer/expand/conv1/conv/InstanceNorm/beta"
  input: "transformer/expand/conv1/conv/InstanceNorm/gamma"
  input: "transformer/expand/conv1/conv/weights"
  input: "transformer/expand/conv2/conv/InstanceNorm/beta"
  input: "transformer/expand/conv2/conv/InstanceNorm/gamma"
  input: "transformer/expand/conv2/conv/weights"
  input: "transformer/expand/conv3/conv/InstanceNorm/beta"
  input: "transformer/expand/conv3/conv/InstanceNorm/gamma"
  input: "transformer/expand/conv3/conv/weights"
  input: "transformer/residual/residual1/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual1/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual1/conv1/weights"
  input: "transformer/residual/residual1/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual1/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual1/conv2/weights"
  input: "transformer/residual/residual2/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual2/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual2/conv1/weights"
  input: "transformer/residual/residual2/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual2/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual2/conv2/weights"
  input: "transformer/residual/residual3/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual3/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual3/conv1/weights"
  input: "transformer/residual/residual3/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual3/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual3/conv2/weights"
  input: "transformer/residual/residual4/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual4/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual4/conv1/weights"
  input: "transformer/residual/residual4/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual4/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual4/conv2/weights"
  input: "transformer/residual/residual5/conv1/InstanceNorm/beta"
  input: "transformer/residual/residual5/conv1/InstanceNorm/gamma"
  input: "transformer/residual/residual5/conv1/weights"
  input: "transformer/residual/residual5/conv2/InstanceNorm/beta"
  input: "transformer/residual/residual5/conv2/InstanceNorm/gamma"
  input: "transformer/residual/residual5/conv2/weights"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/control_dependency"
  op: "Identity"
  input: "save/Const"
  input: "^save/SaveV2"
  attr {
    key: "T"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@save/Const"
      }
    }
  }
}
node {
  name: "save/RestoreV2/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2/tensor_names"
  input: "save/RestoreV2/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign"
  op: "Assign"
  input: "transformer/contract/conv1/InstanceNorm/beta"
  input: "save/RestoreV2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_1/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_1/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_1"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_1/tensor_names"
  input: "save/RestoreV2_1/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_1"
  op: "Assign"
  input: "transformer/contract/conv1/InstanceNorm/gamma"
  input: "save/RestoreV2_1"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_2/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv1/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_2/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_2"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_2/tensor_names"
  input: "save/RestoreV2_2/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_2"
  op: "Assign"
  input: "transformer/contract/conv1/weights"
  input: "save/RestoreV2_2"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_3/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_3/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_3"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_3/tensor_names"
  input: "save/RestoreV2_3/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_3"
  op: "Assign"
  input: "transformer/contract/conv2/InstanceNorm/beta"
  input: "save/RestoreV2_3"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_4/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_4/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_4"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_4/tensor_names"
  input: "save/RestoreV2_4/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_4"
  op: "Assign"
  input: "transformer/contract/conv2/InstanceNorm/gamma"
  input: "save/RestoreV2_4"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_5/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv2/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_5/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_5"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_5/tensor_names"
  input: "save/RestoreV2_5/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_5"
  op: "Assign"
  input: "transformer/contract/conv2/weights"
  input: "save/RestoreV2_5"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_6/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv3/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_6/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_6"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_6/tensor_names"
  input: "save/RestoreV2_6/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_6"
  op: "Assign"
  input: "transformer/contract/conv3/InstanceNorm/beta"
  input: "save/RestoreV2_6"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_7/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv3/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_7/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_7"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_7/tensor_names"
  input: "save/RestoreV2_7/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_7"
  op: "Assign"
  input: "transformer/contract/conv3/InstanceNorm/gamma"
  input: "save/RestoreV2_7"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_8/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/contract/conv3/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_8/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_8"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_8/tensor_names"
  input: "save/RestoreV2_8/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_8"
  op: "Assign"
  input: "transformer/contract/conv3/weights"
  input: "save/RestoreV2_8"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/contract/conv3/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_9/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv1/conv/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_9/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_9"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_9/tensor_names"
  input: "save/RestoreV2_9/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_9"
  op: "Assign"
  input: "transformer/expand/conv1/conv/InstanceNorm/beta"
  input: "save/RestoreV2_9"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_10/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv1/conv/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_10/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_10"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_10/tensor_names"
  input: "save/RestoreV2_10/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_10"
  op: "Assign"
  input: "transformer/expand/conv1/conv/InstanceNorm/gamma"
  input: "save/RestoreV2_10"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_11/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv1/conv/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_11/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_11"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_11/tensor_names"
  input: "save/RestoreV2_11/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_11"
  op: "Assign"
  input: "transformer/expand/conv1/conv/weights"
  input: "save/RestoreV2_11"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv1/conv/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_12/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv2/conv/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_12/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_12"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_12/tensor_names"
  input: "save/RestoreV2_12/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_12"
  op: "Assign"
  input: "transformer/expand/conv2/conv/InstanceNorm/beta"
  input: "save/RestoreV2_12"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_13/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv2/conv/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_13/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_13"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_13/tensor_names"
  input: "save/RestoreV2_13/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_13"
  op: "Assign"
  input: "transformer/expand/conv2/conv/InstanceNorm/gamma"
  input: "save/RestoreV2_13"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_14/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv2/conv/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_14/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_14"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_14/tensor_names"
  input: "save/RestoreV2_14/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_14"
  op: "Assign"
  input: "transformer/expand/conv2/conv/weights"
  input: "save/RestoreV2_14"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv2/conv/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_15/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv3/conv/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_15/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_15"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_15/tensor_names"
  input: "save/RestoreV2_15/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_15"
  op: "Assign"
  input: "transformer/expand/conv3/conv/InstanceNorm/beta"
  input: "save/RestoreV2_15"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_16/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv3/conv/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_16/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_16"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_16/tensor_names"
  input: "save/RestoreV2_16/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_16"
  op: "Assign"
  input: "transformer/expand/conv3/conv/InstanceNorm/gamma"
  input: "save/RestoreV2_16"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_17/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/expand/conv3/conv/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_17/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_17"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_17/tensor_names"
  input: "save/RestoreV2_17/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_17"
  op: "Assign"
  input: "transformer/expand/conv3/conv/weights"
  input: "save/RestoreV2_17"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/expand/conv3/conv/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_18/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual1/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_18/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_18"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_18/tensor_names"
  input: "save/RestoreV2_18/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_18"
  op: "Assign"
  input: "transformer/residual/residual1/conv1/InstanceNorm/beta"
  input: "save/RestoreV2_18"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_19/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual1/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_19/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_19"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_19/tensor_names"
  input: "save/RestoreV2_19/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_19"
  op: "Assign"
  input: "transformer/residual/residual1/conv1/InstanceNorm/gamma"
  input: "save/RestoreV2_19"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_20/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual1/conv1/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_20/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_20"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_20/tensor_names"
  input: "save/RestoreV2_20/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_20"
  op: "Assign"
  input: "transformer/residual/residual1/conv1/weights"
  input: "save/RestoreV2_20"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_21/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual1/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_21/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_21"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_21/tensor_names"
  input: "save/RestoreV2_21/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_21"
  op: "Assign"
  input: "transformer/residual/residual1/conv2/InstanceNorm/beta"
  input: "save/RestoreV2_21"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_22/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual1/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_22/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_22"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_22/tensor_names"
  input: "save/RestoreV2_22/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_22"
  op: "Assign"
  input: "transformer/residual/residual1/conv2/InstanceNorm/gamma"
  input: "save/RestoreV2_22"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_23/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual1/conv2/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_23/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_23"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_23/tensor_names"
  input: "save/RestoreV2_23/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_23"
  op: "Assign"
  input: "transformer/residual/residual1/conv2/weights"
  input: "save/RestoreV2_23"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual1/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_24/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual2/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_24/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_24"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_24/tensor_names"
  input: "save/RestoreV2_24/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_24"
  op: "Assign"
  input: "transformer/residual/residual2/conv1/InstanceNorm/beta"
  input: "save/RestoreV2_24"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_25/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual2/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_25/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_25"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_25/tensor_names"
  input: "save/RestoreV2_25/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_25"
  op: "Assign"
  input: "transformer/residual/residual2/conv1/InstanceNorm/gamma"
  input: "save/RestoreV2_25"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_26/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual2/conv1/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_26/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_26"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_26/tensor_names"
  input: "save/RestoreV2_26/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_26"
  op: "Assign"
  input: "transformer/residual/residual2/conv1/weights"
  input: "save/RestoreV2_26"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_27/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual2/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_27/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_27"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_27/tensor_names"
  input: "save/RestoreV2_27/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_27"
  op: "Assign"
  input: "transformer/residual/residual2/conv2/InstanceNorm/beta"
  input: "save/RestoreV2_27"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_28/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual2/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_28/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_28"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_28/tensor_names"
  input: "save/RestoreV2_28/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_28"
  op: "Assign"
  input: "transformer/residual/residual2/conv2/InstanceNorm/gamma"
  input: "save/RestoreV2_28"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_29/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual2/conv2/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_29/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_29"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_29/tensor_names"
  input: "save/RestoreV2_29/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_29"
  op: "Assign"
  input: "transformer/residual/residual2/conv2/weights"
  input: "save/RestoreV2_29"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual2/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_30/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual3/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_30/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_30"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_30/tensor_names"
  input: "save/RestoreV2_30/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_30"
  op: "Assign"
  input: "transformer/residual/residual3/conv1/InstanceNorm/beta"
  input: "save/RestoreV2_30"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_31/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual3/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_31/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_31"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_31/tensor_names"
  input: "save/RestoreV2_31/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_31"
  op: "Assign"
  input: "transformer/residual/residual3/conv1/InstanceNorm/gamma"
  input: "save/RestoreV2_31"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_32/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual3/conv1/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_32/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_32"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_32/tensor_names"
  input: "save/RestoreV2_32/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_32"
  op: "Assign"
  input: "transformer/residual/residual3/conv1/weights"
  input: "save/RestoreV2_32"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_33/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual3/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_33/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_33"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_33/tensor_names"
  input: "save/RestoreV2_33/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_33"
  op: "Assign"
  input: "transformer/residual/residual3/conv2/InstanceNorm/beta"
  input: "save/RestoreV2_33"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_34/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual3/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_34/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_34"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_34/tensor_names"
  input: "save/RestoreV2_34/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_34"
  op: "Assign"
  input: "transformer/residual/residual3/conv2/InstanceNorm/gamma"
  input: "save/RestoreV2_34"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_35/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual3/conv2/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_35/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_35"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_35/tensor_names"
  input: "save/RestoreV2_35/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_35"
  op: "Assign"
  input: "transformer/residual/residual3/conv2/weights"
  input: "save/RestoreV2_35"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual3/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_36/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual4/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_36/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_36"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_36/tensor_names"
  input: "save/RestoreV2_36/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_36"
  op: "Assign"
  input: "transformer/residual/residual4/conv1/InstanceNorm/beta"
  input: "save/RestoreV2_36"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_37/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual4/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_37/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_37"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_37/tensor_names"
  input: "save/RestoreV2_37/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_37"
  op: "Assign"
  input: "transformer/residual/residual4/conv1/InstanceNorm/gamma"
  input: "save/RestoreV2_37"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_38/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual4/conv1/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_38/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_38"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_38/tensor_names"
  input: "save/RestoreV2_38/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_38"
  op: "Assign"
  input: "transformer/residual/residual4/conv1/weights"
  input: "save/RestoreV2_38"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_39/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual4/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_39/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_39"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_39/tensor_names"
  input: "save/RestoreV2_39/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_39"
  op: "Assign"
  input: "transformer/residual/residual4/conv2/InstanceNorm/beta"
  input: "save/RestoreV2_39"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_40/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual4/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_40/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_40"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_40/tensor_names"
  input: "save/RestoreV2_40/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_40"
  op: "Assign"
  input: "transformer/residual/residual4/conv2/InstanceNorm/gamma"
  input: "save/RestoreV2_40"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_41/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual4/conv2/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_41/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_41"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_41/tensor_names"
  input: "save/RestoreV2_41/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_41"
  op: "Assign"
  input: "transformer/residual/residual4/conv2/weights"
  input: "save/RestoreV2_41"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual4/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_42/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual5/conv1/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_42/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_42"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_42/tensor_names"
  input: "save/RestoreV2_42/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_42"
  op: "Assign"
  input: "transformer/residual/residual5/conv1/InstanceNorm/beta"
  input: "save/RestoreV2_42"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_43/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual5/conv1/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_43/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_43"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_43/tensor_names"
  input: "save/RestoreV2_43/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_43"
  op: "Assign"
  input: "transformer/residual/residual5/conv1/InstanceNorm/gamma"
  input: "save/RestoreV2_43"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_44/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual5/conv1/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_44/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_44"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_44/tensor_names"
  input: "save/RestoreV2_44/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_44"
  op: "Assign"
  input: "transformer/residual/residual5/conv1/weights"
  input: "save/RestoreV2_44"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv1/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_45/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual5/conv2/InstanceNorm/beta"
      }
    }
  }
}
node {
  name: "save/RestoreV2_45/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_45"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_45/tensor_names"
  input: "save/RestoreV2_45/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_45"
  op: "Assign"
  input: "transformer/residual/residual5/conv2/InstanceNorm/beta"
  input: "save/RestoreV2_45"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/beta"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_46/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual5/conv2/InstanceNorm/gamma"
      }
    }
  }
}
node {
  name: "save/RestoreV2_46/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_46"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_46/tensor_names"
  input: "save/RestoreV2_46/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_46"
  op: "Assign"
  input: "transformer/residual/residual5/conv2/InstanceNorm/gamma"
  input: "save/RestoreV2_46"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/InstanceNorm/gamma"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/RestoreV2_47/tensor_names"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: "transformer/residual/residual5/conv2/weights"
      }
    }
  }
}
node {
  name: "save/RestoreV2_47/shape_and_slices"
  op: "Const"
  attr {
    key: "dtype"
    value {
      type: DT_STRING
    }
  }
  attr {
    key: "value"
    value {
      tensor {
        dtype: DT_STRING
        tensor_shape {
          dim {
            size: 1
          }
        }
        string_val: ""
      }
    }
  }
}
node {
  name: "save/RestoreV2_47"
  op: "RestoreV2"
  input: "save/Const"
  input: "save/RestoreV2_47/tensor_names"
  input: "save/RestoreV2_47/shape_and_slices"
  attr {
    key: "dtypes"
    value {
      list {
        type: DT_FLOAT
      }
    }
  }
}
node {
  name: "save/Assign_47"
  op: "Assign"
  input: "transformer/residual/residual5/conv2/weights"
  input: "save/RestoreV2_47"
  attr {
    key: "T"
    value {
      type: DT_FLOAT
    }
  }
  attr {
    key: "_class"
    value {
      list {
        s: "loc:@transformer/residual/residual5/conv2/weights"
      }
    }
  }
  attr {
    key: "use_locking"
    value {
      b: true
    }
  }
  attr {
    key: "validate_shape"
    value {
      b: true
    }
  }
}
node {
  name: "save/restore_all"
  op: "NoOp"
  input: "^save/Assign"
  input: "^save/Assign_1"
  input: "^save/Assign_2"
  input: "^save/Assign_3"
  input: "^save/Assign_4"
  input: "^save/Assign_5"
  input: "^save/Assign_6"
  input: "^save/Assign_7"
  input: "^save/Assign_8"
  input: "^save/Assign_9"
  input: "^save/Assign_10"
  input: "^save/Assign_11"
  input: "^save/Assign_12"
  input: "^save/Assign_13"
  input: "^save/Assign_14"
  input: "^save/Assign_15"
  input: "^save/Assign_16"
  input: "^save/Assign_17"
  input: "^save/Assign_18"
  input: "^save/Assign_19"
  input: "^save/Assign_20"
  input: "^save/Assign_21"
  input: "^save/Assign_22"
  input: "^save/Assign_23"
  input: "^save/Assign_24"
  input: "^save/Assign_25"
  input: "^save/Assign_26"
  input: "^save/Assign_27"
  input: "^save/Assign_28"
  input: "^save/Assign_29"
  input: "^save/Assign_30"
  input: "^save/Assign_31"
  input: "^save/Assign_32"
  input: "^save/Assign_33"
  input: "^save/Assign_34"
  input: "^save/Assign_35"
  input: "^save/Assign_36"
  input: "^save/Assign_37"
  input: "^save/Assign_38"
  input: "^save/Assign_39"
  input: "^save/Assign_40"
  input: "^save/Assign_41"
  input: "^save/Assign_42"
  input: "^save/Assign_43"
  input: "^save/Assign_44"
  input: "^save/Assign_45"
  input: "^save/Assign_46"
  input: "^save/Assign_47"
}
versions {
  producer: 21
}
