//
//  Body.swift
//  LavaBox
//
//  Created by David Fearon on 26/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class WaterBody
{
    var temperature : Celsius

    private let length  : Metres
    private let width   : Metres
    private let height  : Metres
    
    private let density : KilogramsPerCubicMetre = 1000
    
    
    private let specificHeatCapacity : JoulesPerKilogramKelvin = 4181

    private var volume : CubicMetres
    {
        return length * width * height
    }
    
    private var mass : Kilograms
    {
        return volume * density
    }
    
    private var surfaceArea : SquareMetres
    {
        return (length * width * 2) + (length * height * 2) + (width * height * 2)
    }
    
    init(length : Metres, width : Metres, height : Metres, initialTemperature : Celsius)
    {
        self.length =  length
        self.width =   width
        self.height =  height
        
        self.temperature = initialTemperature
    }
    
    func temperatureChangeForInputEnergy(inputEnergy : Joules) -> Celsius
    {
        return inputEnergy / (self.mass * self.specificHeatCapacity)
    }
}
