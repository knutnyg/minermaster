module Update exposing (..)

import Miners exposing (..)
import Model exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, fetch model.miner )

        NodeDataFetched (Ok res) ->
            ( { model | miner = Miners model.miner.name model.miner.url res.id res.uptime [] }, Cmd.none )

        NodeDataFetched (Err _) ->
            ( model, Cmd.none )