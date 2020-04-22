# Ada's Inspiration Board API

[![Build Status](https://travis-ci.org/AdaGold/inspiration-board-api.svg?branch=master)](https://travis-ci.org/AdaGold/inspiration-board-api)

[![Heroku](https://heroku-badge.herokuapp.com/?app=inspiration-board&svg=1)](inspiration-board.herokuapp.com)

This API is intended for use with our second React project Ada's Inpiration Board.

## Boards

This API supports many boards, each of which may have many cards. Each student should maintain their own boards. A board is referenced by name (`Grace's-Board`), _not_ by ID.

- **Retrieve list of all Boards:** GET https://inspiration-board.herokuapp.com/boards
- **Create a board:**
  - POST https://inspiration-board.herokuapp.com/boards
  - accepted params:
    - name (string)

## Cards

- **Retrieve list of cards for a single board From Name:** GET https://inspiration-board.herokuapp.com/boards/Ada-Lovelace/cards
- **Add a New Card:**
  - POST https://inspiration-board.herokuapp.com/boards/:board_name/cards
  - accepted params:
    - text (string)
    - emoji (string)
- **Retrieve specific card:** https://inspiration-board.herokuapp.com/cards/:card_id
- **Update a card**
  - PATCH https://inspiration-board.herokuapp.com/cards/:card_id
  - accepted params:
    - text (string)
    - emoji (string)
- **Delete a card**
  - DELETE https://inspiration-board.herokuapp.com/cards/:card_id
