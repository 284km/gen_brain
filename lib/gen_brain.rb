require "gen_brain/version"
require "gen_brain/generator"
require "yaml"

module GenBrain
  def self.generate
    config_file_name = ARGV[0] || "config.yml"
    puts "⭐️ Input config file nam #=> #{config_file_name}"
    Generator.new(YAML.load_file(config_file_name)).call
  end
end
