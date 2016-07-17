require "github_api"
require "json"
require "date"
require_relative "issues.rb"
require_relative "collaborators.rb"
require_relative "milestones.rb"

class Github_scan

  def initialize param = nil
    @github = Github.new :basic_auth => 'login',
    :org => 'Sauropod-Studio',
    :user => 'Sauropod-Studio',
    :repo => 'castlestory-game'
  end

  def github ; return @github end

  def run param = nil

    case param
    when "stats"
      
      return "done stats"
    when "issues"

      response_limit = get_rate_limit
      response_pages = get_page_count
      
      issues = Issues.new(github)
      response_hash= Hash.new

      for page in 0..response_pages
        new_page = issues.get_issues(page)
        response_hash = response_hash.merge(new_page) if new_page
      end

      write_to_json("Apps/scan/github/", "issues.json", response_hash.sort_by{|k,v| k.to_i })

      return "Done! #{response_hash.size} issues found"
      
    when "collaborators"
      
      collaborators = Collaborators.new(github)
      response_hash = collaborators.get_collaborators

      write_to_json("Apps/scan/github/", "collaborators.json", response_hash)

      return "Done! #{response_hash.size} collaborators found"

    when "milestones"
    
      milestones = Milestones.new(github)
      response_hash = milestones.get_milestones

      write_to_json("Apps/scan/github/", "milestones.json", response_hash)

      return "Done! #{response_hash.size} milestones found"

    else 
      return "nothing to scan".red
    end

  end

  def get_rate_limit

    response = github.ratelimit

    return response

  end

  def get_page_count

    response = github.issues.list(org:'Sauropod-Studio', state:'all', filter:'all',per_page:'100').count_pages 

    return response

  end

  def write_to_json path, name, data

    File.open("#{path}#{name}", "w") do |file|
      file.write(JSON.pretty_generate(data))  
    end

  end

end