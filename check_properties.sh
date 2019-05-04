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

property_regex='[.^"][A-Z][A-Z0-9]*[a-z][A-Za-z0-9]*"'

known_properties="$(mktemp)"
sed -n -e '/^syn keyword fbProperty/ s/^\(\w* \)*//p' "syntax/fastbuild.vim" \
	| sort > "${known_properties}"

property_candidates="$(mktemp)"
grep -r --include *.h --include *.cpp -h "${property_regex}" "${fastbuild_repo}/Code/Tools/FBuild/FBuildCore" \
	| sed -e '/^ *\/\//d; /WritePGItem/d; /PROFILE_SECTION/d; /DoSectionTitle/d; /REFLECT.*MetaHidden()/d; /REFLECT.*MetaEmbedMembers()/d' \
	| grep -o "${property_regex}" \
	| sed -e 's/^[.^"]//; s/"$//' \
	| sort -u > "${property_candidates}"

false_positives="$(mktemp)"
cat > "${false_positives}" <<EOF
Alias
Any
ArrayOfStrings
ArrayOfStructs
Bool
CacheFreeMemory
CacheInit
CacheOutputInfo
CachePublish
CacheRetrieve
CacheShutdown
CacheTrim
Client
ClientThread
CompilerInputFile
Connection
Copy
CopyDir
CopyFile
CppForm
CSAssembly
Debug
Directory
Dynamic
Error
ExcludePaths
ExcludePatterns
Exe
Exec
Fa
FastBuild
Fd
File
FilesToExclude
Fo
ForEach
Fp
Gm
Idle
If
Int
Job
JobResult
Library
Linux
Manifest
NoJobAvailable
Object
ObjectList
Organization
Patterns
PBXLegacyTarget
PBXNativeTarget
PBXProject
PCHObjectFileName
PreBuild
PrecompiledHeader
Print
Proxy
Recursive
Release
RemoteWorkerThread
RemoveDir
RequestFile
RequestJob
RequestManifest
Server
ServerStatus
ServerThread
Settings
Static
Status
String
Struct
Test
Unavailable
Uncacheable
Unity
Using
VCXProj
VCXProject
VSSolution
Win32
Windows
WorkerThread
XCodeProj
XCodeProject
Yc
Yu
Zi
EOF

echo "Known properties not found in FASTBuild source code:"
comm -23 "${known_properties}" "${property_candidates}"
echo "Potential new properties:"
comm -13 "${known_properties}" <(comm -23 "${property_candidates}" "${false_positives}")
echo "False positives not found in property candidates (sanity check):"
comm -23 "${false_positives}" "${property_candidates}"

rm -f "${known_properties}" "${property_candidates}" "${false_positives}"
