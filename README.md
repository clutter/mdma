MDM Agent
=========

Schedule deploys of the Clutter WMS app to all our iOS devices.

How to use
----------

[1] In [SimpleMDM](https://a.simplemdm.com/admin/apps) I created an app group that associates the [Clutter WMS](https://a.simplemdm.com/admin/apps/16714) appto all the devices where it has to be installed:

<img width="1270" alt="screen shot 2018-01-16 at 11 07 51 am" src="https://user-images.githubusercontent.com/32649767/35007195-b2c2be26-faad-11e7-9f2f-e1085b21b499.png">

[2] On the [Show devices page](https://mdma-production.herokuapp.com/devices), you can see the list of all the devices in this group and the current version of the app:

<img width="1270" alt="screen shot 2018-01-16 at 11 11 11 am" src="https://user-images.githubusercontent.com/32649767/35007266-fc2c25ca-faad-11e7-8c1e-617f29a45911.png">

[3] On the [Upload new build page](https://mdma-production.herokuapp.com/builds/new), you can upload a new .ipa file and set the deploy time:

<img width="1270" alt="screen shot 2018-01-16 at 11 11 51 am" src="https://user-images.githubusercontent.com/32649767/35007311-1f725022-faae-11e7-8752-0d3ea5ba186a.png">

[4] After the file is uploaded, the [Show builds page]() will present all your builds, with the scheduled ones at the top:

<img width="1192" alt="screen shot 2018-01-16 at 11 16 49 am" src="https://user-images.githubusercontent.com/32649767/35007511-c3cabfec-faae-11e7-813d-c559bc2a3706.png">

[5] Before the deploy time comes, the devices will still have the old version of the app:

<img width="1192" alt="screen shot 2018-01-16 at 11 13 55 am" src="https://user-images.githubusercontent.com/32649767/35007390-68faa4ce-faae-11e7-982b-4bdd7d960c4e.png">

[6] When the time comes, the app will be pushed to all the devices in the group. The [Show devices page](https://mdma-production.herokuapp.com/devices) will show the new version of the app.

How it works
------------

The app is hosted on Heroku and relies on one job run by Heroku Scheduler:

- `bundle exec rake builds:enqueue` runs every 10 minutes and checks whether any build needs to be deployed soon
