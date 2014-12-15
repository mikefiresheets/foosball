project_type = :rails
project_path = RAILS_ROOT if defined?(RAILS_ROOT)


# Enable Debugging (Line Comments, FireSass)
# Invoke from command line: compass watch -e development --force
if Rails.env.development?
  output_style = :expanded
  # sass_options = { :debug_info => true }
end
