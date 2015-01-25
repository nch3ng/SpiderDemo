require './url_handler'

class SPIDER
  @already_scanned
  def initialize
    @already_scanned=[]
  end

  def crawl_web(url='', max_depth=2, max_count=100)
    url_list = [url.to_s]
    count=0
    next_url_list = []
    max_depth.times do
      puts '=================='
      #puts url_list

      url_list.each do |x|
        url = UrlHandler.unify_path(x.to_s)
        next if @already_scanned.include?(url.to_s)
        new_list = UrlHandler.find_all_possible_address(url.to_s)

        next if new_list == nil

        @already_scanned.push(x.to_s)
        puts @already_scanned.size.to_s + ': Scanning => ' + url.to_s

        return if(@already_scanned.size >= max_count)
        #UrlHandler.find_all_possible_image(url.to_s)
        next_url_list += new_list

      end
      url_list = next_url_list

      puts 'Next level: ' + url_list.size.to_s
      puts 'Scanned: ' + @already_scanned.size.to_s
    end
  end
end
