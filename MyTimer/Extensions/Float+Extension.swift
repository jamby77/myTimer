//
//  Int+Extension.swift
//  TimerDemo
//
//  Created by Aryaman Sharda on 2/20/23.
//

import Foundation

extension Float {
    var asTimestamp: String {
        let timeInMs = Int(self * 100)
//        print(self, timeInMs)
        let hour = (timeInMs/100) / 3600
        let minute = (timeInMs/100) / 60 % 60
        let second = (timeInMs/100) % 60
        let ms = timeInMs % 100

        return String(format: "%02i:%02i:%02i.%02i", hour, minute, second, ms)
    }
}
