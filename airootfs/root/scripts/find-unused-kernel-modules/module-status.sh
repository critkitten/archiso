#!/bin/bash

declare -A all_modules # 0 module is used 1 module is not used

#
# Note when ls shows module some modules have names separated by `_`
# In the very same time files that contains this modules might have `-`
# Example:
# /usr/lib/modules/5.11.9-200.fc33.x86_64/kernel/arch/x86/crypto/ghash-clmulni-intel.ko.xz - file
# [Alex@NormandySR2 i686]$ lsmod | grep 'ghash' 
# ghash_clmulni_intel    16384  0
# At the very same time, I didn't find any module that has `-` reported by lsmod
# [Alex@NormandySR2 i686]$ lsmod |grep '-'


# I know that for and find is fragile, but it's the simplest way
for i in $(find /lib/modules/$(uname -r) -type f -name '*.ko*'); do 
    module_name=$(basename $i);
    # used {module_name%.*}, but cut with is simpler, and works with multiple extensions like .ko.xz
    module_without_extension=$(echo $module_name | cut -f 1 -d '.')
    # replace - with _ 
    module_name_normalized=$(echo $module_without_extension | sed 's/-/_/g')
    all_modules[$module_name_normalized]=1
done

# Note that `lsmod` output starts with "Module Size Used By " that's why sed is used
IFS=$'\n'
for i in $(lsmod | sed '1d;$d'); do 
    module_name=$(echo $i | awk '{print $1}')
    echo "$module_name"
    # check module from lsmod is in all modules
    if [[ -v all_modules[$module_name] ]]; then
        all_modules[$module_name]=0
    else
        echo "Warning! There is no $module_name module in all_modules array - adding it to all modules but you should check"
        all_modules[$module_name]=0
    fi
done

# print output
for i in "${!all_modules[@]}"
do
  if [ ${all_modules[$i]} -eq 0 ]; then
      echo "$i LOADED"
  else
      echo "$i UNLOADED"
  fi
done

