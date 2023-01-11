//
//  ForecastRepository.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/11.
//

import UIKit

import RealmSwift

protocol ForecastRepositoryType {
    func fetch() -> Results<Forecast>
    func deleteAll()
    func addRecord(record: Forecast)
}

final class ForecastRepository: ForecastRepositoryType {
    





    let localRealm = try! Realm()
    
    func addRecord(record: Forecast) {
        do {
            try localRealm.write {
                localRealm.add(record)
            }
        } catch let error {
            print(error)
        }
        
    }

    func fetch() -> Results<Forecast> {
        return localRealm.objects(Forecast.self).sorted(byKeyPath: "dt_txt", ascending: true)
    }
    
    func fetchFilterDateString(formatString: String) -> Results<Forecast> {
        return localRealm.objects(Forecast.self).filter("dateString CONTAINS[c] '\(formatString)'").sorted(byKeyPath: "date", ascending: true)
    }
    
    func deleteById(id: ObjectId) {

        let task = localRealm.object(ofType: Forecast.self, forPrimaryKey: id)
        do {
            try localRealm.write {
                localRealm.delete(task!)
            }
        } catch let error {
            print(error)
        }
    }
    
    
    func deleteAll() {
        try! localRealm.write {
            localRealm.deleteAll()
        }
    }
    
}
