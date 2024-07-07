echo "name=$(cat info.json | jq -r .name)" >> "$GITHUB_OUTPUT"
echo "version=$(cat info.json | jq -r .version)" >> "$GITHUB_OUTPUT"
FACTORIO="$(cat info.json | jq -r .factorio_version)"
echo "factorio=${FACTORIO}" >> "$GITHUB_OUTPUT"


mkdir -p tmp
SEP="---------------------------------------------------------------------------------------------------"
csplit --prefix "tmp/xx" -z changelog.txt /$SEP/ '{*}'
sed --in-place "s/$SEP//" ./tmp/xx00

EOF=$(dd if=/dev/urandom bs=15 count=1 status=none | base64)

echo "changes<<$EOF" >> $GITHUB_OUTPUT
echo "<pre>$(cat ./tmp/xx00)</pre>" >> "$GITHUB_OUTPUT"
echo "" >> "$GITHUB_OUTPUT"
echo "<small>factorio_version: ${FACTORIO}</small>" >> "$GITHUB_OUTPUT"
echo "$EOF" >> "$GITHUB_OUTPUT"

echo "# Changelog" >> $GITHUB_STEP_SUMMARY
echo "<pre>$(cat ./tmp/xx00)</pre>" >> $GITHUB_STEP_SUMMARY
echo "" >> $GITHUB_STEP_SUMMARY
echo "<small>factorio_version: ${FACTORIO}</small>" >> $GITHUB_STEP_SUMMARY
