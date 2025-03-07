TAG=$(echo $1)
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

CHECK=$(git tag | grep $PATCH_TAG)

if [ $? == 0 ]; then
    echo $PATCH_TAG tag alrady exists!
    exit 1 
fi

echo "Tagging commit: $(git rev-parse HEAD)"
git tag $MAJOR_TAG
git tag $MINOR_TAG
git tag $PATCH_TAG

git push origin :refs/tags/$MAJOR_TAG
git push origin :refs/tags/$MINOR_TAG

git push origin $BRANCH_NAME tag $MAJOR_TAG
git push origin $BRANCH_NAME tag $MINOR_TAG
git push origin $BRANCH_NAME tag $PATCH_TAG