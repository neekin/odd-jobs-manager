class FaDeusoddProject < ExternalRecord
  self.table_name = "fa_deusodd_project"
  has_many :project_users, class_name: "FaDeusoddProjectUser", foreign_key: "project_id"
  has_many :users, through: :project_users, class_name: "FaDeusoddUser"
  has_many :attends, class_name: "FaDeusoddProjectAttend", foreign_key: "project_id"

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
