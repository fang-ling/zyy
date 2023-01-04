//
//  tree.swift
//  
//
//  Created by Fang Ling on 2022/11/7.
//

class TreeNode {
//    var p : TreeNode?
    var child : [TreeNode?]
    /* Actual payload, html tag */
    var begin : String
    var end : String
    
    init() {
//        p = nil
        child = [TreeNode?]()
        begin = ""
        end = ""
    }
    
    init(begin : String, end : String) {
//        self.p = p
        self.child = [TreeNode?]()
        self.begin = begin
        self.end = end
    }
}

/* Each node can have arbitrary number of children */
class Tree {
    var `nil` : TreeNode /* Sentinel */
    var root : TreeNode
    
    /* Create a empty html tree */
    init() {
        `nil` = TreeNode()
        root = `nil`
    }
    
    /* Insert a node to a subtree */
    static func subtree_insert(_ subtree : TreeNode,
                               begin : String,
                               end : String) {
        subtree.child.append(TreeNode(begin: begin, end: end))
    }
}
