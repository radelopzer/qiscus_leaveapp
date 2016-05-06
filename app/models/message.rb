class Message < ActiveRecord::Base
	belongs_to :user

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
end