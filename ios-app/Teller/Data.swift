//
//  Data.swift
//  ios-app
//
//  Created by Stevie Graham on 30/05/2020.
//  Copyright © 2020 Stevie Graham. All rights reserved.
//

import Foundation

extension Teller {
    struct Configuration {
        var appId: String
        var skipPicker: Bool?
        var institution: String?
        var userId: String?
        var enrollmentId: String?
        var environment: String?
    }
    
    struct Registration {
        var accessToken: String
        var user: User
        var enrollment: Enrollment
    }
    
    struct User: Codable {
        var id: String
    }

    struct Enrollment: Codable {
        var id: String
        var institution: Institution
    }
    
    struct Balance: Codable {
        var ledger:    String
        var available: String
    }

    struct RoutingInfo: Codable {
        var ach:  String
        var wire: String?
    }

    struct Institution: Codable {
        var name: String
    }

    struct Account: Identifiable, Codable {
        var id:              String
        var name:            String
        var accountNumber:   String
        var institution:     Institution
        var currencyCode:    String
        var routingNumbers:  RoutingInfo
        var balances:        Balance
    }
}
