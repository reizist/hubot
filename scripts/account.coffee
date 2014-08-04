module.exports = (robot) ->
  robot.respond /(account)( me)? (.*)/i, (msg) ->
    account = msg.match[3]

    accounts =
      reizist:
        mail: "reizist@gmail.com"
        github: "reizist"
        hipchat: "reizist"
      hogenuma:
        mail: "hoge@gmail.com"
        github: "hoge"
        hipchat: "hoge"
    for key of accounts
      if key == account
        infos = accounts[key]
        message = ""
        for key of infos
          message += "#{key} : #{infos[key]} "
        msg.send message
