//
//  routes.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor

func routes(_ app : Application) throws {
  try app.register(collection: ReactionController())
  
  try app.register(collection: AuthenticationController())
  
  try app.register(collection: PageController())
  
  try app.register(collection: DashboardController())
}
