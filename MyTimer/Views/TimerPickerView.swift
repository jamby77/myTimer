//
//  TimerPickerView.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 19.12.23.
//

import SwiftUI

struct TimerPickerView: View {
    @StateObject private var model = TimerViewModel()
    
    var controls: some View {
        HStack {
            Button("Cancel") {
                model.state = .canceled
            }
            .buttonStyle(CancelButtonStyle())
            
            Spacer()
            
            switch model.state {
            case .active, .resumed:
                Button("Pause") {
                    model.state = .paused
                }.buttonStyle(PauseButtonStyle())
            case .paused:
                Button("Resume") {
                    model.state = .resumed
                }
                .buttonStyle(PauseButtonStyle())
            case .canceled, .finished:
                Button("Start") {
                    model.state = .active
                }
                .buttonStyle(StartButtonStyle())
                
            }
        }
        .padding(.horizontal, 32)
    }
    
    var picker: some View {
        HStack {
            TimePickerPartView(
                title: "hours",
                range: model.hoursRange,
                binding: $model.selectedHoursAmount
            )
            TimePickerPartView(
                title: "min",
                range: model.minutesRange,
                binding: $model.selectedMinutesAmount
            )
            TimePickerPartView(
                title: "sec",
                range: model.secondsRange,
                binding: $model.selectedSecondsAmount
            )
        }
        .padding(32)
        .frame(width: 360, height: 255)
        .background(.black)
        .foregroundColor(.white)
    }
    
    var progressView: some View {
        ZStack {
            withAnimation {
                TimerProgressView(progress: $model.progress)
            }
            VStack {
                Text(model.secondsToCompletion.asTimestamp)
                    .font(.largeTitle)
                HStack {
                    Image(systemName: "bell.fill")
                    Text(
                        model.completionDate,
                        format: .dateTime.hour().minute()
                    )
                }
            }
        }
        .frame(width: 360, height: 255)
        .padding(32)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                if model.state == .canceled {
                    picker
                } else {
                    progressView
                }
                
                Spacer()
                controls
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    TimerPickerView()
}
