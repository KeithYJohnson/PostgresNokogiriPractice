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
    
  def characters(c)

    if @interested == true
      @content = c
      logger.debug "This is #{@name}'s content: #{@content}"

    end
  end

  def start_element(name, attrs)
    logger.debug "Found element #{name}"
    # attrs.each do |k,v|
    #   logger.debug "element #{name} has key #{k} and value #{v}" 
    # end

    if name == "title" #|| name == "text"
      @name = name
      logger.debug "Found a #{name}"
      @interested = true

    else
      @interested = false
    end
  end
  
  def end_element(name)
    logger.debug "Finished element #{name}"
    if name == "title"
      sql = "INSERT INTO articles (title) VALUES (\'#{@content}\')\n"

      @write << sql

      @interested = false
      #sql << "insert into articles (title) VALUES (#{@title})"
      logger.debug "I've Finished a title!!!"
      #self.last_page[:title] = self.last_body
    end

    if name = "body"
      logger.debug "I've finished a body!"
      self.last_page[:body] = self.last_body
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
