//
//  ContentView.swift
//  Chungler
//
//  Created by Bharat Mediratta on 7/25/23.
//

import SwiftUI

struct ContentView: View {
    // Array of image names from the image set
    @State var question = ""
    @State var answer = ""

    var body: some View {
        ZStack {
            Image("Hero1")
                .resizable()
                .scaledToFill()
                .opacity(0.5)
            VStack(alignment: .leading) {
                Label("Question", systemImage: "person.fill.questionmark")
                TextField("Question", text: $question, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...5)
                    .onSubmit {
                        Task {
                            await answer = AI.ask(question: question)
                            Speech.say(message: answer)
                        }
                    }
                Label("Answer", systemImage: "arrowshape.right.fill")
                TextField("Answer", text: $answer, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...)
            }
            .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
