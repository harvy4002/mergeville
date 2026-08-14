# Device Viewports & Frames

Use these dimensions for pixel-perfect mobile mockups.

## iOS (Apple)
| Device | Viewport (px) | Notes |
| :--- | :--- | :--- |
| iPhone 15 Pro | 390 x 844 | Dynamic Island at top. |
| iPhone 14 / 13 | 390 x 844 | Notch at top. |
| iPad Pro (11") | 834 x 1194 | Side-by-side apps support. |

## Android
| Device | Viewport (px) | Notes |
| :--- | :--- | :--- |
| Google Pixel 7 | 412 x 915 | Centered hole-punch camera. |
| Samsung Galaxy S23| 360 x 800 | |

## Desktop Breakpoints
| Label | Width (px) | Typical Use |
| :--- | :--- | :--- |
| Small Desktop | 1024 | Laptops (13") |
| Large Desktop | 1440+ | Monitors |

## Best Practices for Mobile Frames
- **Bezels**: Add a subtle `border: 8px solid #1c1c1e` and `border-radius: 40px` to a container to mimic a device.
- **Safe Areas**: Leave ~44px at the top (Status Bar) and ~34px at the bottom (Home Indicator) for mobile hardware UI.
