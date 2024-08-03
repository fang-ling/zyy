//
//  HTML.swift
//
//
//  Created by Fang Ling on 2024/5/6.
//

import Foundation

protocol HTML {
  func render_as_HTML(into stream: inout HTMLOutputStream)
}

@resultBuilder
struct HTMLBuilder {
  /* Expression-statements in the DSL should always produce an HTML value. */
  typealias Expression = HTML

  /*
   * "Internally" to the DSL, we'll just build up flattened arrays of HTML
   * values, immediately flattening any optionality or nested array structure.
   */
  typealias Component = [HTML]

  /*
   * Given an expression result, "lift" it into a Component.
   *
   * If Component were "any Collection of HTML", we could have this return
   * CollectionOfOne to avoid an array allocation.
   */
  static func buildExpression(_ expression: Expression) -> Component {
    return [expression]
  }

  /*
   * Build a combined result from a list of partial results by concatenating.
   *
   * If Component were "any Collection of HTML", we could avoid some unnecessary
   * reallocation work here by just calling joined().
   */
  static func buildBlock(_ children: Component...) -> Component {
    return children.flatMap { $0 }
  }

  /*
   * We can provide this overload as a micro-optimization for the common case
   * where there's only one partial result in a block.  This shows the
   * flexibility of using an ad-hoc builder pattern.
   */
  static func buildBlock(_ component: Component) -> Component {
    return component
  }
  
  /* Handle optionality by turning nil into the empty list. */
  static func buildOptional(_ children: Component?) -> Component {
    return children ?? []
  }

  /* Handle optionally-executed blocks. */
  static func buildEither(first child: Component) -> Component {
    return child
  }
  
  /* Handle optionally-executed blocks. */
  static func buildEither(second child: Component) -> Component {
    return child
  }
}
