# Adapted from
# https://gist.githubusercontent.com/mlocher/98e97cc884a041799fd6
# and 
# https://gist.github.com/nicoles/582fb0842b848630b91d
#
#
#!/bin/bash
# Install Meteor, https://www.meteor.com
# based on https://github.com/codeship/scripts/blob/master/packages/meteor.sh
# extended for caching the ${HOME}/.meteor folder
#
# Include in your builds via
# \curl -sSL https://gist.githubusercontent.com/mlocher/98e97cc884a041799fd6/raw/meteor.sh | bash -s
set -e
CACHE_FOLDER="${HOME}/cache/meteor/"
SOURCE_FOLDER="${HOME}/.meteor"

rm -rf "${CACHE_FOLDER}/package-metadata/"

# download and install
\curl -sSL https://install.meteor.com | sed -e 's/PREFIX=.*/PREFIX="${HOME}"/g' | sh
# export PATH=$PATH:"${SOURCE_FOLDER}"

# configure the dependency cache on codeship.com
mkdir -p "${CACHE_FOLDER}"
cp -prf "${SOURCE_FOLDER}/." "${CACHE_FOLDER}"
rm -rf "${SOURCE_FOLDER}"
ln -sf "${CACHE_FOLDER}" "${SOURCE_FOLDER}"

#test meteor
meteor --version
