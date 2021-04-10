//
//  String+jumbled.swift
//  Logo-Quiz
//
//  Created by Vishal Singh on 10/04/21.
//

import Foundation

extension String {

    var jumbled: [Int: String] {
        var jumbled: [String] = []
        for (index, char) in enumerated() {
            jumbled.append(String(char))
        }
        let alphabets = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        for _ in 0..<jumbled.count {
            jumbled.append(alphabets[Int.random(in: 0..<alphabets.count)])
        }
        
        var indexed: [Int: String] = [:]
        for (index, character) in jumbled.shuffled().enumerated() {
            indexed[index] = character
        }
        
        return indexed
    }
}
