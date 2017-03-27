require "./GettingStarted/*"
require "kemal"

module GettingStarted
	
	class CheckParams < Kemal::Handler
		only ["/hi"],"POST"
		def call(env)
			return call_next(env) unless only_match?(env)
			required = ["id", "age"]
			params_received = [] of String
			env.params.json.each do |param|
				params_received << param[0]
			end
			p required
			p params_received
			p required - params_received
			if !(required - params_received).empty?
				env.response.status_code = 400
				env.response << "tá faltando #{(required - params_received).join(", ")}"
			end
			
			return call_next(env)
		end
	end
	
	add_handler CheckParams.new

	get "/" do 
		"oier"
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
