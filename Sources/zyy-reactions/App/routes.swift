//
//  routes.swift
//
//
//  Created by Fang Ling on 2024/1/21.
//

import Vapor

func routes(_ app : Application) throws {
  try app.register(collection: AddController())
  try app.register(collection: GetController())
  
  try app.register(collection: AuthenticationController())
}
