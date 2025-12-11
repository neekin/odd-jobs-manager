class FaDeusoddsBatches < ExternalRecord
  self.table_name = "fa_deusodds_batches"
  belongs_to :admin, class_name: "FaDeusoddUser", foreign_key: "admin_id", optional: true

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
