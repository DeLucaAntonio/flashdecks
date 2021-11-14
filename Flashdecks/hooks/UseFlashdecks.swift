//
//  useFlashdecks.swift
//  Flashdecks
//
//  Created by Antonio on 14/11/21.
//
// How to read JSON files https://www.youtube.com/watch?v=9tkoD0fSxmU&t=871s

import Foundation

// public class to use all Flashdecks properties and functions
public class UseFlashdecks {
    
    // Published used to maccess property with $ symbol
    @Published var flashdecks = DbConfig(flashdecks: [])
    
    init(){
        loadDecks()
    }
    
    func loadDecks(){
        // if let -> used to check if the let exists so you can run the code inside the braces {}
        if let dbLocation = Bundle.main.url(forResource: "db", withExtension: "json"){
            // do catch -> check if something goes wrong to handle errors
            do {
                // we use do catch because Data() can return an error and we need to handle it
                // Data() is used to read an URL location (our db file in that case)
                let data = try Data(contentsOf: dbLocation)
                // we need a decoder to decode our json file (we use .self because we want to decode an array but not create a new one
                let decodedData = try JSONDecoder().decode(DbConfig.self, from: data)
                
                // after we load our data we set our flashdecks var to them
                flashdecks.self = decodedData
            } catch  {
                print(error)
            }
        }
        
    }
    
    func createDeck(name: String) -> Bool{
        let deckId = Int(NSDate().timeIntervalSince1970)
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let newDeck = Flashdecks(id: String(deckId), name: name, flashcards: [])
        
        do {
            let jsonData = try JSONEncoder().encode(newDeck)
            
            if let url = urls.first {
                var fileURL = url.appendingPathComponent(String(deckId))
                fileURL = fileURL.appendingPathExtension("json")
                let jsonString = String(data: jsonData, encoding: .utf8)!
                
                try jsonString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                
                print(jsonString)
                //try data.write(to: fileURL, options: [.atomicWrite])
                return true
            }
            return false
            
        } catch {
            print (error)
            return false
        }
    }
    
}
