class IdeasController < ApplicationController

    def index

        @user = User.find_by(id: session[:user_id])
        @ideas = @user.ideas.all
        
    end

    def new

        @idea = Idea.new

    end

    def create

        @user = User.find_by(id: session[:user_id])

        @idea = @user.ideas.create(idea_params)

        if @idea.save

            redirect_to 'index'

        else

            redirecto_to 'new'

        end
        
    end

    private

    def idea_params

        params.require(:idea).permit(:title, :content)
        
    end

end
