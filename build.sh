#!/bin/bash


: '
maxbybee 2023
This will MANUALLY BUILD a minecraft plugin
WHY DID I DO THIS?!?!?!??


Program NEEDS: 
JAVA JDK (or atleast javac and jar in path)
spigot-api.jar file (renamed to a clean name)
linux/unix computer
/bin/bash

Program WANTS:
some familiarity with java and or linux bash
'

printf '\n';
printf '\n';
printf '\n';
echo "=========== SET VARIABLES (to change, edit the script file) ==========="
# java jdk path
JAVAC=`type -p javac`
JAVAJ=`type -p jar`
# spigot api jar path
SPIGOT_PATH=".:spigot-api.jar"


MAIN_CLASS=Plugin
MAIN_PATH_DIR=com/maxbybee/

MAIN_COMPILED_PATH=${MAIN_PATH_DIR}${MAIN_CLASS}.class

# main path of the main plugin file
MAIN_PATH=${MAIN_PATH_DIR}${MAIN_CLASS}.java

# name of directory (of plugin) 
DIRECTORY_PATH=com.maxbybee.plugin

# name of directory to build to (put finished files to)
BUILD_PATH=.tmp/


PRINT_VARS=0;
if [[ $PRINT_VARS -eq 0 ]]; then echo "print_vars off"; fi
if [[ $PRINT_VARS -eq 1 ]]; then echo "print_vars on";
 echo "spigot_path=${SPIGOT_PATH}"; 
 echo "main_class=${MAIN_CLASS}"; 
 echo "main_path_dir=${MAIN_PATH_DIR}"; 
 echo "main_compiled_path=${MAIN_COMPILED_PATH}"; 
 echo "main_path=${MAIN_PATH}"; 
 echo "directory_path=${DIRECTORY_PATH}"; 
 echo "build_class=${BUILD_PATH}"; 
fi


# START
printf '\e[1;33;4;44m'; #colors
echo "=========== REMOVE TMP DIRECTORY (IF EXISTS) ==========="
printf '\e[0m';  #remove colors
if [ -d "$BUILD_PATH" ]; then rm -Rf $BUILD_PATH; echo REMOVED; fi

printf '\e[1;33;4;44m'; #colors
echo =========== CREATE DIRECTORY ===========
printf '\e[0m';  #remove colors
mkdir $BUILD_PATH
if [ -d "$BUILD_PATH" ]; then echo CREATED; fi
printf '\e[1;33;4;44m'; #colors
echo =========== COMPILE CLASS FILE ===========
printf '\e[0m';  #remove colors
printf '\e[0;37;5;40m'; # output colors
$JAVAC $MAIN_PATH -classpath ${SPIGOT_PATH}
printf '\e[0m';  #remove colors

if [ -f "$MAIN_COMPILED_PATH" ]; then echo "SUCCESS!"; fi
# show if .class file(s) was created successfully

printf '\e[1;33;4;44m'; #colors
echo =========== CREATE JAR FILE ===========
printf '\e[0m';  #remove colors


# compile by idividual files
#${JAVAJ} cvfm ${BUILD_PATH}Plugin.jar plugin.yml MANIFEST.MF ${MAIN_COMPILED_PATH}

# compile by moving to directory
printf '\e[0;37;5;40m'; # output colors
mkdir  ${BUILD_PATH}/META-INF
cp MANIFEST.MF ${BUILD_PATH}/META-INF/
cp -R com/ ${BUILD_PATH}
cp plugin.yml ${BUILD_PATH}
${JAVAJ} -cvMf ${BUILD_PATH}Plugin.jar -C ${BUILD_PATH} .
printf '\e[0m';  #remove colors


if [ -f "${BUILD_PATH}Plugin.jar" ]; then echo "SUCCESS! JAR CREATED!"; fi
printf '\e[1;33;4;44m'; #colors
echo =========== FINISHED ===========
printf '\e[0m';  #remove colors
