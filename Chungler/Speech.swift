//
//  Speech.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/4/23.
//

import Foundation
import AVFoundation

class Speech {
    static let defaultSpeechRate = AVSpeechUtteranceDefaultSpeechRate
    static let minimumSpeechRate = AVSpeechUtteranceMinimumSpeechRate
    static let maximumSpeechRate = AVSpeechUtteranceMaximumSpeechRate
    
    var synthesizer = AVSpeechSynthesizer()
    var adminSettings = AdminSettings.standard

    func say(message: String) {
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.rate = adminSettings.speechRate
        
        synthesizer.speak(utterance)
    }
}
