module ApplicationHelper
  
  #Assembles a custom title for every page
  def title
    base = "Paradigms"
    if @title
      base += " | #{@title}"
    end
  end
  
  #Places a logo image and a link to the root page
  def logo(path, params)
   l = image_tag(path, params)     
   link_to l, path
  end
  
  #Formats time to a more readable format (Eg. 10 Jan 5:45 PM)
  def localtime(time)
    time.getlocal.strftime('%d %b %I:%M %p')
  end
  
end
