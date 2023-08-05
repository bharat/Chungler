//
//  AdminView.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/4/23.
//

import SwiftUI

class AdminSettings: ObservableObject {
    @Published var apiKey: String {
        didSet {
            UserDefaults.standard.set(apiKey, forKey: "apiKey")
        }
    }
    
    init() {
        self.apiKey = UserDefaults.standard.object(forKey: "apiKey") as? String ?? ""
    }
}

struct AdminView: View {
    @ObservedObject var adminSettings = AdminSettings()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("OpenAPI")) {
                    Text("API Key")
                    TextField("", text: $adminSettings.apiKey)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct Previews_AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
