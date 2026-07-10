# meetup_app

## Design & Wireframing
Designs are subject to change during the phases of design and implementation.
Preview: https://www.figma.com/design/xKYdlKL3pxpe3ZyksckuR8/Color-wheel-palette-generator--Community-?node-id=0-1&t=at2iEqBdTpU1bBR6-1
### Tools
Wireframes and UI mockups were designed in **Figma**, using **Figma Make** to rapidly prototype the onboarding flow before implementation in Flutter.

### Color Palette
The app's visual identity is built around two primary accent tones, each with a full tonal ramp for backgrounds, surfaces, and text states:

| Role | Hex | Swatch |
|---|---|---|
| Primary accent (teal) | `#4894B1` | Interactive elements, dark mode buttons |
| Primary accent (indigo) | `#0E31AA` | Interactive elements, light mode buttons |

**Teal ramp:** `#B0DFF6` · `#5DBCE0` · `#4894B1` · `#346E84` · `#214A5A` · `#0F2932` · `#051319`

**Indigo ramp:** `#EFF0FE` · `#CCD0FD` · `#9CA5FC` · `#697AFA` · `#1E4DF7` · `#0E31AA` · `#041862`

**Neutral ramp:** `#D6D8DA` · `#ADB1B3` · `#888B8D` · `#656768` · `#434546` · `#242526` · `#101111`

Both a dark mode and light mode theme are supported, drawing from the same palette (teal-forward accents in dark mode, indigo-forward accents in light mode).

### Onboarding Flow Wireframes
The onboarding flow was wireframed as 10 screens (5 dark mode, 5 light mode), designed for iPhone 17:

1. **Welcome** — Map-themed hero image, app tagline ("Meet people near you"), social proof (2.4M+ users)
2. **Sign Up** — Create account via Google OAuth or email/password (full name, email, password, confirm password)
3. **Log In** — Returning user login via Google OAuth or email/password, with forgot password link
4. **Profile Setup** — Username selection step (step 2 of 3), with explanation of visibility to other users
5. **Success** — Welcome confirmation screen with account stats (members, topics, rating) and CTA to start exploring

