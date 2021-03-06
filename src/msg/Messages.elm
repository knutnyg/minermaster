module Messages exposing (..)

import Http exposing (..)
import ApiResponses exposing (..)
import Time exposing (..)


type Msg
    = Init
    | Fetch
    | NodeDataFetched (Result Http.Error NodeRes)
    | FetchCards
    | CardsFetched (Result Http.Error DevicesRes)
    | Tick Time
    | FetchCardDetails
    | CardDetailsFetched (Result Http.Error CardDetailsRes)
    | FetchWalletBalance
    | WalletBalanceFetched (Result Http.Error String)
