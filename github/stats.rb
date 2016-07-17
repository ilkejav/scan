require "json"

class Stats

  content = File.open('Apps/scan/github/issues.json', 'r') { |f| f.read }
  JSON.parse(content)


end