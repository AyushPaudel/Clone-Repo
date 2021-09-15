#! /bin/bash 
# ./clone.sh <name.csv>



mkdir -p lab3
mkdir -p lab4

IFS=","
cloned_repo1=()
cloned_repo2=()

error_repo1=()
error_repo2=()

while read -r repo1 repo2 
do
	timeout 10 git -C repo1/ clone $repo1 && cloned_repo1+=($repo1) || error_repo1+=($repo1)
	timeout 10 git -C repo2/ clone $repo2 && cloned_repo2+=($repo2) || error_repo2+=($repo2)
done < $1

function save_arr_to_file {
	filename="$1"
	shift
	local arr=("$@") 
	for error in "${arr[@]}"
	do
		echo "$error" >> $filename
	done
}
save_arr_to_file repo1_error.txt "${error_repo1[@]}" 
save_arr_to_file repo2_error.txt "${error_repo1[@]}" 
