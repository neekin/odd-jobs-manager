class FaDeusoddMoneylog < ExternalRecord
  self.table_name = "fa_deusodd_moneylog"
  belongs_to :group, class_name: "FaDeusoddGroup", foreign_key: "group_id", primary_key: "id", optional: true

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
