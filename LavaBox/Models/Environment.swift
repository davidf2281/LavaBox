//
//  Environment.swift
//  LavaBox
//
//  Created by David Fearon on 26/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

struct Environment
{
    let ambientTemperature : Celsius
    
    init(ambientTemperature : Celsius)
    {
        self.ambientTemperature = ambientTemperature
    }
}
