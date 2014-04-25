require 'spec_helper'

describe Api::V1::PhotosController do
    # WTF, why do I have to do this to render anything?:
    # https://github.com/rails/jbuilder/issues/32#issuecomment-4964697
    render_views

    subject { create :api_key }

    before(:each) do
        request.headers['HTTP_ACCEPT'] = 'application/json'
    end

    context 'with valid access_token' do
        before(:each) do
            request.headers['X-ACCESS-TOKEN'] = subject.access_token
        end

        it 'GET #tags returns all photos of a given tag' do
            create :photo_on_event, tag_list: 'Dude'
            get :tags, tag: 'Dude'
            expect(response.status).to eq(200)
            expect(json.first).to have_key 'id'
            expect(json.first).to have_key 'tag_list'
            expect(json.first).to have_key 'url'
            expect(json.first['url']).to have_key 'original'
            expect(json.first['url']).to have_key 'large'
            expect(json.first['url']).to have_key 'medium'
            expect(json.first['url']).to have_key 'small'
        end
    end

    context 'without valid access_token' do
        before(:each) { request.headers['X-ACCESS-TOKEN'] = nil }
        after(:each) { expect(response.status).to eq(401) }

        it 'GET #tags is unauthorized' do
            get :tags, tag: 'Dude'
        end
    end
end
