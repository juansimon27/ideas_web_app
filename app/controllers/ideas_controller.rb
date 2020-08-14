class IdeasController < ApplicationController

    PER_PAGE = 5

    def index

        @index_view = params.fetch(:view, 'home')
        @page = params.fetch(:page, 0).to_i

        if @index_view == 'latest'

            query = Idea.where(created_at: (Time.current - 1.day)..Time.current)
            title = 'Latest Ideas'
          
        elsif @index_view == 'user'

            @user = User.find_by(id: session[:user_id])
            query = @user.ideas.order(created_at: :desc)
            title = 'My Ideas'
        
        else

            query = Idea.order(created_at: :desc)
            title = 'Ideas Home'
            
        end

        if query.length % PER_PAGE == 0 && query.length >= PER_PAGE

            @max_page = (query.length / PER_PAGE).to_i - 1
                 
        else

            @max_page = (query.length / PER_PAGE).to_i

        end
        
        @ideas = query.offset(@page * PER_PAGE).take(PER_PAGE)

        render locals: { page_title: title }
        
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

            redirect_to @idea, notice: 'Idea updated successfully.'

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
            redirect_to ideas_path(view: 'user'), notice: 'Idea deleted successfully.'

        end

    end

    def search

        result_alert = nil
        @page = params.fetch(:page, 0).to_i
        @search = params[:search]

        if @search.blank?

            result_alert = 'Empty search, try again.'            
        
        else
        
            search_ = @search.downcase.split
            query = Idea.where(" title LIKE '%#{search_.join('%')}%'")
        
        end
        
        if query.length % PER_PAGE == 0 && query.length >= PER_PAGE

            @max_page = (query.length / PER_PAGE).to_i - 1
                 
        else

            @max_page = (query.length / PER_PAGE).to_i

        end

        @ideas = query.offset(@page * PER_PAGE).take(PER_PAGE)

        flash.now[:alert] = result_alert if !result_alert.nil?
        render :search, locals: { page_title: 'Search Results', for_search: params[:search] }
        
    end


    private

    def idea_params

        params.require(:idea).permit(:title, :content)

    end

end
