//
//  TimePickerView.swift
//  MyTimer
//
//  Created by Petar Dzhambazov on 19.12.23.
//

import SwiftUI

struct TimePickerPartView: View {
    let title: String
    let range: ClosedRange<Int>
    let binding: Binding<Int>
    // This is used to tighten up the spacing between the Picker and its
    // respective label
    //
    // This allows us to avoid having to use custom
    private let pickerViewTitlePadding: CGFloat = 4.0
    
    var body: some View {
        HStack(spacing: -pickerViewTitlePadding) {
            Picker(title, selection: binding) {
                ForEach(range, id: \.self) { timeIncrement in
                    HStack {
                        Spacer()
                        Text("\(timeIncrement)")
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .pickerStyle(InlinePickerStyle())
            .labelsHidden()
            
            Text(title)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    TimePickerPartView(title: "Hours", range: 0...23, binding: Binding.constant(0))
}
