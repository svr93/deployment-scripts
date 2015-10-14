#!/bin/bash

# default Node version
nodeVersion=0.12

# default ECMA-262 version
ecmaScript=5

# default MV* framework
mvFramework='backbone'

while [ "$1" != "" ]; do
    case $1 in
        -nv | --node-version )      shift
                                    nodeVersion=$1
                                    ;;

        -es | --ecma-script )       shift
                                    ecmaScript=$1
                                    ;;

        -mv )                       shift
                                    mvFramework=$1
                                    ;;

        * )                         echo 'error: bad param'
                                    ;;
    esac
    shift
done

if nvm --version &> /dev/null
then    nvm ls | grep $nodeVersion || nvm install $nodeVersion
        nvm use $nodeVersion
else    echo 'error: nvm not found'        
fi        

# makes common dirs
mkdir client &> /dev/null
mkdir client/www &> /dev/null
mkdir client/www/js &> /dev/null

baseDir='client/www/js'
mkdir $baseDir/adapter &> /dev/null
mkdir $baseDir/global &> /dev/null
mkdir $baseDir/lib &> /dev/null
mkdir $baseDir/vendor &> /dev/null
