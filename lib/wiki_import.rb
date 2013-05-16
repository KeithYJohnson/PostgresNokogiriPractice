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
    logger.debug "Initialized"
    self.logger = logger
    self.attribute_stack = Array.new
    self.page_count = 0
    self.last_page = {}
    self.last_body = ""
    @output_file_count = 0
    @write = File.open('wiki.sql', 'w')
    #@entry = {}
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
      else
    end
      # logger.debug "This is #{@name}'s content: #{@content}"
  end

  def start_element(name, attrs)
    logger.debug "Found element #{name}"
    # attrs.each do |k,v|
    #   logger.debug "element #{name} has key #{k} and value #{v}" 
    # end
    case name
      when "title"
        @title = name
        @interested = true

        logger.debug "match #{name}"
      when "text"
        @body = name
        @interested = true
        logger.debug "match #{name}"
      else
        @interested = false
      end
    # logger.debug "Found element #{name}"
  end
  
  def end_element(name)

    logger.debug "Finished element #{name}"
    #if @entry.length > 1
    if name =="page" and @body != nil
      @body = @body.gsub("'", "''")
      @title = @title.gsub("'", "''")
      logger.debug "the hash is good!"
      #sql = "INSERT INTO articles (title, body) VALUES (\'#{@entry[:title]}\',\'#{@entry[:body]}\')\n"
      sql = "INSERT INTO articles (title, created_at, updated_at, body) values (\'#{@title}\', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, \'#{@body}\');\n"
      # binding.pry
      @write << sql
      @title = nil
      @body = nil
      logger.debug "I've Finished an entry!!!"
      else
    end

    # if name =="/page"
    
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
