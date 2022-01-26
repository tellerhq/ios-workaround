//
//  ConnectView.swift
//  ios-app
//
//  Created by Stevie Graham on 30/05/2020.
//  Copyright © 2020 Stevie Graham. All rights reserved.
//

import SwiftUI

extension Teller {
    struct ConnectView: View {
        var config: Teller.Configuration
        var completion: (Teller.Registration?, Error?) -> Void
        
        init(config: Teller.Configuration, completion: @escaping (Teller.Registration?, Error?) -> Void) {
            self.config = config
            self.completion = completion
        }
        var body: some View {
            Teller.ConnectController(config: config, completion: self.completion)
        }
    }
}
