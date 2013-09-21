require 'sinatra'
require 'mongo'
require 'json'
require 'uri'
include Mongo


def get_connection
  return @db_connection if @db_connection
  db = URI.parse(ENV['mongodb://<user>:<password>@paulo.mongohq.com:10067/Leaderboard'])
  db_name = db.path.gsub(/^\//, '')
  @db_connection = Mongo::Connection.new(db.host, db.port).db(db_name)
  @db_connection.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
  @db_connection
end

db = get_connection

# db = MongoClient.new('localhost', 27017).db('accelerometerolympics')
collection = db.collection('leaderboard')
# { name: "TEAM NAME", score: 12013414, throwCount: 4 }

post '/leaderboard' do
	data = JSON.parse request.body.read
	collection.insert data
end

get '/leaderboard' do
	puts collection.find.to_a

	#.find.each { |row| puts row.inspect }
	leaders = collection.find.to_a.count(100)
	puts leaders
	erb :index, :locals => { :leaderboards => leaders }
end