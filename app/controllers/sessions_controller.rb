class SessionsController < ApplicationController
  def getfollower_req
  end
  
  def getfollower_rep
    target = Instagram.user_search(params[:session][:targetusername])
    for u in target do
      if u.username = params[:session][:targetusername]
        @targetId = u.id
        cnt = 50
        response = Instagram.user_followed_by(u.id, :count => cnt)
        nc = response.pagination.next_cursor
        @follower = []
        for r in response
          t = Target.find_by(ownerId: session[:currUsr].igId, targetId: r.id)
          if(t.nil?)
            t = Target.new(ownerId: session[:currUsr].igId, targetId: r.id, isFollowed: false)
            t.save
          end
        end
        while(!nc.blank?)
          sleep 1.0
          response = Instagram.user_followed_by(u.id, :count => cnt, :cursor => nc)
          nc = response.pagination.next_cursor
          for r in response
            t = Target.find_by(ownerId: session[:currUsr].igId, targetId: r.id)
            if(t.nil?)
              t = Target.new(ownerId: session[:currUsr].igId, targetId: r.id, isFollowed: false)
              t.save
            end
          end
        end
        
        break
      end
    end
    render 'getfollower_req'
  end
  
  def autofollow_req
  end
  
  def autofollow_rep
    usr = session[:currUsr]
    target = Target.where("isFollowed = ?", false)
    for t in target
      Instagram.follow_user(t.targetId)
      updT = Target.find_by(ownerId: usr.igId, targetId: t.targetId)
      updT.isFollowed = true
      updT.save
      sleep 181
    end
  end
  
end
