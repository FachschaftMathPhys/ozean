define ['ajax','student','folder'],(ajax,Student,Folder)->
  class Lent
    constructor:(data)->
      #Datenbanken
      @id= ko.observable data?.id
      @studentid= ko.observable data?.studentid
      @folderid= ko.observable data?.folderid
      @lentat = ko.observable data?.lentat
      @returnedat = ko.observable data?.returnedat
      @student = ko.observable new Student (name:"")
      @folder= ko.observable new Folder (name:"")
      #loading student and folder
      ajax("api/student/#{data?.studentid}","GET").done( (data2)=>
        @student(new Student(data2))
        )
      ajax("api/folder/#{data?.folderid}","GET").done( (data2)=>
        @folder(new Folder(data2))
      )
