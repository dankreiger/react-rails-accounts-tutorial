r=React;rd=r.DOM

@Records = r.createClass
  getInitialState: ->
    records: @props.data
  getDefaultProps: ->
    records: []
  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  balance: ->
    @debits() + @credits()    
  addRecord: (record) ->
    records = @state.records.slice()
    records.push record
    @setState records: records
  deleteRecord: (record) ->
    records = @state.records.slice()
    index = records.indexOf record
    records.splice index, 1
    @replaceState records: records
  render: ->
    rd.div
      className: 'records container'
      rd.h2
        className: 'title'
        'Records'
      rd.div
        className: 'row'
        r.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
        r.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
        r.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'        
      r.createElement RecordForm, handleNewRecord: @addRecord
      rd.table
        className: 'table table-striped'
        rd.thead null,
          rd.tr null,
            rd.th null, 'Date'
            rd.th null, 'Title'    
            rd.th null, 'Amount'
            rd.th null, 'Actions'                  
        rd.tbody null,
          for record in @state.records
            r.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord