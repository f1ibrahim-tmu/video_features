#!/bin/bash
# This script is to run the program one video at a time automatically, and ensure that each folder has only one videos.
#

IFS=$'\n'
set -f

for ARGUMENT in "$@"; do
	KEY=$(echo $ARGUMENT | cut -f1 -d=)

	KEY_LENGTH=${#KEY}
	VALUE="${ARGUMENT:$KEY_LENGTH+1}"

	export "$KEY"="$VALUE"
done

i5O_videos="/data/i5O/i5OData/undercover-left/videos/"

# -------------------------------------------------

# build lst
lst="["

count=0
for vid in $(find $i5O_videos -name); do

  # ensure that there is at least 20GB of data left
  if [ $(expr $(df -B1 /data/ | awk 'NR==2 {print $4}') / 1000000000) -gt 10 ]; then

	unset IFS
	set +f
 
  if [[ $count -ne 0 ]]; then
    lst="$lst, $vid"
  else
    lst="${lst}${vid}"
  fi

  count=$(expr $count + 1)

  IFS=$'\n'
	set -f

  fi

done

lst="$lst]"
print lst

# run the script
# python ./main.py \
#   feature_type=i3d \
#   device="cuda:0" \
#   video_paths=$lst \
#   output_path="/root/models/video_features/output/" \
#   on_extraction="save_numpy"



unset IFS
set +f
