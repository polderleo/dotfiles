# SemanticDiff: Programming Language Aware Diff

> [SemanticDiff](https://semanticdiff.com) helps you understand code changes faster by removing noise and adding useful annotations.

## Features

SemanticDiff adds an alternative diff viewer to VS Code that:
- hides style-only changes or reformattings
- detects moved code
- highlights changes inside moved code
- displays only the changes, not the full file
- lets you decide whether changes in comments should be ignored

All features are implemented locally, your code never leaves your machine! 🔒

### Hides Style-Only Changes / Reformattings
Changes that do not have an effect on the program flow, like optional line breaks or commas, are not shown as change.

![Filtered Changes](https://semanticdiff.com/marketplace/filter_changes.png)

### Detection Of Moved Code

SemanticDiff detects when code was moved within a file. The original and new code block are shown side-by-side to help you spot any changes that were introduced during the move.

![Moved Code](https://semanticdiff.com/marketplace/moved_code.png)

### Works With Other Extensions
SemanticDiff works with any diff opened in VS Code, regardless of whether the diff was opened by an extension. The only requirement is that the used file format / programming language is supported.

Here are few ideas how you could combine SemanticDiff with other extensions:
- Explore code changes in your git history ([GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens))
- Review the commits of a GitHub Pull Request ([GitHub Pull Requests and Issues](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-pull-request-github))
- Review the changes of a GitLab Merge Request ([GitLab Workflow](https://marketplace.visualstudio.com/items?itemName=GitLab.gitlab-workflow))
- Compare folders and diff individual files using SemanticDiff ([Diff Folders](https://marketplace.visualstudio.com/items?itemName=L13RARY.l13-diff))

## Supported Programming Languages
SemanticDiff is a programming language aware diff and therefore needs to be able to understand your code. This requires your code to be syntactically correct and written in one of the following languages or data exchange formats:

- C#
- CSS / SCSS
- Go
- HTML
- Java
- JavaScript / JSX
- JSON
- Lua
- PO (gettext)
- Python
- Rust
- TypeScript / TSX
- Vue
- XML / DTD

More programming languages / data exchange formats will be added based on the feedback we receive.

## How To Use

### View Code Changes With SemanticDiff
You can switch between the standard VS Code Diff and SemanticDiff by clicking on the SemanticDiff icon in the top right corner:

![SemanticDiff Switch](https://semanticdiff.com/marketplace/switch.gif)

The switching behavior can be further customized via the extension settings. You can, for example, make SemanticDiff the default diff viewer for supported programming languages.

### Load More Context
SemanticDiff gives you a quick overview of all changes by hiding unmodified lines. You can explore the remaining code in two ways:

| ![SemanticDiff - Load More Lines](https://semanticdiff.com/marketplace/show_more.png) | ![SemanticDiff - Load Parent Scope](https://semanticdiff.com/marketplace/show_scope.png) |
| :----------: | :----------: |
| **Load More Lines** | **Load Parent Scope** |

**Load More Lines**: Click the *Show More* button at the beginning or end of a code change to load 20 additional lines.

**Load Parent Scope**: Each code change header lists the scopes that are active at the start of the block, i.e. the classes or functions the first line belongs to. Click on a scope to expand its full contents.

If you would like to see more of the surrounding code by default, you may want to adjust the *Context Lines* [setting](#extension-settings). The standard value is 3 lines above and below a change.
### Hide/Show Changes in Comments

You can toggle whether changes in comments should be ignored by clicking on the *Hide Comment Changes* or *Show Comment Changes* icon in the top right corner.

| ![SemanticDiff - Changes in comments are shown](https://semanticdiff.com/marketplace/comments_shown.png) | ![SemanticDiff - Changes in comments are hidden](https://semanticdiff.com/marketplace/comments_hidden.png) |
| :----------: | :----------: |
| **Changes in comments are shown** | **Changes in comments are hidden** |

Please note that toggling this setting will lead to a recomputation of the diff. Any changes you made to the files being diffed become visible and any manually loaded parts of the code will be collapsed again.

## Extension Settings
You can customize the behavior of SemanticDiff with the following options.

| Option                               | Default    | Description                                                                    |
|--------------------------------------|------------|--------------------------------------------------------------------------------|
| `semanticdiff.defaultDiffViewer`     | `false`    | Whether SemanticDiff should be the default diff viewer in VS Code              |
| `semanticdiff.closeOriginalTab`      | `false`    | Whether the original diff tab should be closed when switching to SemanticDiff  |
| `semanticdiff.fallbackDiff`          | `true`     | Controls whether to fallback to a regular diff without semantic features in case of an error |
| `semanticdiff.colorIcon`             | `true`     | Specifies whether the SemanticDiff icon should use its own color instead of the theme color |
| `semanticdiff.minimap`               | `detailed` | The type of minimap SemanticDiff should use.                                   |
| `semanticdiff.diff.contextLines`     | `3`        | The amount of context lines shown above and below a change                     |
| `semanticdiff.diff.hideComments`     | `false`    | Whether changes in comments should be ignored by default                       |
| `semanticdiff.diff.compareMovedCode` | `false`    | Whether moved code blocks should be shown in comparison mode by default        |

Just search for SemanticDiff in **Settings** and adjust the options to suit your needs. The changes will become active the next time a diff is generated.

## Known Limitations

- Not all diff editor features are available in SemanticDiff. The VS Code extension API doesn't provide a way to change how diffs are rendered and we had to implement our own diff renderer. We tried to replicate the most basic features for now. Feel free to [open an issue](https://github.com/Sysmagine/SemanticDiff/issues) if you miss a feature and we will check if it is feasible to implement.
- Diffs can not be generated for syntactically incorrect code.

## Data and Telemetry

This extension processes all data locally, ensuring that your source code never leaves your machine.

In order to continuously improve our products and services, this extension collects anonymous usage data and sends it to us at Sysmagine GmbH. Read our [privacy statement](https://semanticdiff.com/privacy-policy-vscode/) to learn more. Collection of telemetry is controlled via the same setting provided by Visual Studio Code: `telemetry.enableTelemetry`. For more details on how to opt-out, please check the [VS Code documentation](https://code.visualstudio.com/docs/supporting/faq#_how-to-disable-telemetry-reporting).


---
*SemanticDiff is a product by Sysmagine GmbH based in Heidelberg, Germany ([Impressum](https://semanticdiff.com/impressum/))*
