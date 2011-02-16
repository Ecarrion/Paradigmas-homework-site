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
  
end
