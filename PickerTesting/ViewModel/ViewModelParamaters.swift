//
//  ViewModelParamaters.swift
//  BikeFitPlus1
//
//  Created by Samuel Chambers on 8/3/20.
//  Copyright © 2020 Samuel Chambers. All rights reserved.
//

import Foundation
import Combine

// the data is right; i just need to figure out how to use it

struct Brand: Hashable, Comparable {
    static func == (lhs: Brand, rhs: Brand) -> Bool {
        return lhs.name == rhs.name && lhs.models == rhs.models
    }
    
    static func <(lhs: Brand, rhs: Brand) -> Bool {
        return lhs.name < rhs.name
    }
    
    var name: String
    var models: [Model]

    init(name:String, models:[Model]) {
        self.name = name
        self.models = models
    }
}

struct Model: Hashable, Comparable {
    static func == (lhs: Model, rhs: Model) -> Bool {
        return lhs.name == rhs.name && lhs.years == rhs.years
    }
    
    static func <(lhs: Model, rhs: Model) -> Bool {
        return lhs.name < rhs.name
    }

    var name: String
    var years: [String]

    init(name:String, years:[String]) {
        self.name = name
        self.years = years
    }
}

// This gets ALL the needed data for paramaters: Brand/Model/Year
// duplicates removed
func getBrandsAll() -> [Brand] {
    var brands: [Brand] = []
    let allFrames = frameData
        for i in 0..<allFrames.count {
            brands.append(Brand(name: allFrames[i].brand, models: [Model(name:  allFrames[i].model, years: [allFrames[i].year.description])]))
        }
        let unique = Array(Set(brands))
        let sorted = unique.sorted()
        dump(sorted)
        return sorted
}

// I need a func to rearrange the data so that there are only as many total brand
// objects as their are brands, and each one of them then contains an array of
// models, and then of years
//func combineSort (uglyData: [Brand]) -> [Brand] {
//    var cleanData: [Brand] = []
//    for i in 0..<uglyData.count {
//        if uglyData[i].name == uglyData[i+1].name {
//            cleanData.append(
//        }
//    }
//
//}





//
//
//
//class SearchArrays: ObservableObject {
//
//    var brand: String
//    var model: String
//    var year: Int
//
//    init() {
//        self.brand = ""
//        self.model = ""
//        self.year = 0
//    }
//
//    @Published var brands = getBrands()
//    @Published var models = getAllModels()
//    @Published var years = getAllYears()
//}
//
//
//
//func getBrands() -> [String] {
//    var brands: [String] = []
//    let allFrames = frameData
//        for i in 0..<allFrames.count {
//            brands.append(allFrames[i].brand)
//        }
//    let setBrands = Set(brands)
//    brands = Array(setBrands)
//    return brands.sorted()
//
//}
//
//func getAllModels() -> [String] {
//    var models: [String] = []
//    let allFrames = frameData
//        for i in 0..<allFrames.count {
//            models.append(allFrames[i].model)
//        }
//        let setModels = Set(models)
//        models = Array(setModels)
//        return models.sorted()
//}
//
//
//func getAllYears() -> [Int] {
//    var years: [Int] = []
//    let allFrames = frameData
//    for i in 0..<allFrames.count {
//        years.append(allFrames[i].year)
//    }
//    let setYears = Set(years)
//    years = Array(setYears)
//    return years.sorted().reversed()
//}
//
//
//func getModelsFromBrand (brand: String) -> [String] {
//    var models: [String] = []
//    let allFrames = frameData
//    for i in 0..<allFrames.count {
//        if allFrames[i].brand == brand {
//            models.append(allFrames[i].model)
//        }
//    }
//        let setModels = Set(models)
//        models = Array(setModels)
//        return models.sorted()
//}
//
//func getYearsFromModels (model: String) -> [Int] {
//    var years: [Int] = []
//    let allFrames = frameData
//    for i in 0..<allFrames.count {
//        if allFrames[i].model == model {
//            years.append(allFrames[i].year)
//        }
//    }
//    let setYears = Set(years)
//    years = Array(setYears)
//    return years.sorted().reversed()
//}
//




