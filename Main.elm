module Main exposing (..)

import Html exposing (Html, button, div, text, p, h1, h2)
import Html.Events exposing (onClick)
import Http exposing (..)
import Json.Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (decode, required)


main =
    Html.program { init = init, view = view, update = update, subscriptions = subscriptions }



-- MODEL


type alias Model =
    { node : Node
    , name : String
    }


type alias Node =
    { name : String
    , url : String
    , uptime : Int
    , id : Int
    , gpus : List Int
    }


type alias NodeRes =
    { uptime : Int
    , id : Int
    }



-- HTTP


fetch : Node -> Cmd Msg
fetch node =
    Http.send NodeDataFetched (Http.get node.url nodeDecoder)


nodeDecoder : Decoder NodeRes
nodeDecoder =
    decode NodeRes
        |> required "id" int
        |> required "uptime" int



-- UPDATE


type Msg
    = Fetch
    | NodeDataFetched (Result Http.Error NodeRes)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, fetch model.node )

        NodeDataFetched (Ok res) ->
            ( { model | node = Node model.node.name model.node.url res.id res.uptime [] }, Cmd.none )

        NodeDataFetched (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ div [] [ h1 [] [ text "Minermaster" ] ]
        , viewNode model.node
        , button [ onClick Fetch ] [ text "fetch" ]
        ]


viewNode : Node -> Html Msg
viewNode node =
    div []
        [ div [] [ h2 [] [ text node.name ] ]
        , p []
            [ text
                ("Up?: "
                    ++ if node.uptime == -1 then
                        "\x1F937\x200D♂️"
                       else if node.uptime > 0 then
                        "👍"
                       else
                        "👎"
                )
            ]
        , p [] [ text ("Uptime: " ++ (toString node.uptime)) ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


baseUrl =
    "http://localhost:1337/"


penganeUrl =
    "84.210.50.24:20000"


nodeInfo =
    "{\"id\":1,\"method\":\"info\",\"params\":[]}"



-- INIT


init : ( Model, Cmd none )
init =
    ( { node =
            { id = 1
            , url = "http://localhost:1337/84.210.50.24:20000/api?command={\"id\":1,\"method\":\"info\",\"params\":[]}&nocache=1521910258052"
            , name = "pengane"
            , uptime = -1
            , gpus = []
            }
      , name = "test"
      }
    , Cmd.none
    )
