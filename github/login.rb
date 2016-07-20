class Login

  def initialize

    file = File.open("Apps/scan/github/github.login", "r")
    file.readlines.each do |line|
      @userpass = line.split(": ").last.strip if line.include?("userpass: ")
      @user = line.split(": ").last.strip if line.include?("user: ")
      @org = line.split(": ").last.strip if line.include?("org: ")
      @repo = line.split(": ").last.strip if line.include?("repo: ")
    end
    file.close

  end
  
  def get_userpass; return @userpass end
  def get_org; return @org end
  def get_user; return @user end
  def get_repo; return @repo end

end