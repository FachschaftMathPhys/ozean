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
        "mailto: #{@student().uniid()}@ix.urz.uni-heidelberg.de?subject=Ordner #{@folder().name()}&body="+
        "Hallo #{@student().name().split(" ")[0]},%0A "+
        " %0A "+
        "laut unserer Datenbank hast du seit dem #{moment(@lentat()).format("ll")} den Ordner #{@folder().name()} ausgeliehen.%0A "+
        "%0A "+
        "Das ist generell auch noch kein großes Problem. Allerdings haben wir nur wenige Ordner, die %0A "+
        "eigentlich nur zum Kopieren ausgeliehen werden sollten. Deswegen wäre es schön, wenn du ihn %0A "+
        "bald wieder zurückbringst :))%0A "+
        "%0A "+
        "Falls du von dieser Mail unglaublich verwirrt bist, weil du dich nicht erinnern kannst, jemals %0A "+
        "einen solchen Ordner ausgeliehen zu haben, sag uns, dass wir wohl der falschen Person %0A "+
        "geschrieben habe ;)%0A "+
        "%0A "+
        "Viele Grüße%0A "+
        "Deine Fachschaft-MathPhys"