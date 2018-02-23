MDM Agent
=========

Mdma helps you deploy an iOS app to many devices at scheduled times with [SimpleMDM](https://www.simplemdm.com).

The **source code** is available on [GitHub](https://github.com/clutter/mdma).

[![Maintainability](https://api.codeclimate.com/v1/badges/62f8c7fe461eead4c44f/maintainability)](https://codeclimate.com/repos/5a8e076bc145340270009815/maintainability)

After [setting up the right groups on SimpleMDM](#setup), you can do the following:

<img width="1792" alt="buildnew" src="https://user-images.githubusercontent.com/32649767/36555945-599852ac-17b8-11e8-9913-4600b78c9a6f.png">

[1] Upload a new build for an iOS app and decide when it should be pushed to devices

<img width="1792" alt="timeslots" src="https://user-images.githubusercontent.com/32649767/36555944-597f438e-17b8-11e8-89b2-3c8237cebb0e.png">

[2] Specify whether devices starting with a certain prefix should receive a delayed update

<img width="1792" alt="home" src="https://user-images.githubusercontent.com/32649767/36555942-595203ba-17b8-11e8-91ef-89d9a1461a2c.png">

[3] Check the status of every pending, scheduled, and completed push

<img width="1792" alt="devices" src="https://user-images.githubusercontent.com/32649767/36555941-593adbc2-17b8-11e8-9a52-579f99a2e33d.png">

[4] Browse the list of all devices to check the current version of the app

How it works
============

The app is hosted on Heroku and relies on one job run by Heroku Scheduler every 10 minutes.
`bundle exec rake deploys:enqueue` checks whether any build needs to be deployed soon and adds to the queue.

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

For completeness, these are the credentials stored in the app

```yaml
aws:
  access_key_id: "[Access key for an S3 Bucket to upload builds to]"
  secret_access_key: "[Access secret for an S3 Bucket to upload builds to]"

simple_mdm:
  key: "[SimpleMDM API key]"

google:
  client_id: "[Google app Client ID to log into the app]"
  client_secret: "[Google app Client Secret to log into the app]"

slack:
  token_url: "[Slack token URL to send build notifications to Slack]"
```
