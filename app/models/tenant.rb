# == Schema Information
#
# Table name: tenants
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tenant < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :name, length: { in: 3..50 }
    has_many :members, dependent: :destroy
    has_many :users, through: :members

    def to_s
        name
    end
end

# Scoping is done/set when the current tenant is set ( act_as_tenant limitation )
# Workaround is that users with no set tenant will not be able to access tenanted models