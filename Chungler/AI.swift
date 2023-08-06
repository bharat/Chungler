//
//  AI.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/1/23.
//

import Foundation
import ChatGPTKit

class AI {
    static let defaultBasePrompt = """
Follow these 7 instructions below in all your responses:
1. Use the Chinese language only;
2. Use the Chinese alphabet whenever possible;
3. Do not use English
4. Avoid the Latin alphabet whenever possible;
5. Translate any other language to the Chinese language whenever possible;
6. Use small words and simple sentences;
7. Answer without repeating the question.
"""

    var history: [Message]
    let adminSettings = AdminSettings.standard

    init() {
        self.history = []
    }
    
    func ask(question: String) async -> String {
        let chattyGPT = ChatGPTKit(apiKey: adminSettings.apiKey)

        do {
            history.append(Message(role: .user, content: question))
            let messages = [Message(role: .system, content: adminSettings.basePrompt)] + history
            print(messages)

            // Reference: https://community.openai.com/t/cheat-sheet-mastering-temperature-and-top-p-in-chatgpt-api-a-few-tips-and-tricks-on-controlling-the-creativity-deterministic-output-of-prompt-responses/172683
            switch try await chattyGPT.performCompletions(
                messages: messages,
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
