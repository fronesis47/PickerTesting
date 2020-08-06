//
// FrameData.swift
//  JsonTesting
//
//  Created by Samuel Chambers on 7/23/20.
//  Copyright © 2020 Samuel Chambers. All rights reserved.
//

import Foundation
import Combine

class Frames: Codable, Identifiable  {

    public var id: Int
    public var model: String
    public var brand: String
    public var year: Int
    public var size: String
    public var modHTA: Double
    public var modStack: Double
    public var modReach: Double

    enum CodingKeys: String, CodingKey {
            case id = "ID"
            case model = "Model"
            case brand = "Brand"
            case year = "Year"
            case size = "Size"
            case modHTA = "HTA"
            case modStack = "Stack"
            case modReach = "Reach"
        }
}



// loads json data; used in getBrands, getModelsFromBrands, getYearsFromModels and frameParameterFilter
let frameData: [Frames] = Bundle.main.decode("newBikes.json")

// Extension fetches remote JSON file containing all frame data
extension Bundle {
    func decode(_ file: String) -> [Frames] {
        guard let url = URL(string: "https://raw.githubusercontent.com/fronesis47/frameData/master/newBikes.json") else {
            fatalError("Failed to load remote file.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to read remote file.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode([Frames].self, from: data) else {
            fatalError("Failed to *decode* remote file.")
        }
        print("accessing json now")
        return loaded
    }
}
