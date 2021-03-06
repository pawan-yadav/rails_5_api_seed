module AdminApi

  class BooksController < AdminApiController

    before_action :set_book, only: [:show, :update, :destroy]


    def index
      @books = Book.all

      render json: @books, render_params: params
    end


    def show
      render json: @book, render_params: params
    end


    def create
      @book = Book.new(book_params)

      if @book.save
        render json: @book, status: :created, location: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end

    end


    def update
      if @book.update(book_params)
        render json: @book, tags: true
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end


    def destroy
      @book.destroy
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.friendly.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(
                               :title,
                               :description,
                               :author,
                               :chapters,
                               :is_paid,
                               { book_tag_list: []}
      )
    end
  end


end



