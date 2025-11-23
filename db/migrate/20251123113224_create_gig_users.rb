class CreateGigUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :gig_users do |t|
      t.string  :serialno,        default: "",  comment: "工号"
      t.integer :user_id,         null: false, default: 0, comment: "关联会员ID"
      t.string  :user_type,       default: "wechat", limit: 10, comment: "用户类型: wechat/wxapp/h5"
      t.references :gig_group,    foreign_key: { to_table: :gig_groups }, index: true, comment: "组别ID"
      t.integer :parent_id,       default: 0,  comment: "上级用户ID"
      t.string  :parent_serialno, comment: "上级工号"
      t.string  :unionid,         limit: 80,   default: "", comment: "开放平台UNIONID"
      t.string  :openid,          limit: 80,   default: "", comment: "公众号OPENID"
      t.string  :wxapp_openid,    limit: 32,   default: "", comment: "小程序OPENID"
      t.string  :nickname,        limit: 64,   default: "", comment: "微信昵称"
      t.string  :truename,                     default: "", comment: "真实姓名"
      t.string  :headimgurl,      limit: 256,  default: "", comment: "微信头像"
      t.string  :sex,             default: "0", limit: 1, comment: "性别:0=未知,1=男,2=女"
      t.string  :language,        default: "", comment: "用户语言"
      t.string  :country,         default: "", comment: "用户所在国家"
      t.string  :province,        default: "", comment: "用户所在省份"
      t.string  :city,            default: "", comment: "用户所在城市"
      t.string  :pay_type,        default: "wxpay", limit: 10, comment: "发薪方式"
      t.string  :pay_image,                     comment: "收款码"
      t.string  :remark,          default: "", comment: "备注"
      t.string  :group_remark,    default: "", comment: "分组备注"
      t.decimal :amount,          precision: 10, scale: 2, null: false, default: "0.00", comment: "月薪"
      t.decimal :total_amount,    precision: 10, scale: 2, null: false, default: "0.00", comment: "累计发薪"
      t.bigint  :lastpay_time,                 comment: "上次发薪时间"
      t.string  :subscribe,       default: "0", limit: 1, comment: "关注公众号:0=未关注,1=已关注"
      t.bigint  :subscribe_time,                comment: "关注公众号时间"
      t.string  :status,          default: "1", limit: 1, comment: "状态:0=拉黑,1=正常"
      # 保留原来的时间字段（如你需要 unix 时间戳）
      t.bigint  :createtime,                   comment: "创建时间"
      t.bigint  :updatetime,                   comment: "更新时间"
      t.bigint  :deletetime,                   comment: "删除时间"
      t.float   :money,           null: false, default: 0.00, comment: "薪资"
      t.string  :state,           default: "1", limit: 1, comment: "状态值:0=禁用,1=正常,2=推荐"
      t.string  :phone,                         comment: "联系方式"
      t.string  :fz_id,                         comment: "负责人id"
      t.string  :sh_id,                         comment: "售后id"
      t.string  :isParent,        default: "0", limit: 1, comment: "是否父节点"
      t.string  :isOnline,        default: "1", limit: 1, comment: "是否上线"
      t.integer :yz_id,                         comment: "云中客会员ID"
      t.string  :zpr,                            comment: "招聘人"
      t.string  :czr,                            comment: "czr"
      t.string  :late_czr,                       comment: "迟到操作人"
      t.string  :late_status,    default: "3", limit: 1, comment: "迟到状态:1=迟到,2=换人,3=正常"

      t.timestamps
    end

    add_index :gig_users, :parent_id
    add_index :gig_users, :openid
    add_index :gig_users, :serialno
  end
end
