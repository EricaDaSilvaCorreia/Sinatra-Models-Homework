class App < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  set :root, File.join(File.dirname(__FILE__), '..')

  set :views, Proc.new { File.join(root, "views")}

  # Index
  get '/books' do
    @title = "Index Page"
    @books = Books.all
    erb :'books/index'
  end

  # New
  get '/books/new' do

    erb :'books/new'
  end


  # Show
  get '/books/:id' do
    id = params[:id].to_i

    @book = Books.find id

    erb :'books/show'
  end

  # Create
  post '/books' do

    book = Books.new

    book.cover = params[:cover]
    book.title = params[:title]
    book.published = params[:published]
    book.author = params[:author]
    book.description = params[:description]


    book.save

    redirect '/books'

  end

  # Update
  put '/books/:id' do
  id = params[:id].to_i

    book = Books.find id

    book.cover = params[:cover]
    book.title = params[:title]
    book.published = params[:published]
    book.author = params[:author]
    book.description = params[:description]

    book.save

    redirect '/books'

  end

  # Destroy
  delete '/books/:id'do
  id = params[:id].to_i
  Books.destroy id

  redirect '/books'

  end

  # Edit
  get '/books/:id/edit'do
  id = params[:id].to_i
  @book = Books.find id

  erb :'books/edit'

  end

end
