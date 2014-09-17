require 'pit'
require 'twitter'


if __FILE__ == $0 then
  config = Pit.get("twitter",
                   :require => {
    'consumer_key'        => 'client CONSUMER_KEY',
    'consumer_secret'     => 'client CONSUMER_SECRET',
    'access_token'        => 'oauth ACCESS_TOKEN',
    'access_token_secret' => 'oauth ACCESS_TOKEN_SERCTET',
  })

  client = Twitter::REST::Client.new do |c|
    c.consumer_key        = config['consumer_key']
    c.consumer_secret     = config['consumer_secret']
    c.access_token        = config['access_token']
    c.access_token_secret = config['access_token_secret']
  end 

  list = 'pyconjp2014'
  list = 'pyconapac2013'
  members = []
  data = ARGF.read
  data.each_line do |line|
    member = line.chomp
    next if member.empty?
    puts member
    begin
      next if client.list_member?(list, member)
      client.add_list_member(list, member)
    rescue Twitter::Error::Forbidden => e
      puts "#{member} can't add to #{list} list"
      members << member
      next
    end
    sleep 5
  end
  puts
  puts members
end

