class IdeasController < ApplicationController

    def index

        @ideas = Idea.order(created_at: :desc).all
        render locals: { page_title: 'Latest Ideas' }
        
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

        if @idea.user_id != session[:user_id]
            
            redirect_to @idea, alert: 'You don\'t have permission to modify this idea.'
        
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

    def destroy

        @idea = Idea.find(params[:id])

        if @idea.user_id != session[:user_id]
            
            redirect_to @idea, alert: 'You don\'t have permission to modify this idea.'
        
        else

            @idea.destroy
            redirect_to '/user/ideas'

        end

    end

    def user_ideas

        @user = User.find_by(id: session[:user_id])
        page_title = @user.username + ' Ideas'
        @ideas = @user.ideas.order(created_at: :desc).all
        render :index, locals: { page_title: 'My Ideas'}

    end


    private

    def idea_params

        params.require(:idea).permit(:title, :content)

    end

end
