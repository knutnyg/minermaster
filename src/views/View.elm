module View exposing (..)

import Html exposing (..)
import Model exposing (..)
import Html.Events exposing (onClick)
import Miners exposing (..)
import Card exposing (..)
import Messages exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [] [ h1 [] [ text "Minermaster" ] ]
        , viewNode model.miner
        , button [ onClick Fetch ] [ text "fetch" ]
        , button [ onClick FetchCardDetails ] [ text "Details" ]
        ]


viewNode : Miners -> Html Msg
viewNode miner =
    let
        cards =
            miner.cards
    in
        div []
            [ div [] [ h2 [] [ text miner.name ] ]
            , p []
                [ text
                    ("Up: "
                        ++ if miner.uptime == -1 then
                            "?️"
                           else if miner.uptime > 0 then
                            "👍"
                           else
                            "👎"
                    )
                ]
            , p [] [ text ("Uptime: " ++ (toString miner.uptime)) ]
            , div [] (List.map viewCard miner.cards)
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
