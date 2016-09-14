" Vim syntax file
" Language:	FASTBuild

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn case match

" Comments
syn region fbComment start=";" end="$"
syn region fbComment start="//" end="$"

" Strings
syn match fbEscape display contained "\^."
syn match fbVariablePaste display contained "\$\w\+\$"
syn match fbBTSubstitution display contained "%[0-4]"
syn region fbString start=+"+ skip=+^"+ end=+"+ contains=fbEscape,fbVariablePaste,fbBTSubstitution
syn region fbString start=+'+ skip=+^'+ end=+'+ contains=fbEscape,fbVariablePaste,fbBTSubstitution

" Integers
syn match fbInteger display "[0-9]\+"

" Boolean constants
syn keyword fbBoolConstant true false

" Variables
syn match fbVariablePrefix display contained "[.^]"
syn match fbVariableName display contained "\w\+"
syn match fbVariable transparent "[.^]\w" contains=fbVariablePrefix,fbProperty,fbVariableName

" #define/#undef
syn match fbDefineToken display contained "\w\+"
syn match fbDefine display "#\s*\(define\|undef\)" nextgroup=fbDefineToken skipwhite

" Predefined symbols
syn keyword fbPredefSymbol __LINUX__ __OSX__ __WINDOWS__

" #include
" File names are handled as regular strings
syn match fbInclude display "#\s*include"

" #if/#else/#endif
syn match fbIfElse display "#\s*\(if\|else\|endif\)"

" #import
syn match fbImport display "#\s*import" nextgroup=fbVariableName skipwhite

" #once
syn match fbOnce display "#\s*once"

if exists('fastbuild_operators')
	syn keyword fbKeyword in
	syn match fbOperator display "+"
	syn match fbOperator display "-"
	syn match fbOperator display "="
endif

" Functions
syn keyword fbFunction Alias Compiler Copy CopyDir CSAssembly DLL Exec Executable ForEach Library ObjectList Print RemoveDir Settings Test Unity Using VCXProject VSSolution XCodeProject

" Common properties
syn keyword fbProperty PreBuildDependencies

" Alias properties
syn keyword fbProperty Targets

" Compiler properties
syn keyword fbProperty Executable ExtraFiles VS2012EnumBugFix

" Copy properties
syn keyword fbProperty Source Dest SourceBasePath

" CopyDir properties
syn keyword fbProperty SourcePaths Dest SourcePathsPattern SourcePathsRecurse SourceExcludePaths

" CSAssembly properties
syn keyword fbProperty Compiler CompilerOptions CompilerOutput CompilerInputPath CompilerInputPathRecurse CompilerInputPattern CompilerInputExcludePath CompilerInputExcludedFiles CompilerReferences

" DLL/Executable properties
syn keyword fbProperty Linker LinkerOutput LinkerOptions Libraries LinkerLinkObjects LinkerAssemblyResources LinkerStampExe LinkerStampExeArgs LinkerType

" Exec properties
syn keyword fbProperty ExecExecutable ExecInput ExecOutput ExecArguments ExecWorkingDir ExecReturnCode ExecUseStdOutAsOutput PreBuildDependencies

" Library/ObjectList properties
syn keyword fbProperty Compiler CompilerOptions CompilerOutputPath CompilerOutputExtension CompilerOutputPrefix
syn keyword fbProperty Librarian LibrarianOptions LibrarianOutput LibrarianAdditionalInputs
syn keyword fbProperty CompilerInputPath CompilerInputPattern CompilerInputPathRecurse CompilerInputExcludePath CompilerInputExcludedFiles CompilerInputFiles CompilerInputFilesRoot CompilerInputUnity
syn keyword fbProperty AllowCaching AllowDistribution Preprocessor PreprocessorOptions CompilerForceUsing PCHInputFile PCHOutputFile PCHOptions

" RemoveDir properties
syn keyword fbProperty RemovePaths RemovePathsRecurse RemovePatterns RemoveExcludePaths

" Settings properties
syn keyword fbProperty Environment CachePath CachePluginDLL Workers

" Test properties
syn keyword fbProperty TestExecutable TestOutput TestArguments TestWorkingDir TestTimeOut

" Unity properties
syn keyword fbProperty UnityInputPath UnityInputExcludePath UnityInputExcludePattern UnityInputPattern UnityInputPathRecurse UnityInputFiles UnityInputExcludedFiles UnityInputObjectLists UnityInputIsolateWritableFiles UnityInputIsolateWritableFilesLimit UnityOutputPath UnityOutputPattern UnityNumFiles UnityPCH

" VCXProject/XCodeProject common properties
syn keyword fbProperty ProjectOutput ProjectInputPaths ProjectInputPathsExclude ProjectPatternToExclude ProjectAllowedFileExtensions ProjectFiles ProjectFilesToExclude ProjectBasePath

" VCXProject properties
syn keyword fbProperty ProjectReferences ProjectProjectReferences RootNamespace ProjectGuid DefaultLanguage ApplicationEnvironment
syn keyword fbProperty ProjectFileTypes ProjectConfigs FileType Pattern Platform Config Target
" ProjectConfig part
syn keyword fbProperty ProjectBuildCommand ProjectRebuildCommand ProjectCleanCommand Output OutputDirectory IntermediateDirectory LayoutDir LayoutExtensionFilter
syn keyword fbProperty PreprocessorDefinitions IncludeSearchPath ForcedIncludes AssemblySearchPath ForcedUsingAssemblies AdditionalOptions
syn keyword fbProperty LocalDebuggerCommand LocalDebuggerCommandArguments LocalDebuggerWorkingDirectory LocalDebuggerEnvironment Xbox360DebuggerCommand DebuggerFlavor AumidOverride PlatformToolset DeploymentType DeploymentFiles

" VSSolution properties
syn keyword fbProperty SolutionOutput SolutionProjects SolutionConfigs SolutionBuildProject SolutionFolders SolutionDependencies SolutionVisualStudioVersion SolutionMinimumVisualStudioVersion Platform Config SolutionConfig SolutionPlatform Path Projects Projects Dependencies

" XCodeProject properties
syn keyword fbProperty XCodeBuildToolPath XCodeBuildToolArgs XCodeBuildWorkingDir ProjectConfigs XCodeOrganizationName Config Target

"
" Highlight mappings
"

hi def link fbComment Comment

hi def link fbEscape SpecialChar
hi def link fbVariablePaste Special
hi def link fbBTSubstitution Special
hi def link fbString String
hi def link fbInteger Number
hi def link fbBoolConstant Boolean

if exists('fastbuild_operators')
	hi def link fbVariablePrefix Operator
endif
hi def link fbVariableName Identifier

hi def link fbDefineToken Constant
hi def link fbDefine Define
hi def link fbPredefSymbol Keyword
hi def link fbInclude Include
hi def link fbIfElse PreCondit
hi def link fbImport PreProc
hi def link fbOnce PreProc

" Don't highlight operators by default (it look very busy)
if exists('fastbuild_operators')
	hi def link fbKeyword Keyword
	hi def link fbOperator Operator
endif

" FASTBuild functions are actually statements
hi def link fbFunction Statement

" Since variable types are implicit, we reuse Type to highlight builtin properties
hi def link fbProperty Type

let b:current_syntax = "fastbuild"
