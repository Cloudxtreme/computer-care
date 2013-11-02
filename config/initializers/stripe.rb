config_yml = YAML.load_file("#{Rails.root}/config/stripe.yml")

Stripe.api_key = config_yml["secret"]
STRIPE_PUBLIC_KEY = config_yml["public"]