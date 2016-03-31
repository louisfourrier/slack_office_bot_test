class SlackCommunication
  require "net/http"
  require "uri"
  require "json"

  URL_AFFREUX = "https://hooks.slack.com/services/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"


  def self.send_webhook(url, payload)
    uri = URI.parse(url.to_s)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(payload)
    response = http.request(request)
  end

  # Send a message on a particular Channel with an API code for the URL of destination
  def self.webhook_send_test
    string = "Alerte sur nos serveurs. Test des Webhooks, alertes serveur vers Slack pour toutes les notifications"

  payload = {
    "payload" => {
        text: string, # Text to be sent link into the string
        username: "LouisTestAlertMessage", # Change the username name
        channel: "#general", # For direct message or public channels
        icon_emoji: ":ghost:",
        attachments: [
          {
              fallback: "Required plain-text summary of the attachment.",
              color: "#36a64f",
              pretext: "On va tester des messages Stylés",
              author_name: "Plus beau culs du monde",
              author_link: "http://www.mensquare.com/avionsdechasse/",
              author_icon: "http://angeoudemongif.a.n.pic.centerblog.net/d3e42620.gif",
              title: "Nouveau site pour les affreux (Title)",
              title_link: "http://www.mensquare.com/avionsdechasse/avions/?type=avion&id=100762",
              text: "Avion exceptionnel",
              image_url: "http://i0.wp.com/public.avionsdechasse.org/images/sources/2016/03/20160310153704_97.jpg",
              thumb_url: "http://i0.wp.com/public.avionsdechasse.org/images/sources/2016/03/20160310153704_97.jpg",

              fields: [
               {
                   title: "ID",
                   value: "678",
                   short: true
               },
               {
                   title: "Rendez-vous",
                   value: "louis.fourrier@gmail.com",
                   short: true
               },
               {
                   title: "Votre Rendez-vous est dans 15 minutes",
                   value: "Avec Office Bot ne ratez aucun rdv",
                   short: false
               }
             ],
          }
      ]
        }.to_json
    }

    self.send_webhook(URL_AFFREUX, payload)

  end



  def self.basic_request
    string = Restaurant.first.name + " A very important thing has occurred! <https://alert-system.com/alerts/1234|Click here> for details!"

  parms_form = {
    "payload" => {
        text: string, # Text to be sent link into the string
        username: "reservationbtoname", # Change the username name
        channel: "#general", # For direct message or public channels

        attachments: [
          {
              fallback: "Required plain-text summary of the attachment.",
              color: "#36a64f",
              pretext: "Optional text that appears above the attachment block",
              author_name: "Bobby Tables",
              author_link: "http://flickr.com/bobby/",
              author_icon: "http://angeoudemongif.a.n.pic.centerblog.net/d3e42620.gif",
              title: "Slack API Documentation",
              title_link: "https://api.slack.com/",
              text: "Optional text that appears within the attachment",
              image_url: "http://www.online-image-editor.com//styles/2014/images/example_image.png",
              thumb_url: "http://www.online-image-editor.com//styles/2014/images/example_image.png",

              fields: [
               {
                   title: "ID",
                   value: "678",
                   short: true
               },
               {
                   title: "EMAIL",
                   value: "louis.fourrier@gmail.com",
                   short: true
               },
               {
                   title: "Reservations",
                   value: "300 réservations effectuées par le client",
                   short: false
               }
             ],
          }
      ]
        }.to_json
    }

  uri = URI.parse('https://hooks.slack.com/services/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')
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.request_uri)
  request.set_form_data(parms_form)

  response = http.request(request)
  end

  def self.handle_commands(params)
    command = params["command"]
    query = params["text"]
    response_url = params["response_url"]

    id = query.to_i
    user = User.find_by(id: id)
    if user
      link =  Rails.application.routes.url_helpers.administration_user_url(user)
      string = ">L'utilisateur avec un id *" + id.to_s + "* est incrit sur Happy Dining. >>> Son email est _" + user.email + "_ Accès au BO : <" + link + ">>> (service fournit par *HD on Slack*)"
      Slackcommunication.answer_command(string, response_url)
    else
      string = "Pas le bon format. Il y a " + User.count.to_s + " utilisateurs *Happy Dining*. _Entrez un ID valide_"
      Slackcommunication.answer_command(string, response_url)
    end
    return
  end

  def self.answer_command(message, url)
    string = message

    parms_form = {
    "payload" => {
        text: string, # Text to be sent link into the string
        username: "commandanswer",
        mrkdwn: true
      }
    }

    uri = URI.parse(url.to_s)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(parms_form)

    response = http.request(request)
  end


  ## FOR HAPPY DINING

  def self.send_json_notification(json)
    parms_form = {
    "payload" => json.to_json
    }

    uri = URI.parse('https://hooks.slack.com/services/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')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data(parms_form)

    response = http.request(request)
  end


end
