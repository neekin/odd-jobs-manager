class FaDeusoddUser < ExternalRecord
  self.table_name = "fa_deusodd_user"
  belongs_to :group, class_name: "FaDeusoddGroup", foreign_key: "group_id", optional: true
  has_many :project_users, class_name: "FaDeusoddProjectUser", foreign_key: "user_id"
  has_many :projects, through: :project_users, class_name: "FaDeusoddProject"
  has_many :attends, class_name: "FaDeusoddProjectAttend", foreign_key: "user_id"
  has_many :records, class_name: "FaDeusoddRecord", foreign_key: "user_id"
  has_many :moneylogs, class_name: "FaDeusoddMoneylogs", foreign_key: "user_id"
  has_many :parentslogs, class_name: "FaDeusoddParentslogs", foreign_key: "user_id"
  has_many :user_logs, class_name: "FaDeusoddUserLog", foreign_key: "user_id"
  has_many :user_lates, class_name: "FaDeusoddUserLate", foreign_key: "user_id"
  has_many :user_lateyzs, class_name: "FaDeusoddUserLateyz", foreign_key: "user_id"

  def tags
    return FaDeusoddTag.none if !respond_to?(:tag_ids) || tag_ids.blank?
    ids = tag_ids.to_s.split(",").map(&:strip).reject(&:blank?).map(&:to_i)
    FaDeusoddTag.where(id: ids)
  end

  def created_at_ts
    ts = createtime.to_i
    return nil if ts.zero?
    ts > 10_000_000_000 ? Time.at(ts / 1000.0) : Time.at(ts)
  end
  def updated_at_ts
    ts = updatetime.to_i
    return nil if ts.zero?
    ts > 10_000_000_000 ? Time.at(ts / 1000.0) : Time.at(ts)
  end
end
