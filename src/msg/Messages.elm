module Messages exposing (..)

import Http exposing (..)
import ApiResponses exposing (..)


type Msg =
    Fetch |
    NodeDataFetched (Result Http.Error NodeRes) |
    FetchCards |
    CardsFetched (Result Http.Error DevicesRes)
