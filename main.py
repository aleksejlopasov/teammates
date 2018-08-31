import teammates
import config


# Note: debug=True is enabled here to help with troubleshooting. You should
# remove this in production.
app = teammates.create_app(config, debug=False)


# This is only used when running locally. When running live, gunicorn runs
# the application.
if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8080, debug=False)
