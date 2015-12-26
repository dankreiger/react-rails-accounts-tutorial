r=React;rd=r.DOM

@AmountBox = r.createClass
  render: ->
    rd.div
      className: 'col-md-4'
      rd.div
        className: "panel panel-#{ @props.type }"
        rd.div
          className: 'panel-heading'
          @props.text
        rd.div
          className: 'panel-body'
          amountFormat(@props.amount)