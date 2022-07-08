(import pygame :as pg)
(import button)
(setv clock (pg.time.Clock))

(defn hello []
  (pg.init)
  (setv WINDOW_SIZE    (, 854 480)
        screen         (pg.display.set_mode WINDOW_SIZE)
        display        (pg.Surface (, 256 144))
        OPEN_GAME      (+ pg.USEREVENT 0)
        OPEN_OPTIONS   (+ pg.USEREVENT 1)
        OPEN_SCORES    (+ pg.USEREVENT 2)
        OPEN_MAIN_MENU (+ pg.USEREVENT 3))
  (main_menu screen (, OPEN_GAME OPEN_OPTIONS OPEN_SCORES OPEN_MAIN_MENU) display WINDOW_SIZE))

(defn main_menu [screen event_given display WINDOW_SIZE]
  (screen.fill "#FFFFFF")
  (pg.display.set_caption "Limetime")
  (setv play    (button.Button "Play" 150 40 (, 695 330) screen (get event_given 0))
        options (button.Button "Options" 150 40 (, 695 380) screen (get event_given 1))
        scores  (button.Button "Scores" 150 40 (, 695 430) screen (get event_given 2))
        running True)
  (while running
    (do
      (clock.tick 60)
      (pg.display.update)
      (play.draw)
      (options.draw)
      (scores.draw)
      (for [event (pg.event.get)]
        (if (= event.type pg.QUIT)
            (do
              (pg.quit)
              (setv running False)))
        (if (= event.type (get event_given 0))
            (do
              (print "game")
              (setv running False)
              (play_game screen event_given display WINDOW_SIZE)))
        (if (= event.type (get event_given 1))
            (do
              (print "options")
              (setv running False)
              (options_menu screen event_given WINDOW_SIZE)))
        (if (= event.type (get event_given 2))
            (do
              (print "scores")
              (setv running False)
              (scores_menu screen event_given WINDOW_SIZE))))
      (if (= running False)
          (break)))))

(defn play_game [screen event_given display WINDOW_SIZE]
  (pg.display.set_caption "Limetime - Playing")
  (setv running      True
        moving_right False
        moving_left  False
        jump         False
        crouch       False
        player_image (pg.image.load "Resources/Limeman.png")
        player_grav  0.1
        grass_image  (pg.image.load "Resources/Grass.png")
        dirt_image   (pg.image.load "Resources/Dirt.png")
        back         (button.Button "<" 30 30 (, 0 0) screen (get event_given 3))
        player_pos   [100 100]
        player_rect  (pg.Rect (get player_pos 0) (get player_pos 1) (player_image.get_width) (player_image.get_height))
        game_map     [[0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
                      [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
                      [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
                      [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
                      [0 0 0 0 0 0 2 2 2 2 2 2 0 0 0 0 0 0 0 0]
                      [2 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 2]
                      [1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 1 1]
                      [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
                      [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
                      [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]
                      [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]])
  (while running
    (do
      (display.fill "#FFFFFF")
      (clock.tick 60)
      (display.blit player_image player_pos)
      (setv player_grav (+ player_grav 0.2))
      (setv (get player_pos 1) (+ player_grav (get player_pos 1)))
      (cond
        [(= moving_right True)
         (setv (get player_pos 0) (+ 5 (get player_pos 0)))]
        [(= moving_left True)
         (setv (get player_pos 0) (- (get player_pos 0) 5))]
        [(= jump True)
         (setv (get player_pos 1) (- (get player_pos 1) 10))]
        [(= crouch True)
         (setv (get player_pos 1) (+ 10 (get player_pos 1)))])
      (setv player_rect.x (get player_pos 0)
            player_rect.y (get player_pos 1))
      (back.draw)
      (screen.blit (pg.transform.scale display WINDOW_SIZE) (, 0 0))
      (pg.display.update)
      (for [event (pg.event.get)]
        (if (= event.type pg.QUIT)
            (do
              (pg.quit)
              (setv running False)))
        (if (= event.type (get event_given 3))
            (do
              (print "main")
              (setv running False)
              (main_menu screen event_given WINDOW_SIZE)))
        (if (= event.type pg.KEYDOWN)
            (if (= event.key)
                (cond
                  [(= event.key pg.K_RIGHT)
                   (setv moving_right True)
                   (print "right")]
                  [(= event.key pg.K_LEFT)
                   (setv moving_left True)
                   (print "left")]
                  [(= event.key pg.K_UP)
                   (setv jump True)
                   (print "jump")]
                  [(= event.key pg.K_DOWN)
                   (setv crouch True)
                   (print "crouch")])))
        (if (= event.type pg.KEYUP)
            (if (= event.key)
                (cond
                  [(= event.key pg.K_RIGHT)
                   (setv moving_right False)
                   (print "right removed")]
                  [(= event.key pg.K_LEFT)
                   (setv moving_left False)
                   (print "left removed")]
                  [(= event.key pg.K_UP)
                   (setv jump False)
                   (print "jump removed")]
                  [(= event.key pg.K_DOWN)
                   (setv crouch False)
                   (print "crouch removed")]))))
      (if (= running False)
          (break)))))

(defn options_menu [screen event_given WINDOW_SIZE]
  (screen.fill "#FFFFFF")
  (pg.display.set_caption "Limetime - Options")
  (setv running True
        back    (button.Button "<" 30 30 (, 0 0) screen (get event_given 3)))
  (while running
    (do
      (clock.tick 60)
      (pg.display.update)
      (back.draw)
      (for [event (pg.event.get)]
        (if (= event.type pg.QUIT)
            (do
              (pg.quit)
              (setv running False)))
        (if (= event.type (get event_given 3))
            (do
              (print "main")
              (setv running False)
              (main_menu screen event_given))))
      (if (= running False)
          (break)))))

(defn scores_menu [screen event_given WINDOW_SIZE]
  (screen.fill "#FFFFFF")
  (pg.display.set_caption "Limetime - Scores")
  (setv running True
        back    (button.Button "<" 30 30 (, 0 0) screen (get event_given 3)))
  (while running
    (do
      (clock.tick 60)
      (pg.display.update)
      (back.draw)
      (for [event (pg.event.get)]
        (if (= event.type pg.QUIT)
            (do
              (pg.quit)
              (setv running False)))
        (if (= event.type (get event_given 3))
            (do
              (print "main")
              (setv running False)
              (main_menu screen event_given))))
      (if (= running False)
          (break)))))

(hello)
