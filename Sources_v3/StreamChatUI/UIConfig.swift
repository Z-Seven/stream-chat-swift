//
// Copyright © 2020 Stream.io Inc. All rights reserved.
//

import Foundation
import StreamChat

public struct UIConfig<ExtraData: UIExtraDataTypes> {
    public var channelList: ChannelListUI

    public init(
        channelList: ChannelListUI = .init()
    ) {
        self.channelList = channelList
    }
}

// MARK: - UIConfig + Default

private var defaults: [String: Any] = [:]

public extension UIConfig {
    static var `default`: Self {
        get {
            let key = String(describing: ExtraData.self)
            if let existing = defaults[key] as? Self {
                return existing
            } else {
                let config = Self()
                defaults[key] = config
                return config
            }
        }
        set {
            let key = String(describing: ExtraData.self)
            defaults[key] = newValue
        }
    }
}

// MARK: - ChannelListUI

public extension UIConfig {
    struct ChannelListUI {
        public var avatarView: AvatarView.Type
        
        public init(
            avatarView: AvatarView.Type = AvatarView.self
        ) {
            self.avatarView = avatarView
        }
    }
}