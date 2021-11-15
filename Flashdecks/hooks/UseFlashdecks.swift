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
    @Published var db = DbConfig(flashdecks: [])
    @Published var dbLocation: URL? = nil
    @Published var deckList: [Flashdeck] = []
    
    init(){
        loadDecks()
    }
    
    func loadDecks(){
        // if let -> used to check if the let exists so you can run the code inside the braces {}
        if let dbInitLocation = Bundle.main.url(forResource: "db", withExtension: "json"){
            // do catch -> check if something goes wrong to handle errors
            do {
                // we use do catch because Data() can return an error and we need to handle it
                // Data() is used to read an URL location (our db file in that case)
                let data = try Data(contentsOf: dbInitLocation)
                // we need a decoder to decode our json file (we use .self because we want to decode an array but not create a new one
                let decodedData = try JSONDecoder().decode(DbConfig.self, from: data)
                
                // after we load our data we set our flashdecks var to them
                db.self = decodedData
                dbLocation.self = dbInitLocation
                
                
                
            } catch  {
                print(error)
            }
        }
        
    }
    
    func createDeck(name: String, description: String) -> Bool {
        let deckId = Int(NSDate().timeIntervalSince1970)
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let newDeck = Flashdeck(id: String(deckId), description: description, name: name, flashcards: [])
        
        do {
            let jsonData = try JSONEncoder().encode(newDeck)
            
            if let url = urls.first {
                var fileURL = url.appendingPathComponent(String(deckId))
                fileURL = fileURL.appendingPathExtension("json")
                let jsonString = String(data: jsonData, encoding: .utf8)!
                
                try jsonString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                
                db.flashdecks.append(String(deckId))
                
                let jsonDb = try JSONEncoder().encode(db)
                try jsonDb.write(to: dbLocation!)
                
                return true
            }
            return false
            
        } catch {
            print("Error createDeck: \(error)")
            return false
        }
    }
    
    func deleteDeck(deckId: String) -> Bool {
        do {
            
            let url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            
            try FileManager.default.removeItem(at: URL(string: "\(url.absoluteString)\(deckId).json")!)
            
            if let idIndex = db.flashdecks.firstIndex(of: deckId){
                db.flashdecks.remove(at: idIndex)
                print("trovato ed eliminato")
            }
            
            return true
        } catch  {
            print("Error deleteDeck: \(error)")
            return false
        }

    }
    
    func createFlashcard(newFlashcard: Flashcard, deckId: String) -> Bool {
        var flashdecks = db.flashdecks
        
        if flashdecks.contains(deckId){
            
        }
        
        return false
    }
    
}
