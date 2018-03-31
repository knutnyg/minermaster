module Update exposing (..)

import Model exposing (..)
import Messages exposing (..)
import Node exposing (..)
import Card exposing (..)
import Api exposing (..)
import CardDetails exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Init ->
            model ! [ (fetch model.pengane), (fetchCards model.pengane) ]

        Fetch ->
            ( model, fetch model.pengane )

        NodeDataFetched (Ok res) ->
            ( { model | pengane = Node model.pengane.name model.pengane.url res.id res.uptime model.pengane.cards }, Cmd.none )

        NodeDataFetched (Err _) ->
            ( model, Cmd.none )

        FetchCards ->
            ( model, fetchCards model.pengane )

        CardsFetched (Ok res) ->
            let
                pengane =
                    model.pengane

                newCards =
                    List.map (\d -> Card d.device_id d.name Nothing) res.devices
            in
                ( { model | pengane = { pengane | cards = newCards } }, Cmd.none )

        CardsFetched (Err _) ->
            ( model, Cmd.none )

        FetchCardDetails ->
            (model ! fetchCardDetails model.pengane.cards)

        CardDetailsFetched (Ok res) ->
            let
                pengane =
                    model.pengane

                updatedCards =
                    List.map
                        (\c ->
                            if c.id == res.device_id then
                                { c | details = Just (CardDetails res.gpu_temp res.gpu_fan_speed res.gpu_fan_speed_rpm res.gpu_power_usage res.gpu_load res.device_id) }
                            else
                                c
                        )
                        pengane.cards
            in
                ( { model | pengane = { pengane | cards = updatedCards } }, Cmd.none )

        CardDetailsFetched (Err _) ->
            ( model, Cmd.none )

        FetchWalletBalance ->
            ( model, Cmd.none )

        WalletBalanceFetched (Ok strBalance) ->
            let
                banken =
                    model.banken

                balance =
                    (String.toFloat strBalance |> Result.withDefault 0)
            in
                ( { model | banken = { banken | balance = balance } }, Cmd.none )

        WalletBalanceFetched (Err _) ->
            ( model, Cmd.none )

        Tick time ->
            model ! fetchCardDetails model.pengane.cards
