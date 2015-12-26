r=React;rd=React.DOM;rfdn=React.findDOMNode;


@Record = r.createClass
  getInitialState: ->
    edit: false
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: rfdn(@refs.title).value
      date: rfdn(@refs.date).value
      amount: rfdn(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record
  recordRow: ->
    rd.tr null,
      rd.td null, @props.record.date
      rd.td null, @props.record.title
      rd.td null, amountFormat(@props.record.amount)
      rd.td null,
        rd.a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Edit'
        rd.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  recordForm: ->
    rd.tr null,
      rd.td null,
        rd.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.date
          ref: 'date'
      rd.td null,
        rd.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.title
          ref: 'title'
      rd.td null,
        rd.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.record.amount
          ref: 'amount'
      rd.td null,
        rd.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        rd.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'    
  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()                