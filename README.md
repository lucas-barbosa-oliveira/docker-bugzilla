# Bugzilla deployment

---

## Prerequisites


- Docker Engine 19.03.5+

  - **Linux:** Follow all the steps present in the [official documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)

- Docker Compose 1.25.5+
  -  Follow all the steps present in the [official documentation](https://docs.docker.com/compose/install/)


## Set the environment variables

The file `.env.example` contains all the environment variables required by the services being deployed.

Copy and paste with the file `.env.example` with the name `.env` to make the Docker Compose use the environment variables defined in this file:

```sh
cp .env.example .env
```

#### Authorization/Authentication Setup

Variables to define the administrator user's credentials the first time the platform is instantiated.

| Variable | Description | Example |
| -------- | ----------- | ------- |
| `ADMIN_EMAL` | Email of the default admin user created automatically at the first time the Bugzilla is instantiated. | `admin@bugzilla.org` |
| `ADMIN_PASSWORD` | Password of the default admin user created automatically at the first time the Bugzilla is instatiated. | `password` |

#### External Service Port
Variables to define the port of service to be exposed:

| Variable | Description | Example |
| -------- | ----------- | ------- |
| `PORT` | Port used by the Bugzilla service to listen for HTTP request. | `80` |

#### SMTP Setup

| Variable | Description | Example |
| -------- | ----------- | ------- |
| `MAINTAINER` | Maintainer email of the bugzilla instance.  | `smtp.gmail.com:465` |
| `MAILFROM` | Email that will send emails. | `admin@bugzilla.com` |
| `SMTP_USERNAME` | Registered email on the SMTP server. | `admin@bugzilla.com` |
| `SMTP_PASSWORD` | Password for the email registered on the SMTP server. | `secret` |

### Databases setup
| Variable | Description | Example |
| -------- | ----------- | ------- |
| `MYSQL_ADMIN_USER` | Username of the root user of the MySQL that has permission to create other users. | `admin` |
| `MYSQL_ADMIN_PASS` | Password of the root user of the MySQL that has permission to create other users. | `a6m1n*s3cr7t94ssw0rd` |