# BSGCompassKit

## Description

Create compass views to display heading information. Also includes a speedometer option.

## Requirements

+ iOS 13+

## Installation

### Swift Package Manager

1. Navigate to `File->Add Packages...`.
2. Search for the package URL (https://github.com/brook-street-games/bsg-compass-kit.git).
3. Select a dependency rule and a project.
4. Select `Add Package`.

## Example

```swift
// Create needle compass.
let compassView = ArrowCompassView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
compassView.needleColor = .black
compassView.textColor = .yellow

// Create circular compass.
let compassView = CircularCompassView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
compassView.borderColor = .black
compassView.fillColor = .black
compassView.tickColor = .yellow
compassView.primaryTextColor = .white
compassView.secondaryTextColor = .white
compassView.needleColor = .white

// Set the heading to a degree value. This can be called each time a new *course* value is obtained from CoreLocation.
compassView.setHeading(degrees: 180, animated: true)

// Set the heading to a directional value.
compassView.setHeading(direction: .east, animated: true)

// Set the heading to point from one location to another.
let newYork = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
let sanDiego = CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611)
compassView.setHeading(destination: sanDiego, origin: newYork, animated: true)
```

![BSGCompassKit](../main/BSGCompassKitSample/Assets/Images/compass-example.png)

## Sample Project

A sample project is included in the repository. Select the `BSGCompassKitSample` target to run it.

## Author

Brook Street Games LLC
