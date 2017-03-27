module Middleware
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

	class AuthXToken < Kemal::Handler
		def call(env)
			req = ""
			req = env.request.headers["XToken"]
			if req != ENV["XTOKEN"] #token123
				env.response.status_code = 401
				env.response << "XToken doesn't match"
			end
			return call_next(env)
		end
	end

end