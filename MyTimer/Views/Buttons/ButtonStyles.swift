//
//  ButtonStyles.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 19.12.23.
//

import SwiftUI

struct StartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 70)
            .foregroundStyle(.timerButtonStart)
            .background(.timerButtonStart.opacity(0.3))
            .clipShape(Circle())
            .padding(.all, 3)
            .overlay(
                Circle()
                    .stroke(.timerButtonStart
                        .opacity(0.3), lineWidth: 2)
            )
    }
}


struct CancelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 70)
            .foregroundStyle(.timerButtonCancel)
            .background(.timerButtonCancel.opacity(0.3))
            .clipShape(Circle())
            .padding(.all, 3)
            .overlay(
                Circle()
                    .stroke(.timerButtonCancel
                        .opacity(0.3), lineWidth: 2)
            )
    }
}


struct PauseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 70)
            .foregroundStyle(.timerButtonPause)
            .background(.timerButtonPause.opacity(0.3))
            .clipShape(Circle())
            .padding(.all, 3)
            .overlay(
                Circle()
                    .stroke(.timerButtonPause
                        .opacity(0.3), lineWidth: 2)
            )
    }
}
