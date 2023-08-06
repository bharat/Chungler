//
//  AdminView.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/4/23.
//

import SwiftUI


struct AdminView: View {
    @ObservedObject var adminSettings = AdminSettings.standard
    
    var body: some View {
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
                    HStack {
                        Text("Speaking speed")
                        Slider(value: $adminSettings.speechRate, in:Speech.minimumSpeechRate...Speech.maximumSpeechRate)
                    }
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

struct Previews_AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
