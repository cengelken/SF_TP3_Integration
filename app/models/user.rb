class User < ActiveRecord::Base
  def self.from_omniauth(auth)
#    puts auth
#    binding.pry # view what's in the returned omniauth hash from Salesforce
    where(auth.slice(:provider, :uid).permit!).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.instance_url = auth.credentials.instance_url
      user.save!
    end
   end
end
