module Miners exposing (..)

import Graphicscard exposing (..)
import Json.Decode exposing (Decoder, int, string, list)
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

deviceDecoder : Decoder DeviceRes
deviceDecoder =
    decode DeviceRes
        |> required "device_id" int
        |> required "name" string

cardsDecoder : Decoder DevicesRes
cardsDecoder =
    decode DevicesRes
        |> required "devices" (list deviceDecoder)
        |> required "id" int