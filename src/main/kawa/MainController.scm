(import 
 (class java.lang Override)
 (class java.net URL)
 (class java.util ResourceBundle)
 (class javafx.event ActionEvent)
 (class javafx.fxml FXML)
 (class javafx.fxml Initializable)
 (class javafx.scene.control Label))

(define-simple-class MainController (Initializable)

  (label ::Label (@FXML) access: 'private)

  ((handleButtonAction event ::ActionEvent) ::void (@FXML) access: 'private
   (display "You Clicked Me!")(newline)
   (label:setText "Hello World!")
   )

  ((initialize url ::URL rb ::ResourceBundle) (@Override)
   (display "Initialized MainController")(newline))
  )
