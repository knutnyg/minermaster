module Banken exposing (..)

import ApiResponses exposing (..)
import Json.Decode exposing (Decoder, int, string, list)
import Json.Decode.Pipeline exposing (decode, required)


type alias Banken =
    { wallet : String
    , balance : Float
    , estValue : Float
    }
