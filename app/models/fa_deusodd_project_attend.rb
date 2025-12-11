class FaDeusoddProjectAttend < ExternalRecord
  self.table_name = "fa_deusodd_project_attend"
  belongs_to :project, class_name: "FaDeusoddProject", foreign_key: "project_id", optional: true
  belongs_to :user, class_name: "FaDeusoddUser", foreign_key: "user_id", optional: true

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
