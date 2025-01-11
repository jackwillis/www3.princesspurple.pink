desc 'Import privacy policies'
task 'privacy_policies:import' => :environment do
  ImportPrivacyPolicies.new.call
end
