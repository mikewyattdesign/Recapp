module Api
    module V1
        # Provide read-only access to Photos via JSON
        class PhotosController < ApplicationController
            skip_before_filter :authenticate_user!
            before_filter :authenticate_user_from_token!

            respond_to :json

            def tags
                @photos = Photo.with_event.tagged_with(params[:tag])
                # render @photos.to_json
                if @photos.empty?
                    render(
                        json: { error: 'No photos found.' },
                        status: :not_found
                    )
                end
            end

            # Probably not the safest thing ever, but we can lock this
            # down with José Valim's suggestion later:
            # https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
            def authenticate_user_from_token!
                unless valid_access_token?
                    render(
                        json: { error: 'Invalid access token.' },
                        status: :unauthorized
                    )
                end
            end

            def valid_access_token?
                ApiKey.where(
                    access_token: request.headers['X-ACCESS-TOKEN']
                ).present?
            end
        end
    end
end
