#!/bin/bash
# Wrapper for the main.py file

#!/bin/bash
input="/data/i5O/UCF101-THUMOS/THUMOS14/actionformer_subset.txt"
data_root="/data/i5O/UCF101-THUMOS/THUMOS14/"

mkdir -p "$data_root/actionformer_subset"

while IFS= read -r video; do

  split=$(cut -d '_' -f 2 <<<$video)

  if [ $split == "validation" ]; then
    split=${split:0:3}
  fi

  cp "$data_root/$split/$split-videos/$video.mp4" "$data_root/actionformer_subset"

done < "$input"
