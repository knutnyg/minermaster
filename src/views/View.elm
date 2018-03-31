module View exposing (..)

import Html exposing (..)
import Model exposing (..)
import Html.Events exposing (onClick)
import Node exposing (..)
import Card exposing (..)
import Messages exposing (..)
import FormatNumber.Locales exposing (Locale, usLocale)
import FormatNumber exposing (format)
import Banken exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [] [ h1 [] [ text "Minermaster" ] ]
        , viewNode model.pengane
        , viewBanken model.banken
        , button [ onClick Fetch ] [ text "fetch" ]
        , button [ onClick FetchCardDetails ] [ text "Details" ]
        ]


viewBanken : Banken -> Html Msg
viewBanken banken =
    div []
        [ h3 [] [ text "Banken" ]
        , p [] [ text ("Address: " ++ banken.wallet) ]
        , p [] [ text ("Balance: " ++ format (Locale 1 " " "," "-" "") (banken.balance / 100000) ++ " mBtc") ]
        , p [] [ text ("Est value: " ++ format usLocale banken.estValue) ]
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
                div []
                    [ p [] [ text ("Temperature: " ++ toString details.temp) ]
                    , p [] [ text ("Power usage: " ++ format usLocale details.pwrUsage ++ "W") ]
                    , p [] [ text ("Fan speed: " ++ toString details.fanPercent ++ "%, " ++ toString details.fanRpm ++ " rpm") ]
                    ]

            Nothing ->
                text ""
        ]
