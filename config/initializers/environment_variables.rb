module EnvironmentVariablesExample
  class Application < Rails::Application
    config.before_configuration do
      #env_file = Rails.root.join("config", 'environment_variables.yml').to_s
      env_file = "/home/deploy/.bootops.yaml"
      if File.exists?(env_file)
        YAML.load_file(env_file).each do |key, value|
        if key == 'environment'
          ENV['RAILS_ENV'] = value
        end
        end # end YAML.load_file
      end # end if File.exists?
    end # end config.before_configuration
  end # end class
end # end module
