//
//  StopwatchView.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 6.01.24.
//

import SwiftUI

struct StopwatchView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            Text("Stopwatch")
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    StopwatchView()
}
