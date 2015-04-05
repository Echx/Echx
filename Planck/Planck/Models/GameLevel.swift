//
//  GameLevel.swift
//  Planck
//
//  Created by Jiang Sheng on 5/4/15.
//  Copyright (c) 2015 Echx. All rights reserved.

import UIKit
import Foundation

class GameLevel: NSObject {
    
    var grid:GOGrid
    
    var name:String
    
    var index:Int
    
    init(levelName:String, levelIndex: Int, grid:GOGrid) {
        self.name = levelName
        self.index = levelIndex
        self.grid = grid
    }
}