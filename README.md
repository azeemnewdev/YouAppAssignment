# You App Assignment
-------------------

This repo contains a mobile app created with Flutter and an API created with NestJS


### Flutter Mobile App
----------------------
The mobile app connects to the api endpoint provided and only the login and register endpoints comsume the api.
The other functionality like saving the profile information are done in SharedPreferences (stored locally on the device).
When the user session timesout or the user logsout from the app the Shared preferences are cleared.

### NestJS API
--------------
The NestJsAPI is connected to a mongoDB and the URL is in the app (Hard coded, ideally should be in the .env file)
This is a monorepo
> Api-Gateway
>
> Auth-service
>
> users-service
>
> Shared Library
>
> messages-service (With websockets for chat - this is a simple websocket and not connected with the rest of the application)
>> There is a folder names chat that has a simple html file and will connect with the chat



> The end points created:
>> Auth
>>> Login
>>> 
>>> Register

>> User
>>> Get Single
>>> 
>>> Get All
>>>
>>> Create
>>>
>>> Update
>>>
>>> Delete

The DB has 2 collections
>> User
>> 
>> UserProfile

When Deleting a user profile, the corresponding user is deleted as well.

Rate limiter has been added to the api, 10 requests per min

There are a few unit tests written in both application but not covering 100%.

The Swagger end point for the api after running locally is http://localhost:3000/docs#/

![image](https://github.com/user-attachments/assets/9a7f6ca8-621b-4f53-bebb-2a8631754b1f)
