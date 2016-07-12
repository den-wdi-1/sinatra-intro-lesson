require 'json'

class HighFiveTracker < Sinatra::Base

	@@team_members = [{'name' => 'Fry', 'high5s' => 3}, {'name' => 'Professor', 'high5s' => 1},{'name' => 'Bender', 'high5s' => -2}, {'name' => 'Leela', 'high5s' => 1001}]

	get '/team_members' do
		@team_members = @@team_members
		erb :index
	end 

	get '/team_members/new' do 
		erb :new
	end

	get '/team_members/:id' do
		@team_member = @@team_members[params['id'].to_i]
		@team_member['picture'] = 'some_url' unless params['picture'].nil?
		erb :show
	end

	post '/team_members' do
		p request.body.read
		request.body.rewind
		form_data = URI::decode_www_form(request.body.read).to_h 
		p form_data
		@@team_members.push form_data
		
		redirect to('/team_members')
	end
end