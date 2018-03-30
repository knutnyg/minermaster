module Update exposing (..)

import Model exposing (..)
import Messages exposing (..)
import Miners exposing (..)
import Card exposing (..)
import Api exposing (..)
import CardDetails exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init ->
            model ! [ (fetch model.miner), (fetchCards model.miner) ]

        Fetch ->
            ( model, fetch model.miner )

        NodeDataFetched (Ok res) ->
            ( { model | miner = Miners model.miner.name model.miner.url res.id res.uptime model.miner.cards }, Cmd.none )

        NodeDataFetched (Err _) ->
            ( model, Cmd.none )

        FetchCards ->
            ( model, fetchCards model.miner )

        CardsFetched (Ok res) ->
            let
                miner =
                    model.miner

                newCards =
                    List.map (\d -> Card d.device_id d.name Nothing) res.devices
            in
                ( { model | miner = { miner | cards = newCards } }, Cmd.none )

        CardsFetched (Err _) ->
            ( model, Cmd.none )

        FetchCardDetails ->
            (model ! fetchCardDetails model.miner.cards)

        CardDetailsFetched (Ok res) ->
            let
                miner =
                    model.miner

                updatedCards =
                    List.map
                        (\c ->
                            if c.id == res.id then
                                { c | details = Just (CardDetails res.gpu_temp res.gpu_fan_speed res.gpu_fan_speed_rpm res.gpu_power_usage res.gpu_load res.id) }
                            else
                                c
                        )
                        miner.cards
            in
                ( { model | miner = { miner | cards = updatedCards } }, Cmd.none )

        CardDetailsFetched (Err _) ->
            ( model, Cmd.none )

        Tick time ->
            model ! fetchCardDetails model.miner.cards
