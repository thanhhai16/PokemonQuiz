//
//  DataManager.swift
//  THPokemonQuiz
//
//  Created by Hai on 11/20/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    var pokemons :  [Pokemon]?
    
    let kDatabaseName = "pokemon"
    let kDataExtention = "db"
    
    func getDataBaseFolderPath() -> String {
        let documentPatch = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return documentPatch + "/" + kDatabaseName + "." + kDataExtention
    }
    
    func copyDataBaseIfNeed () {
        
        // 1. Get bundle Path
        let bundlePath = Bundle.main.path(forResource: kDatabaseName, ofType: kDataExtention)
        // 2. Get Document Path
        let documentPath = self.getDataBaseFolderPath()
        
        // 3. Check If Exist
        if !FileManager.default.fileExists(atPath: documentPath) {
            // 4. Copy
            do {
                try FileManager.default.copyItem(atPath: bundlePath!, toPath: documentPath)
            } catch  {
                print(error)
            }
        }
    }
    
    func selectPokemons() -> [Pokemon] {
        // 1. Open Database
        
        let database = FMDatabase(path: self.getDataBaseFolderPath())
        database?.open()
        
        // 2. Select query
        let select = "SELECT * FROM pokemon"
        
        // 3. Query
        do {
            let result = try database?.executeQuery(select, values: nil)
            self.pokemons = [Pokemon]()
            while (result?.next())! {
                let pokemon = Pokemon()
                pokemon.color = result?.string(forColumn: "color")
                pokemon.gen = Int((result?.int(forColumn: "gen"))!)
                pokemon.name = result?.string(forColumn: "name")
                pokemon.id = Int((result?.int(forColumn: "Id"))!)
                pokemon.images = result?.string(forColumn: "img")
                pokemon.tag = result?.string(forColumn: "tag")
                
                pokemons?.append(pokemon)
            }
                   } catch  {
            print(error)
        }
        return pokemons!
        
        // 4. Close
        database?.close()

    }
    func filterPokemon(gens : [Bool], pokemons: [Pokemon]) -> [Pokemon] {
        var done = [Pokemon]()
        var pokemonFiltered = pokemons
        for i in  0...5 {
            if gens[i] == false {
                pokemonFiltered = pokemonFiltered.filter { $0.gen != i + 1 }
            }
            }
        return pokemonFiltered
    }
    }


