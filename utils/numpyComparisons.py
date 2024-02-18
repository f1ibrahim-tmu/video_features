import numpy as np

# Load the numpy arrays
rgb = np.load('i3d/undercover-left_20220412_074307_rgb.npy')
flow = np.load('i3d/undercover-left_20220412_074307_flow.npy')
concat = np.load('i3d/concat/undercover-left_20220412_074307_concat.npy')

# Get the size of the arrays
rgb_size = rgb.shape
flow_size = flow.shape
concat_size = concat.shape

# Print the array size
print("RGB size:", rgb_size)
print("Flow size:", flow_size)
print("Concat size:", concat_size)
