r=React;rd=r.DOM

@RecordForm = r.createClass
  getInitialState: ->
    title: ''
    date: ''
    amount: ''
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  valid: ->
    @state.title && @state.date && @state.amount    
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '', { record: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'
  render: ->
    rd.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      rd.div
        className: 'form-group'
        rd.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Date'
          name: 'date'
          value: @state.date
          onChange: @handleChange
      rd.div
        className: 'form-group'
        rd.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange  
      rd.div
        className: 'form-group'
        rd.input
          type: 'number'
          className: 'form-control'
          placeholder: 'Amount'
          name: 'amount'
          value: @state.amount
          onChange: @handleChange 
      rd.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create record'               
