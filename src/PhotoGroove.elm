module PhotoGroove exposing (main)
import Html exposing (button, div, input, h1, h3, label, img, text, Html)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Browser
import Array exposing (Array)



----------------   MODEL   -------------------

initialModel : Model
initialModel =
  { photos =
    [ { url = "1.jpeg" }
    , { url = "2.jpeg" }
    , { url = "3.jpeg" }
    ]
  , selectedUrl = "1.jpeg"
  , chosenSize = Medium
  }

main =
  Browser.sandbox
    { init = initialModel
    , view = view
    , update = update
    }


----------------   VIEW   -------------------
view : Model -> Html Msg
view model =
  div [ class "content" ]
    [ h1 [] [ text "Photo Groove" ]
    , button [ onClick ClickedSurpriseMe ]
      [ text "Surprise Me!" ]
    , h3 [] [ text "ThumbnailSize:" ]
    , div [ id "choose-size" ]
        (List.map viewSizeChooser [ Small, Medium, Large ])
    , div [ id "thumbnails", class (sizeToString model.chosenSize) ]
        (List.map (viewThumbnail model.selectedUrl) model.photos
      )
    , img [ class "large", src (urlPrefix ++ "large/" ++ model.selectedUrl) ] []
    ]

viewThumbnail : String -> Photo -> Html Msg
viewThumbnail selectedUrl thumb =
  img [ src (urlPrefix ++ thumb.url), classList [ ("selected", selectedUrl == thumb.url )], onClick (ClickedPhoto thumb.url) ] []

viewSizeChooser : ThumbnailSize -> Html Msg
viewSizeChooser size =
  label []
    [ input [ type_ "radio", name "size", onClick (ClickedSize size) ] []
    , text (sizeToString size)
    ]

sizeToString : ThumbnailSize -> String
sizeToString size =
  case size of
    Small ->
      "small"
    Medium ->
      "med"
    Large ->
      "large"

urlPrefix =
  "http://elm-in-action.com/"

photoArray : Array Photo
photoArray =
  Array.fromList initialModel.photos


type alias Photo =
  { url : String }

type alias Model =
  { photos: List Photo
  , selectedUrl : String
  , chosenSize : ThumbnailSize
  }

type Msg
  = ClickedPhoto String
  | ClickedSize ThumbnailSize
  | ClickedSurpriseMe

type ThumbnailSize
  = Small
  | Medium
  | Large

----------------   UPDATE   -------------------

update : Msg -> Model -> Model
update msg model =
  case msg of
    ClickedPhoto url ->
      { model | selectedUrl = url }
    ClickedSize size ->
      { model | chosenSize = size}
    ClickedSurpriseMe ->
      { model | selectedUrl = "2.jpeg"}
