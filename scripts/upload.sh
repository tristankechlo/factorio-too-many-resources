# Validate the version string we're building
if ! echo "${TAG}" | grep -P --quiet '^\d+\.\d+\.\d+$'; then
    echo "Incorrect version pattern, needs to be %u.%u.%u (e.q., 0.1.0)"
    exit 1
fi


# Query the mod info, verify the version number we're trying to push doesn't already exist
curl -s "https://mods.factorio.com/api/mods/${NAME}/full" | jq -e ".releases[] | select(.version == \"${TAG}\")"
# store the return code before running anything else
STATUS_CODE=$?

if [[ $STATUS_CODE -ne 4 ]]; then
    echo "Release already exists, skipping"
    exit 0
fi
echo "Release doesn't exist for ${TAG}, uploading"

# Get an upload url for the mod
URL_RESULT=$(curl -s -d "mod=${NAME}" -H "Authorization: Bearer ${FACTORIO_MOD_API_KEY}" https://mods.factorio.com/api/v2/mods/releases/init_upload)
UPLOAD_URL=$(echo "${URL_RESULT}" | jq -r '.upload_url')
if [[ -z "${UPLOAD_URL}" ]]; then
    echo "Couldn't get an upload url, failed"
    ERROR=$(echo "${URL_RESULT}" | jq -r '.error')
    MESSAGE=$(echo "${URL_RESULT}" | jq -r '.message // empty')
    echo "${ERROR}: ${MESSAGE}"
    exit 1
fi

# Upload the file
UPLOAD_RESULT=$(curl -s -F "file=@${NAME}_${TAG}.zip" "${UPLOAD_URL}")

# The success attribute only appears on successful uploads
SUCCESS=$(echo "${UPLOAD_RESULT}" | jq -r '.success')
if [[ -z "${SUCCESS}" ]]; then
    echo "Upload failed"
    ERROR=$(echo "${UPLOAD_RESULT}" | jq -r '.error')
    MESSAGE=$(echo "${UPLOAD_RESULT}" | jq -r '.message // empty')
    echo "${ERROR}: ${MESSAGE}"
    exit 1
fi

echo "Upload of ${NAME}_${TAG}.zip completed"
