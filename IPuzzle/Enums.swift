//
//  Enums.swift
//  IPuzzle
//
//  Created by Hawkar Jamal Ali on 2020-11-26.
//

import Foundation

enum NumberLevels : Int {
    case easy   = 4
    case medium = 8
    case hard   = 12
    case insane = 16
    case areyoukiddingme = 20
}
enum ImageLevels : Int {
    case easy   = 4
    case normal = 6
    case hard   = 8
}
enum TileMoves{
    case up, down, right, left, notMove
}
