# Stor
An app to rent people's extra space as storage space to other people

![](stor.gif)

Stor is an app that allows people to post their own extra space they have in their homes/apartments/property to sell to other people. To start the app, open the `Stor.xcworkspace` (do not open the project file in Xcode, this will prevent it from connecting to Firebase) which should open up the project in Xcode and run and compile it using a simulator or connect your own phone.

## Log-in/Register Screen

The app will begin with a login screen, where you have to ability to register an account with an email and password. The password must be over 6 characters in length. Once you type a username and a password, you can then hit the register button to create an account. An alert will then pop up telling you to login in if this process was successful, and you can then click "OK" and then the login button to access the rest of the app. If this process was not successful, then an alert will pop up telling you so and you will need to try some other credentials. Then try re-registering and logging in again.

The user will be able to stay logged in once they exit the app and re-open it once again. It is only until they specifically logout (described in the profile section) that they will be logged out.

## The "Find a Space" Screen

Once logged in, you will be able to see a list of storage spaces other users have listed. This is where you can browse each space, look at the address, size, and price of each space. Each space will read the address first, then the square footage of that space, followed by the price of the space, all separated by commas. If you want to look at what a space looks like, you can click on that space in the tablelistview, where it will bring you to a separate screen, where you will see a photo of the space along with the details of the space. (There will also be two time selectors, where you can pick when you want the storage space with a start time and end time. However, these have not been fully implemented yet, but they are there.) 

At the bottom of the screen, you will see a button that is clickable only if the space is available. If it has already been rented by another user, the button will be disabled and will read "Unavailable." However, if the button has been previously rented by you, it will appear as "Cancel Rent," and you will be able to cancel your rental by clicking it, in which case it will turn into "Rent Now." If no one has rented it, it will read "Rent Now" and any user will be able to click it to rent the space.

## The "Rent your Space" Screen

If a user would like to sell their own space, they can navigate to the "Rent your Space." There, they will be met with a prompt asking them the address of their space. They can then type in any string and click the "Next" Button to progress to the next step. If there is no string entered, an alert will pop-up, telling the user to enter in a string. If they wish to cancel adding their space, they can click the "Cancel" button at any point, leading them back to the listing of spaces.
On the next screen, the user will be be met with a prompt asking them the size of their space in square feet. They can then type in any string and click the "Next" Button to progress to the next step. If there is no string entered, an alert will pop-up, telling the user to enter in a string. If they wish to cancel adding their space or go back to change something, they can click the "Cancel" or "Back" button at any point, leading them back to the listing of spaces or to the previous prompt respectively.

On the next screen, the user will be be met with a prompt asking them the price of their space in US dollars per day. They can then type in any string and click the "Next" Button to progress to the next step. If there is no string entered, an alert will pop-up, telling the user to enter in a string. If they wish to cancel adding their space or go back to change something, they can click the "Cancel" or "Back" button at any point, leading them back to the listing of spaces or to the previous prompt respectively.

On the next screen, the user will be be met with a prompt asking them to upload a photo of their space. They can then select the "Choose Photo" button, where they will be prompted to allow the app to access their photos if they have not already done so, or led to their photo library. Here, they can tap on any photo they want from their photo library and use it. It will then pop up in the image view, where they can see it. If they wish to change the photo, they can then click on "Choose Photo" and pick a different one. If a photo is not selected before moving on, an alert will popup asking the user to select a photo. Once they are satisfied, they can click "Add My Space" to then add their space to the listing. If they wish to cancel adding their space or go back to change something, they can click the "Cancel" or "Back" button at any point, leading them back to the listing of spaces or to the previous prompt respectively.

Following the "Add My Space" button click, the user will be met with a prompt saying that their space has been confirmed and another button saying "Browse Spaces" can be clicked to return to the table view of all the listings. Here, the user might have to wait 5-10 seconds to finish waiting for their image to upload to the cloud before clicking on their space to ensure everything has been fully uploaded. After this, the user will be able to see their space in the listing and click on it to view the details. At the bottom, the button will be disabled and read "Your Own Space," preventing the user from renting their own space.

## The "Profile" Screen

If a user would like to view all the spaces they have uploaded, check the status of their spaces, or logout, they can navigate to the "Profile" section by the bottom tab. There, they will be met with their own email to confirm that it is their own profile, and then a table view of their listed spaces. If one of their space has been rented by another user, it will read "RENTED -- " followed by the details of that space. Finally, the user has the "logout" button at the end, which when clicked, will log the user out and bring them back to the login/sign up screen. 
