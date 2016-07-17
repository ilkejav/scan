class Milestones

  def initialize github_instance

    @github = github_instance

  end

  def github; return @github end

  def get_milestones

    milestones_list = Hash.new

    response = github.issues.milestones.list

    response.each do |resource|

      this_milestone = Hash.new
      this_milestone["title"] = resource["title"]
      this_milestone["description"] = resource["description"]
      this_milestone["state"] = resource["state"]
      this_milestone["closed_issues"] = resource["closed_issues"]
      this_milestone["open_issues"] = resource["open_issues"]
      this_milestone["closed_at"] = resource["closed_at"]
      milestones_list["#{resource["number"]}"] = this_milestone

    end

    return milestones_list

  end
  
end