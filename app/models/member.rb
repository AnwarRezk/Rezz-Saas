# == Schema Information
#
# Table name: members
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  tenant_id  :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Member < ApplicationRecord
  belongs_to :user
  belongs_to :tenant

  validates :tenant_id, presence: true
  validates_uniqueness_of :user_id, scope: :tenant_id, message: 'already associated with a tenant'
  acts_as_tenant(:tenant)
end
