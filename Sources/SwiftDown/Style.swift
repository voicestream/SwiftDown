//
//  Style.swift
//
//
//  Created by Quentin Eude on 10/03/2021.
//

import Foundation

public struct Style {
  public var attributes: [NSAttributedString.Key: Any] = [:]

  public init(attributes: [NSAttributedString.Key: Any]) {
    self.attributes = attributes
  }

  public init() {}
}
