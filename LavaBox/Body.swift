//
//  Body.swift
//  LavaBox
//
//  Created by David Fearon on 26/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class Body
{
    private let length  : Float
    private let width   : Float
    private let height  : Float
    
    private let density : Float
    
    private let specificHeatCapacity : Float

    private var volume : Float
    {
        return length * width * height
    }
    
    private var mass : Float
    {
        return volume * density
    }
    
    private var surfaceArea : Float
    {
        return (length * width * 2) + (length * height * 2) + (width * height * 2)
    }
    
    init(length : Float, width : Float, height : Float, density : Float, specificHeatCapacity : Float)
    {
        self.specificHeatCapacity = specificHeatCapacity
        self.length =  length
        self.width =   width
        self.height =  height
        self.density = density
    }
}
