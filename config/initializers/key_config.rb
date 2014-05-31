require 'yaml'

yaml_data = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'application.yml'))).result)
AWS = HashWithIndifferentAccess.new(yaml_data)