//
//  AccountView.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject private var userState: UserState
    
    var body: some View {
        NavigationView {
            VStack {
                if userState.isLoggedIn {
                    ProfileView().environmentObject(userState)
                } else {
                    LoginView().environmentObject(userState)
                }
            }
            .navigationBarTitle(Text("Account"))
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
