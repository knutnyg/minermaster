module Api exposing (..)

import Node exposing (..)
import Banken exposing (..)
import Http exposing (..)
import Messages exposing (..)
import Card exposing (..)
import CardDetails exposing (..)
import ApiResponses exposing (..)


fetch : Node -> Cmd Msg
fetch miner =
    Http.send NodeDataFetched (Http.get miner.url minerDecoder)


fetchCards : Node -> Cmd Msg
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
                    "http://localhost:1337/84.210.50.24:20000/api?command={\"id\":1,\"method\":\"device.get\",\"params\":[\"" ++ toString card.id ++ "\"]}"
            in
                Http.send CardDetailsFetched (Http.get url cardDetailsDecoder)
        )
        cards


fetchWalletBalance : Banken -> Cmd Msg
fetchWalletBalance banken =
    let
        url =
            "https://blockchain.info/q/addressbalance/" ++ banken.wallet ++ "?confirmations=6"
    in
        Http.send WalletBalanceFetched <|
            Http.getString url
