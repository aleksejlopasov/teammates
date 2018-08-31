# There are two different ways to store the data in the application.
# You can choose 'datastore', or 'cloudsql'.
DATA_BACKEND = 'datastore'

# Google Cloud Project ID.
PROJECT_ID = 'PROJECT'

# Replace user, pass, host, and database with the respective values of your
# Cloud SQL instance.
SQLALCHEMY_DATABASE_URI = \
    'mysql+pymysql://user:password@host/database'

# Google Cloud Storage and upload settings.
CLOUD_STORAGE_BUCKET = PROJECT_ID
MAX_CONTENT_LENGTH = 8 * 1024 * 1024
ALLOWED_EXTENSIONS = set(['png', 'jpg', 'jpeg', 'gif'])
