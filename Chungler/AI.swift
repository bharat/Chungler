//
//  AI.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/1/23.
//

import Foundation
import ChatGPTKit

class AI {
    static let defaultBasePrompt = "You are a Mandarin teacher. You reply only in Mandarin. You use small words and simple sentences. You answer without repeating the question."
    static let standard = AI()

    var history: [Message]
    let adminSettings = AdminSettings()

    init() {
        self.history = []
    }
    
    func ask(question: String) async -> String {
        let chattyGPT = ChatGPTKit(apiKey: adminSettings.apiKey)

        do {
            history.append(Message(role: .user, content: question))

            // Reference: https://community.openai.com/t/cheat-sheet-mastering-temperature-and-top-p-in-chatgpt-api-a-few-tips-and-tricks-on-controlling-the-creativity-deterministic-output-of-prompt-responses/172683
            switch try await chattyGPT.performCompletions(
                messages: [Message(role: .system, content: adminSettings.basePrompt)] + history,
                temperature: 0.5,
                topP: 0.5
            ) {
            case .success(let response):
                print(response)
                if let firstResponse = response.choices?.first {
                    history.append(firstResponse.message)
                    history = history.suffix(6)

                    return firstResponse.message.content
                }
            case .failure(let error):
                print(error)
                return error.message
            }
        } catch let error {
            return error.localizedDescription.debugDescription
        }
        
        return "error"
    }
}
