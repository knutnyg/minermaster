module View exposing (..)

import Html exposing (..)
import Model exposing (..)
import Html.Events exposing (onClick)
import Node exposing (..)
import Card exposing (..)
import Messages exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [] [ h1 [] [ text "Minermaster" ] ]
        , viewNode model.pengane
        , button [ onClick Fetch ] [ text "fetch" ]
        , button [ onClick FetchCardDetails ] [ text "Details" ]
        ]


viewNode : Node -> Html Msg
viewNode node =
    let
        cards =
            node.cards
    in
        div []
            [ div [] [ h2 [] [ text node.name ] ]
            , p []
                [ text
                    ("Up: "
                        ++ if node.uptime == -1 then
                            "?️"
                           else if node.uptime > 0 then
                            "👍"
                           else
                            "👎"
                    )
                ]
            , p [] [ text ("Uptime: " ++ (toString node.uptime)) ]
            , div [] (List.map viewCard node.cards)
            ]


viewCard : Card -> Html Msg
viewCard card =
    div []
        [ h3 [] [ text card.name ]
        , case card.details of
            Just details ->
                p [] [ text ("Temperature: " ++ toString details.temp) ]

            Nothing ->
                text ""
        ]
