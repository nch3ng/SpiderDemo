require 'hpricot'
require 'open-uri'
require 'uri'

module UrlHandler
  def initialize
  end

  def self.make_absolute_url(web_url,parsed_url)
    begin
      uri = URI.parse(parsed_url.to_s)
    rescue
      #puts 'exception happened'
    end
      if uri && uri.absolute?
        #puts 'Absolute'
        return parsed_url
      elseif uri
        return web_url.scheme + '//' + web_url.host + '/' + web_url.path
      else
        return nil
      end
  end

  def self.unify_path(web_url)
    if(web_url.to_s[-1,1] == '/')
      return web_url.to_s[0..-2]
    else
      return web_url
    end
  end
  def self.find_all_possible_address(url)
    url_list = []
    begin

      doc = open(url) { |f| Hpricot(f)}
    rescue Exception => ex
      #puts 'Cannot open this URL'
      #puts ex.message
    end
    if doc
      doc.search('//a[@href]').map do |x|
        new_url = x['href'].split('#')[0]
        new_url = self.make_absolute_url(url, new_url)
        if(new_url)
          url_list.push(new_url.to_s)
          #puts new_url
          self.find_all_possible_image(doc)
        end
      end
      return url_list
    else
      return nil
    end
  end
 
  def self.find_all_possible_image(url)
    begin
      doc = open(url) { |f| Hpricot(f)}
    rescue Exception => ex
      #puts 'Cannot open this URL'
      #puts ex.message
    end

    if doc
      doc.search('//img[@src]').map do |x|
        new_url =  x['src'].split('#')[0]
        new_url = self.make_absolute_url(url, new_url)
        if new_url
          puts '      '  + new_url.to_s
        end
      end
    end
  end

end
