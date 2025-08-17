# Changelog

## 0.10.0
- Initial support for Lua
  - Ignore conversion of escape sequence to text and vice-versa
  - Ignore certain conversions of integer / float values
- Initial support for XML/DTD
  - Ignore order of attributes within a tag
  - Ignore conversion from text to CDATA and vice-versa
  - Ignore conversion from character entities to text and vice-versa
  - Ignore whitespace immediately before and after a start or end tag
  - Support for xml:space="preserve" attribute
- Re-implement C# support
  - Switch to Roslyn parser to improve overall quality and bring C# support up to version 13
  - Add support for diffing preprocessor directives
- Improve Rust support
  - Allow dynamic types in where clause
  - Allow integer literals as identifier in struct patterns
  - Ignore order of choices inside of patterns
- Improve Vue support
  - Allow re-ordering of (most) top-level elements
- Improve Go support
  - Ignore re-ordering of imports
- Minimap improvements
  - Add new minimap mode "Detailed" that shows a thumbnail view of the code
  - Add configuration option to switch between different Minimap modes
- Text layer and selection improvements
  - Add support for variable-width character sizes in text layout algorithm
  - Allow text selections that exceed the area displayed on screen
  - Ignore non-code elements (line numbers, headers, etc.) when copying code
  - Improve display of line breaks when lines have a lot of indentation
- Diff quality improvements
  - Avoid showing invariant moves without actual changes
  - Try harder to match text where no nodes were mapped between old/new versions
  - Add support for "node barriers" in ASTs (used for better re-ordering detection)
  - More precise matching of strings, especially if they consist of multiple nodes
  - Improve matching of long texts (>= 200 characters), where an optimization led to sub-optimal results
- Parse old and new files in parallel
- Add option to allow using SemanticDiff as default diff viewer even for unsupported languages
- Fix a bug where jumping to next / previous change didn't work
- Catch errors that are thrown when closing a tab and print them to the console
- Fix automatic closing of tabs by adding a workaround for VS Code bug #228270

## 0.9.0
- Implement support for languages that embed other languages
- Support for syntax highlighting in injected languages
- Add support for Vue
  - Parse embedded template, style and script tags
  - Ignore order of classes in class attributes
  - Ignore order of values in rel attributes
  - Treat HTML entities and their textual representation as invariant
  - Ignore order of attributes in tags unless a v-bind is encountered
  - Treat tag and attribute names as case-insensitive
  - Collapse whitespace according to CSS rules while evaluating all possible states of conditional directives (e.g. v-if)
- Add support for HTML
  - Parse embedded script and style tags
  - Collapse whitespace according to CSS rules (based on default tag display type)
  - Ignore order of attributes in tags
  - Ignore order of classes in class attributes
  - Ignore order of values in rel attributes
  - Ignore value of boolean attributes
  - Treat tag and attribute names as case-insensitive
  - Treat HTML entities and their textual representation as invariant
- Improve JSX/TSX diffs
  - Ignore whitespace according to React's whitespace handling rules
  - Collapse multiple whitespace characters to improve readability of diff
  - Treat HTML entities and their textual representation as invariant
  - Ignore attribute order unless a spread operator is encountered
  - Fix parsing error when encountering invalid HTML entities
- Treat conversion between string and template literals as invariant in JS/TS
- Treat conversion between string literal and raw string literal as invariant in Rust
- Extract more scopes in JS/JSX/TS/TSX
- Ignore order of elements in union pattern in Python
- Various performance improvements
- Improve CSS parsing
- Improve Python parsing
- Improve JSON parsing
- Improve Java parsing
- Improve Rust parsing
- Improve JavaScript/JSX parsing
- Improve TypeScript/TSX parsing

## 0.8.10
- Fix syntax highlighting in remote setups (WSL/dev containers/ssh) by preferring UI side as extension host
- Fix syntax highlighting when grammar and language are defined by two different extensions
- Fix compatibility with themes that use mostly grayscale colors
- Fix jumping to previous / next change when hunk header is centered on screen
- Adjust icons to use VS Code color theme
- Add 'SemanticDiff:' prefix to various commands, disable commands if they are not applicable
- Show hint for GitHub App when diffing files from GitHub repositories

## 0.8.9
- SemanticDiff is no longer in beta 🎉️
- License updated to clarify SemanticDiff stays free after the beta
- Better handling of suspicious unicode characters (e.g. BIDI characters)
- Fix a bug that some unicode characters were incorrectly detected as linebreaks
- Fix a bug that sometimes caused nested copy operations to be displayed incorrectly
- Various performance optimizations
- Improve C# parsing
- Improve CSS parsing
- Improve Python parsing
- Improve Rust parsing
- Improve SCSS parsing

## 0.8.8
- Add support for Rust
- Improve handling of indention changes in Python
- Support for base conversions of integer literals with a postfix (e.g. 13L)
- Treat swapping an explicit parameter list (`(x) => x`) with an implicit parameter (`x => x`) as invariant in C#
- Fix a bug that aborted the diff computation when a certain type of change occurred in a moved code block
- Fix highlighting of characters in the supplementary Unicode planes
- Improved detection of moved code blocks
- Improve CSS parsing

## 0.8.7
- Vastly improved JSON matching
- Support for invariances with arbitrary large integer literals
- Performance improvements
- Minor quality improvements

## 0.8.6
- Initial support for diffing Java files
- Allow to run extension in restricted workspaces
- Add menu item to expand context lines
- Add buttons to expand context lines between hunks
- Ignore conversion between decimal, hexadecimal, binary, and octal numbers
- Fix a bug in the comment matching logic

## 0.8.5
- Indicate whether a moved code block contains changes
- Show only part of the connecting line when the source and target of a move are far apart
- Fix blurry rendering of the connecting line between the source and target of a move
- Show move target as normal insert by default, old behavior is now called compare mode
- Add action menu entry to collapse all manually expanded context lines
- Add minimap
- Improve handling of decorators in TypeScript
- Fix parsing errors in JavaScript/TypeScript when certain keywords are used as property names
- Add support for import() types in TypeScript
- Add support for namespaces in @use SCSS statements
- Improve detection of moved code blocks
- General quality and performance improvements

## 0.8.4
- Use a toggle button in the toolbar to hide/show changes in comments instead of a menu entry
- Treat conversion of anonymous function <-> arrow function as invariance in JavaScript and TypeScript
- Compare integer and float literals case-insensitive and ignore optional underscores
- Add support for gettext .po files
- Ignore re-ordering of messages in .po files
- Ignore re-ordering of keyword arguments in Python
- Display a line-based fallback diff (with move detection) in case a file cannot be parsed
- Don't match lines if they share too little content even though the overall structure stays the same
- Scopes are now wrapped into multiple lines and use ellipsis if they are too long
- Optimize performance of the text similarity calculation
- Do not show grouping for single occurrences of a change
- Merge consecutive copy boxes into a single copy box to reduce visual noise
- Fix a bug related to rendering of deletions within a copy box
- Fix a bug that sometimes incorrectly caused large blocks of code to be marked as changed

## 0.8.3
- Initial support for diffing Go files
- Improved matching of lines between old and new version of the source code
- Avoid unnecessary space when a line in the old code maps to multiple lines in the new code (or vice versa)
- Improved CSS/SCSS parsing:
  * Allow multiple keyframe selectors
  * Allow to leave out left part in child selector in SCSS
  * Support case modifier in attribute selectors
  * Add support for raw urls in url() function
- Improved C# parsing:
  * Allow suppress keyword in pragma warning preprocessor directive
  * Add support for the unsigned right shift operator
  * Better handling of void pointers
  * Support for the scoped modifier
  * Initial, incomplete support for raw strings
  * Various minor improvements
- Improved JavaScript/TypeScript parsing:
  * Do not fail on glimmer templates, treat them as string/text
  * Support for HTML comments
  * Support for static initializer blocks in classes
- Minor improvements to Python parsing
- Improved detection of invariant changes in various programming languages
- Ignore adding or removing of parenthesis around the only parameter of an arrow function in JavaScript

## 0.8.2
- Add initial support for diffing JSON(5) files
- Add support for diffing two unsaved files
- Add entry in the action menu to re-compute the currently opened semantic diff
- Ignore insertion / deletion of parentheses when they have no effect
- Fix missing syntax highlighting for various third-party themes
- Fix breadcrumbs when using SemanticDiff with GitLens
- Improve language detection
- Improve moved line detection
- Improve detection of file encoding

## 0.8.1

- Fix displaying of diff when number of context lines is set to zero
- Indicate when the number of lines in a modified code block differs between the old and new version

## 0.8.0

- First public beta release 🎉
