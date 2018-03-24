import Html exposing (Html, button, div, text, p)
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
  , url  : String
  , uptime : Int
  , id: Int
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

type Msg = Fetch
    | NodeDataFetched(Result Http.Error NodeRes)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Fetch ->
        (model, fetch model.node )
    NodeDataFetched (Ok res) ->
       ( { model | node = Node model.node.name model.node.url res.id res.uptime }, Cmd.none)
    NodeDataFetched (Err _) ->
       ( model, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Fetch ] [ text "fetch"]
    , div []
            [ text (model.name) ]
    , div []
            [ p [] [ text ( toString model.node.id ) ]
            , p [] [ text model.node.url ]
            , p [] [ text ( toString model.node.uptime ) ]
            , p [] [ text model.node.name ]
            ]

    ]



-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT
init : (Model, Cmd none)
init =
    ({ node =
    { id = 1
    , url = "http://localhost:1337/84.210.50.24:20000/api?command={%22id%22:1,%22method%22:%22info%22,%22params%22:[]}&nocache=1521910258052"
    , name = "pengane"
    , uptime = 0
    }
    , name = "test" }, Cmd.none)


