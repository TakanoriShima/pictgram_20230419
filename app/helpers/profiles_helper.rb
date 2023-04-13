module ProfilesHelper
  def user_profile_nil?(user)
    !user.profile.nil?
  end
end
