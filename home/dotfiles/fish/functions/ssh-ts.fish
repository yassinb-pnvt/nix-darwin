function ssh-ts --description 'Finds all the peer devices in tailscale and connects to it'
	# TODO : Add more use cases with args like ssh'ing into other users if necessary or change the user.
	# TODO : Make a better fzf window with tmux, maybe with ts status, test ping, add other functionalities with other fzf binds
	set fzfcmd "enter:become(ssh {}),alt-enter:become(ssh root@{} ),ctrl-e:change-preview(echo {\$json_ip} | jq '.Peer[]  | select( .HostName == \"{}\") ' | bat --style=numbers --color=always --language=json),ctrl-r:change-preview-label(Testing connection: {})+change-preview( ping {})"
	set -Ux json_ip (tailscale status --json) && echo $json_ip | jq '. | .Peer[] | .HostName' --raw-output | fzf --multi --preview "echo {\$json_ip} | jq '.Peer[]  | select( .HostName == \"{}\" ) | { Name: .HostName, OS:.OS, DNSName:.DNSName, IPs: .TailscaleIPs, Online: .Online }' | bat --style=numbers --color=always --language=json" --bind $fzfcmd --tmux 60%; set -e json_ip
end
