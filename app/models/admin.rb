class Admin < ApplicationRecord
  has_secure_password
  # 标记：通过 CLI 创建或修改时设置为 true
  attr_accessor :created_via_cli

  validates :username, presence: true, uniqueness: true
  validate :created_only_via_cli, on: :create

  # 仅供命令行 / 管理脚本创建或更新
  def self.create_or_update_admin!(username:, password:, **attrs)
    admin = find_or_initialize_by(username: username)
    admin.assign_attributes(attrs)
    admin.password = password if password.present?
    admin.created_via_cli = true
    admin.save!
    admin
  end

  # 仅供命令行 / 管理脚本重置密码
  def self.reset_password_for!(username:, password:)
    admin = find_by!(username: username)
    admin.password = password
    admin.created_via_cli = true
    admin.save!
    admin
  end

  private

  def created_only_via_cli
    if new_record? && !created_via_cli
      errors.add(:base, "管理员只能通过命令行创建")
    end
  end
end
