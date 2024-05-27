import Foundation
import Ignite

struct Robots: RobotsConfiguration {
    var disallowRules: [DisallowRule]

    init() {
        disallowRules = [
            DisallowRule(robot: .google),
            DisallowRule(robot: .bing),
            DisallowRule(robot: .chatGPT),
            DisallowRule(robot: .apple),
            DisallowRule(name: "*")
        ]
    }
}
