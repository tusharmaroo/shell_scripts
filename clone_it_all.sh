curl -u tusharmaroo -s https://api.github.com/orgs/oragnization_name/repos\?per_page\=200 | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone #{repo["ssh_url"]} ]}'

curl -u tusharmaroo -s https://api.bitbucket.org/1.0/users/username | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read)["repositories"].each { |repo| %x[git clone git@bitbucket.org:username/#{repo["slug"]}.git] }'

curl --header "PRIVATE-TOKEN: private_token" https://gitlab.domain.co.in/api/v3/groups/:id | ruby -rubygems -e 'require "json"; JSON.load(STDIN.read)[:projects].each { |repo| %x[git clone #{repo[:ssh_url_to_repo]} }'
