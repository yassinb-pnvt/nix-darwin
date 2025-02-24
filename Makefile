.PHONY: work mbp

work:
	darwin-rebuild switch --flake .#default

mbp:
	darwin-rebuild switch --flake .#mbp
