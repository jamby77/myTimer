//
//  Int+Extension.swift
//  TimerDemo
//
//  Created by Aryaman Sharda on 2/20/23.
//

import Foundation

extension Float {
    var asTimestamp: String {
        let hour = Int(self) / 3600
        let minute = Int(self) / 60 % 60
        let second = Int(self) % 60

        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}
