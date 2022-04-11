//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Amruta on 12/02/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper( value: $order.quantity, in: 3...20){
                        Text("Number of Cakes: \(order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()){
                        Text("Any special request")
                    }
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add Sprinkles")
                        }
                    }
                    
                }
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}


//Each of them need to update the UI when changed,make the whole class conform to ObservableObject
class Order: ObservableObject, Encodable, Decodable {
    static let types = ["Vanilla","Strawberry","Chocolate", "Rainbow"]
    @Published var type = 0
    @Published var quantity = 3
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    //coumpund property
    var  hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty { return false}
        return true
    }
    
    //coumpound property
    var cost: Double {
        //cost $2 per cake
        var cost = Double(quantity) * 2
        
        //cost for complicated cake
        cost += (Double(type) / 2)
        
        //$1 per extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //$0.50 per cake for sprinkle
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    func encode( to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
            try container.encode(type, forKey: .type)
            try container.encode(quantity, forKey: .quantity)

            try container.encode(extraFrosting, forKey: .extraFrosting)
            try container.encode(addSprinkles, forKey: .addSprinkles)

            try container.encode(name, forKey: .name)
            try container.encode(streetAddress, forKey: .streetAddress)
            try container.encode(city, forKey: .city)
            try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)

        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)

        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    init() {}
}

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View{
        
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }.disabled(order.hasValidAddress == false)
            
        }.navigationBarTitle("Delivery details", displayMode: .inline)
    
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
