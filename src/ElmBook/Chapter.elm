module ElmBook.Chapter exposing
    ( Chapter
    , chapter
    , render
    , renderComponent
    , renderComponentList
    , renderWithComponents
    , withComponent
    , withComponentList
    , withComponentOptions
    , withStatefulComponent
    , withStatefulComponentList
    )

import ElmBook.Internal.Chapter exposing (ChapterBuilder(..), ChapterComponent, ChapterComponentView(..), ChapterCustom(..))
import ElmBook.Internal.Component
import ElmBook.Internal.Helpers exposing (applyAttributes, toSlug)
import ElmBook.Internal.Msg exposing (Msg)
import Html exposing (Html)


{-| -}
type alias Chapter state =
    ElmBook.Internal.Chapter.ChapterCustom state (Html (Msg state))


{-| Creates a chapter with some title.
-}
chapter : String -> ChapterBuilder state html
chapter title =
    ChapterBuilder
        { title = title
        , groupTitle = Nothing
        , url = "/" ++ toSlug title
        , body = "# " ++ title ++ "\n"
        , componentOptions = ElmBook.Internal.Component.defaultOverrides
        , componentList = []
        }


withComponentOptions :
    List ElmBook.Internal.Component.Attribute
    -> ChapterBuilder state html
    -> ChapterBuilder state html
withComponentOptions attributes (ChapterBuilder config) =
    ChapterBuilder
        { config
            | componentOptions =
                applyAttributes attributes config.componentOptions
        }


{-| Used for chapters with a single component.

    inputChapter : Chapter x
    inputChapter =
        chapter "Input"
            |> withComponent (input [] [])

-}
withComponent : html -> ChapterBuilder state html -> ChapterBuilder state html
withComponent html (ChapterBuilder builder) =
    ChapterBuilder
        { builder
            | componentList = fromTuple ( "", html ) :: builder.componentList
        }


{-| Used for chapters with multiple components.

    buttonsChapter : Chapter x
    buttonsChapter =
        chapter "Buttons"
            |> withComponents
                [ ( "Default", button [] [] )
                , ( "Disabled", button [ disabled True ] [] )
                ]

-}
withComponentList : List ( String, html ) -> ChapterBuilder state html -> ChapterBuilder state html
withComponentList componentList (ChapterBuilder builder) =
    ChapterBuilder
        { builder
            | componentList =
                List.map fromTuple componentList ++ builder.componentList
        }


{-| Used for chapters with a single stateful component.
-}
withStatefulComponent : (state -> html) -> ChapterBuilder state html -> ChapterBuilder state html
withStatefulComponent view_ (ChapterBuilder builder) =
    ChapterBuilder
        { builder
            | componentList =
                { label = ""
                , view = ChapterComponentViewStateful view_
                }
                    :: builder.componentList
        }


{-| Used for chapters with multiple stateful components.
-}
withStatefulComponentList : List ( String, state -> html ) -> ChapterBuilder state html -> ChapterBuilder state html
withStatefulComponentList componentList (ChapterBuilder builder) =
    ChapterBuilder
        { builder
            | componentList =
                List.map fromTupleStateful componentList ++ builder.componentList
        }


{-| Used when you want to create a rich chapter with markdown and embedded components.

    buttonsChapter : Chapter x
    buttonsChapter =
        chapter "Buttons"
            |> withComponents
                [ ( "Default", button [] [] )
                , ( "Disabled", button [ disabled True ] [] )
                ]
            |> render """
        # Buttons

        A button can be both active

        <component with-label="Default" />

        or inactive:

        <component with-label="Disabled" />

    """

-}
render : String -> ChapterBuilder state html -> ChapterCustom state html
render body (ChapterBuilder builder) =
    Chapter
        { builder | body = builder.body ++ body }


{-| Used when you just want to render the list of components with no additional information.

    buttonsChapter : Chapter x
    buttonsChapter =
        chapter "Buttons"
            |> withComponents
                [ ( "Default", button [] [] )
                , ( "Disabled", button [ disabled True ] [] )
                ]
            |> renderComponents

-}
renderComponent : html -> ChapterBuilder state html -> ChapterCustom state html
renderComponent component (ChapterBuilder builder) =
    Chapter
        { builder
            | body = builder.body ++ "<component-list />"
            , componentList = fromTuple ( "", component ) :: builder.componentList
        }


{-| Used when you just want to render the list of components with no additional information.

    buttonsChapter : Chapter x
    buttonsChapter =
        chapter "Buttons"
            |> withComponents
                [ ( "Default", button [] [] )
                , ( "Disabled", button [ disabled True ] [] )
                ]
            |> renderComponents

-}
renderComponentList : List ( String, html ) -> ChapterBuilder state html -> ChapterCustom state html
renderComponentList componentList (ChapterBuilder builder) =
    Chapter
        { builder
            | body = builder.body ++ "<component-list />"
            , componentList =
                List.map fromTuple componentList ++ builder.componentList
        }


{-| Used on chapters where all of the text content sits on top and all components at the bottom.
-}
renderWithComponents : String -> ChapterBuilder state html -> ChapterCustom state html
renderWithComponents body (ChapterBuilder builder) =
    Chapter
        { builder | body = builder.body ++ body ++ "\n<component-list />" }



-- Helpers


fromTupleStateful : ( String, state -> html ) -> ChapterComponent state html
fromTupleStateful ( label, view_ ) =
    { label = label, view = ChapterComponentViewStateful view_ }


fromTuple : ( String, html ) -> ChapterComponent state html
fromTuple ( label, view_ ) =
    { label = label, view = ChapterComponentViewStateless view_ }
