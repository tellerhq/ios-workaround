//
//  AccountRowView.swift
//  ios-app
//
//  Created by Teller on 18/10/2019.
//  Copyright © 2019 Teller. All rights reserved.
//

import SwiftUI

struct AccountRowView: View {
    enum BalanceType {
        case ledger
        case available
    }
    
    var account: Teller.Account
    
    func maskedNumber(account: Teller.Account) -> some View {
        let number = account.accountNumber
        let range  = number.index(number.endIndex, offsetBy: -4) ..< number.endIndex
        let chars  = Array(number[range])

        return HStack{
            Text("••••")
                .font(.system(size: 24))
                .padding(.top, -4)
                .padding(.trailing, -4)
            ForEach(chars, id: \.self) {
                MICRDigit(digit: Int(String($0))!)
                    .frame(maxWidth: 10, maxHeight: 12.0)
            }.padding(-2)
            Spacer()
        }
    }
    
    func formattedBalance(account: Teller.Account, type: BalanceType) -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.currencyCode = account.currencyCode
        
        let float: Float
                
        switch type {
        case .available:
            float = Float(account.balances.available)!
        default:
            float = Float(account.balances.ledger)!
        }
        
        return formatter.string(from: NSNumber(value: float))!
    }
    
    var body: some View {
        VStack {
            HStack {
                InstitutionLogo(account: account)
                    .frame(height: 20.0)
            }
            
            HStack {
                Text(account.name)
                    .font(.subheadline)
                    .foregroundColor(.primary)

                Spacer()
                
                Text(formattedBalance(account: account, type: .available))
                    .font(.system(size: 20.0))
                    .bold()
                    .foregroundColor(.primary)
            }
            
            maskedNumber(account: account).padding(.top, -10)
        }
        .padding(5)
        .padding(.top, 10)
        .padding(.bottom, 7)
        .navigationBarTitle("Accounts")
    }
}

struct AccountRowView_Previews: PreviewProvider {
    static var previews: some View {
        AccountRowView(account: accountData[0])
    }
}
