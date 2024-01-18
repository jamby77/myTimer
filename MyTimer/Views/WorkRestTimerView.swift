//
//  WorkRestTimerView.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 6.01.24.
//

import SwiftUI

struct WorkRestTimerView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @StateObject private var model = WorkRestTimerViewModel()
    
    private var progressSize: CGFloat {
        horizontalSizeClass == .regular ? 120 : 72
    }
    
    var controls: some View {
        HStack {
            switch model.state {
            case .work, .resumeWork:
                Button("Rest") {
                    model.state = .rest
                }
                .buttonStyle(CancelButtonStyle())
            case .rest, .resumeRest:
                Button("Work") {
                    model.state = .rest
                }
                .buttonStyle(CancelButtonStyle())
            case .pauseWork, .pauseRest:
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
            case .work, .resumeWork:
                Button("Pause") {
                    model.state = .pauseWork
                }.buttonStyle(PauseButtonStyle())
            case .rest, .resumeRest:
                Button("Pause") {
                    model.state = .pauseRest
                }.buttonStyle(PauseButtonStyle())
            case .pauseWork:
                Button("Resume") {
                    model.state = .resumeWork
                }
                .buttonStyle(StartButtonStyle())
            case  .pauseRest:
                Button("Resume") {
                    model.state = .resumeRest
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
        return Text(model.displayTimeInMs.asTimestamp)
            .monospacedDigit()
            .font(.system(
                size: progressSize,
                weight: .semibold,
                design: .monospaced
            ))
            .foregroundStyle(model.displayColor)
            .padding()
    }
    
    var stageView: some View {
        if model.state == .work || model.state == .resumeWork {
            return Text("Work")
                .font(.largeTitle)
                .foregroundStyle(.green)
        }
        if model.state == .rest || model.state == .resumeRest {
            return Text("Rest")
                .font(.largeTitle)
                .foregroundStyle(.orange)
        }
        return Text("Ready...")
            .font(.largeTitle)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                stageView
                progressView
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

