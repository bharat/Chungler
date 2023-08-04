//
//  Speech.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/4/23.
//

import Foundation
import AVFoundation

class Speech {
    static let synthesizer = AVSpeechSynthesizer()

    static func say(message: String) {
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        
        synthesizer.speak(utterance)
    }
}
