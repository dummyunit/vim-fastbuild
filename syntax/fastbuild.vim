" Vim syntax file
" Language:    FASTBuild

" Quit when a (custom) syntax file was already loaded
if version < 600
	syntax clear
elseif exists("b:current_syntax")
	finish
endif

syn case match

" Comments
syn keyword fbTodo TODO FIXME XXX contained
syn region fbComment start=";" end="$" contains=fbTodo
syn region fbComment start="//" end="$" contains=fbTodo

" Operators
if exists('fastbuild_operators')
	syn keyword fbKeyword in
	syn match fbOperator display "[-+=]"
	syn match fbOperator display contained "!"
endif

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
syn match fbDefine display "#\s*\(define\|undef\)\>" nextgroup=fbDefineToken skipwhite

" Predefined symbols
syn keyword fbPredefSymbol __LINUX__ __OSX__ __WINDOWS__

" #include
" File names are handled as regular strings
syn match fbInclude display "#\s*include\>"

" #if
syn match fbIf "#\s*if\>" nextgroup=fbPredefSymbol,fbDefineToken skipwhite
syn match fbIf "#\s*if\>\s*!"he=e-1 contains=fbOperator nextgroup=fbPredefSymbol,fbDefineToken skipwhite

" #else / #endif
syn match fbElseEndif "#\s*\(else\|endif\)\>"

" #import
syn match fbImport display "#\s*import\>" nextgroup=fbVariableName skipwhite

" #once
syn match fbOnce display "#\s*once\>"

" Functions
syn keyword fbFunction Alias Compiler Copy CopyDir CSAssembly DLL Exec
syn keyword fbFunction Executable ForEach Library ObjectList Print RemoveDir
syn keyword fbFunction Settings Test Unity Using VCXProject VSSolution XCodeProject

" Common properties
syn keyword fbProperty contained PreBuildDependencies

" Alias properties
syn keyword fbProperty contained Targets

" Compiler properties
syn keyword fbProperty contained Executable ExtraFiles VS2012EnumBugFix

" Copy properties
syn keyword fbProperty contained Source Dest SourceBasePath

" CopyDir properties
syn keyword fbProperty contained SourcePaths Dest SourcePathsPattern
syn keyword fbProperty contained SourcePathsRecurse SourceExcludePaths

" CSAssembly properties
syn keyword fbProperty contained Compiler CompilerOptions CompilerOutput
syn keyword fbProperty contained CompilerInputPath CompilerInputPathRecurse
syn keyword fbProperty contained CompilerInputPattern CompilerInputExcludePath
syn keyword fbProperty contained CompilerInputExcludedFiles CompilerReferences

" DLL/Executable properties
syn keyword fbProperty contained Linker LinkerOutput LinkerOptions Libraries
syn keyword fbProperty contained LinkerLinkObjects LinkerAssemblyResources
syn keyword fbProperty contained LinkerStampExe LinkerStampExeArgs LinkerType

" Exec properties
syn keyword fbProperty contained ExecExecutable ExecInput ExecOutput ExecArguments
syn keyword fbProperty contained ExecWorkingDir ExecReturnCode ExecUseStdOutAsOutput
syn keyword fbProperty contained PreBuildDependencies

" Library/ObjectList properties
syn keyword fbProperty contained Compiler CompilerOptions CompilerOutputPath
syn keyword fbProperty contained CompilerOutputExtension CompilerOutputPrefix

syn keyword fbProperty contained Librarian LibrarianOptions LibrarianOutput
syn keyword fbProperty contained CompilerInputPath CompilerInputPattern
syn keyword fbProperty contained CompilerInputExcludePath CompilerInputExcludedFiles
syn keyword fbProperty contained CompilerInputFiles CompilerInputFilesRoot
syn keyword fbProperty contained CompilerInputUnity CompilerInputPathRecurse
syn keyword fbProperty contained AllowCaching AllowDistribution Preprocessor
syn keyword fbProperty contained PreprocessorOptions CompilerForceUsing PCHInputFile
syn keyword fbProperty contained PCHOutputFile PCHOptions LibrarianAdditionalInputs

" RemoveDir properties
syn keyword fbProperty contained RemovePaths RemovePathsRecurse RemovePatterns
syn keyword fbProperty contained RemoveExcludePaths

" Settings properties
syn keyword fbProperty contained Environment CachePath CachePluginDLL Workers

" Test properties
syn keyword fbProperty contained TestExecutable TestOutput TestArguments
syn keyword fbProperty contained TestWorkingDir TestTimeOut

" Unity properties
syn keyword fbProperty contained UnityInputPath UnityInputExcludePath
syn keyword fbProperty contained UnityInputExcludePattern UnityInputPattern
syn keyword fbProperty contained UnityInputPathRecurse UnityInputFiles
syn keyword fbProperty contained UnityInputExcludedFiles UnityInputObjectLists
syn keyword fbProperty contained UnityInputIsolateWritableFiles
syn keyword fbProperty contained UnityInputIsolateWritableFilesLimit
syn keyword fbProperty contained UnityOutputPath UnityOutputPattern UnityNumFiles UnityPCH

" VCXProject/XCodeProject common properties
syn keyword fbProperty contained ProjectOutput ProjectInputPaths
syn keyword fbProperty contained ProjectInputPathsExclude ProjectPatternToExclude
syn keyword fbProperty contained ProjectAllowedFileExtensions ProjectFiles
syn keyword fbProperty contained ProjectFilesToExclude ProjectBasePath

" VCXProject properties
syn keyword fbProperty contained ProjectReferences ProjectProjectReferences
syn keyword fbProperty contained RootNamespace ProjectGuid DefaultLanguage ApplicationEnvironment
syn keyword fbProperty contained ProjectFileTypes ProjectConfigs FileType Pattern
syn keyword fbProperty contained Platform Config Target

" ProjectConfig part
syn keyword fbProperty contained ProjectBuildCommand ProjectRebuildCommand
syn keyword fbProperty contained ProjectCleanCommand Output OutputDirectory
syn keyword fbProperty contained IntermediateDirectory LayoutDir LayoutExtensionFilter
syn keyword fbProperty contained PreprocessorDefinitions IncludeSearchPath
syn keyword fbProperty contained ForcedIncludes AssemblySearchPath
syn keyword fbProperty contained ForcedUsingAssemblies AdditionalOptions
syn keyword fbProperty contained LocalDebuggerCommand LocalDebuggerCommandArguments
syn keyword fbProperty contained LocalDebuggerWorkingDirectory LocalDebuggerEnvironment
syn keyword fbProperty contained Xbox360DebuggerCommand DebuggerFlavor AumidOverride
syn keyword fbProperty contained PlatformToolset DeploymentType DeploymentFiles

" VSSolution properties
syn keyword fbProperty contained SolutionOutput SolutionProjects SolutionConfigs
syn keyword fbProperty contained SolutionBuildProject SolutionFolders
syn keyword fbProperty contained SolutionDependencies SolutionVisualStudioVersion
syn keyword fbProperty contained SolutionMinimumVisualStudioVersion Platform
syn keyword fbProperty contained Config SolutionConfig SolutionPlatform Path
syn keyword fbProperty contained Projects Projects Dependencies

" XCodeProject properties
syn keyword fbProperty contained XCodeBuildToolPath XCodeBuildToolArgs
syn keyword fbProperty contained XCodeBuildWorkingDir ProjectConfigs
syn keyword fbProperty contained XCodeOrganizationName Config Target

"
" Highlight mappings
"
if version >= 508 || !exists("fastbuild_did_init")
	if version < 508
		lef fastbuild_did_init = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif

	HiLink fbTodo           Todo
	HiLink fbComment        Comment

	HiLink fbEscape         SpecialChar
	HiLink fbVariablePaste  Special
	HiLink fbBTSubstitution Special
	HiLink fbString         String
	HiLink fbInteger        Number
	HiLink fbBoolConstant   Boolean

	HiLink fbVariableName   Identifier

	HiLink fbDefineToken    Constant
	HiLink fbDefine         Define
	HiLink fbPredefSymbol   Keyword
	HiLink fbInclude        Include
	HiLink fbIf             PreCondit
	HiLink fbElseEndif      PreCondit
	HiLink fbImport         PreProc
	HiLink fbOnce           PreProc

	" FASTBuild functions are actually statements
	HiLink fbFunction       Statement

	" Since variable types are implicit, we reuse Type to highlight builtin properties
	HiLink fbProperty       Type

	" Don't highlight operators by default (it looks very busy)
	if exists('fastbuild_operators')
		HiLink fbVariablePrefix Operator
		HiLink fbKeyword        Keyword
		HiLink fbOperator       Operator
	endif

	delcommand HiLink
endif

let b:current_syntax = "fastbuild"
