function whoserver

  set server= $argv
  for server in servers;
    #  Tailscale scan
    ssh root@$server "who" | awk '{print $5}' | sed 's/[()]//g' | while read ip; 
        tailscale whois --json $ip | jq '. |  "Machine: " + .Node.ComputedName + " running for user: " +.UserProfile.LoginName '  
    end
  end 
end
