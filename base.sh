#!/bin/bash

# default Node version
nodeVersion=0.12

# default ECMA-262 version
ecmaScript=6

# default MV* framework
mvFramework='backbone'

# default module system
moduleSystem='es6'

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

        --amd | --requirejs )       moduleSystem='amd'
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

# creates new git info
rm -rf .git
git init
git add .
git commit -a -m "initial_commit"

# creates package.json
npm init

# installs npm modules
npm i --save-dev gulp

# installs gulp modules
if [ ecmaScript = 6 ]; then
    npm i --save-dev gulp-babel
fi
npm i --save-dev gulp-closure-compiler-service
npm i --save-dev gulp-concat

npm i --save-dev gulp-connect
npm i --save-dev gulp-csslint
npm i --save-dev gulp-html-minifier

npm i --save-dev gulp-html-replace
npm i --save-dev gulp-if
npm i --save-dev gulp-jshint

npm i --save-dev gulp-less
npm i --save-dev gulp-mocha
npm i --save-dev gulp-rename

if [ moduleSystem = 'amd' ]; then
    npm i --save-dev gulp-requirejs-optimize
fi
npm i --save-dev gulp-ssh
npm i --save-dev gulp-w3cjs

# creates file with Bower settings
echo '
{
    "directory": "client/www/js/vendor/script"
}
' > .bowerrc

echo 'Add settings for Bower:'
bower init

# installs base framework
case $mvFramework in
    backbone )                      bower i --save backbone
                                    ;;

    angular )                       bower i --save angular
                                    ;;

    * )                             echo 'error: bad MV* framework'
esac
