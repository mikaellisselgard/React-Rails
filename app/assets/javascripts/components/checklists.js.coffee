@Checklists = React.createClass

  getInitialState: ->
    checklists: @props.data

  getDefaultProps: ->
    checklists: []

  addTask: (checklist) ->
    checklists = React.addons.update(@state.checklists, { $push: [checklist] })
    @setState checklists: checklists

  updateTask: (checklist, data) ->
    index = @state.checklists.indexOf checklist
    checklists = React.addons.update(@state.checklists, { $splice: [[index, 1, data]] })
    @replaceState checklists: checklists

  deleteTask: (checklist) ->
    index = @state.checklists.indexOf checklist
    checklists = React.addons.update(@state.checklists, { $splice: [[index, 1]] })
    @replaceState checklists: checklists

  render: ->
    React.DOM.div
      className: 'checklists'
      React.DOM.h2
        className: 'title'
        'To do'
      React.createElement ChecklistForm, handleNewTask: @addTask
      React.DOM.hr null,
      React.DOM.table
        className: 'table table-striped table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Actions'
            React.DOM.th null, 'Status'
        React.DOM.tbody null,
          for checklist in @state.checklists
            React.createElement Checklist, key: checklist.id, checklist: checklist, handleDeleteTask: @deleteTask, handleEditTask: @updateTask, handleEditStatus: @updateTask