class FaDeusoddUserTag < ExternalRecord
  self.table_name = "fa_deusodd_user_tag" # 请根据实际表名确认并调整
  self.primary_key = "id"

  self.record_timestamps = false

  belongs_to :user, class_name: "FaDeusoddUser", foreign_key: "user_id", optional: true
  belongs_to :tag, class_name: "FaDeusoddTag", foreign_key: "tag_id", optional: true
end
