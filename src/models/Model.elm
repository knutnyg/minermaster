module Model exposing (..)

import Node exposing (..)
import Messages exposing (..)
import Task exposing (..)
import Time exposing (..)
import Api exposing (..)
import Banken exposing (..)


type alias Model =
    { pengane : Node
    , knutminer : Maybe Node
    , banken : Banken
    }


init : ( Model, Cmd Msg )
init =
    let
        pengane =
            { id = 1
            , url = "http://localhost:1337/84.210.50.24:20000/api?command={\"id\":1,\"method\":\"info\",\"params\":[]}&nocache=1521910258052"
            , name = "pengane"
            , uptime = -1
            , cards = []
            }

        banken =
            Banken "1JhrSWPuHgV71vzPZdNiQyamVYotuyKD4H" 0.0 0.0
    in
        { pengane = pengane
        , knutminer = Nothing
        , banken = banken
        }
            ! [ (fetch pengane), (fetchCards pengane), (fetchWalletBalance banken) ]
