module Rack
    class Insturment
        def initialize(app)
            @app = app
        end

        def call(env)
            StatsD.increment('rack.request.count')
            StatsD.measure('rack.request.duration') do 
                result = @app.call(env)
            end
        end
    end
end