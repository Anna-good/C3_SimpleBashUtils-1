#!/bin/bash
SUCCESS=0
FAIL=0
COUNTER=0
DIFF=""

s21_command=(
    "./s21_grep"
    )
sys_command=(
    "grep"
    )

flags=(
    "v"
    "c"
    "l"
    "n"
    "h"
    "o"
)

tests=(
"s test_files_grep/test_3_grep.txt flags"
"for s21_grep.c s21_grep.h Makefile flags"
"for s21_grep.c flags"
"-e for -e ^int s21_grep.c s21_grep.h Makefile flags"
"-e for -e ^int s21_grep.c flags"
"-e while -e void s21_grep.c Makefile test_files_grep/test_ptrn_grep.txt"
"-e lorem -e int flags test_files_grep/test_2_grep.txt"
"-e int -e lorem flags test_files_grep/test_2_grep.txt"
"-f test_files_grep/pattern.txt test_files_grep/test_2_grep.txt"
)

manual=(
"-f test_files_grep/pattern.txt test_files_grep/test_2_grep.txt"
"-n for test_files_grep/test_1_grep.txt test_files_grep/test_2_grep.txt"
"-n for test_files_grep/test_1_grep.txt"
"-n -e ^\} test_files_grep/test_1_grep.txt"
"-c -e /\ test_files_grep/test_1_grep.txt"
"-ce ^int test_files_grep/test_1_grep.txt test_files_grep/test_2_grep.txt"
"-e ^int test_files_grep/test_1_grep.txt"
"-nivh = test_files_grep/test_1_grep.txt test_files_grep/test_2_grep.txt"
"-e"
"-ie INT test_files_grep/test_3_grep.txt"
"-echar test_files_grep/test_1_grep.txt test_files_grep/test_2_grep.txt"
"-ne = -e out test_files_grep/test_3_grep.txt"
"-iv int test_files_grep/test_3_grep.txt"
"-in int test_files_grep/test_3_grep.txt"
"-c -l ipsum test_files_grep/test_1_grep.txt test_files_grep/test_3_grep.txt"
"-v test_files_grep/test_1_grep.txt -e ank"
"-noe ) test_files_grep/test_3_grep.txt"
"-l for test_files_grep/test_1_grep.txt test_files_grep/test_2_grep.txt"
"-e = -e out test_files_grep/test_3_grep.txt"
"-noe ing -e as -e the -e not -e is test_files_grep/test_1_grep.txt"
"-e ing -e as -e the -e not -e is test_files_grep/test_1_grep.txt"
"-e int -si no_file.txt s21_grep.c no_file2.txt s21_grep.h"
"-si s21_grep.c -f no_pattern.txt"
)

run_test() {
    param=$(echo "$@" | sed "s/flags/$var/")
    "${s21_command[@]}" $param > "${s21_command[@]}".log
    "${sys_command[@]}" $param > "${sys_command[@]}".log
    DIFF="$(diff -s "${s21_command[@]}".log "${sys_command[@]}".log)"
    let "COUNTER++"
    if [ "$DIFF" == "Files "${s21_command[@]}".log and "${sys_command[@]}".log are identical" ]
    then
        let "SUCCESS++"
        echo "$COUNTER - Success $param"
    else
        let "FAIL++"
        echo "$COUNTER - Fail $param"
    fi
    rm -f "${s21_command[@]}".log "${sys_command[@]}".log
}

echo "^^^^^^^^^^^^^^^^^^^^^^^"
echo "TESTS WITH NORMAL flags"
echo "^^^^^^^^^^^^^^^^^^^^^^^"
printf "\n"
echo "#######################"
echo "MANUAL TESTS"
echo "#######################"
printf "\n"

for i in "${manual[@]}"
do
    var="-"
    run_test "$i"
done

printf "\n"
echo "#######################"
echo "AUTOTESTS"
echo "#######################"
printf "\n"
echo "======================="
echo "1 PARAMETER"
echo "======================="
printf "\n"

for var1 in "${flags[@]}"
do
    for i in "${tests[@]}"
    do
        var="-$var1"
        run_test "$i"
    done
done
printf "\n"
echo "======================="
echo "2 PARAMETERS"
echo "======================="
printf "\n"

for var1 in "${flags[@]}"
do
    for var2 in "${flags[@]}"
    do
        if [ $var1 != $var2 ]
        then
            for i in "${tests[@]}"
            do
                var="-$var1 -$var2"
                run_test "$i"
            done
        fi
    done
done

echo "#######################"
echo "AUTOTESTS"
echo "#######################"
printf "\n"
echo "======================="
echo "DOUBLE PARAMETER"
echo "======================="
printf "\n"

for var1 in "${flags[@]}"
do
    for var2 in "${flags[@]}"
    do
        if [ $var1 != $var2 ]
        then
            for i in "${tests[@]}"
            do
                var="-$var1$var2"
                run_test "$i"
            done
        fi
    done
done

printf "\n"
echo "#######################"
echo "AUTOTESTS"
echo "#######################"
printf "\n"
echo "======================="
echo "TRIPLE PARAMETER"
echo "======================="
printf "\n"

for var1 in "${flags[@]}"
do
    for var2 in "${flags[@]}"
    do
        for var3 in "${flags[@]}"
        do
            if [ $var1 != $var2 ] && [ $var2 != $var3 ] && [ $var1 != $var3 ]
            then
                for i in "${tests[@]}"
                do
                    var="-$var1$var2$var3"
                    run_test "$i"
                done
            fi
        done
    done
done
printf "\n"
echo "FAILED: $FAIL"
echo "SUCCESSFUL: $SUCCESS"
echo "ALL: $COUNTER"
printf "\n"
##############################
