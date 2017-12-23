## Implemented Features
- Load and display tags from internet.
	- Stores tags for offline use using NSURLSession integrated cache mechanism.
	- If an error occurs when fetching tags, the user can choose to try again.
- Shows selected tags at the top of the tag list.
	- Persist selected tags across sessions(If you close the app, you will see your previously selected tags the next time you open it)
	- Selected tags view will grow as big as 1/4 of the screen height for not taking too much space from the tags table view. When adding more tags the selected tag list will start to scroll.
	- A small fade animation is performed when selecting/deselecting tags.
	- Selected tags can be deselected by tapping on them.
	- Selected tags are sorted alphabetically.
- User can filter the tags list using a search bar at the top.
- Optimized for portrait and landscape mode.

## UI

The UI is built majorly using `Interface Builder` .
The main UIKit components used are:
- UISearchBar
- UICollectionView
- UITableView

All of those components are rendered using `AutoLayout` so they are ready to be displayed in any screen size and in any orientation.

A quick mockup of the layout is the following.

![UI Layout](https://image.ibb.co/dGEos6/UI_layout.png)

## Arquitecture

The Architecture implemented in this demo can be called `MVVM-I` which stands for (Model, View, ViewModel - Interactor)

This architecture has two goals in mind:
1. Extract business logic from ViewControllers into objects that consists from simply inputs and outputs, which results in loosely coupled interfaces and in higher testability.
2. Enclose state changes into a single place, to avoid scenarios where we have unhandled state shown to the user.

### Responsibilities

#### ViewModel
Inmutable objects that represents a state of the `View` at a given time. 
For this demo we are handling 3 states(Loading, Loaded, Error). 
Every time the `view` has to change a new `ViewModel` is generated.

#### ViewController
- Renders the view based on the `ViewModel` state.
- Handles user interaction and forwards it the `Interactor`.

#### Interactor
- Receives inputs from `ViewController` (eg: Load tags, select tag, filter list, etc.)
- Contains the _business logic_ of the component and generates new `ViewModel` for the `ViewController` to render.

#### Services
Objects to help the `Interactor` to interact with the outside world, eg:
- Talk to the network
- Talk to the disk. 

### Data Flow
At any given time the data(ViewModels/state) should flow in a unidirectional stream.
This reduces side effects and unhandled state.

![data-flow](https://image.ibb.co/m0iZzm/DataFlow.png)

### Testing

The code in this demo is using two design patterns heavily :
1. Dependency Injection.
2. Protocol oriented programming.

This has allowed me to test all of the key objects (Interactor, ViewModel, Services) easily without the need of using an 3rd party testing framework.


### Dependencies

I've only included one external dependency to handle the Layout of the selected tags view to be always left aligned.

The reasoning for not using more 3rd party dependencies is so **HelpScout** can review more of my code instead of 3rd party code.
