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
    
    internal func addRecord(record: Forecast) {
        do {
            try localRealm.write {
                localRealm.add(record)
            }
        } catch let error {
            print(error)
        }
        
    }

    internal func fetch() -> Results<Forecast> {
        return localRealm.objects(Forecast.self).sorted(byKeyPath: "dt_txt", ascending: true)
    }
    
    internal func fetchFilterDate(date: Date) -> Results<Forecast> {
        return localRealm.objects(Forecast.self).filter("dt_txt == %@", date).sorted(byKeyPath: "dt_txt", ascending: true)
    }
    
    internal func deleteById(id: ObjectId) {

        let task = localRealm.object(ofType: Forecast.self, forPrimaryKey: id)
        do {
            try localRealm.write {
                localRealm.delete(task!)
            }
        } catch let error {
            print(error)
        }
    }
    
    
    internal func deleteAll() {
        try! localRealm.write {
            localRealm.deleteAll()
        }
    }
    
}
