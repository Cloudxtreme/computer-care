config_yml = YAML.load_file("#{Rails.root}/config/site_host.yml")
SITE_HOST = config_yml[Rails.env]["host"]