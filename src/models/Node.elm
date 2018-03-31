module Node exposing (..)

import Card exposing (..)
import Json.Decode exposing (Decoder, int, string, list)
import Json.Decode.Pipeline exposing (decode, required)
import ApiResponses exposing (..)
import Http exposing (..)


type alias Node =
    { name : String
    , url : String
    , uptime : Int
    , id : Int
    , cards : List Card
    }


minerDecoder : Decoder NodeRes
minerDecoder =
    decode NodeRes
        |> required "id" int
        |> required "uptime" int
