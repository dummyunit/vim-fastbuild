#!/bin/bash

if [[ -z "$1" ]]; then
	echo "Usage: $0 PATH_TO_FASTBUILD_REPO" >&2
	exit 1
fi
fastbuild_repo="$1"

if [[ ! -d "${fastbuild_repo}/Code/Tools/FBuild" ]]; then
	echo "Path ${fastbuild_repo} doesn't look like a FASTBuild repository" >&2
	exit 1
fi

if [[ ! -r "syntax/fastbuild.vim" ]]; then
	echo "Can't find syntax/fastbuild.vim" >&2
	exit 1
fi

known_properties="$(mktemp)"
sed -n -e '/^syn keyword fbProperty/ s/^\(\w* \)*//p' "syntax/fastbuild.vim" \
	| sort > "${known_properties}"

property_candidates="$(mktemp)"
grep -r --include *.h --include *.cpp -h "^ *REFLECT" "${fastbuild_repo}/Code/Tools/FBuild/FBuildCore" \
	| sed -e '/MetaHidden()/d; /MetaEmbedMembers()/d' \
	| grep -o '"[A-Z][A-Za-z0-9]*"' \
	| sed -e 's/^"//; s/"$//' \
	| sort -u > "${property_candidates}"

false_positives="$(mktemp)"
cat > "${false_positives}" <<EOF
CompilerInputFile
ContentSize
ExcludePaths
ExcludePatterns
Files
FilesToExclude
Hash
MainExecutableRootPath
Name
Patterns
PCHObjectFileName
Recursive
TimeStamp
ToolId
EOF

echo "Known properties not found in FASTBuild source code:"
comm -23 "${known_properties}" "${property_candidates}"
echo "Potential new properties:"
comm -13 "${known_properties}" <(comm -23 "${property_candidates}" "${false_positives}")
echo "False positives not found in property candidates (sanity check):"
comm -23 "${false_positives}" "${property_candidates}"

rm -f "${known_properties}" "${property_candidates}" "${false_positives}"
