//
//  PropertyType.swift
//  CoreDataQueryInterface
//
//  Created by Gregory Higley on 6/14/15.
//  Copyright © 2015 Prosumma LLC. All rights reserved.
//

import CoreData
import Foundation

public protocol ExpressionType {
    func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription
    func toExpression(entityDescription: NSEntityDescription) -> NSExpression
}

extension NSPropertyDescription : ExpressionType {
    public func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription {
        return self
    }
    public func toExpression(entityDescription: NSEntityDescription) -> NSExpression {
        if let expressionDescription = self as? NSExpressionDescription {
            return expressionDescription.expression!
        } else {
            return NSExpression(forKeyPath: name)
        }
    }
}

extension NSExpression : ExpressionType {
    public func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.expression = self
        if let keyPath = ExpressionHelper.keyPathForExpression(self) {
            expressionDescription.name = ExpressionHelper.nameForKeyPath(keyPath)
            expressionDescription.expressionResultType = ExpressionHelper.attributeTypeForKeyPath(keyPath, inEntity: entityDescription)
        } else {
            expressionDescription.name = "expression"
        }
        return expressionDescription
    }
    
    public func toExpression(_: NSEntityDescription) -> NSExpression {
        return self
    }
}

extension String : ExpressionType {
    public func toPropertyDescription(entityDescription: NSEntityDescription) -> NSPropertyDescription {
        let expressionDescription = NSExpressionDescription()
        expressionDescription.name = ExpressionHelper.nameForKeyPath(self)
        expressionDescription.expression = toExpression(entityDescription)
        expressionDescription.expressionResultType = ExpressionHelper.attributeTypeForKeyPath(self, inEntity: entityDescription)
        return expressionDescription
    }
    public func toExpression(_: NSEntityDescription) -> NSExpression {
        return NSExpression(forKeyPath: self)
    }
}