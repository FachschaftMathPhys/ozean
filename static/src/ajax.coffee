define [],()->
  (uri, method, data,isChached)->
    daten = null
    if(data!=null)
      daten = JSON.stringify(data)
    request =
      url: uri,
      type: method
      contentType: "application/json"
      accepts: "application/json"
      cache: isChached
      dataType: 'json'
      async:isChached
      data: JSON.stringify(data)
      beforeSend: (xhr)->
      error:(jqXHR)->
        if(showError)
          alert jqXHR.responseJSON.message
    $.ajax request
