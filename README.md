# David Appenborough
### A lightweight catalogue of David Attenborough's work. 

Using [The Movie Db](https://www.themoviedb.org)'s API ([documentation](https://www.themoviedb.org/documentation/api)), this app presents a selection of information about David Attenborough and his TV work. I hope you enjoy reading through the code!

#### Features:
* Biography
* List of TV Show credits
* TV Show details
* Offline mode

#### Design
The app is comprised of a number of small packages to seperate concerns and encapsulate functionality. These packages are:
* [Foundational](https://github.com/NoahKnudsen/DavidAppenborough/tree/main/Packages/Foundational "Foundational") - A collection of extensions and augmentations for the Swift Standard Library and Foundation
* [Stores](https://github.com/NoahKnudsen/DavidAppenborough/tree/main/Packages/Stores) - Storage structures and data persistence mechanisms
* [MovieDatabase](https://github.com/NoahKnudsen/DavidAppenborough/tree/main/Packages/MovieDatabase) - Models and Services to represent and manage The Movie Database data
* [Toolkit](https://github.com/NoahKnudsen/DavidAppenborough/tree/main/Packages/Toolkit) - A UI library containing project-non-specific, resuable SwiftUI views. 
* [MovieDatabaseUI](https://github.com/NoahKnudsen/DavidAppenborough/tree/main/Packages/MovieDatabaseUI) - A collection of UI to present information from The Movie Database.  

### Technical Notes

The app is written using SwiftUI for it's interface and a number of modern Swift APIs such as the Swift Structured Concurrency suite (Actors, Async/Await, Tasks).

I opted to use Apple's first-party APIs, such as those for Networking (URLSession) and Serialiation (Codable), as nowadays they are more than suffient to serve an app of this size and complexity. There are no 3rd party libraries used in this app.

For offline storage I am storing the data in `UserDefaults` which is perfectly adaquate for this small amount of data. This follows the "only use the bare minimum for what you need" [guidance of Souroush Khanlou](https://jeffreyfulton.ca/blog/2018/02/userdefaults-limitations-and-alternatives) but could easily be swapped out for a more sophisticated data persistence implementation in the future due to the `WritableStore` protocol that it is abstracted behind.

### Future improvements

One future improvement I'd like to make would be to integrate a small [Ontology](https://en.wikipedia.org/wiki/Ontology_(information_science)) into the app using something like [Mindflare](https://github.com/thousandyears/MindFlare) to generate the Swift compile-time ontology language. The first usages of the ontology would be to provide human-friendly, unique identifiers to each significant piece of UI which in turn would enable a greater degree of modularity and testability. 

### References

A small collection of reference material I found particularly useful or interesting during the course of developing this app
* [Swift Evolution Async/Await Sequences](https://github.com/apple/swift-evolution/blob/main/proposals/0298-asyncsequence.md)
* [Comparing lifecycle management for async sequences and publishers - Donny Wals](https://www.donnywals.com/comparing-lifecycle-management-for-async-sequences-and-publishers/)
* [New Formatters in iOS15 - Sarunw](https://sarunw.com/posts/new-formatters-in-ios15/)
