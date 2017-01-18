(import 
 (class javafx.application Application)
 (class javafx.stage Stage)
 (class javafx.event ActionEvent)
 (class javafx.event EventHandler)
 (class javafx.scene Scene)
 (class javafx.scene.control Button)
 (class javafx.scene.layout StackPane)
 (class java.lang Override))

(define-simple-class Plogger (Application)
  ((start primary-stage ::Stage) ::void (@Override)
   (let* ((btn (Button))
	  (root (StackPane))
	  (scene (Scene root 300 250)))
     (btn:setText "Say Hello World")
     (btn:setOnAction
      (lambda (e) (display "Hello World")(newline)))
     ((root:getChildren):add btn)
     (primary-stage:setTitle "Hello World")
     (primary-stage:setScene scene)
     (primary-stage:show)))
  ((main args ::java.lang.String[]) ::void allocation: 'static
   (Plogger:launch args))
  
)
