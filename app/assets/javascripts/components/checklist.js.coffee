@Checklist = React.createClass

  getInitialState: ->
    edit: false

  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit

  handleEdit: (e) ->
    e.preventDefault()
    if $("#done").is(":checked")
      done = React.findDOMNode(@refs.done).value = true
    else
      done = React.findDOMNode(@refs.done).value = false
    data =
      title: React.findDOMNode(@refs.title).value
      done: done
    $.ajax
      method: 'PUT'
      url: "/checklists/#{ @props.checklist.id }"
      dataType: 'JSON'
      data:
        checklist: data
      success: (data) =>
        @setState edit: false
        @props.handleEditTask @props.checklist, data

  handleStatus: (e) ->
    e.preventDefault()
    data =
      id: React.findDOMNode(@refs.id).value
      title: React.findDOMNode(@refs.title).value
      done: React.findDOMNode(@refs.done).value = true
    $.ajax
      method: 'PUT'
      url: "/checklists/#{ @props.checklist.id }"
      dataType: 'JSON'
      data:
        checklist: data
      success: () =>
        @props.handleEditStatus @props.checklist, data

  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/checklists/#{ @props.checklist.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteTask @props.checklist

  checklistRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.checklist.title
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default btn-fix'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger btn-fix'
          onClick: @handleDelete
          'Delete'
        React.DOM.a
          className: 'btn btn-success btn-fix'
          onClick: @handleStatus
          'Done'
        React.DOM.input
          type: 'hidden'
          defaultValue: @props.checklist.id
          ref: 'id'
        React.DOM.input
          className: 'form-control'
          type: 'hidden'
          defaultValue: @props.checklist.done
          ref: 'done'
        React.DOM.input
          className: 'form-control'
          type: 'hidden'
          defaultValue: @props.checklist.title
          ref: 'title'
      React.DOM.td null,
        if @props.checklist.done == true
          'Done'
        else
          'Not done'

  checklistForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.checklist.title
          ref: 'title'
        React.DOM.td null,
          'Done'
          React.DOM.input
              type: 'hidden'
              defaultValue: @props.checklist.id
              ref: 'id'
          React.DOM.input
            id: 'done'
            className: 'checkbox inline checkbox-fix'
            type: 'checkbox'
            defaultValue: @props.checklist.done
            defaultChecked: @props.checklist.done
            ref: 'done'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default btn-fix'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger btn-fix'
          onClick: @handleToggle
          'Cancel'

  render: ->
    if @state.edit
      @checklistForm()
    else
      @checklistRow()