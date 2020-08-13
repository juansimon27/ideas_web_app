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
        @ideas = @user.ideas.order(created_at: :desc).all
        render :index, locals: { page_title: 'My Ideas'}

    end


    def search

        result_alert = nil

        if params[:search].blank?

            result_alert = 'Empty search.'            
        
        else

            result_alert = params[:search]

            search_ = params[:search].downcase
            search_ = search_.split

            results = Array.new

            search_.each do |word|

                results += Idea.all.where(" title LIKE '%#{word}%' ")

            end

            @ideas = results

            if @ideas.length < 0

                result_alert = 'Results not found.'
            
            end
        
        end
        
        render :index, locals: { page_title: 'Search Results' }
        flash.now[:alert] = result_alert
    end


    private

    def idea_params

        params.require(:idea).permit(:title, :content)

    end

end
