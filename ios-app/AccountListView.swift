//
//  AccountListView.swift
//  ios-app
//
//  Created by Teller on 18/10/2019.
//  Copyright © 2019 Teller. All rights reserved.
//

import SwiftUI

struct AccountListView: View {
    var accounts: [Teller.Account]

    var body: some View {
        NavigationView {
            List(accounts) { account in
                AccountRowView(account: account)
            }.navigationBarTitle("Accounts")
        }
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView(accounts: accountData)
    }
}
    
