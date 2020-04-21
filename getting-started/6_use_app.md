You should now see the login page for the social network. For simplicity of this app, there is no password or sign-up required. First enter your name and click Log in.

![Login Screen](/daml/scenarios/getting-started/assets/create-daml-app-login-screen.png)

You should see the main screen with two panels. One for the users you are following and one for your followers. Initially these are both empty as you are not following anyone and you don’t have any followers! Go ahead and start following users by typing their usernames in the text box and clicking on the Follow button in the top panel.

![Main Screen](/daml/scenarios/getting-started/assets/create-daml-app-main-screen-initial-view.png)

You’ll notice that the users you just started following appear in the Following panel. However they do not yet appear in the Network panel. This is either because they have not signed up and are not parties on the ledger or they have not yet started followiong you. This social network is similar to Twitter and Instagram, where by following someone, say Alice, you make yourself visible to her but not vice versa. We will see how we encode this in DAML in the next section.

![Bob Follows Alice](/daml/scenarios/getting-started/assets/create-daml-app-bob-follows-alice.png)

To make this relationship reciprocal, [open the UI](https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com) in a separate browser tab. (Having separate windows/tabs allows you to see both you and the screen of the user you are following at the same time.) Once you log in as the user you are following - Alice, you’ll notice your name in her network. In fact, Alice can see the entire list of users you are follwing in the Network panel. This is because this list is part of the user data that became visible when you started follwing her.

![Alice Sees Bob](/daml/scenarios/getting-started/assets/create-daml-app-alice-sees-bob.png)

When Alice starts follwing you, you can see her in your network as well. Just switch to the window where you are logged in as yourself - the network should update automatically.

![Bob Sees Alice](/daml/scenarios/getting-started/assets/create-daml-app-bob-sees-alice-in-the-network.png)

Play around more with the app at your leisure: create new users and start following more users. Observe when a user becomes visible to others - this will be important to understanding DAML’s privacy model later.
