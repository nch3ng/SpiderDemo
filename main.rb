#! /home/natec/.rvm/rubies/ruby-2.2.0/bin/ruby
require 'optparse'
require './spider'

Options = Struct.new(:site,:level,:max)

class Parser
  def self.parse(options)
    args = Options.new
    args.site = []
    args.level=0
    args.max=50
    

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: demo.rb [options]"

      opts.on("-s", "--site=address", "The web you want to crawl") do |n|
        args.site = n
      end

      opts.on("-l", "--level=#", "How deep you want to crawl") do |n|
        args.level = n.to_i
      end

      opts.on("-m", "--max=#", "Total webpage it will crawl") do |n|
        args.max = n.to_i
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    return args
  end
end

options = Parser.parse(ARGV)

spider = SPIDER.new
spider.crawl_web(options.site, options.level, options.max)
#spider.crawl_web('http://www.yahoo.com/',3, 50)
