module Model exposing (..)

import Miners exposing (..)
import Http exposing (..)
import ApiResponses exposing (..)

type alias Model =
    { miner : Miners
    , name : String
    }

type Msg =
    Fetch |
    NodeDataFetched (Result Http.Error NodeRes)


fetch : Miners -> Cmd Msg
fetch miner =
    Http.send NodeDataFetched (Http.get miner.url minerDecoder)

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