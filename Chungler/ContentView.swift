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
        VStack(alignment: .leading) {
            Label("Question", systemImage: "person.fill.questionmark")
            TextField("Question", text: $question, axis: .vertical)
                .background(Color.white)
            Button(action: {
                Task {
                    await answer = AI.ask(question: question)
                    Speech.say(message: answer)
                }
            }) {
                Text("Ask!")
            }
            .buttonStyle(.borderedProminent)

            Label("Answer", systemImage: "arrowshape.right.fill")
            TextField("Answer", text: $answer, axis: .vertical)
                .lineLimit(3...)
                .background(Color.white)
        }
        .frame(maxHeight: .infinity)
        .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
        .background(Image("Hero1")
            .resizable()
            .scaledToFill()
            .opacity(0.5))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
