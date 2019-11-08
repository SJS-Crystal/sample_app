User.create! name: Settings.name_admin_faker,
  email: Settings.email_admin_faker,
  password: Settings.password_admin_faker,
  password_confirmation: Settings.password_admin_faker,
  admin: true,
  activated: true,
  activated_at: Time.zone.now

99.times do |n|
name = Faker::Name.name
email = "#{Settings.username_email_customer_faker}#{n+1}@" <<
  Settings.domain_email_faker
password = Settings.password_customer_faker
User.create! name: name, email: email, password: password,
  password_confirmation: password,
  activated: true,
  activated_at: Time.zone.now
end
