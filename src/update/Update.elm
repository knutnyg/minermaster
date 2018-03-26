module Update exposing (..)

import Model exposing (..)
import Messages exposing (..)
import Miners exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, fetch model.miner )

        NodeDataFetched (Ok res) ->
            ( { model | miner = Miners model.miner.name model.miner.url res.id res.uptime [] }, Cmd.none )

        NodeDataFetched (Err _) ->
            ( model, Cmd.none )

        FetchCards ->
            ( model, fetchCards model.miner )
        CardsFetched (Ok res) ->
            ( model, Cmd.none )

        CardsFetched (Err _) ->
            ( model, Cmd.none )