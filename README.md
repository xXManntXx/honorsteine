# Honorsteine App

>>> /!\ For iOs version, check iOs_app branch /!\

The main goal of our Stolpersteine App is to create a meaningful platform that enables users to engage with the stolpersteine memorials and honor the victims of war. 

This application will be available for both iOS and Android devices,for that we will code using IOS and Flutter.

## Context
This app was developed in the context of a four-week industry project for the semester four of fontys academy.
Client foundation can be found at this link : https://stolpersteine.app/en/stolpersteine-app/

## What are all those directories ?
The whole flutter project is on this git. You can directly duplicate it using Android Studio.
Go to Version controle, enable it, then create a new project from version controle and use this directory.

The actual code used to generate the application and produced by our team can be found on the "lib" directory.
The assets directory compile our assets, and the pubsec.yaml describe the external ressources we used.

Under the lib directory, you'll find several directory. The screen one contains all the main codes used by the app to build the pages you can see on the phone.

## What is the app doing so far and what could be improved ?
### Splash screen
First thing you see when launching the app.
This screen load all the data from the Stolpersteine API (endpoint can be found on the API_fetch.dart file) and create the markers for the map screen.
It indicates that with a little text and a circular progressor.

**What could be improved :**
- adding animation to the logo
- enhance the API so it doesn't take too much time to load the data
- navigate either to OnBoarding screen or to Home screen depending on if it's the firt time or not that the app is used
- asking permission for location here

### OnBoarding screen
This page helps the user to understand the app, how to use it, and introduce them to the stolpersteine project.
You can go back and forth between the tips.

**What could be improved :**
- better visuals, more relevant to the subject
- sliding to go back and forth. Points instead of number to show which panel you're viewing. Animation from one page to another.
- more relevant onboarding tips : what are stolpersteine, the chatbot concept, how to create routes, ...

### Home screen ("for you" page)
This is the main screen, the page where the user land.
First card is a fake one, it's a placeholder for a feature that has not been implemented yet on the app.
Below it you can find a random stolpersteine with a short description. You can fetch new one by pressing the button or reloading the page.

**What could be improved :**
- Replace first card with section about the events/tours that are occuring nearby soon.
- Having the random stolpersteine be picked based on actual user location (for now, eindhoven is hard coded)

### Map screen
Uses google map API to display all the registered stolpersteine.
Automatically center it on the user's location.
Tap the stolpersteine to have more info about them.

**What could be improved :**
- exploration mode / proximity detector : user get a notification when getting near to a stolpersteine. The notification link the user to the chatbot of this particular stolpersteine.
- nearby stolpersteine are shown on the card widget, with direction and proximity
- you can tap on the stolpersteine of the map to go to their information page or to talk to their chatbot
- create custom routes / show custom routes

### Chat bot screen
Allow the user to discuss with a chatbot trained with the data from a custom stolpersteine (accessed either through the home page, the map or the list). Use gpt-3 IA.
The user can either enter free text or use the pre-made question tree to talk with the victim.
/!\ in order to use this functionnality, you need to get a ApiKey from OpenAI. Modify accordingly the chat_api.dart file in the api folder. Also, do not share this key anywhere public (like a git for exemple) because it will instantly be cancel by openAI /!\

**What could be improved :**
- Saving conversation
- Better trained IA to prevent it from answering unrelated questions or to break character.
- User testing the conversation tree
- having voice over functionnality

### Stolpersteine list page
Displays all the stolpersteine from database on a list. Tap on them to have more information.
You can use the search function to filter by name / city / reason of persecution / place of death / ...

**What could be improved :**
- This page shouldn't be a "main" page, displayed on the navigation bar, but rather something you can access from like drawer menu or something like that.
- replace this page with route page.
- having better sorting methods, more precise, with filters and categories.

### Stolpersteine details page
Display information about the victim with a little recap card.
Text adapts depending on the situation of the victim (gender, dead or not due to the persecution, ...)
Available links are shown on this page and are clickable : they open official webpage.
Can access to chatbot through this page.

**What could be improved**
- Ui could be better
- possibility to light a candle or leave tributes that are visible to all users.
- have a voice over to read the information
- related story and victims

### Route page
Not implemented yet at all.
Should replace the victim list on the navigation bar.
This page should allow the user to browse the upcomming events and the walks organise in the neighbourhood.
It should also allow them to join them and share them and be notify about them.
There should be also a link to create your own route and event using the map page.





