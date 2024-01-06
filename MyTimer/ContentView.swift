//
//  ContentView.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 18.12.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
            
            StopwatchView()
                .tabItem {
                    Label("Stopwatch", systemImage: "stopwatch.fill")
                }
            WorkRestTimerView()
                .tabItem {
                    Label("Work Rest", systemImage: "timer.circle")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
