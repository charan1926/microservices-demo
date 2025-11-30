# variables available from Jenkins env: IMAGE_REPO=${IMAGE_REPO}, TAG=${TAG}
REPO_DIR="$WORKSPACE"   # Jenkins workspace
MANIFEST_FILE="kubernetes-manifests/frontend-deployment.yaml"  # adjust path

# update the image in the manifest file (simple sed that matches the image line)
sed -i -E "s|(image:[[:space:]]*).*$|\1 ${IMAGE_REPO}:${TAG}|" "$MANIFEST_FILE"

git config user.email "jenkins@example.com"
git config user.name "jenkins-cd"
git add "$MANIFEST_FILE"
git commit -m "chore: promote ${IMAGE_REPO}:${TAG} [ci skip]" || true
git push origin HEAD:main

