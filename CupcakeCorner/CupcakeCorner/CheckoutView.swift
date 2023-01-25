//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Gorkem Turan on 01/01/2023.
//

import SwiftUI

enum AlertType {
    case none
    case error
    case confirmation
}


struct CheckoutView: View {
    @ObservedObject var order: Order

    @State private var confirmationMessage = ""
    @State private var showingAlert = false
    @State private var alertType: AlertType = .none
    @State private var errorMessage = ""

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityHidden(true)
                } placeholder: {
                    ProgressView()
                        .accessibilityHidden(true)
                }
                .frame(height: 233)

                Text("Your total is \(order.item.cost, format: .currency(code: "USD"))")
                    .font(.title)

                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
            
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingAlert) {
            switch alertType {
            case .error:
                return Alert(title: Text("An error occured!"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            default :
                return Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func placeOrder() async {
        // Convert the order object into some JSON data that can be sent.
        guard let encoded = try? JSONEncoder().encode(order.item) else {
            print("Failed to encode order")
            return
        }
        print("Order is encoded")
        // Prepare a URLRequest to send encoded data as JSON.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        print("Encoded order is prepared to sent")
        
        
        // ------- this is alternative code for do-catch section below
        // Run that request and process the response.
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                errorMessage = "\(error?.localizedDescription ?? "Unknown error")"
                alertType = .error
                showingAlert = true

                return
            }
            print("Data from server received successfuly")
            guard let decodedOrder = try? JSONDecoder().decode(Item.self, from: data) else {
                print("Response or decoder is wrong")
                return
            }
            print("Decoded successfully: \(decodedOrder)")
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Item.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            alertType = .confirmation
            showingAlert = true
        }.resume()
        //--------
//
//        do {
//            guard let (data, _) = try? await URLSession.shared.upload(for: request, from: encoded) else {
//                errorMessage = "Network error"
//                alertType = .error
//                showingAlert = true
//                return
//            }
//
//            guard let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
//                print("asdasdad")
//                return
//            }
//            confirmationMessage = "Your order for \(decodedOrder.item.quantity)x \(Item.types[decodedOrder.item.type].lowercased()) cupcakes is on its way!"
//            showingAlert = true
//            alertType = .confirmation
//        } catch {
//            print("Checkout failed.")
//        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
