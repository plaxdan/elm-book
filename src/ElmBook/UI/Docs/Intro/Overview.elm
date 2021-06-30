module ElmBook.UI.Docs.Intro.Overview exposing (..)

import ElmBook.Chapter exposing (Chapter, chapter, render)
import Html exposing (..)
import Html.Attributes exposing (..)


docs : Chapter x
docs =
    chapter "Overview"
        |> render """
Every application, tool or team has their own history worth telling.

ElmBook tries to help them by making it easy to create rich documents that showcase their **libraries documentations**, **UI components**, **design tokens**, or anything else really.

---

## It all starts with a chapter

They can be as simple as a markdown block or as rich as a set of interactive UI components that talk to each other. Take a look at the ["Creating Chapters"](/guides/chapters) guide for more details.

```elm
module FirstChapter exposing (firstChapter)


import ElmBook.Chapter exposing (chapter)
import Html exposing (..)


firstChapter : ElmBook.Chapter x
firstChapter =
    chapter "The First Chapter"
        |> withComponent component
        |> render content


component : Html msg
component =
    button [] [ text "Click me!" ]


content : String
content = \"\"\"
# It all starts with a chapter

Oh, look – A wide real component!

<component />

Woof! Moving on...
\"\"\"
```

---

## Together, they become a book

A book can hold a number of chapters and there are many ways to customize it from chapter grouping to custom themes. Take a look at the ["Creating Books"](/guides/books) and ["Theming"](/guides/theming) guides for more details.


```elm
module Book exposing (main)


import ElmBook exposing (book, withChapters)
import FirstChapter exposing (firstChapter)


main : ElmBook.Book ()
main =
    book "Book"
        |> withChapters
            [ firstChapter
            ]

```

---

## Inspiration

This library takes a lot of inspiration from two libraries:

- [Storybook](http://storybook.js.org) – a JS ecosystem tool that focus on showcasing components and their states, mostly aiming at internal design systems but also enabling the pattern of creating visual components in isolation.

- [HexDocs](http://hexdocs.pm) – an Erlang/Elixir ecosystem tool that enables structured library documentation with guides, function docs, links to code and external sources.

Both of these tools affected their whole ecosystems greatly. Creating good docs is a common place when you're in Elixir world. Using Storybook to facilitate design-engineering iteration is a common place in the JS world.

What if the Elm ecosystem can create it's own thing with the best of both worlds? ElmBook aims to be just that – making it easy to create attractive documentation websites that can also work as a playground for live components built with Elm.

---

## Roadmap

This tool can already be used as-is for great effect.
Can we add plugins? Sure. Darkmode? Definitely.

The most interesting thing that is currently sitting on the back of my head though is automatically creating ElmBooks based on doc comments, the same that are used to generate docs on elm-packages.

This would enable any/all published elm packages to automatically have their own ElmBook with example codes turning into live components. This is both more simple that it sounds and more complex than it could be. I don't expect it to happen in the next few weeks but it's definitely possible.

---

I really hope we can create something unique to the Elm ecosystem here, so please let me know what you think, ideas to improve it or if you encountered any problems. Find me as **georgesboris** on Elm Slack.

"""
