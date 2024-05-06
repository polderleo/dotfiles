{ pkgs, ... }: {

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  # Create sourcings for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  users.users.nik.home = "/Users/nik";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };

    taps = [
      "azure/azd"
      "azure/functions"
      "dapr/tap"
      "finestructure/hummingbird"
      "heroku/brew"
      "homebrew/cask-fonts"
      "nektos/tap"
      "nextdns/tap"
      "oven-sh/bun"
      "pulumi/tap"
    ];

    brews = [
      "act" # Run your GitHub Actions locally
      "antidote" # Plugin manager for zsh, inspired by antigen and antibody
      "asciiquarium" # Aquarium animation in ASCII art
      "atuin" # Improved shell history for zsh, bash, fish and nushell
      "azure-cli" # Microsoft Azure CLI 2.0
      "bat" # Clone of cat(1) with syntax highlighting and Git integration
      "cloc" # Statistics utility to count lines of code
      "cmatrix" # Console Matrix
      "php" # General-purpose scripting language
      "composer" # Dependency Manager for PHP
      "dotbot" # Tool that bootstraps your dotfiles
      "eza" # Modern, maintained replacement for ls
      "fd" # Simple, fast and user-friendly alternative to find
      "ffmpeg" # Play, record, convert, and stream audio and video
      "firebase-cli" # Firebase command-line tools
      "fish" # User-friendly command-line shell for UNIX-like operating systems
      "fisher" # Plugin manager for the Fish shell
      "fzf" # Command-line fuzzy finder written in Go
      "gh" # GitHub command-line tool
      "python@3.10" # Interpreted, interactive, object-oriented programming language
      "gitui" # Blazing fast terminal-ui for git written in rust
      "gnu-sed" # GNU implementation of the famous stream editor
      "gnu-tar" # GNU version of the tar archiving utility
      "go" # Open source programming language to build simple/reliable/efficient software
      "helix" # Post-modern modal text editor
      "htop" # Improved top (interactive process viewer)
      "httpie" # User-friendly cURL replacement (command-line HTTP client)
      "imagemagick" # Tools and libraries to manipulate images in many formats
      "lolcat" # Rainbows and unicorns in your console!
      "micromamba" # Fast Cross-Platform Package Manager
      "node@18" # Platform built on V8 to build network applications
      "nushell" # Modern shell for the GitHub era
      "pandoc" # Swiss-army knife of markup format conversion
      "php-cs-fixer" # Tool to automatically fix PHP coding standards issues
      "phpunit" # Programmer-oriented testing framework for PHP
      "postgresql@14" # Object-relational database system
      "pulumi" # Cloud native development platform
      "restic" # Fast, efficient and secure backup program
      "ruby" # Powerful, clean, object-oriented scripting language
      "sl" # Prints a steam locomotive if you type sl instead of ls
      "starship" # Cross-shell prompt for astronauts
      "svgo" # Nodejs-based tool for optimizing SVG vector graphics files
      "tmux" # Terminal multiplexer
      "tree" # Display directories as trees (with optional color/HTML output)
      "watch" # Executes a program periodically, showing output fullscreen
      "yq" # Process YAML, JSON, XML, CSV and properties documents from the CLI
      "zoxide" # Shell extension to navigate your filesystem faster
      "azure/azd/azd" # Azure Developer CLI
      "azure/functions/azure-functions-core-tools@4" # Azure Functions Core Tools 4.0
      "dapr/tap/dapr-cli" # Client for Dapr.
      "oven-sh/bun/bun" # Incredibly fast JavaScript runtime, bundler, transpiler and package manager - all in one.
      "pulumi/tap/pulumictl" # A swiss army knife for Pulumi development
    ];

    casks = [
      # Fonts
      "font-dm-sans"
      "font-inter"
      "font-kumbh-sans"
      "font-lexend"
      "font-montserrat"
      "font-open-sans"
      "font-poppins"
      "font-palanquin"
      "font-roboto"
      "font-space-grotesk"
      "font-source-sans-3"

      # Nerd Fonts
      "font-jetbrains-mono-nerd-font"
      "font-sauce-code-pro-nerd-font"
      "font-hack-nerd-font"
      "font-anonymous-pro"

      # Applications
      "affinity-designer" # Professional graphic design software
      "affinity-photo" # Professional image editing software
      "alacritty" # GPU-accelerated terminal emulator
      "arc" # Chromium based browser
      "bitwarden" # Desktop password and login vault
      "blackhole-2ch" # Virtual Audio Driver
      "calibre" # E-books management software
      "codewhisperer" # AI-powered productivity tool for the command-line
      "cyberduck" # Server and cloud storage browser
      "dbngin" # Database version management tool
      "discord" # Voice and text chat software
      "docker" # App to build and share containerised applications and microservices
      "dropbox" # Client for the Dropbox cloud storage service
      "figma" # Collaborative team software
      "finicky" # Utility for customizing which browser to start
      "firefox" # Web browser
      "flutter" # UI toolkit for building applications for mobile, web and desktop
      "fork" # GIT client
      "google-cloud-sdk" # Set of tools to manage resources and applications hosted on Google Cloud
      "gpg-suite" # Tools to protect your emails and files
      "httpie" # Testing client for REST, GraphQL, and HTTP APIs
      "imageoptim" # Tool to optimise images to a smaller size
      "iterm2" # Terminal emulator as alternative to Apple's Terminal app
      "logseq" # Privacy-first, open-source platform for knowledge sharing and management
      "macfuse" # File system integration
      "missive" # Team inbox and chat tool
      "mos" # Smooths scrolling and set mouse scroll directions independently
      "musescore" # Open-source music notation software
      "ngrok" # Reverse proxy, secure introspectable tunnels to localhost
      "nota" # Markdown files editor
      "notion" # App to write, plan, collaborate, and get organised
      "numi" # Calculator and converter application
      "obsidian" # Knowledge base that works on top of a local folder of plain text Markdown files
      "protonvpn" # VPN client focusing on security
      "proxyman" # HTTP debugging proxy
      "qlmarkdown" # Quick Look generator for Markdown files
      "raycast" # Control your tools with a few keystrokes
      "rectangle" # Move and resize windows using keyboard shortcuts or snap areas
      "rwts-pdfwriter" # Print driver for printing documents directly to a pdf file
      "signal" # Instant messaging application focusing on security
      "spotify" # Music streaming service
      "stats" # System monitor for the menu bar
      "tableplus" # Native GUI tool for relational databases
      "telegram" # Messaging app with a focus on speed and security
      "the-unarchiver" # Unpacks archive files
      "timemator" # Automatic time-tracking application
      "todoist" # To-do list
      "topnotch" # Utility to hide the notch
      "visual-studio-code" # Open-source code editor
      "vlc" # Multimedia player
      "warp" # Rust-based terminal
      "wireshark" # Network protocol analyzer
      "zoom" # Video communication and virtual meeting platform
    ];
  };
}
