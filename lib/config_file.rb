module GithubReceiver
  #Parse and return the config file, or false if neither are available
  def self.config
    if File.exists? File.expand_path("~/.github_receiver.conf")
      YAML::load_file(File.expand_path("~/.github_receiver.conf"))
    else
      if File.exists? File.expand_path("/etc/github_receiver.conf")
        YAML::load_file(File.expand_path("/etc/github_receiver.conf"))
      else
        false
      end
    end
  end
end
