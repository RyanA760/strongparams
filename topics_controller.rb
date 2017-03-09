#Topic controller
#Strong params help to improve Mass Assignment issues 

class TopicsController < ApplicationController
	def index
		@topics = Topic.order("Sticky desc")
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(params[:topic], as: current_user.try(:admin?) ? :admin : :user)
		# @topic = Topic.new(topic_params)
		if @topic.save
			redirect_to @topic, notice: "Created topic."
		else 
			render :new
		end
	end

	def edit
		@topic = Topic.find(params[:id])
	end

	def update 
		@topic = Topic.find(params[id])
		if @topic.update_attributes(params[:topic], as: current_user.try(:admin?) ? :admin : :user)
		   # @topic.update_attributes(topic_params)
			
			redirect_to topics_url, notice: "Updated topic."
		else 
			render :edit
		end
	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy
		redirect_to topics_url, notice: "Destroyed topic."

	end


	# private

	# def topic_params
	# 	if current_user && current_user.admin?
	# 		params[:topic].permit(:name, :sticky)
	# 	else
	# 		params[:topic].permit(:name)
	# 	end

	# 	# if current_user && current_user.admin?
	# 	# 	params.require(:topic).permit(:name, :sticky)
	# 	# else
	# 	# 	params.require(:topic).permit(:name)
	# 	# end

	# end
	# also .permit! works to give admins power over anything can be dangerous! (of course)
end