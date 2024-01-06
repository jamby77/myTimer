//
//  WorkRestTimerView.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 6.01.24.
//

import SwiftUI

struct WorkRestTimerView: View {
    
    @StateObject private var model = WorkRestTimerViewModel()
    
    var controls: some View {
        HStack {
            switch model.state {
            case .work, .rest, .resumed:
                Button("Lap") {
                    model.state = .canceled
                }
                .buttonStyle(CancelButtonStyle())
            case .paused:
                Button("Reset") {
                    model.state = .canceled
                }
                .buttonStyle(CancelButtonStyle())
            case .canceled, .finished:
                Button("Cancel") {
                    model.state = .canceled
                }
                .buttonStyle(CancelButtonStyle())
            }
            
            Spacer()
            
            switch model.state {
            case .work, .rest, .resumed:
                Button("Pause") {
                    model.state = .paused
                }.buttonStyle(PauseButtonStyle())
            case .paused:
                Button("Resume") {
                    model.state = .resumed
                }
                .buttonStyle(StartButtonStyle())
            case .canceled, .finished:
                Button("Start") {
                    model.state = .work
                }
                .buttonStyle(StartButtonStyle())
            }
        }
        .padding(.horizontal, 32)
    }
    var progressView: some View {
        VStack {
            Text(model.elapsedTimeInSeconds.asTimestamp)
                .monospacedDigit()
                .font(.system(size: 60, weight: .semibold, design: .rounded))
        }
        .padding()
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                if model.state == .canceled {
                    progressView
                } else {
                    progressView
                }
                
                controls
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    WorkRestTimerView()
}

