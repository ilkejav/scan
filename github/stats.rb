require "json"

class Stats

  def name; return "stats" end

  def initialize

    begin
      @content = File.new('Apps/scan/github/issues.json', 'r')
      @issues = JSON.load(@content)
    rescue JSON::ParserError => e
      puts e
    end

  end

  # def content; return @content end
  def issues; return @issues end

  def get_stats params = nil
    
    # puts "go criss"
    response = iterate_issues

    return response

  end

  def iterate_issues

    stats = Hash.new
    # puts issues.size
    issues.each do |key, value| # iterate over all issues

      value.each do |key, value| # iterate over all key/value pairs
    
        case key
        when "title", "created_at", "updated_at", "closed_at", "labels", "user", "repo"
          next
        else

          if !stats.has_key?(key)
            stats[key] = Hash.new
            stats[key][value] = 1 
            next
          end

          # value = "none" unless value

          if stats[key].include?(value)
            stats[key][value] += 1
            # puts "increment!"
          else
            stats[key][value] = 0
            # puts "new!"
          end

        end

      end


    end

    stats.each do |key, value|

      # puts key

      value.each do |section, count|
      
      puts "#{value} #{section}"
      sorted = value.sort_by{|k,v|v}
      value = sorted 
      # puts sorted
      # value = sorted

      end

    end
   
    return stats

  end

end