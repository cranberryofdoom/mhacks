require 'sinatra'
require 'mongo'
require 'json'
include Mongo


def get_connection
  client = MongoClient.from_uri("mongodb://admin:thisisrandom@paulo.mongohq.com:10067/Leaderboard")
  client.db("Leaderboard")
end

db = get_connection

# db = MongoClient.new('localhost', 27017).db('accelerometerolympics')
collection = db.collection('leaderboard')
# { name: "TEAM NAME", score: 12013414, throwCount: 4 }

post '/' do
	data = JSON.parse request.body.read
	collection.insert data
end

get '/' do

	#.find.each { |row| puts row.inspect }
	leaders = collection.find.limit(100).to_a

	erb :index, :locals => { :leaderboards => leaders }
end