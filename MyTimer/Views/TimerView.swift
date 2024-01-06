//
//  TimerPickerView.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 19.12.23.
//

import SwiftUI

struct TimerView: View {
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
                .buttonStyle(StartButtonStyle())
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
                title: TimePickerOptions.hrs,
                range: TimePickerOptions.hoursRange,
                binding: $model.selectedHoursAmount
            )
            TimePickerPartView(
                title: TimePickerOptions.min,
                range: TimePickerOptions.minutesRange,
                binding: $model.selectedMinutesAmount
            )
            TimePickerPartView(
                title: TimePickerOptions.sec,
                range: TimePickerOptions.secondsRange,
                binding: $model.selectedSecondsAmount
            )
        }
        .padding(32)
        .frame(width: 360, height: 255)
    }
    
    var progressView: some View {
        ZStack {
            withAnimation {
                TimerProgressView(progress: $model.progress)
            }
            VStack {
                Text(model.secondsToCompletion.asTimestamp)
                    .monospacedDigit()
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                HStack {
                    Image(systemName: "bell.fill")
                    Text(
                        model.completionDate,
                        format: .dateTime.hour().minute()
                    )
                }
                .padding(.top, 5)
            }
            .padding()
        }
        .frame(width: 360, height: 360)
        .padding()
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
                
                controls
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    TimerView()
}
