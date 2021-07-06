//
//  ContentView.swift
//  UnitConversions
//
//  Created by Theodore Mantz on 7/1/21.
//

import SwiftUI

struct ContentView: View {
//    Initialize state variables to hold user input values
    @State private var conversionType = 0
    @State private var inputSystem = 0
    @State private var outputSystem = 0
    @State private var inputUnits = 0
    @State private var outputUnits = 0
    @State private var input = ""
    
//    Initialize conversion type array
    let conversionTypes = ["Temperature", "Length", "Volume"]
    let systems = ["Metric", "Imperial"]
    let measures = [
        [["Celsius"], ["Fahrenheit"]],
        [["Meter", "Kilometer"], ["Foot", "Yard", "Mile"]],
        [["Millileter", "Liter"], ["Pint", "Quart", "Gallon"]]
    ]
    
    var output: Double {
        let type = conversionTypes[conversionType]
        let iSystem = systems[inputSystem]
        let oSystem = systems[outputSystem]
        let iUnit = measures[conversionType][inputSystem][inputUnits]
        let oUnit = measures[conversionType][inputSystem][inputUnits]
        let localInput = Double(input) ?? 0
        
        var intermediateValue = 0.0
        
        if (type == "Temperature") {
            if (iSystem == "Metric" ) {
                if (oSystem == "Metric" ) {
                    return localInput
                } else {
                    return (localInput * (9/5)) + 32
                }
            } else {
                if (oSystem == "Imperial") {
                    return localInput
                } else {
                    return ((localInput - 32) * (5/9))
                }
            }
        } else if (type == "Length") {
            if (iSystem == "Metric") {
                intermediateValue = iUnit == "Meter" ? localInput : localInput / 1000
                if (oSystem == "Metric") {
                    
                } else {
                    
                }
            }
        }
        
        return 0.0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Conversion Type")){
                    Picker("Conversion Type", selection: $conversionType) {
                        ForEach(0 ..< conversionTypes.count) {
                            Text("\(self.conversionTypes[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section (header: Text("Converting From")){
                    Picker("From System", selection: $inputSystem) {
                        ForEach(0 ..< systems.count) {
                            Text("\(self.systems[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("Input Units", selection: $inputUnits) {
                        ForEach(0 ..< measures[conversionType][inputSystem].count) {
                            Text("\(self.measures[conversionType][inputSystem][$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    TextField("Input", text: $input)
                        .keyboardType(.decimalPad)
                }
                Section (header: Text("Converting To")) {
                    Picker("To System", selection: $outputSystem) {
                        ForEach(0 ..< systems.count) {
                            Text("\(self.systems[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Picker("Output Units", selection: $outputUnits) {
                        ForEach(0 ..< measures[conversionType][outputSystem].count) {
                            Text("\(self.measures[conversionType][outputSystem][$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("\(output, specifier: "%.2f") \(measures[conversionType][outputSystem][outputUnits])")
                        .multilineTextAlignment(.center)
                }
            }
            .navigationBarTitle("Unitify")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
