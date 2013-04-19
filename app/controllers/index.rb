get '/' do
  erb :index
end

get'/signup' do
  erb :signup
end

post '/signup' do
  @user =User.create(:first_name => params[:first_name],:last_name=>params[:last_name],:email=>params[:email],:birthdate=>params[:birthdate],:password=>params[:password],:password_confirmation=>params[:password_confirmation])
  if @user.valid?
    @user.save!
    erb :login
  else
    redirect '/signup'
  end
end

post '/login' do
  @user = User.find_by_email(params[:email])
  if @user && @user.authenticate(params[:password])
    session[:current_user_id]=@user.id
    redirect '/show_events'
  else 
    redirect '/login'
  end
end

get '/login' do
  erb :login
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/show_events' do
  @user = User.find(session[:current_user_id])
  @events_created = @user.created_events
  @events_attended =@user.attended_events
  erb :success
end


