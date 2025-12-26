format:
	stylua nvim/
	prettier --write --ignore-path .gitignore "**/*.json" "**/*.yaml" "**/*.yml"
	shfmt -w -i 2 zsh/.zshrc tc/*.sh
