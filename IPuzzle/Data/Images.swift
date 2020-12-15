//
//  Images.swift
//  IPuzzle
//
//  Created by Hawkar Jamal Ali on 2020-11-24.
//

import Foundation

Struct Images: Decodable {
    
    let id: String
    let author: String
    let width: Int
    let height: Int
    let url: String
    let download_url: String
}
