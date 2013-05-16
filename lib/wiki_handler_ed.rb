require_relative 'wiki_handler'

class WikiImport < Nokogiri::XML::SAX::Document

  include WikiHandler

  # A stack (Array) of attributes as we find them
  attr_accessor :attribute_stack

  # A logger to output to the screen
  attr_accessor :logger

  # A counter to increment each time you find a page
  attr_accessor :page_count

  # The output SQL file
  attr_accessor :sql

  # The contents of the last page as a hash
  attr_accessor :last_page

  # The text contents of last element's body
  attr_accessor :last_body

  def initialize(logger)
    self.logger = logger
    self.attribute_stack = Array.new
    self.page_count = 0
    self.last_page = {}
    self.last_body = ""
    @output_file_count = 0
    @write = File.open('wiki.sql', 'w')
  end

  def start_document
    logger.debug "Start document"
  end

  def end_document
    logger.debug "End document"
    @write.close
  end

  def characters(text)
        if @title == "title" and @interested
        @title = text
        # binding.pry
      elsif @body == "text" and @interested
        @body = text
        # binding.pry
      else
    end
    # binding.pry
  end

  def start_element(name, attrs)
    # @interested = true
    case name
    when "title"
      @title = name
      @interested = true
      # binding.pry
      logger.debug "match #{name}"
    when "text"
      @body = name
      @interested = true
      logger.debug "match #{name}"
    # if name == "text" @text = name or name == "title" @title = name
    #   @interested = true
    #   logger.debug "match #{name}"
      # binding.pry
    else
      @interested = false
    # logger.debug "Found element #{name}"
  end

end

  def end_element(name)
      if name = "/page" and @body != nil
      # binding.pry
      @body = @body.gsub("'", "''")
      @title = @title.gsub("'", "''")

      sql = "INSERT INTO articles (title, created_at, updated_at, body) values (\'#{@title}\', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'#{@body}\')\n"
      # binding.pry
      @write << sql
      @title = nil
      @body = nil

    else

    logger.debug "Finished element #{name}"
  end
end


  def method_missing(m, *args, &block)
    logger.debug("Ignoring #{m}")
  end

  protected
  def handler_method(name)
    :"handle_#{name.downcase}"
  end

  def clean(s)
    s.strip.gsub("'", "''")
  end

  def output_file_name
    "/tmp/articles-#{@output_file_count}.sql"
  end
end