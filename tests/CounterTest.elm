module CounterTest exposing (suite)

import Counter
import Expect
import Html.Attributes exposing (value)
import Set
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, containing, id, tag, text)


initialModel : Int
initialModel =
    0


sampleModel : Int
sampleModel =
    11


testView : Test
testView =
    describe "view"
        [ test "initail Model" <|
            \_ ->
                Counter.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ tag "div", tag "div" ]
                    |> Query.has [ text (String.fromInt initialModel) ]
        , test "sample Model" <|
            \_ ->
                Counter.view sampleModel
                    |> Query.fromHtml
                    |> Query.find [ tag "div", tag "div" ]
                    |> Query.has [ text (String.fromInt sampleModel) ]
        ]


testUpdate : Test
testUpdate =
    describe "update"
        [ test "increment form initail model" <|
            \_ ->
                Counter.update Counter.Increment initialModel
                    |> Tuple.first
                    |> Expect.equal (initialModel + 1)
        , test "increment from sample model" <|
            \_ ->
                Counter.update Counter.Increment sampleModel
                    |> Tuple.first
                    |> Expect.equal (sampleModel + 1)
        , test "decrement from initial model" <|
            \_ ->
                Counter.update Counter.Decrement initialModel
                    |> Tuple.first
                    |> Expect.equal (initialModel - 1)
        , test "decrement from sample model" <|
            \_ ->
                Counter.update Counter.Decrement sampleModel
                    |> Tuple.first
                    |> Expect.equal (sampleModel - 1)
        ]


testEvent : Test
testEvent =
    describe "event"
        [ test "increment" <|
            \_ ->
                Counter.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ tag "button", containing [ text "+" ] ]
                    |> Event.simulate Event.click
                    |> Event.expect Counter.Increment
        , test "decrement" <|
            \_ ->
                Counter.view initialModel
                    |> Query.fromHtml
                    |> Query.find [ tag "button", containing [ text "-" ] ]
                    |> Event.simulate Event.click
                    |> Event.expect Counter.Decrement
        ]


suite : Test
suite =
    describe "Counter"
        [ testView, testUpdate, testEvent ]
