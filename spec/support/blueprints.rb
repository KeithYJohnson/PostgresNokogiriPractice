require 'machinist/active_record'

Article.blueprint do
  title {"My amazing article"}

end

User.blueprint do
  # Attributes here
end
