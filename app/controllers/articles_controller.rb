class ArticlesController < ApplicationController
   def index
       @articles = Article.all
       
   end
   
    def new
        @article = Article.new
    end
  
    def create
        #render plain: params[:article].inspect
        @article = Article.new(article_params)
        @article.save
        
        #Checking to make sure validations go through
        if @article.save 
            flash[:success] = "The article was successfully submitted."
            redirect_to article_path(@article)
        else

            render 'new'
        end
        
    end 
    
    def show 
        @article = Article.find(params[:id])
    end
    
    def edit
        @article = Article.find(params[:id])
        
    end
    
    def update
         @article = Article.find(params[:id])
        if @article.update(article_params)
            flash[:success] = "The article was successfully updated."
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end 
    
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        flash[:danger] = "Article was successfully deleted."
        redirect_to articles_path
    end
    
    private 
    def article_params
        params.require(:article).permit(:title, :description)
    end
    
end