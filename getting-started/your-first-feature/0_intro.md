This is the second to last in a series of four tutorials to get you up and running with full-stack Daml development. We do this through the example of a simple social networking application. The four tutorials cover:

1. How to build and run the application ([Running the app](https://digitalasset.com/developers/interactive-tutorials/getting-started/build-and-run/)).
1. The design of its different components ([Application Architecture](https://docs.daml.com/getting-started/app-architecture.html)).
1. How to write a new feature for the app (this tutorial).
1. How to deploy your app to [Daml Hub](https://www.digitalasset.com/developers/interactive-tutorials/getting-started/deploy-to-dabl/)

In this scenario we'll dive into implementing a new feature for our social network app. This will give us a better idea how to develop Daml applications using our template.

At the moment, our app lets us follow users in the network, but we have no way to communicate with them! Let’s fix that by adding a direct messaging feature. This will allow users that follow each other to send messages, respecting authorization and privacy. This means:

- You cannot send a message to someone unless they have given you the authority by following you back.
- You cannot see a message unless you sent it or it was sent to you.
- We will see that Daml lets us implement these guarantees in a direct and intuitive way.

There are three parts to building and running the messaging feature:

1. Adding the necessary changes to the Daml model.
2. Making the corresponding changes in the UI.
3. Running the app with the new feature.

As usual, we must start with the Daml model and base our UI changes on top of that.
