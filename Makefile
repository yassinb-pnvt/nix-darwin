.PHONY: work mbp

work:
	darwin-rebuild switch --flake .#spren

mbp:
	darwin-rebuild switch --flake .#mbp
