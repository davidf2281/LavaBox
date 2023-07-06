//
//  Simulator.swift
//  LavaBox
//
//  Created by David Fearon on 26/07/2016.
//  Copyright © 2016 David Fearon. All rights reserved.
//

import Cocoa

protocol SimulatorUpdateDelegate
{
    func simulatorDidUpdateSimulationWithWaterTemperature(temperature : Celsius, time : TimeInterval)
}

class Simulator
{
    private let container : Container
    
    private let waterBody : WaterBody
    
    private let heater    : Heater
 
    var delegate : SimulatorUpdateDelegate
    
    init(container : Container, waterBody : WaterBody, heater : Heater, heaterController : HeaterController)
    {
        self.container = container
        self.waterBody = waterBody
        self.heater = heater
        delegate = heaterController
    }
    
    func simulate(timeStep : TimeInterval, duration : TimeInterval, externalTemperature : Celsius) -> SimulationResults
    {
        var results = SimulationResults()
        
        var currentTime : TimeInterval = 0
        
        var temperatureAveragingAccumulator : Celsius = 0
        
        var iterations : Int = 0
        
        self.heater.switchOn()

        while (currentTime < duration)
        {
            // 1: Calculate notional temperature change of water for given input energy with no losses
            let heaterOutput = self.heater.currentOutputPower
            let inputEnergy = heaterOutput * timeStep
            let temperatureChangeForEnergyInput = self.waterBody.temperatureChangeForInputEnergy(inputEnergy: inputEnergy)
            
            // 2: Calculate energy lost to environment for given notional average temperature change
            let averageTemperature = self.waterBody.temperature + (temperatureChangeForEnergyInput / 2)
            let powerLoss = self.container.powerLoss(internalTemperature:averageTemperature, externalTemperature: externalTemperature)
            let energyLoss = powerLoss * timeStep
            
            // 3: Set water temperature for overall net energy input
            let netInputEnergy = inputEnergy - energyLoss
            let finalTemperatureChange = self.waterBody.temperatureChangeForInputEnergy(inputEnergy: netInputEnergy)
            let finalTemperature = self.waterBody.temperature + finalTemperatureChange
            self.waterBody.temperature = finalTemperature
            
            // 4: Record our data point
            results.append(TemperatureDataPoint(time: currentTime, temperature: finalTemperature))
            
            // 5: Inform heater controller of water temperature and time update
            self.delegate.simulatorDidUpdateSimulationWithWaterTemperature(temperature: self.waterBody.temperature, time: currentTime)
            
            // 6: Prepare for next iteration
            iterations += 1
            temperatureAveragingAccumulator += finalTemperature
            currentTime = currentTime + timeStep
        }

        print(String(format: "Final temperature: %.2f", self.waterBody.temperature))
     
        self.heater.switchOff() // We mustn't waste energy
        
        return results
    }
}
