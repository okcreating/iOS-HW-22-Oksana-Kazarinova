//
//  ModuleBuilder.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit

protocol ModulesBuilder {
    func createMainModule() -> UIViewController
    func createDetailModule(model: User) -> UIViewController
}
