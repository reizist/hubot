module.exports = (robot) ->
  API_KEY = process.env.HUBOT_DOCOMO_DIALOGUE_API_KEY

  robot.respond /(news) (.*)?/i, (msg) ->
    command = msg.match[2]
    if (command != 'genre' && command != 'list')
      msg.send "Usage: \n news genre: getting genreId \n news list genreId: getting news of the genre"

  robot.respond /(news) (genre)/i, (msg) ->
    url = "https://api.apigw.smt.docomo.ne.jp/webCuration/v3/genre?APIKEY=#{API_KEY}&lang=ja"

    robot.http(url).get() (err, response, body) ->
      res = JSON.parse(body)
      if err?
        msg.send "Encountered an error #{err}"
      else
        str = ''
        for key,val of res.genre
          str += "#{val.title}: #{val.genreId}\n"
        msg.send str

  robot.respond /(news) (list) (.*)/i, (msg) ->
    genre_id = msg.match[3]
    url = "https://api.apigw.smt.docomo.ne.jp/webCuration/v3/contents?APIKEY=#{API_KEY}&genreId=#{genre_id}&lang=ja"

    robot.http(url).get() (err, response, body) ->
      res = JSON.parse(body)
      if err?
        msg.send "Encountered an error #{err}"
      else
        str = ''
        for key,val of res.articleContents
          str += "#{val.contentData.title}: #{val.contentData.linkUrl}\n"
        msg.send str

