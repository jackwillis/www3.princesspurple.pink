desc 'Seed privacy policies'
task 'privacy_policies:seed' => :environment do
  SeedPrivacyPolicies.new.call
end
