//
//  ContentView.swift
//  PIA11Firebase
//
//  Created by Bill Martensson on 2022-10-17.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @State var useremail = ""
    @State var userpass = ""
    
    @State var userfruit = ""
    
    @State var allthefruits : [String] = []
    @State var alltheids : [String] = []

    
    var ref: DatabaseReference! = Database.database().reference()

    
    
    var body: some View {
        
        NavigationView {
            VStack {
                
                TextField("E-post", text: $useremail)
                TextField("Lösenord", text: $userpass)
                
                HStack {
                    Button(action: {
                        Auth.auth().createUser(withEmail: useremail, password: userpass) { authResult, error in
                            print("REGISTRERAT RESULTAT")
                        }
                    }, label: {
                        Text("Registrera")
                    })
                    Button(action: {
                        Auth.auth().signIn(withEmail: useremail, password: userpass) { authResult, error in
                            print("LOGIN RESULTAT")
                            loadfruits()
                        }
                    }, label: {
                        Text("Logga in")
                    })
                    
                    Button(action: {
                        try! Auth.auth().signOut()
                    }, label: {
                        Text("Logga ut")
                    })
                }
                
                TextField("Frukt", text: $userfruit)
                
                Button(action: {
                    
                    var userid = Auth.auth().currentUser!.uid
                    
                    ref.child("frukter").child(userid).childByAutoId().setValue(userfruit)
                    loadfruits()
                    
                }, label: {
                    Text("Spara")
                })
                
                /*
                List(allthefruits, id: \.self) { rowfruit in
                    
                    NavigationLink(destination: FruitinfoView(fruktnamn: rowfruit)) {
                        Text(rowfruit)
                    }
                    
                }
                */
                
                List {
                    ForEach(Array(allthefruits.enumerated()), id: \.element) { index, rowfruit in
                        
                        
                        NavigationLink(destination: FruitinfoView(fruktnamn: allthefruits[index], fruktid: alltheids[index])) {
                            HStack {
                                Text(String(index))
                                Text(allthefruits[index])
                                //Text(alltheids[index])
                            }
                        }
                        
                        
                        
                    }
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
                
                if(Auth.auth().currentUser == nil) {
                    print("INTE INLOGGAD")
                } else {
                    print("INLOGGAD")
                    
                    print(Auth.auth().currentUser?.email)
                    print(Auth.auth().currentUser?.uid)
                    
                    loadfruits()
                }
                
                
                
                
                print("Och nu händer detta")
                
                
                
            } // HÄR SLUTAR VSTACK SAKER
            
        }
    }
    
    
    func loadfruits() {
        
        allthefruits = []
        alltheids = []
                
        var userid = Auth.auth().currentUser!.uid
        
        ref.child("frukter").child(userid).getData(completion:  { error, snapshot in
            
            for somefruit in snapshot!.children {
                
                let fruitsnap = somefruit as! DataSnapshot
                
                let fruitname = fruitsnap.value as! String
                let fruitid = fruitsnap.key
                
                
                print(fruitname)
                allthefruits.append(fruitname)
                alltheids.append(fruitid)
            }
            
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
