# nag-example-apps

Sample apps showcasing the possible use cases with the Nordic API Gateway SDK.

## Getting started
The sample app is called QuickSprout and is a app that enables users to get an overview of their savings. It is still a work in progress. For now it is only possible to authenticate with banks ~~and list the user's accounts~~.

Find the Swagger documentation at https://api.nordicapigateway.com/swagger/index.html.

### Sign up for Nordic API Gateway

1. Go to https://www.nordicapigateway.com/ and sign up
2. Obtain your `Client ID` and `Client Secret` (find them at https://developer.nordicapigateway.com/keys)

### Setup Node project
If you have not already implemented services to communicate with Nordic API Gateway, you can use the test server implementation found in `node/api-test-server`.

1. Open the project in your favorite JavaScript editor (we use Visual Studio Code at Spiir)
2. Create an environment file and paste the following code into it: 
```
CLIENT_ID=<Client ID>
CLIENT_SECRET=<Client ID>
```
* `CLIENT_ID` – This variable contains the client ID (found at https://developer.nordicapigateway.com/keys)
* `CLIENT_SECRET` – This variable contains the client secret (found at https://developer.nordicapigateway.com/keys)

3. Run `npm install` and then `node index.js` to start the server.

This simple server returns an URL that is used to load the authentication flow from the Nordic API Gateway.

The server implements the following endpoints

```
POST /init
```
Implements `POST /v1/authentication/initialize` (see [documentation](https://api.nordicapigateway.com/swagger/index.html?url=/swagger/v1/swagger.json#operation/Authentication_Initialize))

Request body
* redirectUrl : `<string>`

Response
* See [documentation](https://api.nordicapigateway.com/swagger/index.html?url=/swagger/v1/swagger.json#operation/Authentication_Initialize)

```
POST /tokens
```
Implements `POST /v1/authentication/tokens` (see [documentation](https://api.nordicapigateway.com/swagger/index.html?url=/swagger/v1/swagger.json#operation/Authentication_Tokens))

Request body
* code : `<string>`

Response
* See [documentation](https://api.nordicapigateway.com/swagger/index.html?url=/swagger/v1/swagger.json#operation/Authentication_Tokens)

``` 
POST /accounts
```
Implements `GET /v1/accounts` (see [documentation](https://api.nordicapigateway.com/swagger/index.html?url=/swagger/v1/swagger.json#operation/Account_GetAccounts)) 

Request body
* token : `<string>`

Response
* See [documentation](https://api.nordicapigateway.com/swagger/index.html?url=/swagger/v1/swagger.json#operation/Account_GetAccounts)
### Setup Xcode project
1. Open Xcode and select the project file
2. Select 'QuickSprout' under 'Targets' and select 'Build Settings'
3. Set `NAG_API_URL` found under 'User Defined' to match your configuration
4. Start the application

### Setup Android project
1. Open Android Studio and select 'Open project' and browse the project folder
2. Make sure that you have configured network settings for the application, add unsecure connections to `/app/src/main/res/xml/network_security_config.xml`
3. Start the application