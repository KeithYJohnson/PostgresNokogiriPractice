module WikiHandler

  # A call back once we've reached the end of a page  
  def handle_page(name, attrs)
   
  end
  
  # A callback once we've reached the end of a <title> element
  def handle_title(name, attrs)    
  	binding.pry
  	sql = File.open('pg_practice_development','w')
    sql << "INSERT INTO articles (title) VALUES (#{@content})"
    logger.debug "Added TITLE to DB"
  end
  
  # A callback once we've reached the end of a <text> element
  def handle_text(name, attrs)
  	sql << "INSERT INTO articles text VALUES (#{@content})"
  	logger.debug "Added TEXT to DB"
  end
  
end
