//
//  AI.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/1/23.
//

import Foundation
import ChatGPTKit

class AI {
    static let standard = AI()
    let adminSettings = AdminSettings()
    
    func ask(question: String) async -> String {
        
        let chattyGPT = ChatGPTKit(apiKey: adminSettings.apiKey)
        var history = [
            Message(role: .system, content: "You are a Mandarin teacher. You understand English but only speak in Mandarin that a 9 year old with 3 years of Mandarin experience can understand. You never speak in English. You use small words where possible. You answer questions without repeating the question."),
            Message(role: .user, content: question)
        ]

        do {
            switch try await chattyGPT.performCompletions(messages: history) {
            case .success(let response):
                if let firstResponse = response.choices?.first {
                    history.append(firstResponse.message)
                    return firstResponse.message.content
                }
            case .failure(let error):
                return error.message
            }
        } catch let error {
            return error.localizedDescription.debugDescription
        }
        
        return "error"
    }
}
