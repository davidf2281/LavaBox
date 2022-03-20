# LavaBox - Because Thermal Simulations Are Fun

LavaBox simulates and (very crudely) graphs the change in temperature over time of a volume of water, in a given thickness of container made of a given material, when heat is applied by a heater with a given output power to a controlled target temperature. Because who wouldn’t want to play about and determine the electrical requirements of a sous-vide cooker design they had kicking around in their head?

It's essentially just an iterative integrator of the thermal conduction equation: **Q/t = kA(T1 - T2)/d**, along with a basic model of a heater controller with very simple thermostatic on / off threshold control. It was designed to allow quick, rough estimation of the power requirement to heat water to a given temperature over a reasonable time, allowing tweaking of the size of the cooker, wall thickness etc.

Lavabox was written in 2016 purely as an experiment and doesn’t follow any particular software design pattern beyond what I thought looked pretty at the time. It has no tests either, although just for fun I’ll probably add some at some point.

It turned out to be a nice little demonstrator of Swift code-clarity, with little things like `typealias` making the code more or less self-documenting, eg:

```
    private let specificHeatCapacity: JoulesPerKilogramKelvin = 4181
    
    func temperatureChangeForInputEnergy(inputEnergy: Joules) -> Celsius
    {
        return inputEnergy / (self.mass * self.specificHeatCapacity)
    }
```

Set your simulation parameters in [ViewController.swift](https://github.com/davidf2281/LavaBox/blob/master/LavaBox/ViewController.swift) and have fun!
