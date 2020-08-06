import Foundation
import SwiftUI

struct ContentView: View {

    @State private var brands = getBrandsAll()

    @State private var brand = Brand()
    @State private var model = Model()
    @State private var chosenBrand = 0
    @State private var chosenModel = 0
    @State private var chosenYear = 0
    
    var body: some View {
        VStack {
            Picker(selection: $chosenBrand, label: Text("Brand")) {
                ForEach(0..<self.brands.count) { index in
                    Text(self.brands[index].name).tag(index)
                    }
                }
                .labelsHidden()
                .onChange(of: chosenBrand) { _ in brand = self.brands[chosenBrand];
                    chosenModel = 0 }
            
            Picker(selection: $chosenModel, label: Text("Model")) {
                ForEach(0..<brand.models.count) { index in
                    Text(brand.models[index].name).tag(index)
                    }
                }
            .onChange(of: chosenModel) { _ in model = self.brands[chosenBrand].models[chosenModel] ; chosenYear = 0 }
                .id(brand)
                .labelsHidden()
            
            Picker(selection: $chosenYear, label: Text("Year")) {
                ForEach(0..<model.years.count) { index in
                    Text(model.years[index].description).tag(index)
                    }
                }
            .labelsHidden()
            .id(model)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
