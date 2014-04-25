# Let's keep our API versioned through an Accept header!
class ApiConstraints
    def initialize(version: 'v1', default: true)
        @version, @default = version, default
    end

    def matches?(request)
        @default || request.headers['Accept'].include?("application/vnd.recapp.v#{@version}")
    end
end
