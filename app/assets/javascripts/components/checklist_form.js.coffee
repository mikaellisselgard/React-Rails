@ChecklistForm = React.createClass
  getInitialState: ->
    title: ''
    done: false

  valid: ->
    @state.title

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/checklists', { checklist: @state }, (data) =>
      @props.handleNewTask data
      @setState @getInitialState()
    , 'JSON'

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange
        React.DOM.input
          type: 'hidden'
          className: 'form-control'
          name: 'done'
          value: @state.done
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create task'