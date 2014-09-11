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

  members = []
  data = ARGF.read
  data.each_line do |line|
    member = line.chomp
    puts member
    begin
      client.add_list_member("pyconjp2014", member)
    rescue Twitter::Error::Forbidden => e
      puts "#{member} can't add to pyconjp2014 list"
      members << member
      next
    end
  end
  puts
  puts members
end

