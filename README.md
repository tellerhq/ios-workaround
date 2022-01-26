# ios-workaround

This repo is a temporary workaround while we build our iOS-SDK. It is essentially the source code for the future SDK. It provides `Teller.ConnectView` for SwiftUI apps and `Teller.ConnectViewController` for UIKit apps.

This method of using Teller Connect is not supported unless separately agreed with your Teller point of contact.

## SwiftUI

```swift
struct RootView: View {        
    let config: Teller.Configuration = Teller.Configuration(appId: "app_id")

    var body: some View {
        Teller.ConnectView(config: self.config, completion: { registration, error in
            self.registration = registration
        })
        .edgesIgnoringSafeArea(.bottom)
    })
}
```
