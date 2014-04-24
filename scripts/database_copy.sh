heroku pgbackups:capture --expire --app g360-event-application
heroku pgbackups:restore DATABASE 'heroku pgbackups:url --app g360-event-application' \
--app g360-event-application-staging --confirm g360-event-application-staging