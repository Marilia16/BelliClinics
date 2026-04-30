class ManagerUsersController < ApplicationController

    def index
        @users = User.all
    end 

end
