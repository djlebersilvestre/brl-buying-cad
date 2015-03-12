# Trick to allow descendants or subclasses method over classes.
Dir[Rails.root + 'app/models/**/*.rb'].map do |f|
  File.basename(f, '.*').camelize.constantize
end
