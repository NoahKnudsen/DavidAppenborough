# MovieDatabase

#### Models and Services to represent and manage The Movie Database data

##### MovieDatabaseService
 A small class to encapsulate all Movie Database interactions and expose only what the clients need to know, namely accessed to a `PersistedStore` of each main data type: `Person`, `Credits`, & `TVShow`. 
 The ` MovieDatabaseService` is also responsible for performing the network requests to fetch data from the API. 

 One concession I made when developing `MovieDatabaseService` was to hardcode the concrete type of the local storage mechanisms of each `PersistedStore`. I did go down the road of making the `MovieDatabaseService` generic over `WriteableStore` types so that the concrete implementations can be injected in, however it introduced far more noise than I liked and ultimately I decided the loss of clarity wasn't worth the benefits. This decision may need reviewing if the system is dramatically scaled up as it would open up avenues to make the unit tests much more concise and expressive.
 
##### Models
 The models to represent [The Movie Db API's](https://www.themoviedb.org/documentation/api) types are very simple due to the design of the API. No complex data transformations were needed, so I opted for a very straight forward Codable implementation without intermediatry types or custom encoding/decoding logic. 

There is one place that my optimised-for-consiceness-and-clarity approach to the Modelling lets me down, which is the `Date` values. The API returns dates in a format that Swift is unable to decode out of the box due to it's ambiguity. My options for handling this were essentially:
* Configure any `JSONDecoder`/`JSONEncoder` to have a custom `dateDecodingStrategy`/`dateEncodingStrategy`
* Custom encode/decode implementations in each model type specifically to handle the format of the date
* Decode the dates as a string and compute the `Date` instance when needed
Each of these options has its own advantages and disadvantages, but for this exercise I felt that choosing the option resulting in the most consise and evident implementation, the third option, was the best course of action. I've accepted the performance cost of this decision for an application of this kind. 
 
 
