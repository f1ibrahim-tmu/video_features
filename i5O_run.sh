#!/bin/bash
# This script is to run the program one video at a time automatically (video paths variable takes a list of video path inputs), and ensure that each folder has only one videos.
#

IFS=$'\n'
set -f

for ARGUMENT in "$@"; do
	KEY=$(echo $ARGUMENT | cut -f1 -d=)

	KEY_LENGTH=${#KEY}
	VALUE="${ARGUMENT:$KEY_LENGTH+1}"

	export "$KEY"="$VALUE"
done

# Specify the root directory
videos_dir="/data/i5O/i5OData/undercover-left/videos/"

echo $videos_dir

# Variable to store the list of video paths
lst="["

# Check if the directory exists
if [ -d "$videos_dir" ]; then
    # List all folders (directories) within the specified directory
    echo "Folders in $videos_dir:"
    while IFS= read -r -d '' folder; do
        echo "$folder"

        # Find .mp4 files in the folder and append their paths to lst
        while IFS= read -r -d '' video; do
            lst+="\"$video\", "
        done < <(find "$folder" -type f -name "*.mp4" -print0)
    done < <(find "$videos_dir" -mindepth 1 -maxdepth 1 -type d -print0)
    
    # Remove the last comma and space
    lst="${lst%, }"
else
    echo "Directory $videos_dir does not exist."
fi

# Finalize the list variable
lst+="]"

# Print the generated list of video paths
echo "Generated list of video paths:"
echo "$lst"


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
