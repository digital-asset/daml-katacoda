[On the the UI tab](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com) you should now see a login page. For simplicity of this app, there is no password or sign-up required.

Log in as `alice`. Other valid usernames are `bob` and `charlie`.

> Note: Usernames are all lower-case, although they are displayed in the social network UI by their alias instead of their user id, with the usual capitalization). Usernames are case sensitive.

You should see the main screen with two panels. The top panel displays the social network users you are following; the bottom displays the aliases of the users who follow you. Initially these are both empty as you are not following anyone and you don’t have any followers. Log out from `alice` and log in as `bob`. Then you will be able to start following `alice` by either 1) typing her name into the text box or 2) selecting it from the drop-down list and clicking the *Follow* button in the top panel.

The user you just started following (`alice` in this case) appears in the *Following* panel. However, she does not yet appear in the *Network* panel. This is because `alice` has not yet started following `bob`. This social network is similar to Twitter and Instagram, where by following someone you make yourself visible to them but not vice versa.

To make this relationship reciprocal, log out from `bob` and log in as `alice`.

Now have `alice` follow `bob` by clicking the + sign next to `bob`'s name.

Once `alice` starts following `bob` both of them can now see each other in their Network. Try logging back in as `bob` and you'll see `alice` is now in his network. Then log back in as `alice` and you'll see the same for her. You can repeat the process for `charlie` to get a better understanding when a user becomes visible to others - this will be important to understanding Daml’s privacy model later.

> Note: If you want to see the code within this `create-daml-app` project click on the IDE tab or [check it out on GitHub](https://github.com/digital-asset/daml/tree/master/templates/create-daml-app).
