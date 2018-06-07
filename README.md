# Ada's Inspiration Board API

This API is intended for use with our second React project Ada's Inpiration Board.

## Retrieve Data
  - **Retrieve list of all Boards:** https://inspiration-board.herokuapp.com/boards

  - **Retrieve list of cards for a single board From Name:** https://inspiration-board.herokuapp.com/boards/Ada-Lovelace/cards

  - **Retrieve specific card:** https://inspiration-board.herokuapp.com/boards/:board_name/cards/:card_id

## Send Data

  - **Create a board:**
    - POST https://inspiration-board.herokuapp.com/boards
    - accepted params:
      - name (string)

  - **Add a New Card:**
    - POST https://inspiration-board.herokuapp.com/boards/:board_name/cards
    - accepted params:
      - text (string)
      - emoji (string)

## Update Data

- **Update a card**
  - PATCH https://inspiration-board.herokuapp.com/boards/:board_name/cards/:card_id
  - text (string)
  - emoji (string)

## Delete Data
- **Delete a board, warning destroys all card data for that board**
  - DELETE https://inspiration-board.herokuapp.com/boards/:board_name
- **Delete a card**
  - DELETE https://inspiration-board.herokuapp.com/boards/:board_name/cards/:card_id
