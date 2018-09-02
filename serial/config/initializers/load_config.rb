CONFIG_PATH="#{Rails.root}/config/config.yml"
APP_CONFIG_TEMP = YAML.load_file(CONFIG_PATH)
APP_CONFIG = {}
APP_CONFIG.merge!(APP_CONFIG_TEMP['default'])
if APP_CONFIG_TEMP[Rails.env]
  APP_CONFIG.merge!(APP_CONFIG_TEMP[Rails.env])
end


