//
//  FlashdecksApp.swift
//  Flashdecks
//
//  Created by Antonio on 12/11/21.
//

import SwiftUI

@main
struct FlashdecksApp: App {
    var body: some Scene {
        WindowGroup {
            Home().environment(\.colorScheme,.light)
                .environmentObject(UseFlashdecks())

        }
    }
}
