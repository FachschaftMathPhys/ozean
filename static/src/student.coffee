define [],()->
  class Student
    constructor: (data)->
      @id = ko.observable data?.id
      @name = ko.observable data?.name
      @uniid = ko.observable data?.uniid
      @matriculationnumber= ko.observable data?.matriculationnumber
      @refund = ko.observable data?.refund ? false
      @report = ko.observable data?.report ? false
      @comment= ko.observable data?.comment ? false
