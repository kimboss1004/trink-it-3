module ApplicationHelper

  def truncate(string, length)
    if string.length > length
      return "#{string[0,length]} .."
    else
      return string
    end
  end

  def abreviate(string)
    abreviation = ""
    words = string.split(" ")
    words.each do |word|
      abreviation += word[0]
    end
    return abreviation
  end

end
