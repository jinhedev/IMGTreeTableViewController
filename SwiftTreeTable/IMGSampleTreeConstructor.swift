//
//  IMGSampleTreeConstructor.swift
//  SwiftTreeTable
//
//  Created by Geoff MacDonald on 3/26/15.
//  Copyright (c) 2015 Geoff MacDonald. All rights reserved.
//

import UIKit

class IMGCommentNode: IMGTreeNode, NSCopying {
    var comment: String?
    
    override var description : String {
        return "Node: \(comment)"
    }
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        var copy = super.copyWithZone(zone) as IMGCommentNode
        copy.comment = comment
        return copy
    }
}

class IMGCommentModel : NSObject {
    var replies: [IMGCommentModel]?
    var comment: String?
}

class IMGSampleTreeConstructor: NSObject, IMGTreeConstructorDelegate {
    
    func sampleCommentTree() -> IMGTree {
        var comments: [IMGCommentModel] = []
        
        for i in 0..<3 {
            let comment = IMGCommentModel()
            comment.comment = "Root: \(i)"
            comment.replies = sampleComments(0)
            comments.append(comment)
        }
        
        let tree = IMGTree.tree(fromRootArray: comments, withConstructerDelegate: self)
        return tree
    }
    
    func sampleComments(depth: Int) -> [IMGCommentModel]? {
        var comments: [IMGCommentModel] = []
        for i in 0..<3 {
            let comment = IMGCommentModel()
            comment.comment = "\(depth)     \(i+1)"
            if depth < 7 {
                comment.replies = sampleComments(depth+1)
            }
            comments.append(comment)
        }
        return comments
    }
    
    //MARK: IMGTreeConstructorDelegate
    
    func classForNode() -> IMGTreeNode.Type {
        return IMGCommentNode.self
    }
    
    func childrenForNodeObject(object: AnyObject) -> [AnyObject]? {
        let commentObject = object as IMGCommentModel
        return commentObject.replies
    }
    
    func configureNode(node: IMGTreeNode, modelObject: AnyObject) {
        let commentNode = node as IMGCommentNode
        let model = modelObject as IMGCommentModel
        commentNode.comment = model.comment
        
    }
    
    
   
}
