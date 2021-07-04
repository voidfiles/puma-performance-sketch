module Rack
    class Insturment
        def initialize(app)
            @app = app
        end

        def call(env)
            $statsd.time('hello.rack.request') { 
                @app.call(env)
            }
        end
    end
end