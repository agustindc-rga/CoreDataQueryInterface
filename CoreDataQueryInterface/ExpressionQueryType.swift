//
//  ExpressionQueryType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public protocol ExpressionQueryType {
    typealias ExpressionQueryType
    
    func select(attributes: [AnyObject]) -> ExpressionQueryType
    func groupBy(attributes: [AnyObject]) -> ExpressionQueryType
}