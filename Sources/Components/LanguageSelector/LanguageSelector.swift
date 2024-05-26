//
//  File.swift
//  
//
//  Created by Igor Ferreira on 26/05/2024.
//

import Foundation
import Ignite

struct LanguageSelector: NavigationItem {
    var columnWidth = ColumnWidth.automatic
    var attributes: CoreAttributes
    /// The array of items to shown in this `Dropdown`.
    var items: [LanguageElement]
    
    init(
        attributes: CoreAttributes,
        @ElementBuilder<LanguageElement> items: () -> [LanguageElement]
    ) {
        self.attributes = attributes
        self.items = items()
    }
    
    func render(context: PublishingContext) -> String {
        Group(isTransparent: true) {
            if let activeItem = items.first(where: { $0.isActive }) {
                Button(activeItem)
                    .class("dropdown-toggle")
                    .data("bs-toggle", "dropdown")
                    .aria("expanded", "false")
            }
            List {
                for item in items {
                    item
                        .class("dropdown-item")
                        .class(item.isActive ? "active" : nil)
                        .aria("current", item.isActive ? "page" : nil)
                        .style("min-width: 1rem", "margin: 1rem")
                }
            }
            .listStyle(.unordered(.default))
            .class("dropdown-menu")
            .style("min-width: 1rem", "padding: .5rem")
        }
        .attributes(attributes)
        .class("dropdown")
        .render(context: context)
    }
}
