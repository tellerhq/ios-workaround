# ios-workaround

This repo is a temporary workaround while we build our iOS-SDK. It is essentially the source code for the future SDK. It provides `Teller.ConnectView` for SwiftUI apps and `Teller.ConnectViewController` for UIKit apps.

This method of using Teller Connect is not supported unless separately agreed with your Teller point of contact.

## SwiftUI

```swift
struct RootView: View {
    @State var presentSheet = false
    @State var registration: Teller.Registration?
        
    let config: Teller.Configuration = Teller.Configuration(appId: "app_id")

    var body: some View {
        VStack {
            if registration != nil {
                Text("Success!")
            } else {
                Text("This is a demo application with an example implementation of how to integrate Teller Connect into your native iOS application")
                    .padding()
                                    
                Spacer()
                
                Button(action: {
                    self.presentSheet = true
                }) {
                    Text("Begin")
                }
                .sheet(isPresented: self.$presentSheet,
                    onDismiss: {
                        self.presentSheet = false
                    }, content: {
                        Teller.ConnectView(config: self.config, completion: { registration, error in
                            self.registration = registration
                        })
                        .edgesIgnoringSafeArea(.bottom)
                    })
            }
        }
    }
}
```
