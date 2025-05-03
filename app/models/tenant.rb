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
    has_many :members, dependent: :destroy
    has_many :users, through: :members

    def to_s
        name
    end
end
