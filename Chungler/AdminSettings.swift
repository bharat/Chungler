//
//  AdminSettings.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/6/23.
//

import Foundation

class AdminSettings: ObservableObject {
    public static let standard = AdminSettings()

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
    
    @Published var speechRate: Float {
        didSet {
            UserDefaults.standard.set(speechRate, forKey: "speechRate")
            print("speechRate is now \(speechRate)")
        }
    }
    
    init() {
        self.apiKey = UserDefaults.standard.object(forKey: "apiKey") as? String ?? ""
        self.basePrompt = UserDefaults.standard.object(forKey: "basePrompt") as? String ?? AI.defaultBasePrompt
        self.useSpeech = UserDefaults.standard.object(forKey: "useSpeech") as? Bool ?? true
        self.speechRate = UserDefaults.standard.object(forKey: "speechRate") as? Float ?? Speech.defaultSpeechRate
    }

    func reset() {
        self.basePrompt = AI.defaultBasePrompt
        self.useSpeech = true
        self.speechRate = Speech.defaultSpeechRate
    }
}
