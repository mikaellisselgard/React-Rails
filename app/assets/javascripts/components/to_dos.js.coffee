@To_dos = React.createClass

  getInitialState: ->
    to_dos: @props.data

  getDefaultProps: ->
    to_dos: []

  render: ->
    React.DOM.div
      className: 'to_dos'
      React.DOM.h2
        className: 'title'
        'Todos'
      React.DOM.div
        className: 'Row'
        for todo in @state.to_dos
          React.createElement Todo, key: todo.id, todo: todo

          for record in @state.records
            React.createElement Record, key: record.id, record: record