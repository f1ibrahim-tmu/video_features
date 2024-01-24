#!/bin/bash
# This script is to run the program one video at a time automatically (video paths variable takes a list of video path inputs), and ensure that each folder has only one videos.
#

for ARGUMENT in "$@"; do
	KEY=$(echo $ARGUMENT | cut -f1 -d=)

	KEY_LENGTH=${#KEY}
	VALUE="${ARGUMENT:$KEY_LENGTH+1}"

	export "$KEY"="$VALUE"
done

# Specify the root directory
videos_dir="/data/i5O/i5OData/undercover-left/videos/"
echo $videos_dir

# -------------------------------------------------------------------------------------------------

# Check if the directory exists
if [ -d "$videos_dir" ]; then
    # Find directories and their files
    for folder in $(find "$videos_dir" -mindepth 1 -maxdepth 1 -type d); do
      for file in $(find "$folder" -maxdepth 1 -type f -name "*.mp4"); do
        # Append to lst without space in the beginning
        if [ -z "$lst" ]; then
            lst="$file"
        else
            lst="$lst,$file"
        fi
      done
    done 
else
    echo "Directory $videos_dir does not exist."
fi

lst="[$lst]"

# run the script
python3 ./main.py \
  feature_type=i3d \
  device="cuda:0" \
  video_paths=$lst \
  output_path="/data/fady/aar/TemporalMaxer/data/i5O_redo" \
  on_extraction="save_numpy" 
