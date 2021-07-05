module Rack
    class Insturment
        def initialize(app)
            @app = app
        end

        def call(env)
            $statsd.time('rack.request') do
                result = @app.call(env)
            end
        end
    end
end