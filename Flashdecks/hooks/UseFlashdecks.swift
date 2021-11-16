//
//  useFlashdecks.swift
//  Flashdecks
//
//  Created by Antonio on 14/11/21.
//
//  How to read JSON files https://www.youtube.com/watch?v=9tkoD0fSxmU&t=871s

import Foundation

// public class to use all Flashdecks properties and functions
public class UseFlashdecks {
    
    // Published used to maccess property with $ symbol
    @Published var db = DbConfig(flashdecks: [])    // Object of our db
    @Published var dbLocation: URL? = nil           // Our url to db json file
    @Published var deckList: [Flashdeck] = []       // Object of flashdecks and cards, to use around the app
    @Published var decksCardsFolderUrl: URL? = nil  // Our url to all decks and cards folder
    
    init(){
        loadDecks()
    }
    
    func loadDecks(){
        // if let -> used to check if the let exists so you can run the code inside the braces {}
        if let dbInitLocation = Bundle.main.url(forResource: "db", withExtension: "json"){
            // do catch -> check if something goes wrong to handle errors
            do {
                // Init our flashdecks and cards folder url
                decksCardsFolderUrl = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                // we use do catch because Data() can return an error and we need to handle it
                // Data() is used to read an URL location (our db file in that case)
                let data = try Data(contentsOf: dbInitLocation)
                // we need a decoder to decode our json file (we use .self because we want to decode an array but not create a new one
                let decodedData = try JSONDecoder().decode(DbConfig.self, from: data)
                
                // after we load our data we set our flashdecks var to them
                db.self = decodedData
                dbLocation.self = dbInitLocation
                
                // Adding each flashdeck to our deckList object
                for deckId in db.flashdecks {
                    let flashDeckObject = try String(contentsOfFile: "\(decksCardsFolderUrl!.path)/\(deckId).json").data(using: .utf8)
                    let decodedFlashdeck = try JSONDecoder().decode(Flashdeck.self, from: flashDeckObject!)
                    
                    deckList.append(decodedFlashdeck)
                }
                                
            } catch  {
                print(error)
            }
        }
    }
    
    //*********************************************************************** DECKS HANDLERS
    
    enum action{
        case delete
        case update
    }
    
    func handleUpdDelDeck(newDeck: Flashdeck, action: action) -> Bool {
        do {
            for (index, deck) in deckList.enumerated(){
                if(deck.id == newDeck.id){
                    
                    // Delete action
                    if(action == .delete){
                        
                        deckList.remove(at: index)
                        try FileManager.default.removeItem(at: URL(string: "\(decksCardsFolderUrl!.absoluteString)\(deck.id).json")!)
                        
                        return true
                    }else{
                        // Update new deck
                        // Assign new deck to deck list object
                        deckList[index] = newDeck
                        
                        try FileManager.default.removeItem(at: URL(string: "\(decksCardsFolderUrl!.absoluteString)\(deck.id).json")!)
                        
                        // Encoding new deck to json
                        let jsonData = try JSONEncoder().encode(newDeck)
                        
                        // Creating file path and appending new name
                        var fileURL = decksCardsFolderUrl!.appendingPathComponent(String(newDeck.id))
                        fileURL = fileURL.appendingPathExtension("json")
                        let jsonString = String(data: jsonData, encoding: .utf8)!
                        
                        // Writing the data in folder
                        try jsonString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                        
                        return true
                    }
                }
            }
            return false
        } catch {
            print(error)
            return false
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
    
    func deleteDeck(deckToDelete: Flashdeck) -> Bool {
        return handleUpdDelDeck(newDeck: deckToDelete, action: .delete)
    }
    
    func getDeck(deckId: String) -> Flashdeck?{
        
        for deck in deckList {
            if(deckId == deck.id){
                return deck
            }
        }
        
        return nil
    }
        
    func updateDeck(newDeck: Flashdeck) -> Bool {
        return handleUpdDelDeck(newDeck: newDeck, action: .update)
    }
    
    //*********************************************************************** CARDS HANDLERS
    
    func createCard(newFlashcard: Flashcard, deckId: String) -> Bool {
        let flashdecks = db.flashdecks
        
        if flashdecks.contains(deckId){
            for var deck in deckList {
                if (deck.id == deckId) {
                    do {
                        // We are adding our card to the deck object
                        deck.flashcards.append(newFlashcard)
                        
                        // We remove the deck
                        try FileManager.default.removeItem(at: URL(string: "\(decksCardsFolderUrl!.absoluteString)\(deckId).json")!)
                        
                        // We write the new deck
                        let updatedDeck = try JSONEncoder().encode(deck)
                        try updatedDeck.write(to: decksCardsFolderUrl!)
                        
                        return true
                    } catch {
                        print(error)
                        return false
                    }
                }
            }
        }
        return false
    }
    
    func deleteCard(deckId: String, cardId: String) -> Bool {
        do {
            // We remove the card from the deck object
            for var deck in deckList {
                if(deck.id == deckId){
                    for (index, card) in deck.flashcards.enumerated(){
                        if(card.id == cardId){
                            deck.flashcards.remove(at: index)
                            
                            // We remove the deck
                            try FileManager.default.removeItem(at: URL(string: "\(decksCardsFolderUrl!.absoluteString)\(deckId).json")!)
                            
                            // We write the new deck
                            let updatedDeck = try JSONEncoder().encode(deck)
                            try updatedDeck.write(to: decksCardsFolderUrl!)
                            
                            return true
                        }
                    }
                }
            }
            return false
            
        } catch {
            print(error)
            return false
        }
    }
    
    func updateCard(deckId: String, newFlashCard: Flashcard) -> Bool{
        do {
            for var deck in deckList {
                if(deckId == deck.id){
                    for (index, card) in deck.flashcards.enumerated(){
                        if(card.id == newFlashCard.id){
                            deck.flashcards[index] = newFlashCard
                            
                            // We remove the deck
                            try FileManager.default.removeItem(at: URL(string: "\(decksCardsFolderUrl!.absoluteString)\(deckId).json")!)
                            
                            // We write the new deck
                            let updatedDeck = try JSONEncoder().encode(deck)
                            try updatedDeck.write(to: decksCardsFolderUrl!)
                            
                            return true
                        }
                    }
                }
            }
            return false
        } catch {
            print(error)
            return false
        }
    }
    
    func getCard(deckId: String, cardId: String) -> Flashcard?{
        
        for deck in deckList {
            if(deckId == deck.id){
                for card in deck.flashcards{
                    if(card.id == cardId){
                        return card
                    }
                }
            }
        }
        
        return nil
        
       
        
    }
    
}
