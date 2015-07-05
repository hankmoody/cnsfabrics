DROPBOX_CFG  = YAML.load_file(Rails.root.join('config/dropbox.yml'))[Rails.env]
MIXPANEL_CFG = YAML.load_file(Rails.root.join('config/mixpanel.yml'))[Rails.env]
