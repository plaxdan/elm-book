module ElmBook.ThemeOptions exposing
    ( subtitle, logo, header
    , background, backgroundGradient, accent, navBackground, navAccent, navAccentHighlight
    , globals
    , ThemeOption
    )

{-| Use the attributes provided by this module to customize your book through `ElmBook.withThemeOptions`.

Take a look at the ["Theming"](https://elm-book-in-elm-book.netlify.app/guides/theming) guide for some examples.


# Header

@docs subtitle, logo, header


# Color palette

@docs background, backgroundGradient, accent, navBackground, navAccent, navAccentHighlight


# Global CSS

@docs globals


# Types

@docs ThemeOption

-}

import ElmBook.Internal.Theme exposing (ThemeOptions)
import Html exposing (Html)


{-| -}
type alias ThemeOption html =
    ThemeOptions html -> ThemeOptions html


{-| Provide a custom logo for your book.
-}
logo : Html Never -> ThemeOption html
logo logo_ theme =
    { theme | logo = Just logo_ }


{-| Define a custom subtitle for your book. This will appear below the title.
-}
subtitle : String -> ThemeOption html
subtitle subtitle_ theme =
    { theme | subtitle = Just subtitle_ }


{-| Provide a completely custom header to your book. This will replace the whole area where usually the logo, title and subtitle appears.
-}
header : Html Never -> ThemeOption html
header header_ theme =
    { theme | header = Just header_ }


{-| Customize the background color of your book. Any valid value for the `background` CSS property will work.
-}
background : String -> ThemeOption html
background background_ theme =
    { theme | background = background_ }


{-| Customize the background of your book using a gradient by providing the start and end color. This is just a helper since the same thing can be achieved by using the `background` attribute.
-}
backgroundGradient : String -> String -> ThemeOption html
backgroundGradient startColor endColor theme =
    { theme
        | background =
            "linear-gradient(150deg, "
                ++ startColor
                ++ " 0%, "
                ++ endColor
                ++ " 100%)"
    }


{-| Customize the accent color of your book. This will change the color for all elements that sit on top of your background.
-}
accent : String -> ThemeOption html
accent v theme =
    { theme | accent = v }


{-| Customize the nav background color of your book. This will affect both the background on hovered and active nav items as well as the background of the search field.
-}
navBackground : String -> ThemeOption html
navBackground v theme =
    { theme | navBackground = v }


{-| Customize the nav accent color of your book. This will affect the default text color for nav items.
-}
navAccent : String -> ThemeOption html
navAccent v theme =
    { theme | navAccent = v }


{-| Customize the nav accent highlight color of your book. This will affect the color of active nav items.
-}
navAccentHighlight : String -> ThemeOption html
navAccentHighlight v theme =
    { theme | navAccentHighlight = v }


{-| Add global elements to your book. This can be helpful for things like CSS resets.

For instance, if you're using elm-tailwind-modules, this would be really helpful:

    import Css.Global exposing (global)
    import Tailwind.Utilities exposing (globalStyles)

    book "MyApp"
        |> withStatefulOptions [
            globals [ global globalStyles ]
        ]

-}
globals : List html -> ThemeOption html
globals globals_ options =
    { options | globals = Just globals_ }