#!/usr/bin/bash

# Copyright (c) 2022. Huawei Technologies Co.,Ltd.ALL rights reserved.
# This program is licensed under Mulan PSL v2.
# You can use it according to the terms and conditions of the Mulan PSL v2.
#          http://license.coscl.org.cn/MulanPSL2
# THIS PROGRAM IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
# EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
# MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
# See the Mulan PSL v2 for more details.
####################################
#@Author    	:   @meitingli
#@Contact   	:   bubble_mt@outlook.com
#@Date      	:   2020-11-18
#@License   	:   Mulan PSL v2
#@Desc      	:   Take the test access of /dev
#####################################

source ${OET_PATH}/libs/locallibs/common_lib.sh

function config_params() {
    LOG_INFO "Start to prepare the database config."
    disk=$(lsblk | grep disk | awk '{print $1}')
    LOG_INFO "Finish to prepare the database config."
}

function run_test() {
    LOG_INFO "Start to run test."
    ls -l /dev | grep autofs | grep "crw-r--r--"
    CHECK_RESULT $? 0 0 "The file autofs on /dev has some errors."
    ls -l /dev | grep block | grep "drwxr-xr-x"
    CHECK_RESULT $? 0 0 "The file block on /dev has some errors."
    ls -l /dev | grep console | grep "crw--w----"
    CHECK_RESULT $? 0 0 "The file console on /dev has some errors."
    ls -l /dev | grep $disk | grep "brw-rw----"
    CHECK_RESULT $? 0 0 "The disk file $disk on /dev has some errors."
    LOG_INFO "End to run test."
}

main "$@"
