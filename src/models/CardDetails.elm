module CardDetails exposing (..)

import Json.Decode exposing (Decoder, int, string, list, float)
import Json.Decode.Pipeline exposing (decode, required)
import ApiResponses exposing (..)


type alias CardDetails =
    { temp : Int
    , fanPercent : Int
    , fanRpm : Int
    , pwrUsage : Float
    , load : Int
    , id : Int
    }


cardDetailsDecoder : Decoder CardDetailsRes
cardDetailsDecoder =
    decode CardDetailsRes
        |> required "gpu_temp" int
        |> required "gpu_load" int
        |> required "gpu_power_usage" float
        |> required "gpu_fan_speed" int
        |> required "gpu_fan_speed_rpm" int
        |> required "id" int
