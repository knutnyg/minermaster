module Card exposing (..)

import CardDetails exposing (..)
import ApiResponses exposing (..)
import Json.Decode exposing (Decoder, int, string, list)
import Json.Decode.Pipeline exposing (decode, required)


type alias Card =
    { id : Int
    , name : String
    , details : Maybe CardDetails
    }


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
