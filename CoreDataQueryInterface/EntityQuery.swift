//
//  EntityQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/12/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public struct EntityQuery<E: EntityType> : QueryType {
    typealias QueryResultType = E
    
    public let builder: QueryBuilder<E>
    public init(builder: QueryBuilder<E>) {
        self.builder = builder
    }
    
    public let resultType = NSFetchRequestResultType.ManagedObjectResultType
}