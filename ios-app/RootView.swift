//
//  RootView.swift
//  ios-app
//
//  Created by Teller on 27/05/2020.
//  Copyright © 2020 Teller. All rights reserved.
//

import SwiftUI
import Combine

struct RootView: View {
    @State var presentSheet = false
    @State var enrolled = false
    @State var registration: Teller.Registration?
        
    let config: Teller.Configuration = Teller.Configuration(appId: "app_id")

    var body: some View {
        VStack {
            Text("🏦")
                .font(.system(size: 64))
                .padding(.top, 30)
                .padding(.bottom, 10)
                .frame(width: 80, alignment: .center)
            VStack {
                Text("Teller Connect")
                    .font(.system(size: 32.0))
                    .fontWeight(.bold)
                    .foregroundColor(.secondary)
                Text("iOS Example Code")
                    .font(.system(size: 36.0))
                    .fontWeight(.bold)
            }
            .padding(.bottom, 10)
            
            if let registration = registration {
                VStack {
                    VStack {
                        HStack {
                            Text("Access Token")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text(registration.accessToken)
                            Spacer()
                        }
                    }
                    .padding(5)
                    
                    VStack {
                        HStack {
                            Text("Enrollment ID")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text(registration.enrollment.id)
                            Spacer()
                        }
                    }
                    .padding(5)

                    VStack {
                        HStack {
                            Text("User ID")
                                .bold()
                            Spacer()
                        }
                        
                        HStack {
                            Text(registration.user.id)
                            Spacer()
                        }
                    }
                    .padding(5)

                    VStack {
                        HStack {
                            Text("Institution")
                                .bold()
                            Spacer()
                        }
                        
                        HStack {
                            Text(registration.enrollment.institution.name)
                            Spacer()
                        }
                    }
                    .padding(5)
    
                }.padding(35)
                                
                Spacer()
                
                Button(action: {
                    self.registration = nil
                }) {
                    Text("Reset")
                        .font(.system(size: 16.0))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .cornerRadius(5.0)

                }
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .padding(.horizontal, 25)
                .padding(.bottom, 25)
                
            } else {
                Text("This is a demo application with an example implementation of how to integrate Teller Connect into your native iOS application")
                    .padding()
                    .lineSpacing(5)
                
                VStack {
                    VStack {
                        HStack {
                            Text("Username")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("sandbox_user")
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    
                    VStack {
                        HStack {
                            Text("Password")
                                .bold()
                            Spacer()
                        }
                        HStack {
                            Text("Password")
                            Spacer()
                        }
                    }
                    .padding(.horizontal)

                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    self.presentSheet = true
                }) {
                    Text("Begin")
                        .font(.system(size: 16.0))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .cornerRadius(5.0)

                }
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10.0)
                .padding(.horizontal, 25)
                .padding(.bottom, 25)
                
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

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
