module ApiResponses exposing (..)


type alias NodeRes =
    { uptime : Int
    , id : Int
    }


type alias DevicesRes =
    { devices : List DeviceRes
    , id : Int
    }


type alias DeviceRes =
    { device_id : Int
    , name : String
    }
