class AdminManager
  class Error < StandardError; end

  def self.create_admin!(username:, password:, **attrs)
    raise Error, "username required" if username.to_s.strip.empty?
    raise Error, "password required" if password.to_s.strip.empty?

    Admin.create_or_update_admin!(username: username, password: password, **attrs)
  end

  def self.reset_password!(username:, password:)
    raise Error, "username required" if username.to_s.strip.empty?
    raise Error, "password required" if password.to_s.strip.empty?

    Admin.reset_password_for!(username: username, password: password)
  end
end
