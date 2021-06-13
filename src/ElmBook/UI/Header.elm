module ElmBook.UI.Header exposing
    ( styles
    , view
    )

import ElmBook.UI.Helpers exposing (..)
import ElmBook.UI.Icons exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


styles : Html msg
styles =
    css_ """
.elm-book-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.elm-book-header--link {
    display: block;
    padding: 8px 12px;
    text-decoration: none;
}
.elm-book-header--link:hover {
    opacity: 0.9;
}
.elm-book-header--link:active {
    opacity: 0.8;
}

.elm-book-header--button {
    display: none;
    padding: 12px;
    border-radius: 4px;
    box-shadow: none;
    background-color: transparent;
    cursor: pointer;
}
.elm-book-header--button:hover {
    opacity: 0.9;
    background-color: rgba(255, 255, 255, 0.1);
}
.elm-book-header--button:active {
    opacity: 0.4;
}
@media screen and (max-width: 768px) {
    display: flex;
    align-items: center;
}

.elm-book-header-default {
    display: flex;
    align-items: center;
}

.elm-book-header-default--wrapper {
    display: block;
    padding-left: 16px;
    font-weight: 600;
    font-size: 16px;
}

.elm-book-header-default--title {
    display: block;
    padding-right: 4px;
}

.elm-book-header-default--subtitle {
    display: block;
    font-weight: 400;
}
"""


view :
    { href : String
    , logo : Maybe (Html msg)
    , title : String
    , subtitle : String
    , custom : Maybe (Html msg)
    , isMenuOpen : Bool
    , onClickMenuButton : msg
    }
    -> Html msg
view props =
    header [ class "elm-book-header" ]
        [ a
            [ href props.href
            , class "elm-book-header--link"
            , style "color" themeAccentAlt
            ]
            [ h1 [ class "elm-book" ]
                [ props.custom
                    |> Maybe.withDefault
                        (viewDefault
                            { href = props.href
                            , logo = props.logo
                            , title = props.title
                            , subtitle = props.subtitle
                            }
                        )
                ]
            ]
        , button
            [ class "elm-book elm-book-header--button"
            , onClick props.onClickMenuButton
            ]
            [ if props.isMenuOpen then
                iconClose { size = 20, color = "#fff" }

              else
                iconMenu { size = 20, color = "#fff" }
            ]
        ]


viewDefault :
    { href : String
    , logo : Maybe (Html msg)
    , title : String
    , subtitle : String
    }
    -> Html msg
viewDefault props =
    span
        [ class "elm-book-sans elm-book-header-default" ]
        [ props.logo
            |> Maybe.withDefault
                (iconElm
                    { size = 28
                    , color = themeAccentAlt
                    }
                )
        , span [ class "elm-book-header-default--wrapper" ]
            [ span
                [ class "elm-book-header-default--title" ]
                [ text props.title ]
            , span
                [ class "elm-book-header-default--subtitle" ]
                [ text props.subtitle ]
            ]
        ]