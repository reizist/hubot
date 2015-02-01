module.exports = (robot) ->
  robot.respond /(talk|tk)( me)? (.*)/i, (msg) ->
    query = msg.match[3]
    user_name = msg.message.user.name
    API_KEY = process.env.HUBOT_DOCOMO_DIALOGUE_API_KEY
    url = "https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=#{API_KEY}"
    robot.http(url).post(JSON.stringify({
      utt: query
      nickname: user_name if user_name
    })) (err, response, body) ->
      if err?
        msg.send "Encountered an error #{err}"
      else
        msg.send JSON.parse(body).utt
