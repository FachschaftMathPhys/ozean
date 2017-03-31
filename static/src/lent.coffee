define ['ajax','student','folder'],(ajax,Student,Folder)->
  class Lent
    constructor:(data)->
      #Datenbanken
      @id= ko.observable data?.id
      @studentid= ko.observable data?.studentid
      @folderid= ko.observable data?.folderid
      @lentat = ko.observable data?.lentat
      @date= ko.computed ()=>
        moment(@lentat())
      @student = ko.observable new Student (name:"")
      @folder= ko.observable new Folder (name:"")
      #loading student and folder
      ajax("api/student/#{data?.studentid}","GET").done( (data2)=>
        @student(new Student(data2))
        )
      ajax("api/folder/#{data?.folderid}","GET").done( (data2)=>
        @folder(new Folder(data2))
      )
      @MailPath= ko.computed =>
        "mailto: #{@student().uniid()}@urz.uni-heidelberg.de?subject=Ordner #{@folder().name()}&body=Hallo #{@student().name()},%0ADu hast den Ordner #{@folder().name()} #{moment(@lentat()).fromNow()} bei uns ausgeliehen und bisher noch nicht zurückgebracht.%0AWir sind in der Vorlesungszeit täglich von X bis Y im Fachschaftsraum erreichbar.%0A Wir freuen uns dich mit dem Ordner bald wieder zusehen!%0A Deine Fachschaft MathPhys "
