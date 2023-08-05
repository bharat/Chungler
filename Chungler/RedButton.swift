//
//  RedButton.swift
//  Chungler
//
//  Created by Bharat Mediratta on 8/5/23.
//

import SwiftUI

struct RedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
