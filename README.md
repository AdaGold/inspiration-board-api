# Ada's Inspiration Board API

[![Build Status](https://travis-ci.org/Ada-Developers-Academy/inspiration-board-api.svg?branch=master)](https://travis-ci.org/Ada-Developers-Academy/inspiration-board-api)

[![Heroku](https://heroku-badge.herokuapp.com/?app=inspiration-board&svg=1)](inspiration-board.herokuapp.com)

This API is intended for use with our second React project Ada's Inpiration Board.

## General


## Boards

This API supports many boards, each of which may have many cards. Each student should maintain their own boards. A board is referenced by name (`Grace's-Board`), _not_ by ID.

- **Retrieve list of all Boards:** https://inspiration-board.herokuapp.com/boards
- **Create a board:**
  - POST https://inspiration-board.herokuapp.com/boards
  - accepted params:
  - name (string)

## Cards

- **Retrieve list of cards for a single board From Name:** https://inspiration-board.herokuapp.com/boards/Ada-Lovelace/cards
  - **Note** if a board with the given `board_name` does not exist, it will be created
- **Add a New Card:**
  - POST https://inspiration-board.herokuapp.com/boards/:board_name/cards
  - accepted params:
    - text (string)
    - emoji (string)
  - **Note** if a board with the given name does not exist it will be created
- **Retrieve specific card:** https://inspiration-board.herokuapp.com/boards/:board_name/cards/:card_id

## Update Data

- **Update a card**
  - PATCH https://inspiration-board.herokuapp.com/boards/:board_name/cards/:card_id
  - text (string)
  - emoji (string)

## Delete Data
- **Delete a card**
  - DELETE https://inspiration-board.herokuapp.com/boards/:board_name/cards/:card_id
