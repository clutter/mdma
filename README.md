MDM Agent
=========

Mdma helps you deploy an iOS app to many devices at scheduled times with [SimpleMDM](https://www.simplemdm.com).

The **source code** is available on [GitHub](https://github.com/clutter/mdma).

[![Maintainability](https://api.codeclimate.com/v1/badges/eac591ba7b06c98080dc/maintainability)](https://codeclimate.com/github/clutter/mdma/maintainability)
[![Tests](https://travis-ci.com/clutter/mdma.svg?branch=master)](https://travis-ci.com/clutter/mdma)

After [setting up the right groups on SimpleMDM](#setup), you can do the following:

<img width="1792" alt="buildnew" src="https://user-images.githubusercontent.com/32649767/36555945-599852ac-17b8-11e8-9913-4600b78c9a6f.png">

[1] Upload a new build for an iOS app and decide when it should be pushed to devices

<img width="1792" alt="home" src="https://user-images.githubusercontent.com/32649767/36555942-595203ba-17b8-11e8-91ef-89d9a1461a2c.png">

[2] Check the status of every pending, scheduled, and completed push

<img width="1792" alt="devices" src="https://user-images.githubusercontent.com/32649767/36555941-593adbc2-17b8-11e8-9a52-579f99a2e33d.png">

[3] Browse the list of all devices to check the current version of the app

How it works
============

The app is hosted on Heroku and relies on one job run by Heroku Scheduler every 10 minutes.
`bundle exec rake deploys:enqueue` checks whether any build needs to be deployed soon and adds to the queue.

A separate job is run on Heroku Scheduler every day.
`bundle exec rake devices:fetch` fetches the list of devices with the latest app version.

A third-party client can be used to make a request to upload a build. This can be used in place of the web interface in order to do things like upload a build automatically after a GitHub action is triggered. To use this functionality, the `MDMA_TOKEN` environment variable must be set. An example request is shown below.

```
curl -X POST \
  -H "Authorization: Token token=[mdma_token]" \
  -H "Content-Type: multipart/form-data" \
  -F "package=@[ipa_path]" \
  -F "title=\"[title]\"" \
  http://[host]/api/builds
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

- `GITHUB_PROJECT`: The GitHub "username/project" path to fetch release notes from
- `SLACK_CHANNEL`: The Slack channel to post notifications to (defaults to #deploys)
- `MDMA_TOKEN`: The key required for a third-party client to make a request to upload a build

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
