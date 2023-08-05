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

    @Published var basePrompt: String {
        didSet {
            print("basePrompt is now: \(basePrompt)")
            UserDefaults.standard.set(basePrompt, forKey: "basePrompt")
        }
    }

    @Published var useSpeech: Bool {
        didSet {
            UserDefaults.standard.set(useSpeech, forKey: "useSpeech")
        }
    }
    
    init() {
        self.apiKey = UserDefaults.standard.object(forKey: "apiKey") as? String ?? ""
        self.basePrompt = UserDefaults.standard.object(forKey: "basePrompt") as? String ?? AI.defaultBasePrompt
        self.useSpeech = UserDefaults.standard.object(forKey: "useSpeech") as? Bool ?? true
    }

    func reset() {
        self.basePrompt = AI.defaultBasePrompt
        self.useSpeech = true
    }
}

struct AdminView: View {
    @ObservedObject var adminSettings = AdminSettings()
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("OpenAPI API Key")) {
                        TextField("", text: $adminSettings.apiKey)
                    }
                    Section(header: Text("Prompt")) {
                        TextField("", text: $adminSettings.basePrompt, axis: .vertical)

                    }
                    Section(header: Text("Interaction")) {
                        Toggle(isOn: $adminSettings.useSpeech) {
                            Text("Speak the answer")
                        }
                        .toggleStyle(.switch)
                    }
                }
                .navigationTitle("Settings")

                Button(action:{ adminSettings.reset() }) {
                    Text("Reset to defaults")
                }
                .buttonStyle(RedButton())
            }
        }
    }
}

struct Previews_AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
