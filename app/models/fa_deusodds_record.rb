class FaDeusoddsRecord < ExternalRecord
  self.table_name = "fa_deusodds_record"
  belongs_to :user, class_name: "FaDeusoddUser", foreign_key: "user_id", optional: true
  # bat_id 为 int
  # belongs_to :batch, class_name: 'FaDeusoddsBatches', foreign_key: 'bat_id', primary_key: 'id', optional: true

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
