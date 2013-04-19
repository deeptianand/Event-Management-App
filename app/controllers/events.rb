post '/create_event' do
  @user = User.find(session[:current_user_id])
  @event = Event.create(:user_id=> @user.id, :name=> params[:name], 
                        :location=>params[:location],:starts_at=>[:starts_at],
                        :ends_at=>params[:ends_at])
  
  if params[:attended].downcase == "no"
    @user.created_events << @event 
  elsif params[:attended].downcase == "yes"
    @user.attended_events << @event
  end
  erb :created_events_partials, :layout=>false
end


get '/delete_event/:event_id' do
  Event.find(params[:event_id]).destroy
  redirect '/show_events'
end

get '/events/:event_id' do
  @event = Event.find(params[:event_id])
  erb :show_event_details
end

get '/edit_event/:event_id' do
  @event = Event.find(params[:event_id])
  erb :edit_event  
end

post '/edit_event/:event_id' do
 @user = User.find(session[:current_user_id])
 @event = Event.find(params[:event_id])
 @event.update_attributes(:user_id=> @user.id, :name=> params[:name], 
                          :location=>params[:location],:starts_at=>[:starts_at],
                          :ends_at=>params[:ends_at])
 @event.save!
 redirect '/show_events'
end
