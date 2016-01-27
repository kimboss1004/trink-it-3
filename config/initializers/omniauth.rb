Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, (FACEBOOK_CONFIG["app_id"] if FACEBOOK_CONFIG), (FACEBOOK_CONFIG["secret"] if FACEBOOK_CONFIG), {client_options: {ssl: {ca_file: Rails.root.join('lib/assets/cacert.pem').to_s}}}
end

