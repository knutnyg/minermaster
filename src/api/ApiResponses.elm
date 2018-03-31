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


type alias CardDetailsRes =
    { gpu_temp : Int
    , gpu_load : Int
    , gpu_power_usage : Float
    , gpu_fan_speed : Int
    , gpu_fan_speed_rpm : Int
    , device_id : Int
    }


type alias BalanceRes =
    { value : Float
    }
