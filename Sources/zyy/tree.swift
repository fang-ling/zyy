//
//  tree.swift
//  
//
//  Created by Fang Ling on 2022/11/7.
//

class TreeNode {
    var child : [TreeNode]
    /* Actual payload, html tag */
    var begin : String
    var end : String
    
    init() {
        child = [TreeNode]()
        begin = ""
        end = ""
    }
    
    init(begin : String, end : String) {
        self.child = [TreeNode]()
        self.begin = begin
        self.end = end
    }
    
    init(begin : String, content : String, end : String) {
        self.child = [TreeNode]()
        self.child.append(TreeNode(begin: content, end: ""))
        self.begin = begin
        self.end = end
    }
    
    public static func inorder_tree_traversal(_ node : TreeNode) {
        print(node.begin)
        for i in node.child {
            inorder_tree_traversal(i)
        }
        print(node.end)
    }
}



/* Each node can have arbitrary number of children */
//class Tree {
//    var `nil` : TreeNode /* Sentinel */
//    var root : TreeNode
//
//    /* Create a empty html tree */
//    init() {
//        `nil` = TreeNode()
//        root = `nil`
//    }
//
//    /* Insert a node to a subtree */
//    static func subtree_insert(_ subtree : TreeNode,
//                               node : TreeNode) {
//        subtree.child.append(node)
//    }
//}
