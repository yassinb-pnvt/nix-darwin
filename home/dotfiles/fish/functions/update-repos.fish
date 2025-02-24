function update-repos --description 'Small function to update all the repos from the current dir (projects or project/paynovate)'
	fd . --maxdepth 1 -x sh -c " echo 'Updating repo {}' && cd {} && git pull"
end
