module Miners exposing (..)

import Graphicscard exposing (..)
import Json.Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (decode, required)
import ApiResponses exposing (..)
import Http exposing (..)



type alias Miners =
    { name : String
    , url : String
    , uptime : Int
    , id : Int
    , cards : List Graphicscard
    }

minerDecoder : Decoder NodeRes
minerDecoder =
    decode NodeRes
        |> required "id" int
        |> required "uptime" int