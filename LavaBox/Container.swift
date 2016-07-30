//
//  Container.swift
//  LavaBox
//
//  Created by David Fearon on 30/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

class Container
{
    private let externalLength,
                externalWidth,
                externalHeight,
                wallThickness,
                thermalConductivity : Float
    
    /*
     The thermal conduction equation: Q/t = kA(T1 - T2)/d relies on what is effectively the
     constant kA/d. Fudge factor is a coefficient that nudges the value of kA/d to match
     empirically derived values.
     */
    private var fudgeFactor : Float = 1
    
    private var volume : Float
    {
        return externalLength * externalWidth * externalHeight
    }

    internal var surfaceArea : Float
    {
        return (externalLength * externalWidth * 2) + (externalLength * externalHeight * 2) + (externalWidth * externalHeight * 2)
    }
    
    init(externalLength : Float, externalWidth : Float, externalHeight : Float, wallThickness : Float, thermalConductivity : Float)
    {
        self.externalLength =  externalLength
        self.externalWidth =   externalWidth
        self.externalHeight =  externalHeight
        self.wallThickness = wallThickness
        self.thermalConductivity = thermalConductivity
    }
    
    func calibrateForEnergyLoss(energyLoss : Float, time : TimeInterval, externalTemperature : Float, internalTemperature : Float)
    {
        
    }
}
