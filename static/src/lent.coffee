define ['ajax','student','folder'],(ajax,Student,Folder)->
  class Lent
    constructor:(data)->
      #Datenbanken
      @id= ko.observable data?.id
      @studentId= ko.observable data?.studentId
      @folderId= ko.observable data?.folderId
      @lentAt = ko.observable data?.DateTime
      @student = ko.observable new Student
      @folder= ko.observable new Folder
      #loading student and folder
      if data? and  data.studentId?
        ajax("api/users/#{data?.studentId}","GET").done( (data2)=>
          @student(new Student(data2))
          )
      if data? and  data.folderId?
        ajax("api/users/#{data?.folderId}","GET").done( (data2)=>
          @folder(new Folder(data2))
          )
