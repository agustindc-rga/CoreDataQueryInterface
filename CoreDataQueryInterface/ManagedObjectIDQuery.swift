//
//  ManagedObjectIDQuery.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 4/11/15.
//  Copyright (c) 2015 Prosumma LLC. All rights reserved.
//

import CoreData

public struct ManagedObjectIDQuery<E: ManagedObjectType>: QueryType {
    internal var builder = QueryBuilder<E>()
    
    // MARK: Query Interface (Chainable Methods)
    
    public static func from(E.Type) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>()
    }
    
    public func context(managedObjectContext: NSManagedObjectContext) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.context(managedObjectContext))
    }
    
    public func filter(predicate: NSPredicate) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.filter(predicate))
    }
        
    public func filter(format: String, argumentArray: [AnyObject]?) -> ManagedObjectIDQuery<E> {
        return filter(NSPredicate(format: format, argumentArray: argumentArray))
    }
    
    public func filter(format: String, _ args: CVarArgType...) -> ManagedObjectIDQuery<E> {
        return withVaList(args) { self.filter(NSPredicate(format: format, arguments: $0)) }
    }
    
    public func filter(predicate: E.ManagedObjectAttributeType -> NSPredicate) -> ManagedObjectIDQuery<E> {
        return filter(predicate(E.ManagedObjectAttributeType(nil, parent: nil)))
    }
    
    public func limit(limit: UInt) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.limit(limit))
    }
    
    public func offset(offset: UInt) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.offset(offset))
    }
    
    public func order(descriptors: [NSSortDescriptor]) -> ManagedObjectIDQuery<E> {
        return ManagedObjectIDQuery<E>(builder: builder.order(descriptors))
    }
    
    public func order(descriptors: NSSortDescriptor...) -> ManagedObjectIDQuery<E> {
        return order(descriptors)
    }
    
    public func order(descriptors: String...) -> ManagedObjectIDQuery<E> {
        return order(descriptors.map() { NSSortDescriptor(key: $0, ascending: true) })
    }
    
    public func order(descending descriptors: String...) -> ManagedObjectIDQuery<E> {
        return order(descriptors.map() { NSSortDescriptor(key: $0, ascending: false) })
    }
    
    public func order(attributes: [AttributeType]) -> ManagedObjectIDQuery<E> {
        return order(attributes.map() { NSSortDescriptor(key: $0.description, ascending: true) })
    }
    
    public func order(attributes: AttributeType...) -> ManagedObjectIDQuery<E> {
        return order(attributes)
    }
    
    public func order(descending attributes: [AttributeType]) -> ManagedObjectIDQuery<E> {
        return order(attributes.map() { NSSortDescriptor(key: $0.description, ascending: false) })
    }
    
    public func order(descending attributes: AttributeType...) -> ManagedObjectIDQuery<E> {
        return order(descending: attributes)
    }
    
    public func order(attributes: [E.ManagedObjectAttributeType -> AttributeType]) -> ManagedObjectIDQuery<E> {
        let a = E.ManagedObjectAttributeType(nil, parent: nil)
        return order(attributes.map() { $0(a) })
    }
    
    public func order(attributes: (E.ManagedObjectAttributeType -> AttributeType)...) -> ManagedObjectIDQuery<E> {
        return order(attributes)
    }
    
    public func order(descending attributes: [E.ManagedObjectAttributeType -> AttributeType]) -> ManagedObjectIDQuery<E> {
        let a = E.ManagedObjectAttributeType(nil, parent: nil)
        return order(descending: attributes.map{ $0(a) })
    }
    
    public func order(descending attributes: (E.ManagedObjectAttributeType -> AttributeType)...) -> ManagedObjectIDQuery<E> {
        return order(descending: attributes)
    }
    
    public func order(attributes: E.ManagedObjectAttributeType -> [AttributeType]) -> ManagedObjectIDQuery<E> {
        return order(attributes(E.ManagedObjectAttributeType(nil, parent: nil)))
    }
    
    public func order(descending attributes: E.ManagedObjectAttributeType -> [AttributeType]) -> ManagedObjectIDQuery<E> {
        return order(descending: attributes(E.ManagedObjectAttributeType(nil, parent: nil)))
    }
    
    // MARK: Query Execution
    
    public func all(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> [NSManagedObjectID]? {
        return (managedObjectContext ?? self.builder.managedObjectContext)!.executeFetchRequest(builder.request(.ManagedObjectIDResultType), error: error) as! [NSManagedObjectID]?
    }
    
    public func first(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> NSManagedObjectID? {
        return limit(1).all(managedObjectContext: managedObjectContext, error: error)?.first
    }
    
    public func count(managedObjectContext: NSManagedObjectContext? = nil, error: NSErrorPointer = nil) -> UInt? {
        let recordCount = (managedObjectContext ?? self.builder.managedObjectContext)!.countForFetchRequest(builder.request(), error: error)
        return recordCount == NSNotFound ? nil : UInt(recordCount)
    }
    
    // MARK: SequenceType
    
    public func generate() -> GeneratorOf<NSManagedObjectID> {
        if let objects = all() {
            return GeneratorOf(objects.generate())
        } else {
            return GeneratorOf() { nil }
        }
    }
    
    // MARK: NSFetchRequest
    
    public func request() -> NSFetchRequest {
        return self.builder.request(.ManagedObjectIDResultType)
    }
}
