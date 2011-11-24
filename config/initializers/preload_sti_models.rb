if Rails.env.development?
  %w[listing buy_listing sell_listing].each do |c|
    require_dependency File.join("app","models","#{c}.rb")
  end
end