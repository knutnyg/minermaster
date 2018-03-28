module Card exposing (..)

import CardDetails exposing (..)


type alias Card =
    { id : Int
    , name : String
    , details : Maybe CardDetails
    }
