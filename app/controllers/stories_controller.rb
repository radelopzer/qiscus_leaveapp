class StoriesController < ApplicationController
	layout "dashboard"

	def index
		 @story = Story.all
      		@hash = Gmaps4rails.build_markers(@story) do |story, marker|
		  marker.lat story.latitude
		  marker.lng story.longitude
		  marker.infowindow story.story

		 @new = Story.new
		 @list_stories = Story.all
	end
end

def new
    @story = Story.new
  end


	def create
		@story = Story.new(story_params)
	    	if 	
	    		@story.user_id=current_user.id

				@story.save
				 record_activity(current_user.id, 'write story')	
		
				
		  redirect_to '/stories', notice: 'success to post story'
			else
				render :new, alert: 'fail to create story'
			end
	end


	private

		def story_params
			params.require(:story).permit(:user_id, :story, :latitude, :longitude, :address)
		end
end
