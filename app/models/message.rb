class Message < ActiveRecord::Base
	belongs_to :user, class_name: "User",
                        foreign_key: "user_id"

 # has_and_belongs_to_many :users

	def calculate_working_day
    c = 0

    (leave_start_date.to_date..leave_end_date.to_date). each do |date|
      unless date.sunday?||date.saturday?

        c+=1 
      end
    end
    c
  end

  def approve
  	update!(approval_status: 'APPROVED')
  end

  def reject
  	update!(approval_status: 'REJECTED')
  end
end