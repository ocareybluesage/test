TAG=$(echo $1)

CHECK=$(git tag | grep $TAG)
if [ $? == 0 ]; then
    echo $TAG tag alrady exists!
    exit 1 
fi

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

TAG_NAME=$(echo $TAG | cut -d'_' -f1)
TAG_SEMVER=$(echo $TAG | cut -d'_' -f2)

IFS='.' read -a TAG_PARTS <<< "$TAG_SEMVER"

MAJOR_TAG=$(echo "${TAG_NAME}_${TAG_PARTS[0]}")
MINOR_TAG=$(echo "${TAG_NAME}_${TAG_PARTS[0]}.${TAG_PARTS[1]}")
PATCH_TAG=$(echo "${TAG_NAME}_${TAG_PARTS[0]}.${TAG_PARTS[1]}.${TAG_PARTS[2]}")

echo Major Version Tag: $MAJOR_TAG
echo Minor Version Tag: $MINOR_TAG
echo Patch Version Tag: $PATCH_TAG

echo "Tagging commit: $(git rev-parse HEAD)"
git tag $MAJOR_TAG
git tag $MINOR_TAG
git tag $PATCH_TAG

# Delete remote major/minor tags so that new major/minor tags can be created
git push origin :refs/tags/$MAJOR_TAG
git push origin :refs/tags/$MINOR_TAG

# Push tags
git push origin $BRANCH_NAME tag $MAJOR_TAG
git push origin $BRANCH_NAME tag $MINOR_TAG
git push origin $BRANCH_NAME tag $PATCH_TAG

# Deletes local tag so future executions of this command run
git tag --delete $MAJOR_TAG
git tag --delete $MINOR_TAG