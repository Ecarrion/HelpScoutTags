## Postmortem

The main challenge from this demo was the programming language required.
Being coding in `Swift` for the past 2 years gave me some handicap when coding this demo:

### Problems
1. The first hours of coding felt really unproductive, getting used to the syntax proved to be way harder than I thought at the beginning, thankfully after a couple of hours the old muscle memory kicked in and I was able to code fluently like I'm used to.
2. Being away from the Objective-C community for so long made me think that I could be outdated in some best practices. With not much time for research I believe I've keep it to the standards but I can't be 100% sure. Something may have slipped by.


### Good

But not everything was bad, here are some of my good takeaways.

1. I was able to implement a lot of cool concepts that are happening inside the `swift`community that really help maintaining a project in the long run.
2. The coding itself went really smoothly I didn't had any major stopping point.
3. Xcode really shines with Objective-C, it is more stable and allows for a faster development overall.
4. Switching context from Swift to Objective-C was really entertaining, I felt motivated to finish this demo.

### Production Ready?

I wouldn't say that this is 100% production ready because I made a few assumption to make the development and communication more efficient but the codebase delivered is easily extensible and could become production ready with minimum effort.

Things I will change if I was to ship this to production:

1. **Better handling of networking:** Currently I'm using a very thin wrapper on `NSURLSession` but there is a lot more juice that we can take away from it.
2. **Better error handling:** Currently I'm showing a generic error as an Alert(because it's easier) but in a production app we should probably have a defined set of errors and present them more gracefully to the user.
3.  **Localize strings:** Nowadays apps are used worldwide and I believe not localizing an app for a specific audience is a huge loss, specially in developing countries.
