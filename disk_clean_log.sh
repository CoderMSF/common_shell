#!/bin/bash
cd ~
base_dir=$(pwd)/myservice/
declare -a next_arr
declare -a nnext_arr
echo "$base_dir"
current_space=$(df -h | grep '/dev/vda1' | awk '{print $5}')
current_space_no=${current_space%%%}
if [ $current_space_no -gt 93 ]; then
    echo "clear data"
    list_dir=$(du -d1 -h $base_dir | awk '{print $2}')
    IFS=$'\n';
    list_dir_set=($list_dir)
    unset IFS;
    i=0
    for item in "${list_dir_set[@]}";do
        fname=${item}
        xxx=${fname##*/}
        if [ ! $xxx ]; then
            continue
        fi
        next_arr[$i]=$xxx
        i=$(($i+1))
        #echo $i
    done
    for idir in "${next_arr[@]}";do
        delete_dir_file="${base_dir}${idir}/"
        temp_file_name=$(du -d1 -h $delete_dir_file | awk '{print $2}')
        IFS=$'\n';
        temp_file_name_set=($temp_file_name)
        unset IFS;
        j=0
        for iitem in "${temp_file_name_set[@]}";do
            ffname=${iitem}
            xxxx=${ffname##*/}
            if [ ! $xxxx ]; then
                continue
            fi
            nnext_arr[$j]=$xxxx
            j=$(($j+1))
        done
        for iidir in "${nnext_arr[@]}";do
            final_delete_dir_file="${base_dir}${idir}/${iidir}/log/*.log"
            final_delete_dir_file_1="${base_dir}${idir}/${iidir}/log/*.log.*"
            rm $final_delete_dir_file $final_delete_dir_file_1
            if [ $? = 0 ]; then
                echo "$final_delete_dir_file $final_delete_dir_file_1 文件删除完成！"
            else
                echo "$final_delete_dir_file $final_delete_dir_file_1 文件不存在！"
            fi
        done
    done
else
    echo "low"
fi
