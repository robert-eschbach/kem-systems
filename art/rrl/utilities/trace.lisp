(in-package 'trace)

;; there is nothing to shadow

;; the external interface 
(export '(go-trace stop-trace))

(use-package 'kr)

(defun go-trace ()

  (create-instance 
   'trace-win inter:interactor-window
   (:title "trace") 
   (:left 0)(:top 400)(:width 480)(:height 450))

  (let* ((trace-agg 
	  (create-instance nil opal:aggregate))

	 (shade-buttons 
	  (create-instance 
	   nil garnet-gadgets::MOTIF-TEXT-BUTTON-PANEL
	   (:constant T :except :foreground-color)
	   (:left 10) (:top 10)
	   (:foreground-color (o-formula (gv trace-win :background-color)))
	   (:final-feedback-p NIL)
	   (:direction :vertical)
	   (:fixed-width-p T)
	   (:items `(("exit"
		      ,#'(lambda (gadget value)
			   (declare (ignore gadget value))
			   (stop-trace)))

		     ("new"
		      ,#'(lambda (gadget value)
			   (declare (ignore gadget value))
			   (stop-trace)
			   (lo)))))))
;; hier noch global
	 (scroll-win 
	  (create-instance 
	   'scroll-win garnet-gadgets:motif-scrolling-window-with-bars
	   (:left 100) (:top 10)	
	   (:width 350)(:height 350)
	   (:background-color opal:motif-gray)
	   (:parent-window trace-win)))
;; hier noch global
	 (text 
	  (create-instance 
	   'text opal:multi-text 
	   (:word-wrap-p T)	
	   (:auto-scroll-p T)
	   (:scrolling-window scroll-win)
	   (:string "Na du Sack-Gesicht !")
	   ))
	 )
    (s-value trace-win :aggregate trace-agg)

    ;; scroll-win kommt hier nicht rein, wird ueber den slot 'parent-window
    ;; geregelt ! text aehnlich 
    (opal:add-components trace-agg shade-buttons)

    (opal:update trace-win)
    (opal:update scroll-win)
    ;; erst scroll-win updaten, dann koennen aggregates hinzugefuegt werden !
    (opal:add-component (g-value scroll-win :inner-aggregate) text)
    ))

(defun stop-trace ()
   (opal:destroy trace-win))

(go-trace)

(defun lo ()
  (load "~/rrl/utilities/trace"))

(defun test-scroll-win (&optional (number 100))
  (dotimes (k number t)
	   (s-value text :string  (string-append "
Depp " (g-value text :string)))
	   (opal:update scroll-win)
	   ))

