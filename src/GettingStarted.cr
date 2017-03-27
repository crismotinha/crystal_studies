require "./GettingStarted/*"
require "kemal"
require "./Middleware/*"

module GettingStarted

	add_handler Middleware::CheckParams.new
	add_handler Middleware::AuthXToken.new

	get "/" do |env|
		if env.response.status_code == 200
			"oier"
		end
	end

	get "/hello/:name" do |env|
		name = env.params.url["name"]
		"Olar, #{name}"
		p "tessss"
	end

	
	post "/hello" do |env|
		name = env.params.json["name"].as(String)
		extra = env.params.json["extra"].as(Array)
		"Olar, #{extra.size}."
	end


	post "/hi" do |env|
		if env.response.status_code == 200
			"OK"
		end
	end

	Kemal.run
end
