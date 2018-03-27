module Model exposing (..)

import Miners exposing (..)
import Http exposing (..)
import ApiResponses exposing (..)
import Messages exposing (..)

type alias Model =
    { miner : Miners
    , name : String
    }

fetch : Miners -> Cmd Msg
fetch miner =
    Http.send NodeDataFetched (Http.get miner.url minerDecoder)

fetchCards : Miners -> Cmd Msg
fetchCards miner =
    let
        url = "http://localhost:1337/84.210.50.24:20000/api?command={\"id\":1,\"method\":\"device.list\",\"params\":[]}&nocache=1522075203303"
    in
        Http.send CardsFetched (Http.get url cardsDecoder)

init : (Model, Cmd Msg)
init =
    ( { miner =
        { id = 1
        , url = "http://localhost:1337/84.210.50.24:20000/api?command={\"id\":1,\"method\":\"info\",\"params\":[]}&nocache=1521910258052"
        , name = "pengane"
        , uptime = -1
        , cards = []
        }
      , name = "Pengane"
      }, Cmd.none )