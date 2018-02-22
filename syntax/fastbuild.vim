" Vim syntax file
" Language:    FASTBuild

" Quit when a (custom) syntax file was already loaded
if v:version < 600
	syntax clear
elseif exists('b:current_syntax')
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
syn keyword fbFunction Alias
syn keyword fbFunction Compiler
syn keyword fbFunction Copy
syn keyword fbFunction CopyDir
syn keyword fbFunction CSAssembly
syn keyword fbFunction DLL
syn keyword fbFunction Exec
syn keyword fbFunction Executable
syn keyword fbFunction ForEach
syn keyword fbFunction Library
syn keyword fbFunction ObjectList
syn keyword fbFunction Print
syn keyword fbFunction RemoveDir
syn keyword fbFunction Settings
syn keyword fbFunction Test
syn keyword fbFunction Unity
syn keyword fbFunction Using
syn keyword fbFunction VCXProject
syn keyword fbFunction VSSolution
syn keyword fbFunction XCodeProject

" Function properties
syn keyword fbProperty contained AdditionalOptions
syn keyword fbProperty contained AllowCaching
syn keyword fbProperty contained AllowDistribution
syn keyword fbProperty contained ApplicationEnvironment
syn keyword fbProperty contained AssemblySearchPath
syn keyword fbProperty contained AumidOverride
syn keyword fbProperty contained BuildLogFile
syn keyword fbProperty contained CachePath
syn keyword fbProperty contained CachePluginDLL
syn keyword fbProperty contained ClangRewriteIncludes
syn keyword fbProperty contained Compiler
syn keyword fbProperty contained CompilerFamily
syn keyword fbProperty contained CompilerForceUsing
syn keyword fbProperty contained CompilerInputExcludedFiles
syn keyword fbProperty contained CompilerInputExcludePath
syn keyword fbProperty contained CompilerInputExcludePattern
syn keyword fbProperty contained CompilerInputFiles
syn keyword fbProperty contained CompilerInputFilesRoot
syn keyword fbProperty contained CompilerInputPath
syn keyword fbProperty contained CompilerInputPathRecurse
syn keyword fbProperty contained CompilerInputPattern
syn keyword fbProperty contained CompilerInputUnity
syn keyword fbProperty contained CompilerOptions
syn keyword fbProperty contained CompilerOptionsDeoptimized
syn keyword fbProperty contained CompilerOutput
syn keyword fbProperty contained CompilerOutputExtension
syn keyword fbProperty contained CompilerOutputPath
syn keyword fbProperty contained CompilerOutputPrefix
syn keyword fbProperty contained CompilerReferences
syn keyword fbProperty contained Config
syn keyword fbProperty contained CustomEnvironmentVariables
syn keyword fbProperty contained DebuggerFlavor
syn keyword fbProperty contained DefaultLanguage
syn keyword fbProperty contained DeoptimizeWritableFiles
syn keyword fbProperty contained DeoptimizeWritableFilesWithToken
syn keyword fbProperty contained Dependencies
syn keyword fbProperty contained DeploymentFiles
syn keyword fbProperty contained DeploymentType
syn keyword fbProperty contained Dest
syn keyword fbProperty contained DistributableJobMemoryLimitMiB
syn keyword fbProperty contained Environment
syn keyword fbProperty contained ExecArguments
syn keyword fbProperty contained ExecExecutable
syn keyword fbProperty contained ExecInput
syn keyword fbProperty contained ExecInputExcludedFiles
syn keyword fbProperty contained ExecInputExcludePath
syn keyword fbProperty contained ExecInputExcludePattern
syn keyword fbProperty contained ExecInputPath
syn keyword fbProperty contained ExecInputPathRecurse
syn keyword fbProperty contained ExecInputPattern
syn keyword fbProperty contained ExecOutput
syn keyword fbProperty contained ExecReturnCode
syn keyword fbProperty contained ExecUseStdOutAsOutput
syn keyword fbProperty contained Executable
syn keyword fbProperty contained ExecutableRootPath
syn keyword fbProperty contained ExecWorkingDir
syn keyword fbProperty contained ExtraFiles
syn keyword fbProperty contained FileType
syn keyword fbProperty contained ForcedIncludes
syn keyword fbProperty contained ForcedUsingAssemblies
syn keyword fbProperty contained IncludeSearchPath
syn keyword fbProperty contained IntermediateDirectory
syn keyword fbProperty contained LayoutDir
syn keyword fbProperty contained LayoutExtensionFilter
syn keyword fbProperty contained Librarian
syn keyword fbProperty contained LibrarianAdditionalInputs
syn keyword fbProperty contained LibrarianOptions
syn keyword fbProperty contained LibrarianOutput
syn keyword fbProperty contained Libraries
syn keyword fbProperty contained Linker
syn keyword fbProperty contained LinkerAssemblyResources
syn keyword fbProperty contained LinkerLinkObjects
syn keyword fbProperty contained LinkerOptions
syn keyword fbProperty contained LinkerOutput
syn keyword fbProperty contained LinkerStampExe
syn keyword fbProperty contained LinkerStampExeArgs
syn keyword fbProperty contained LinkerType
syn keyword fbProperty contained LocalDebuggerCommand
syn keyword fbProperty contained LocalDebuggerCommandArguments
syn keyword fbProperty contained LocalDebuggerEnvironment
syn keyword fbProperty contained LocalDebuggerWorkingDirectory
syn keyword fbProperty contained Output
syn keyword fbProperty contained OutputDirectory
syn keyword fbProperty contained Path
syn keyword fbProperty contained Pattern
syn keyword fbProperty contained PCHInputFile
syn keyword fbProperty contained PCHOptions
syn keyword fbProperty contained PCHOutputFile
syn keyword fbProperty contained Platform
syn keyword fbProperty contained PlatformToolset
syn keyword fbProperty contained PreBuildDependencies
syn keyword fbProperty contained Preprocessor
syn keyword fbProperty contained PreprocessorDefinitions
syn keyword fbProperty contained PreprocessorOptions
syn keyword fbProperty contained ProjectAllowedFileExtensions
syn keyword fbProperty contained ProjectBasePath
syn keyword fbProperty contained ProjectBuildCommand
syn keyword fbProperty contained ProjectCleanCommand
syn keyword fbProperty contained ProjectConfigs
syn keyword fbProperty contained ProjectFiles
syn keyword fbProperty contained ProjectFilesToExclude
syn keyword fbProperty contained ProjectFileTypes
syn keyword fbProperty contained ProjectGuid
syn keyword fbProperty contained ProjectInputPaths
syn keyword fbProperty contained ProjectInputPathsExclude
syn keyword fbProperty contained ProjectOutput
syn keyword fbProperty contained ProjectPatternToExclude
syn keyword fbProperty contained ProjectProjectReferences
syn keyword fbProperty contained ProjectRebuildCommand
syn keyword fbProperty contained ProjectReferences
syn keyword fbProperty contained Projects
syn keyword fbProperty contained ProjectSccEntrySAK
syn keyword fbProperty contained RemoveExcludePaths
syn keyword fbProperty contained RemovePaths
syn keyword fbProperty contained RemovePathsRecurse
syn keyword fbProperty contained RemovePatterns
syn keyword fbProperty contained RootNamespace
syn keyword fbProperty contained SimpleDistributionMode
syn keyword fbProperty contained SolutionBuildProject
syn keyword fbProperty contained SolutionConfig
syn keyword fbProperty contained SolutionConfigs
syn keyword fbProperty contained SolutionDependencies
syn keyword fbProperty contained SolutionFolders
syn keyword fbProperty contained SolutionMinimumVisualStudioVersion
syn keyword fbProperty contained SolutionOutput
syn keyword fbProperty contained SolutionPlatform
syn keyword fbProperty contained SolutionProjects
syn keyword fbProperty contained SolutionVisualStudioVersion
syn keyword fbProperty contained Source
syn keyword fbProperty contained SourceBasePath
syn keyword fbProperty contained SourceExcludePaths
syn keyword fbProperty contained SourcePaths
syn keyword fbProperty contained SourcePathsPattern
syn keyword fbProperty contained SourcePathsRecurse
syn keyword fbProperty contained Target
syn keyword fbProperty contained Targets
syn keyword fbProperty contained TestAlwaysShowOutput
syn keyword fbProperty contained TestArguments
syn keyword fbProperty contained TestExecutable
syn keyword fbProperty contained TestOutput
syn keyword fbProperty contained TestTimeOut
syn keyword fbProperty contained TestWorkingDir
syn keyword fbProperty contained UnityInputExcludedFiles
syn keyword fbProperty contained UnityInputExcludePath
syn keyword fbProperty contained UnityInputExcludePattern
syn keyword fbProperty contained UnityInputFiles
syn keyword fbProperty contained UnityInputIsolateWritableFiles
syn keyword fbProperty contained UnityInputIsolateWritableFilesLimit
syn keyword fbProperty contained UnityInputObjectLists
syn keyword fbProperty contained UnityInputPath
syn keyword fbProperty contained UnityInputPathRecurse
syn keyword fbProperty contained UnityInputPattern
syn keyword fbProperty contained UnityNumFiles
syn keyword fbProperty contained UnityOutputPath
syn keyword fbProperty contained UnityOutputPattern
syn keyword fbProperty contained UnityPCH
syn keyword fbProperty contained VS2012EnumBugFix
syn keyword fbProperty contained WorkerConnectionLimit
syn keyword fbProperty contained Workers
syn keyword fbProperty contained Xbox360DebuggerCommand
syn keyword fbProperty contained XCodeBuildToolArgs
syn keyword fbProperty contained XCodeBuildToolPath
syn keyword fbProperty contained XCodeBuildWorkingDir
syn keyword fbProperty contained XCodeOrganizationName

"
" Highlight mappings
"
if v:version >= 508 || !exists('fastbuild_did_init')
	if v:version < 508
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

let b:current_syntax = 'fastbuild'
