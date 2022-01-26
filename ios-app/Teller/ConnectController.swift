//
//  ConnectController.swift
//  ios-app
//
//  Created by Stevie Graham on 30/05/2020.
//  Copyright © 2020 Stevie Graham. All rights reserved.
//

import SwiftUI

extension Teller {
    struct ConnectController: UIViewControllerRepresentable {
        var config: Teller.Configuration
        var completion: (Teller.Registration?, Error?) -> Void
        
        func makeUIViewController(context: Context) -> Teller.ConnectViewController {
            return Teller.ConnectViewController(configuration: config, completion: completion)    
        }
        
        func updateUIViewController(_ uiViewController: Teller.ConnectViewController, context: Context) {
            
        }
    }
}
