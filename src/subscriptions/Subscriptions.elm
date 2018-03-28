module Subscriptions exposing (..)

import Model exposing (..)
import Messages exposing (..)
import Time exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (10 * Time.second) Tick
