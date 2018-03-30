module Model exposing (..)

import Miners exposing (..)
import Messages exposing (..)
import Task exposing (..)
import Time exposing (..)
import Api exposing (..)


type alias Model =
    { miner : Miners
    , name : String
    }


init : ( Model, Cmd Msg )
init =
    let
        miner =
            { id = 1
            , url = "http://localhost:1337/84.210.50.24:20000/api?command={\"id\":1,\"method\":\"info\",\"params\":[]}&nocache=1521910258052"
            , name = "pengane"
            , uptime = -1
            , cards = []
            }
    in
        { name = "Pengane"
        , miner = miner
        }
            ! [ (fetch miner), (fetchCards miner) ]
