Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '288275221194002', '14a3cbc41c21448341cd82b356c94c2d'
end