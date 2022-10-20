//
//  FruitinfoView.swift
//  PIA11Firebase
//
//  Created by Bill Martensson on 2022-10-20.
//

import SwiftUI
import Firebase

struct FruitinfoView: View {
    
    @State var fruktnamn = "Banan"
    @State var fruktid = "XYZ123"

    var ref: DatabaseReference! = Database.database().reference()
    
    var body: some View {
        
        VStack {
            Text("FRUKT INFO")
            
            Text(fruktnamn)
            Text(fruktid)
            
            Button(action: {
                
                var userid = Auth.auth().currentUser!.uid
                
                ref.child("frukter").child(userid).child(fruktid).removeValue()
                
            }, label: {
                Text("Radera!").padding()
            })
            
        }
        
        
    }
}

struct FruitinfoView_Previews: PreviewProvider {
    static var previews: some View {
        FruitinfoView()
    }
}
