#! /bin/bash

################################################################################
#
# This script clones the latest version, configures the environment, then
# builds and installs DynAdjust using:
#   gcc 10.1.1
#   boost 1.69.0
#   xerces-c 3.1.4
#
################################################################################

# get current directory
_cwd="$PWD"
# set dynadjust clone dir
_clone_dir="${_cwd}/DynAdjust"
# set dynadjust root dir
_root_dir="${_clone_dir}/dynadjust"
# set build dir
_build_dir="${_root_dir}/build_gcc"
# set clone url
_clone_url="https://github.com/icsm-au/DynAdjust.git"

# usr bin directory
BIN_FOLDER="~/bin"
BIN_FOLDER_FULLPATH="`eval echo ${BIN_FOLDER//>}`"

# opt installation folder
OPT_DYNADJUST_PATH=/opt/dynadjust
OPT_DYNADJUST_GCC_PATH=/opt/dynadjust/gcc
DYNADJUST_INSTALL_PATH=/opt/dynadjust/gcc/1_0_2

echo " "
echo "Build and installation of dynadjust 1.0.2"
echo "==========================================================================="
echo "Repository settings:"
echo " Git repo:      ${_clone_url}"
echo "Build settings:"
echo " Current dir:   ${_cwd}"
echo " Clone dir:     ${_clone_dir}"
echo " Build dir:     ${_build_dir}"
echo "Installation settings:"
echo " Install dir:   ${DYNADJUST_INSTALL_PATH}"
echo " User bin dir:  ${BIN_FOLDER_FULLPATH}"
echo "==========================================================================="
echo " "
read -r -p "Is this ok [Y/n]: " response

if [[ "$response" =~ ^([nN][oO]|[nN])$ ]]
then    
    exit
else
    echo " "
fi

# INSTALL DYNADJUST
# 1. create install dirs:
if [ ! -d "${BIN_FOLDER_FULLPATH}" ]; then
	echo " "
    echo "Making ${BIN_FOLDER_FULLPATH}"
    mkdir ${BIN_FOLDER_FULLPATH}
fi

# 2. download:
echo " "
echo "Cloning DynAdjust..."
git clone ${_clone_url}

if [ -d ${_build_dir} ]; then
    cd ${_build_dir}
    rm -rf CMakeCache.txt CMakeFiles cmake_install.cmake dynadjust Makefile
    cd ${_cwd}
else
    mkdir ${_build_dir}
fi

cd ${_build_dir}

# 3. build:
cp ../FindXercesC.cmake ./
cp ../FindMKL.cmake ./
cp ../FindXSD.cmake ./

REL_BUILD_TYPE="Release"
DBG_BUILD_TYPE="Debug"
THIS_BUILD_TYPE=$REL_BUILD_TYPE

# test argument for build type
if [ "$#" -lt 1 ]; 
then
    echo " "
	echo "No build type specified.  Building $THIS_BUILD_TYPE by default...";

elif [ "$1" == "debug" -o "$1" == "Debug" ]; 
then
    THIS_BUILD_TYPE="Debug"

elif [ "$1" == "release" -o "$1" == "Release" ];
then
    THIS_BUILD_TYPE="Release"
fi

echo " "
echo "Building DynaNet ($THIS_BUILD_TYPE)..."
echo " "

gcc_version=$(gcc -v 2>&1 | tail -1 | awk '{print $1 " " $2 " " $3}')

echo $gcc_version
echo " "

# copy CMakeLists

if [ "$THIS_BUILD_TYPE" == "Debug" ]; 
then
	cp ../CMakeLists.debug.txt ../CMakeLists.txt
	cp ../dynadjust/dnaadjust/CMakeLists.debug.txt ../dynadjust/dnaadjust/CMakeLists.txt
	cp ../dynadjust/dnaadjustwrapper/CMakeLists.debug.txt ../dynadjust/dnaadjustwrapper/CMakeLists.txt
	cp ../dynadjust/dnageoid/CMakeLists.debug.txt ../dynadjust/dnageoid/CMakeLists.txt
	cp ../dynadjust/dnageoidwrapper/CMakeLists.debug.txt ../dynadjust/dnageoidwrapper/CMakeLists.txt
	cp ../dynadjust/dnaimport/CMakeLists.debug.txt ../dynadjust/dnaimport/CMakeLists.txt
	cp ../dynadjust/dnaimportwrapper/CMakeLists.debug.txt ../dynadjust/dnaimportwrapper/CMakeLists.txt
	cp ../dynadjust/dnaplot/CMakeLists.debug.txt ../dynadjust/dnaplot/CMakeLists.txt
	cp ../dynadjust/dnaplotwrapper/CMakeLists.debug.txt ../dynadjust/dnaplotwrapper/CMakeLists.txt
	cp ../dynadjust/dnareftran/CMakeLists.debug.txt ../dynadjust/dnareftran/CMakeLists.txt
	cp ../dynadjust/dnareftranwrapper/CMakeLists.debug.txt ../dynadjust/dnareftranwrapper/CMakeLists.txt
	cp ../dynadjust/dnasegment/CMakeLists.debug.txt ../dynadjust/dnasegment/CMakeLists.txt
	cp ../dynadjust/dnasegmentwrapper/CMakeLists.debug.txt ../dynadjust/dnasegmentwrapper/CMakeLists.txt
	cp ../dynadjust/dynadjust/CMakeLists.debug.txt ../dynadjust/dynadjust/CMakeLists.txt

elif [ "$THIS_BUILD_TYPE" == "Release" ];
then
	cp ../CMakeLists.release.txt ../CMakeLists.txt
	cp ../dynadjust/dnaadjust/CMakeLists.release.txt ../dynadjust/dnaadjust/CMakeLists.txt
	cp ../dynadjust/dnaadjustwrapper/CMakeLists.release.txt ../dynadjust/dnaadjustwrapper/CMakeLists.txt
	cp ../dynadjust/dnageoid/CMakeLists.release.txt ../dynadjust/dnageoid/CMakeLists.txt
	cp ../dynadjust/dnageoidwrapper/CMakeLists.release.txt ../dynadjust/dnageoidwrapper/CMakeLists.txt
	cp ../dynadjust/dnaimport/CMakeLists.release.txt ../dynadjust/dnaimport/CMakeLists.txt
	cp ../dynadjust/dnaimportwrapper/CMakeLists.release.txt ../dynadjust/dnaimportwrapper/CMakeLists.txt
	cp ../dynadjust/dnaplot/CMakeLists.release.txt ../dynadjust/dnaplot/CMakeLists.txt
	cp ../dynadjust/dnaplotwrapper/CMakeLists.release.txt ../dynadjust/dnaplotwrapper/CMakeLists.txt
	cp ../dynadjust/dnareftran/CMakeLists.release.txt ../dynadjust/dnareftran/CMakeLists.txt
	cp ../dynadjust/dnareftranwrapper/CMakeLists.release.txt ../dynadjust/dnareftranwrapper/CMakeLists.txt
	cp ../dynadjust/dnasegment/CMakeLists.release.txt ../dynadjust/dnasegment/CMakeLists.txt
	cp ../dynadjust/dnasegmentwrapper/CMakeLists.release.txt ../dynadjust/dnasegmentwrapper/CMakeLists.txt
	cp ../dynadjust/dynadjust/CMakeLists.release.txt ../dynadjust/dynadjust/CMakeLists.txt
fi

cmake ../ || exit 1

# exit

make -j 8 || exit 1

# exit

echo " "
read -r -p "Install DynAdjust to ${OPT_DYNADJUST_PATH} [Y/n]: " optresponse
if [[ "$optresponse" =~ ^([nN][oO]|[nN])$ ]]
then    
    echo "Skipping DynAdjust installation."
else

    _lib_ext="so"

	# 1 GET OS, DISTRO AND TOOLS
	if [[ "$OSTYPE" == "darwin"* ]]; then
		# Mac OSX
		_lib_ext="dylib"
	fi



	if [ ! -d $OPT_DYNADJUST_PATH ]; then
		sudo mkdir $OPT_DYNADJUST_PATH
	fi

	if [ ! -d $OPT_DYNADJUST_GCC_PATH ]; then
		sudo mkdir $OPT_DYNADJUST_GCC_PATH
	fi

	if [ ! -d $DYNADJUST_INSTALL_PATH ]; then
		sudo mkdir $DYNADJUST_INSTALL_PATH
	fi

	echo "Copying libraries and binaries to $DYNADJUST_INSTALL_PATH ..."

	if [ -e "./dynadjust/dynadjust/dynadjust" ]; then
		sudo cp ./dynadjust/dynadjust/dynadjust $DYNADJUST_INSTALL_PATH/
		ln -sf $DYNADJUST_INSTALL_PATH/dynadjust ${BIN_FOLDER_FULLPATH}/dynadjust
		echo " - dynadjust"
	fi

	if [ -e "./dynadjust/dnaadjustwrapper/dnaadjust" ]; then
		sudo cp ./dynadjust/dnaadjust/libdnaadjust.$_lib_ext $DYNADJUST_INSTALL_PATH/
		sudo cp ./dynadjust/dnaadjustwrapper/dnaadjust $DYNADJUST_INSTALL_PATH/
		ln -sf $DYNADJUST_INSTALL_PATH/dnaadjust ${BIN_FOLDER_FULLPATH}/dnaadjust
		ln -sf $DYNADJUST_INSTALL_PATH/libdnaadjust.$_lib_ext  ${BIN_FOLDER_FULLPATH}/libdnaadjust.$_lib_ext 
		echo " - dnaadjust, libdnaadjust.${_lib_ext}"
	fi

	if [ -e "./dynadjust/dnaimportwrapper/dnaimport" ]; then
		sudo cp ./dynadjust/dnaimport/libdnaimport.$_lib_ext $DYNADJUST_INSTALL_PATH/
		sudo cp ./dynadjust/dnaimportwrapper/dnaimport $DYNADJUST_INSTALL_PATH/
		ln -sf $DYNADJUST_INSTALL_PATH/dnaimport ${BIN_FOLDER_FULLPATH}/dnaimport
		ln -sf $DYNADJUST_INSTALL_PATH/libdnaimport.$_lib_ext  ${BIN_FOLDER_FULLPATH}/libdnaimport.$_lib_ext
		echo " - dnaimport, libdnaimport.${_lib_ext}"
	fi

	if [ -e "./dynadjust/dnareftranwrapper/dnareftran" ]; then
		sudo cp ./dynadjust/dnareftran/libdnareftran.$_lib_ext $DYNADJUST_INSTALL_PATH/
		sudo cp ./dynadjust/dnareftranwrapper/dnareftran $DYNADJUST_INSTALL_PATH/
		ln -sf $DYNADJUST_INSTALL_PATH/dnareftran ${BIN_FOLDER_FULLPATH}/dnareftran
		ln -sf $DYNADJUST_INSTALL_PATH/libdnareftran.$_lib_ext  ${BIN_FOLDER_FULLPATH}/libdnareftran.$_lib_ext
		echo " - dnareftran, libdnareftran.${_lib_ext}"
	fi

	if [ -e "./dynadjust/dnageoidwrapper/dnageoid" ]; then
		sudo cp ./dynadjust/dnageoid/libdnageoid.$_lib_ext $DYNADJUST_INSTALL_PATH/
		sudo cp ./dynadjust/dnageoidwrapper/dnageoid $DYNADJUST_INSTALL_PATH/
		ln -sf $DYNADJUST_INSTALL_PATH/dnageoid ${BIN_FOLDER_FULLPATH}/dnageoid
		ln -sf $DYNADJUST_INSTALL_PATH/libdnageoid.$_lib_ext  ${BIN_FOLDER_FULLPATH}/libdnageoid.$_lib_ext
		echo " - dnageoid, libdnageoid.${_lib_ext}"
	fi

	if [ -e "./dynadjust/dnasegmentwrapper/dnasegment" ]; then
		sudo cp ./dynadjust/dnasegment/libdnasegment.$_lib_ext $DYNADJUST_INSTALL_PATH/
		sudo cp ./dynadjust/dnasegmentwrapper/dnasegment $DYNADJUST_INSTALL_PATH/
		ln -sf $DYNADJUST_INSTALL_PATH/dnasegment ${BIN_FOLDER_FULLPATH}/dnasegment
		ln -sf $DYNADJUST_INSTALL_PATH/libdnasegment.$_lib_ext  ${BIN_FOLDER_FULLPATH}/libdnasegment.$_lib_ext 
		echo " - dnasegment, libdnasegment.${_lib_ext}"
	fi

	if [ -e "./dynadjust/dnaplotwrapper/dnaplot" ]; then
		sudo cp ./dynadjust/dnaplot/libdnaplot.$_lib_ext $DYNADJUST_INSTALL_PATH/
		sudo cp ./dynadjust/dnaplotwrapper/dnaplot $DYNADJUST_INSTALL_PATH/
		ln -sf $DYNADJUST_INSTALL_PATH/dnaplot ${BIN_FOLDER_FULLPATH}/dnaplot
		ln -sf $DYNADJUST_INSTALL_PATH/libdnaplot.$_lib_ext  ${BIN_FOLDER_FULLPATH}/libdnaplot.$_lib_ext 
		echo " - dnaplot, libdnaplot.${_lib_ext}"
	fi

	echo "Creating symbolic links to libraries and binaries in $DYNADJUST_INSTALL_PATH ..."
	sudo ln -sf $DYNADJUST_INSTALL_PATH/libdnaimport.$_lib_ext /opt/dynadjust/libdnaimport.$_lib_ext
	sudo ln -sf $DYNADJUST_INSTALL_PATH/libdnareftran.$_lib_ext /opt/dynadjust/libdnareftran.$_lib_ext
	sudo ln -sf $DYNADJUST_INSTALL_PATH/libdnageoid.$_lib_ext /opt/dynadjust/libdnageoid.$_lib_ext
	sudo ln -sf $DYNADJUST_INSTALL_PATH/libdnasegment.$_lib_ext /opt/dynadjust/libdnasegment.$_lib_ext 
	sudo ln -sf $DYNADJUST_INSTALL_PATH/libdnaadjust.$_lib_ext /opt/dynadjust/libdnaadjust.$_lib_ext 
	sudo ln -sf $DYNADJUST_INSTALL_PATH/libdnaplot.$_lib_ext /opt/dynadjust/libdnaplot.$_lib_ext 

	sudo ln -sf $DYNADJUST_INSTALL_PATH/dnaimport /opt/dynadjust/dnaimport
	sudo ln -sf $DYNADJUST_INSTALL_PATH/dnareftran /opt/dynadjust/dnareftran
	sudo ln -sf $DYNADJUST_INSTALL_PATH/dnageoid /opt/dynadjust/dnageoid
	sudo ln -sf $DYNADJUST_INSTALL_PATH/dnasegment /opt/dynadjust/dnasegment
	sudo ln -sf $DYNADJUST_INSTALL_PATH/dnaadjust /opt/dynadjust/dnaadjust
	sudo ln -sf $DYNADJUST_INSTALL_PATH/dnaplot /opt/dynadjust/dnaplot
	sudo ln -sf $DYNADJUST_INSTALL_PATH/dynadjust /opt/dynadjust/dynadjust

fi

echo "Done."
echo " "
echo "Don't forget to add the bin directory to path in ~/.bash_profile"
echo "For example:"
echo "    EXPORT PATH=$PATH:$HOME/bin"
echo " "

