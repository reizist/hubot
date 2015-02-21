module.exports = (robot) ->
  robot.respond /(\S+)/i, (msg) ->
    if msg.message.match(/^@/)
      query = msg.match[1]
      user_name = msg.message.user.name
      API_KEY = process.env.HUBOT_DOCOMO_DIALOGUE_API_KEY
      url = "https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=#{API_KEY}"

      KEY_DOCOMO_CONTEXT = 'docomo_talk_context'
      context = robot.brain.get KEY_DOCOMO_CONTEXT || ''
      robot.http(url).post(JSON.stringify({
        utt: query
        nickname: user_name if user_name
        context: context if context
      })) (err, response, body) ->
        res = JSON.parse(body)
        robot.brain.set KEY_DOCOMO_CONTEXT, res.context
        if err?
          msg.send "Encountered an error #{err}"
        else
          msg.send "@#{user_name} #{res.utt}"
