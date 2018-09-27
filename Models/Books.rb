class Books
  attr_accessor :id, :cover, :title, :published, :author, :description

  # ==== open_connection : connect to db =====

  def self.open_connection
  conn = PG.connect(dbname: 'books')
  end

  # ==== save =====

  def save

    conn = Books.open_connection

    if !self.id
      sql = "INSERT INTO books (cover, title, published, author, description) VALUES ('#{cover}', '#{title}', '#{published}', '#{author}', '#{description}')"

    else
      sql = "UPDATE books SET cover='#{cover}', title='#{title}', published='#{published}', author='#{author}', description='#{description}' WHERE id='#{self.id}'"

    end

    conn.exec(sql)


  end

  # ==== all : ====

  def self.all

    conn = self.open_connection

    sql = "SELECT * FROM books ORDER BY id"
    result = conn.exec(sql)

 # Creates Array of data imported from table^

    books = result.map do |book|
      self.hydrate book
    end

    books

  end

  # ==== Find ID ====

  def self.find id

    conn = self.open_connection

    sql = "SELECT * FROM books WHERE id=#{id}"
    result = conn.exec(sql)

    book = self.hydrate result[0]

    book

  end

  # ==== Destroy ====
  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM books WHERE id=#{id}"
    conn.exec(sql)
  end

  # ==== hydrate : process data =====

  def self.hydrate books_data
    book = Books.new

    book.id = books_data['id']
    book.cover = books_data['cover']
    book.title = books_data['title']
    book.published = books_data['published']
    book.author = books_data['author']
    book.description = books_data['description']

    book

  end

end
