class ShortenurlsController < ApplicationController
 respond_to :json
 def index
		result = Hash.new
	 	result['error_messages'] = []
	 	result['success_messages'] = []
	 	result['status'] = true
	 
	 	params[:url] = 'http://google.co.in'

	 	if !params[:url].blank? && !Urlshortner.find_by(url: params[:url]).nil?
	 		redirect_to 'http://google.co.in' and return
	 		# if i am redirecting to the home page getting not properly redirected error.
		elsif !params[:url].blank?
			tiny_url = ""
			until Urlshortner.find_by(tinyurl: tiny_url).nil? 
				tiny_url = (0...8).map { (65 + rand(26)).chr }.join.downcase
			end
			shorten_url = Urlshortner.create(url: params[:url], tinyurl: tiny_url)
			puts tiny_url.inspect
			result['tiny_url'] = shorten_url.tinyurl
			result['success_messages'] << 'Url successfully shortened.' 
		else
			result['error_messages'] << 'Url can not be blank.'
			result['status'] &= false
		end
	 	respond_to do |format|
	 		format.json { render json: result}
	 	end
	
	end
end

# http://localhost:3000/shortenurls/index.json