require 'rails_helper'

describe 'API Routes' do
    it 'has nice routes' do
        expect(get: '/api/photos/tags/Dude').to route_to(
            controller: 'api/v1/photos',
            action:     'tags',
            format:     'json',
            tag:        'Dude'
        )
    end
end
