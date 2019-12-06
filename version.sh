#! /bin/bash -ue
#
# Convert the git describe output to a version string R style
#

version=$(git describe --dirty --first-parent)
echo $version > ${0/%.sh/.txt}
#version=$(echo $version | sed 's/\-g[0-9a-f]*//')
version=${version%%-g*}
version=${version//-/.}
echo $version > ${0/%.sh/.r}

sed -i -e "s/0.0.0.9000/$version/" DESCRIPTION

echo "R Version: $version"

# are we building an annotated tag
message=$(git tag -ln $version)
if [ -n "$message" ]; then
  echo ${message#$version} > message.txt
fi

echo "Tag message: ${message#$version}"