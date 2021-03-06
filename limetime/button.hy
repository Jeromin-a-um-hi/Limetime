(import pygame :as pg)
(defclass Button []
  (defn __init__ [self text width height pos screen given_event]
    ;; Event
    (setv self.given_event given_event)
    
    ;; Logic
    (setv self.pressed False)

    ;; Set screen
    (setv self.screen screen)
    
    ;; Get Font
    (setv default (pg.font.Font "Resources/Grand9k.ttf" 16))

    ;; Create rectangle
    (setv self.top_rect
          (pg.Rect pos (, width height)))
    (setv self.top_colour "#475F77")

    ;; Text
    (setv self.text_surf (default.render text True "#FFFFFF"))
    (setv self.text_rect
          (self.text_surf.get_rect :center self.top_rect.center)))

  (defn draw [self]
    (pg.draw.rect self.screen self.top_colour self.top_rect)
    (self.screen.blit self.text_surf self.text_rect)
    (self.check_click))

  (defn check_click [self]
    (setv mouse_pos (pg.mouse.get_pos))
    (if (self.top_rect.collidepoint mouse_pos)
        (do
          (setv self.top_colour "#D74B4B")
          (if (get (pg.mouse.get_pressed) 0)
              (setv self.pressed True)
              (if self.pressed
                (do
                  (pg.event.post (pg.event.Event self.given_event))
                  (setv self.pressed False)))))
        (setv self.top_colour "#475F77"))))
