module Rack
    class Insturment
        def initialize(app)
            @app = app
        end

        def call(env)
            $statsd.increment('hello.rack.request.count')
            $statsd.time('hello.rack.request.duration') { 
                result = @app.call(env)
            }
        end
    end
end