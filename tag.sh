TAG=$(echo $1)

TAG_NAME=$(echo $TAG | cut -d'_' -f1)
TAG_SEMVER=$(echo $TAG | cut -d'_' -f2)

IFS='.' read -a TAG_PARTS <<< "$TAG_SEMVER"

MAJOR_TAG=$(echo "${TAG_NAME}_${TAG_PARTS[0]}")
MINOR_TAG=$(echo "${TAG_NAME}_${TAG_PARTS[0]}.${TAG_PARTS[1]}")
PATCH_TAG=$(echo "${TAG_NAME}_${TAG_PARTS[0]}.${TAG_PARTS[1]}.${TAG_PARTS[2]}")

echo Major Version Tag: $MAJOR_TAG
echo Minor Version Tag: $MINOR_TAG
echo Patch Version Tag: $PATCH_TAG
