config_yml = YAML.load_file("#{Rails.root}/config/mandrill.yml")
MANDRILL_USERNAME = config_yml["user_name"]
MANDRILL_PASSWORD = config_yml["password"]