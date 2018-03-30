module Api exposing (..)

import Miners exposing (..)
import Http exposing (..)
import Messages exposing (..)
import Card exposing (..)
import CardDetails exposing (..)
import ApiResponses exposing (..)


fetch : Miners -> Cmd Msg
fetch miner =
    Http.send NodeDataFetched (Http.get miner.url minerDecoder)


fetchCards : Miners -> Cmd Msg
fetchCards miner =
    let
        url =
            "http://localhost:1337/84.210.50.24:20000/api?command={\"id\":1,\"method\":\"device.list\",\"params\":[]}&nocache=1522075203303"
    in
        Http.send CardsFetched (Http.get url cardsDecoder)


fetchCardDetails : List Card -> List (Cmd Msg)
fetchCardDetails cards =
    List.map
        (\card ->
            let
                url =
                    "http://localhost:1337/84.210.50.24:20000/api?command={\"id\":" ++ toString card.id ++ ",\"method\":\"device.get\",\"params\":[\"0\"]}"
            in
                Http.send CardDetailsFetched (Http.get url cardDetailsDecoder)
        )
        cards
