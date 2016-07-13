require 'json'

class HighFiveTracker < Sinatra::Base

	set :method_override, true

	@@team_members = [{'name' => 'Fry', 'high5s' => 3}, {'name' => 'Professor', 'high5s' => 1},{'name' => 'Bender', 'high5s' => -2}, {'name' => 'Leela', 'high5s' => 1001}]

	# create
	post '/team_members' do
		request.body.rewind
		form_data = URI::decode_www_form(request.body.read).to_h 
		@@team_members.push form_data
		
		redirect to('/team_members')
	end

	# delete
	delete '/team_members/:id' do
		@@team_members.delete_at(params['i'].to_i)
		redirect to('/team_members')
	end

	# edit
	get '/team_members/:id/edit' do 
		@team_member = find_team_member
		@index = params['id']
		erb :edit
	end

	# index
	get '/team_members' do
		@team_members = @@team_members
		erb :index
	end 

	# new
	get '/team_members/new' do 
		erb :new
	end

	# show
	get '/team_members/:id' do
		@team_member = find_team_member
		erb :show
	end

	# update 
	put '/team_members/:id' do
		team_member = find_team_member
		request.body.rewind
		form_data = URI::decode_www_form(request.body.read).to_h
		team_member['name'] = form_data['name']
		team_member['high5s'] = form_data['high5s']
		redirect to("/team_members/#{params['id']}")
	end

	def find_team_member
		@@team_members[params['id'].to_i]
	end
end