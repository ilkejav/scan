# require_relative "github/github.rb"

class Scan

  def initialize
    
  end

  def name ; return "scan" end
  def github ; return @github end

  def run params

    program_to_scan ||= params.first
    argument ||= params.at(1)
    
    case program_to_scan
    when "github", ""
      load("Apps/scan/github/github.rb")
      github = Github_scan.new
      response = github.run(argument)
      return response
    else
      return "nothing to scan".red
    end

  end

end
