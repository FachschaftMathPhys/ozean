define [],()->
  class Folder
    constructor:(data)->
      @id = ko.observable data?.id
      @name  = ko.observable data?.name
      @content  = ko.observable data?.content
      @obligation_to_report = ko.observable data?.obligation_to_report
      @barcode = ko.observable data?.barcode
      @text=ko.computed ()=>
        if @obligation_to_report()
          return @name()+" (kostenpflichtig)"
        @name()
