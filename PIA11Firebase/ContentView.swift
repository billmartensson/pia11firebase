//
//  ContentView.swift
//  PIA11Firebase
//
//  Created by Bill Martensson on 2022-10-17.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var fancytext = "Hej"

    @State var userfruit = ""
    
    @State var allthefruits : [String] = []
    
    var ref: DatabaseReference! = Database.database().reference()

    
    
    var body: some View {
        VStack {
            Text(fancytext)
            
            TextField("Frukt", text: $userfruit)
            
            Button(action: {
                ref.child("myfruits").childByAutoId().setValue(userfruit)
                loadfruits()
                
            }, label: {
                Text("Spara")
            })
            
            List(allthefruits, id: \.self) { rowfruit in
                Text(rowfruit)
            }
            
        }
        .padding()
        .onAppear() {
            
            print("Nu visas vyn")
            
            /*
            ref.child("fruit").getData(completion:  { error, snapshot in
                let thefruit = snapshot!.value as! String
                
                print(thefruit)
                
                userfruit = thefruit
            })
            */
            
            loadfruits()
            
            print("Och nu händer detta")
            
            
            
        }
    }
    
    
    func loadfruits() {
        
        allthefruits = []
        
        ref.child("myfruits").getData(completion:  { error, snapshot in
            
            for somefruit in snapshot!.children {
                
                let fruitsnap = somefruit as! DataSnapshot
                
                let fruitname = fruitsnap.value as! String
                
                print(fruitname)
                allthefruits.append(fruitname)
            }
            
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
