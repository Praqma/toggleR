#/bin/bash -ue

# Do we have a version to release
if [ $# -gt 0 ]; then
  version=$1
  shift
else
  cat << EOF
Usage: $0 version-to-release [Message for the relelease]

  The corresponding package toggleR_<version>.tar.gz must
  be present in the directory
EOF
  exit 0
fi

# Do we have a message to use for the release?
if [ $# -gt 0 ]; then
  message=$@
else
  message=$version
fi

# R package to release
rpkg=toggleR_$version.tar.gz

# Does the package exist?
if [ ! -f "$rpkg" ]; then
  echo "ERROR $rpkg does not exist"
  exit 1
fi

# Generate release info
cat << EOF > release.json
{
    "tag_name": "$version",
    "target_commitish": "master",
    "name": "$version",
    "body": "$message",
    "draft": false,
    "prerelease": false
}
EOF

# Create the release
curl -X POST --data-binary @release.json -o response.json -H "Authorization: token $TOGGLER_TOKEN" -H "Content-Type: application/json" https://api.github.com/repos/Praqma/toggleR/releases

# Determine the upload URL from the response
url=$(cat response.json | grep \"upload_url\" | sed 's/[",]//g' | sed 's/upload_url://' | sed 's/{.*}//')
echo "Upload URL: $url"

#curl -H "Authorization: token $TOGGLER_TOKEN" https://api.github.com/repos/Praqma/toggleR/releases

# Upload the R pkg
curl -X POST --data-binary @$rpkg -H "Authorization: token $TOGGLER_TOKEN" -H "Content-Type: application/octet-stream" $url?name=$rpkg
