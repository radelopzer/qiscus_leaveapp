class Promo < ActiveRecord::Base
	belongs_to :user, class_name: "User",
                    foreign_key: "taker_id"

    belongs_to :taker, :class_name => 'User', foreign_key: 'employee'
    belongs_to :management, :class_name => 'User', foreign_key: 'taker_id'
end