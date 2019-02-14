MDM Agent
=========

Mdma helps you deploy an iOS app to many devices at scheduled times with [SimpleMDM](https://www.simplemdm.com).

The **source code** is available on [GitHub](https://github.com/clutter/mdma).

[![Maintainability](https://api.codeclimate.com/v1/badges/eac591ba7b06c98080dc/maintainability)](https://codeclimate.com/github/clutter/mdma/maintainability)
[![Tests](https://travis-ci.com/clutter/mdma.svg?branch=master)](https://travis-ci.com/clutter/mdma)

After [setting up the right groups on SimpleMDM](#setup), you can do the following:

[1] Upload a new build for an iOS app and decide when it should be pushed to devices

<img width="1792" alt="buildnew" src="https://user-images.githubusercontent.com/32649767/52810718-0c151e80-3048-11e9-80a0-79667f878415.png">

[2] Specify whether devices starting with a certain prefix should receive a delayed update

<img width="1792" alt="timeslots" src="https://user-images.githubusercontent.com/32649767/52810717-0c151e80-3048-11e9-9943-8946e5a3543e.png">

[3] Check the status of every pending, scheduled, and completed push

<img width="1792" alt="home" src="https://user-images.githubusercontent.com/32649767/52810716-0c151e80-3048-11e9-8a71-fb0b42be3adf.png">

[4] Browse the list of all devices to check the current version of the app

<img width="1792" alt="devices" src="https://user-images.githubusercontent.com/32649767/52810715-0c151e80-3048-11e9-911e-67e617f21cda.png">

How it works
============

The app is hosted on Heroku and relies on one job run by Heroku Scheduler every 10 minutes.
`bundle exec rake deploys:enqueue` checks whether any build needs to be deployed soon and adds to the queue.

How to delete a build
=====================

If you have enqueued a build and you have changed your mind, run this command at least 10 minutes
before the scheduled time:

```
heroku run rails runner 'Build.last.destroy'
```

How to contribute
=================

Whenever a new PR is opened, a new Review App is created on Heroku, where you can test your code.
The Review App uses a test app called Ugly Sweater with a test device group.
Test your features on the review app and make sure that Code Climate is happy, then merge.

How to configure
================

In order to use `mdma`, the following environment variables need to be set:

- `MDMA_APP_ID`: The SimpleMDM ID of the app to push
- `MDMA_APP_GROUP_ID`: The SimpleMDM ID of the app group that identifies the devices to push to
- `MDMA_APP_IDENTIFIER`: The unique identifier of the iOS app
- `RAILS_MASTER_KEY`: The key to decrypt the credentials stored in `config/credentials.yml.enc`

The following environment variables are optional:

- `SLACK_CHANNEL`: The Slack channel to post notifications to (defaults to #deploys)

For completeness, these are the credentials stored in the app:

```yaml
aws:
  access_key_id: "[Access key for an S3 Bucket to upload builds to]"
  secret_access_key: "[Access secret for an S3 Bucket to upload builds to]"

simple_mdm:
  key: "[SimpleMDM API key]"

google:
  client_id: "[Google app Client ID to log into the app]"
  client_secret: "[Google app Client Secret to log into the app]"

github:
  username: "[Username of a GitHub account with read access to clutter/clutter-ios-wms]"
  token: "[Personal access token for the account to read the releases for that app]"

slack:
  token_url: "[Slack token URL to send build notifications to Slack]"
```
