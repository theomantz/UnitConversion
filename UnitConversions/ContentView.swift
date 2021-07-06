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
        let localInput = Double(input) ?? 0.0000000001
        
        var intermediateValue = 0.0
        
        if (type == "Temperature") {
            if (iSystem == "Metric" ) {
                if (oSystem == "Metric" ) {
                    return localInput
                } else {
                    return localInput == 0.0000000001 ? 0 : (localInput * (9/5)) + 32
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
                    return oUnit == "Meter" ? intermediateValue : intermediateValue * 1000
                } else {
                    if (oUnit == "Foot") {
                        return intermediateValue * 3.28084
                    } else if (oUnit == "Yard") {
                        return intermediateValue * 1.09361
                    } else {
                        return intermediateValue * 0.000621371
                    }
                }
            } else {
                if (iUnit == "Foot") {
                    intermediateValue = localInput
                } else {
                    intermediateValue = iUnit == "Yard" ? localInput * 3 : localInput * 5280
                }
                if (oSystem == "Imperial") {
                    if (oUnit == "Foot") {
                        return intermediateValue
                    } else {
                        return oUnit == "Yard" ? intermediateValue / 3 : intermediateValue / 5280
                    }
                } else {
                    return oUnit == "Meter" ? intermediateValue * 0.3048 : intermediateValue * 0.0003048
                }
            }
        } else if (type == "Volume") {
            if (iSystem == "Metric") {
                intermediateValue = iUnit == "Liter" ? localInput : localInput / 1000
                if (oSystem == "Metric") {
                    return oUnit == "Liter" ? intermediateValue : intermediateValue * 1000
                } else {
                    if (oUnit == "Pint") {
                        return intermediateValue * 2.11338
                    } else if (oUnit == "Quart") {
                        return intermediateValue * 1.05669
                    } else {
                        return intermediateValue * 0.26417250012978
                    }
                }
            } else if (iSystem == "Imperial") {
                if (iUnit == "Pint") {
                    intermediateValue = localInput * 0.125
                } else {
                    intermediateValue = iUnit == "Quart" ? localInput * 0.25 : localInput
                }
                if (oSystem == "Imperial") {
                    if (oUnit == "Pint") {
                        return intermediateValue / 0.125
                    } else {
                        return oUnit == "Gallon" ? intermediateValue : intermediateValue / 0.25
                    }
                } else {
                    return intermediateValue * (oUnit == "Liter" ? 3.78541 : 3785.41)
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
