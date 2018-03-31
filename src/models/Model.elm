module Model exposing (..)

import Node exposing (..)
import Messages exposing (..)
import Task exposing (..)
import Time exposing (..)
import Api exposing (..)


type alias Model =
    { pengane : Node
    , knutminer : Maybe Node
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
    in
        { pengane = pengane
        , knutminer = Nothing
        }
            ! [ (fetch pengane), (fetchCards pengane) ]
