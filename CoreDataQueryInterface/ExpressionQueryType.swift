//
//  ExpressionResultQueryType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public protocol ExpressionQueryType: QueryType {
    typealias ExpressionResultQueryType
    
    func select(expressions: [NSExpressionDescription]) -> ExpressionResultQueryType
    func select(expressions: NSExpressionDescription...) -> ExpressionResultQueryType
    func select(attributes: [String]) -> ExpressionResultQueryType
    func select(attributes: String...) -> ExpressionResultQueryType
    func select(attributes: [AttributeType]) -> ExpressionResultQueryType
    func select(attributes: AttributeType...) -> ExpressionResultQueryType
    func select(attributes: [EntityType.ManagedObjectAttributeType -> AttributeType]) -> ExpressionResultQueryType
    func select(attributes: (EntityType.ManagedObjectAttributeType -> AttributeType)...) -> ExpressionResultQueryType
    func select(attributes: EntityType.ManagedObjectAttributeType -> [AttributeType]) -> ExpressionResultQueryType
    func select(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionResultQueryType
    
    func function(function: String, attribute: String, name: String?) -> ExpressionResultQueryType
    func function(function: String, attribute: AttributeType, name: String?) -> ExpressionResultQueryType
    func function(function: String, name: String?, attribute: EntityType.ManagedObjectAttributeType -> AttributeType) -> ExpressionResultQueryType
    func function(function: String, expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionResultQueryType
    func average(attribute: String, name: String?) -> ExpressionResultQueryType
    func average(attribute: AttributeType, name: String?) -> ExpressionResultQueryType
    func average(#name: String?, _ attribute: EntityType.ManagedObjectAttributeType -> AttributeType) -> ExpressionResultQueryType
    func average(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionResultQueryType
    func sum(attribute: String, name: String?) -> ExpressionResultQueryType
    func sum(attribute: AttributeType, name: String?) -> ExpressionResultQueryType
    func sum(#name: String?, _ attribute: EntityType.ManagedObjectAttributeType -> AttributeType) -> ExpressionResultQueryType
    func sum(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionResultQueryType
    func min(attribute: String, name: String?) -> ExpressionResultQueryType
    func min(attribute: AttributeType, name: String?) -> ExpressionResultQueryType
    func min(#name: String?, _ attribute: EntityType.ManagedObjectAttributeType -> AttributeType) -> ExpressionResultQueryType
    func min(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionResultQueryType
    func max(attribute: String, name: String?) -> ExpressionResultQueryType    
    func max(attribute: AttributeType, name: String?) -> ExpressionResultQueryType
    func max(#name: String?, _ attribute: EntityType.ManagedObjectAttributeType -> AttributeType) -> ExpressionResultQueryType
    func max(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionResultQueryType
    func count(attribute: String, name: String?) -> ExpressionResultQueryType
    func count(attribute: AttributeType, name: String?) -> ExpressionResultQueryType
    func count(#name: String?, _ attribute: EntityType.ManagedObjectAttributeType -> AttributeType) -> ExpressionResultQueryType
    func count(expression: NSExpression, name: String, type: NSAttributeType) -> ExpressionResultQueryType
        
    func groupBy(expressions: [NSExpressionDescription]) -> ExpressionResultQueryType
    func groupBy(expressions: NSExpressionDescription...) -> ExpressionResultQueryType
    func groupBy(attributes: [String]) -> ExpressionResultQueryType
    func groupBy(attributes: String...) -> ExpressionResultQueryType
    func groupBy(attributes: [AttributeType]) -> ExpressionResultQueryType
    func groupBy(attributes: AttributeType...) -> ExpressionResultQueryType
    func groupBy(attributes: [EntityType.ManagedObjectAttributeType -> AttributeType]) -> ExpressionResultQueryType
    func groupBy(attributes: (EntityType.ManagedObjectAttributeType -> AttributeType)...) -> ExpressionResultQueryType
    func groupBy(attributes: EntityType.ManagedObjectAttributeType -> [AttributeType]) -> ExpressionResultQueryType
    
    func distinct() -> ExpressionResultQueryType
    
    func pluck<R>(attribute: String?, managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> [R]?
    func value<R>(attribute: String?, managedObjectContext: NSManagedObjectContext?, error: NSErrorPointer) -> R?
}

