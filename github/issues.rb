class Issues

  def initialize github_instance

    @github = github_instance

  end

  def github; return @github end
  
  def get_issues page = 0
    
    issue_list = Hash.new

    response = github.issues.list org:'Sauropod-Studio', state:'all', filter:'all', page:page, per_page:'100'

    response.each do |resource|

      next if resource["pull_request"]
      next if resource["repository_url"] != "https://api.github.com/repos/Sauropod-Studio/castlestory-game"

      this_issue = Hash.new
      this_issue["title"] = resource["title"]
      this_issue["repo"]= resource["repository_url"]
      this_issue["creator"] = resource.dig("user","login")
      this_issue["assignee"] = resource.dig("assignee","login")
      this_issue["milestone"] = resource.dig("milestone","title")
      
      this_issue["labels"] = Array.new
      resource["labels"].each do |label|
        this_issue["labels"].push(label["name"])
      end
      
      this_issue["state"] = resource["state"]
      this_issue["closed_at"] = resource["closed_at"]
      this_issue["created_at"] = resource["created_at"]
      this_issue["updated_at"] = resource["updated_at"]
      issue_list[:"#{resource["number"]}"] = this_issue

    end

    return issue_list

  end

end