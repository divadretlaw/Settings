# Settings

Provides a simple generic settings controller with some default app setting sections.

Usage

```swift
SettingsView(showSettings: $showSettings, content: {
    // Add Sections / Rows here e.g.
    Settings.AppearanceView()
    Settings.SupportView()
    Settings.ResetView()
})
```

## Provided Settings

### Appearance

Easily switch the app between light and dark mode.

Usage: Add the view to the `SettingsView.content`

```swift
Settings.AppearanceView()
```

### Passcode

Protect your app with a passcode. Supports biometrics.

Usage: Add the view to the `SettingsView.content`

```swift
Settings.PasscodeView()
```

### Support

Let users send a support mail via `MFMailComposeViewController`

Usage: Add the view to the `SettingsView.content`

```swift
Settings.SupportView()
```

### Info

Display info from the Info.plist file.

Usage: Add the view to the `SettingsView.content`

```swift
Settings.InfoView()
```

### Device

Display some device informations.

Usage: Add the view to the `SettingsView.content`

```swift
Settings.DeviceView()
```

### Reset

Delete all user defaults to reset the app. Implement the callback for custom reset actions.

Usage: Add the view to the `SettingsView.content`

```swift
Settings.ResetView {
    // Custom app reset logic
}
```

## License

See [LICENSE](LICENSE)

Copyright © 2020 David Walter \(www.davidwalter.at)
