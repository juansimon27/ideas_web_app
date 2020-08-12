class IdeasController < ApplicationController

    def index

        @ideas = Idea.all
        
    end

    def new

        @idea = Idea.new

    end

    def create

        @user = User.find_by(id: session[:user_id])
        @idea = @user.ideas.create(idea_params)

        if @idea.save

            redirect_to @idea

        else

            render 'new'

        end
        
    end

    def show

        @idea = Idea.find(params[:id])

    end

    def edit
            
        @idea = Idea.find(params[:id])

        if @idea.user_id == session[:user_id]

            true
        
        else
            
            redirect_to @idea
            flash[:alert] = 'You don\'t have permission to modify this idea'
        
        end

    end

    def update

        @idea = Idea.find(params[:id])

        if @idea.update(idea_params)

            redirect_to @idea

        else
        
            render 'edit'

        end

    end

    def user_ideas

        @user = User.find_by(id: session[:user_id])
        @ideas = @user.ideas.all
        render :index

    end


    private

    def idea_params

        params.require(:idea).permit(:title, :content)

    end

end
