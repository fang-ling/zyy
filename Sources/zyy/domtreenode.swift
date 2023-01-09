//
//  domtreenode.swift
//  
//
//  Created by Fang Ling on 2022/11/7.
//

class DOMTreeNode {
    /* A void element is an element in HTML that cannot have any child nodes
     * (i.e., nested elements or text nodes). Void elements only have a start
     * tag; end tags must not be specified for void elements.
     *
     * See: https://developer.mozilla.org/en-US/docs/Glossary/Void_element
     * Notice that we consider doctype is a void element here.
     */
    private static let VOID_ELEMENTS : Set = ["area", "base", "br", "col",
                                              "embed", "hr", "img", "input",
                                              "link", "meta", "param", "wbr",
                                              "source", "track",
                                              "!doctype html"]
    
    var child : [DOMTreeNode]
    /* Actual payload:
     * Example:
     *       ↙----- attr       ↙---- text
     *  <a href="https://...">...</a>
     *    ↖--- name
     */
    var name : String
    var attr : [String : String]
    var text : String
    var isVoidElement : Bool
    
    init(name : String, attr : [String : String]) {
        child = [DOMTreeNode]()
        self.name = name
        self.attr = attr
        text = ""
        isVoidElement = DOMTreeNode.VOID_ELEMENTS.contains(name)
    }
    
    func add(_ node : DOMTreeNode) {
        child.append(node)
    }
    
    public static func inorder_tree_traversal(_ node : DOMTreeNode) {
        print(node.name, terminator: "")
        for i in node.child {
            inorder_tree_traversal(i)
        }
        print(node.name, terminator: "")
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
