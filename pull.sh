#!/bin/sh

# General variables
version="16.0.0"
url="https://github.com/be5invis/Iosevka/releases/download/v${version}/ttf-iosevka-term-slab-${version}.zip"
dir="./tmp/"
dir_keep="./keep/"
output="iosevka.zip"

check_dependencies()
{
  which unzip \
    && which curl \
    || "unmet dependencies"
}

check_dependencies

# Setup install dest
mkdir -p $dir_keep
mkdir -p $dir
touch $dir$output

# Download zip
curl -L -o $dir$output $url

# Extract the archive
unzip $dir$output -d $dir

# Extract query of font style from unzipped archive
# query list:
#     bold                       extendedthin
#     bolditalic                 extendedthinitalic
#     boldoblique                extendedthinoblique
#     extended                   extrabold
#     extendedbold               extrabolditalic
#     extendedbolditalic         extraboldoblique
#     extendedboldoblique        extralight
#     extendedextrabold          extralightitalic
#     extendedextrabolditalic    extralightoblique
#     extendedextraboldoblique   heavy
#     extendedextralight         heavyitalic
#     extendedextralightitalic   heavyoblique
#     extendedextralightoblique  italic
#     extendedheavy              light
#     extendedheavyitalic        lightitalic
#     extendedheavyoblique       lightoblique
#     extendeditalic             medium
#     extendedlight              mediumitalic
#     extendedlightitalic        mediumoblique
#     extendedlightoblique       oblique
#     extendedmedium             regular
#     extendedmediumitalic       semibold
#     extendedmediumoblique      semibolditalic
#     extendedoblique            semiboldoblique
#     extendedsemibold           thin
#     extendedsemibolditalic     thinitalic
#     extendedsemiboldoblique    thinoblique

default_query="regular"

# Default query if not supplied
[ -z "$1" ] && cp $dir*-${default_query}.ttf $dir_keep \
  || cp $dir*-${1}.ttf $dir_keep

# Cleanup
rm -rf $dir
