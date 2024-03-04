# Salesforce Integration with OAuth 2.0 Providers

This project empowers you to explore the world of Salesforce integration with popular platforms like Google, LinkedIn, Facebook, Slack, and more! 

It leverages the secure and widely used OAuth 2.0 authorization framework, allowing you to connect these platforms to Salesforce and seamlessly exchange data.

## What You'll Learn:

**Establish Secure Connections:** Gain hands-on experience building secure connections between Salesforce and various external platforms.

**Exchange Data Seamlessly:** Learn how to exchange data between Salesforce and other platforms, unlocking new collaboration and automation possibilities.

## Table of Contents:
* [Prerequisites](#prerequisites)
* [Key Concepts](#key-concepts)
* [Installing the App](#installing-the-app-using-a-developer-edition-org-or-a-trailhead-playground)
* [Optional Installation Instructions](#optional-installation-instructions)

## Prerequisites
Before diving in, ensure you have knowledge of basic Salesforce development concepts like Apex, Visualforce, or LWC.

## Key Concepts

**OAuth 2.0:**  This industry-standard authorization framework enables applications to securely access user data from other services without requiring users to share their credentials directly with those services.

**Third-Party App:** You'll need to create apps within each provider (e.g., Google, LinkedIn) to obtain the necessary client credentials (client ID, client secret) for establishing the connection.

**Salesforce Auth Provider:** This component holds the provider-specific configuration, including the client credentials and API endpoints for interacting with the provider.

**External Credential and Named Credential:** These secure mechanisms allow you to store and manage access tokens and refresh tokens, which are crucial for maintaining ongoing connections with the third-party services.

**Apex Classes:** These classes provide the programmatic logic for interacting with the third-party APIs using the obtained access tokens.

## Installing the App Using a Developer Edition Org or a Trailhead Playground

1. Create a Fresh Environment: 
Start in a new environment [Developer Edition Org](https://developer.salesforce.com/signup) or a [Trailhead Playground](https://trailhead.salesforce.com/) to avoid conflicts with previous work.

2. Set up your environment: 
Follow the steps in the [Quick Start: Lightning Web Components Trailhead](https://trailhead.salesforce.com/content/learn/projects/quick-start-lightning-web-components/) project. The steps include:

* Install Salesforce CLI
* Install Visual Studio Code
* Install the Visual Studio Code Salesforce extensions

3. Clone this repository:
```
  https://github.com/iamSoham01/Salesforce-Integration.git
```
Or download the ZIP file from the GitHub repository.


4. Authorize your Trailhead Playground or Developer org and provide it with an alias (mydevorg in the command below):

```
  sf org login web -s -a mydevorg
```

5. Run this command in a terminal to deploy the app:
```
  sf project deploy start -d force-app
```

6. Assign the callout permission set to the default user:
```
  sf org assign permset -n Callout_Permission_Set
```

7. Open the scratch org:
```
  sf org open
```

8. In App Launcher, select the Integration app.

## Optional Installation Instructions

In Salesforce, you need to configure Auth Provider by replacing your Consumer Key and Consumer Secret Provided by the third-party app.