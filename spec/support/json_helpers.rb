# Convenience methods for working with the JSON API
module JsonHelpers
    # Avoid needing to type JSON.parse(response.body) everywhere in
    # API specs.
    def json
        @json ||= JSON.parse(response.body)
    end
end
