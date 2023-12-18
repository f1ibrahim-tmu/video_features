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
  output_path="/data/fady/aar/TemporalMaxer/data/i5O/features_i3d/" \
  on_extraction="save_numpy" 


# -------------------------------------------------------------------------------------------------

# # Check if the directory exists
# if [ -d "$videos_dir" ]; then
#     # Iterate through directories found by find and list files
#     find "$videos_dir" -mindepth 1 -maxdepth 1 -type d | while read -r folder; do
#         # echo "Folder: $folder"
#         # echo "Files in $folder:"
#         # ls -p "$folder" | grep -v /

#         find "$folder" -maxdepth 1 -type f -name "*.mp4" | while read -r file; do
#             echo $file
#         done
#     done
# else
#     echo "Directory $videos_dir does not exist."
# fi


# -------------------------------------------------

# # build lst
# lst="["

# count=0
# for vid in $(find "$i5O_videos" -name "*.mp4"); do

#   # ensure that there is at least 20GB of data left
#   if [ $(expr $(df -B1 /data/ | awk 'NR==2 {print $4}') / 1000000000) -gt 10 ]; then

# 	# unset IFS
# 	# set +f
#   echo $vid
#   if [[ $count -ne 0 ]]; then
#     lst="$lst, $vid"
#   else
#     lst="${lst}${vid}"
#   fi

#   count=$(expr $count + 1)

#   IFS=$'\n'
# 	set -f

#   fi

# done

# lst="$lst]"
# echo $lst

# # run the script
# python ./main.py \
#   feature_type=i3d \
#   device="cuda:0" \
#   video_paths=$lst \
#   output_path="/data/fady/aar/TemporalMaxer/data/i5O/features_i3d/ \
#   on_extraction="save_numpy"


# unset IFS
# set +f
