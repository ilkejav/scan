class Collaborators

  def initialize github_instance

    @github = github_instance

  end

  def github; return @github end

  def get_collaborators

    collaborators_list = Hash.new

    response = github.repos.collaborators.list

    response.each do |resource|
      collaborators_list["#{resource["login"]}"] = resource["login"]
    end

    return collaborators_list

  end
  
end