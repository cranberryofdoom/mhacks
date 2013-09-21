require 'sinatra'
require 'mongo'
require 'json'
include Mongo

db = MongoClient.new('localhost', 27017).db('accelerometerolympics')
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