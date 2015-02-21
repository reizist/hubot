module.exports = (robot) ->
  robot.respond /(trend)(.*)/i, (msg) ->
    query = msg.match[2]
    API_KEY = process.env.HUBOT_DOCOMO_DIALOGUE_API_KEY
    url = "https://api.apigw.smt.docomo.ne.jp/webCuration/v3/search?APIKEY=#{API_KEY}&keyword=#{query}"

    robot.http(url).get() (err, response, body) ->
      res = JSON.parse(body)
      if err?
        msg.send "Encountered an error #{err}"
      else
        for key,val of res.articleContents
          msg.send val.contentData.title, val.contentData.linkUrl
