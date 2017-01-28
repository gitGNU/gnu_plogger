(import 
 (class java.lang Override)
 (class javafx.application Application)
 (class javafx.fxml FXMLLoader)
 (class javafx.scene Parent)
 (class javafx.scene Scene)
 (class javafx.stage Stage))

(define-simple-class PloggerApp (Application)

  ((start stage ::Stage) ::void (@Override)
   (let* (
	  ;(resource (resource-url "Main.fxml"))
	  ;(root (FXMLLoader:load ((PloggerApp:class):getResource "main.fxml")))
	  (resource (invoke ((this):getClass) 'getResource "Main.fxml"))
	  ;(resource "./Main.fxml")
	  (root (FXMLLoader:load resource))
	  (scene (Scene root)))
     (stage:setScene scene)
     (stage:show)))

  ((main args ::java.lang.String[]) ::void allocation: 'static
   (PloggerApp:launch args)))
