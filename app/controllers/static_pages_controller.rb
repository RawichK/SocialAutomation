class StaticPagesController < ApplicationController
  def home
    @login_page = "/"
    if (session[:access_token] == nil || session[:access_token].length <= 0)
      @login_page = Instagram.authorize_url(:redirect_uri => CALLBACK_URL, :scope => SCOPE)
    else
      Instagram.configure do |config|
        config.access_token = session[:access_token]
      end
      client = Instagram.client(:access_token => session[:access_token])
      session[:client] = client
      @login_page = "/"
      usr = User.find_by(igId: client.user.id)
      if (usr == nil)
        usr = User.new(name: client.user.username, igId: client.user.id)
        usr.save
      end
      session[:currUsr] = usr
        
      redirect_to "/users/#{usr.id}"
      #@fol = Instagram.user_followed_by
      #@html = "<h2>#{session[:client].user.id}'s follower : total #{@fol.count}</h2>"
      #for u in @fol
      #  @html << "#{u.username} \##{u.id} <img src=#{u.profile_picture}><br>"
      #end
    end
  end

  def callback
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect_to "/"
  end

  def help
  end
end
