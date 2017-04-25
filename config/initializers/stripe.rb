# Store the environment variables on the Rails.configuration object
Rails.configuration.stripe = {
  publishable_key: ENV['pk_test_mNYddqZXZqeqWmqpDjVFqcFL'],
  secret_key: ENV['sk_test_cqroFt1BaigijKAoxT6FBU8Y']
}
 
# Set our app-stored secret key with Stripe
Stripe.api_key = Rails.configuration.stripe[:secret_key]