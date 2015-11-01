# hubot chousa assign id member gaiyou
# hubot chousa set [member list array]
# hubot chousa get
module.exports = (robot) ->
  robot.respond /chousa (\S*)(\s(.*))*/i, (msg) ->
    CHOUSA_LIST_KEY = "chousa_base_lists"
    CHOUSA_TMP_KEY = "chousa_tmp_lists"

    command = msg.match[1]
    sub_command = msg.match[3]
    # debugging
    msg.send "entered command=#{command}, sub_command=#{sub_command}, list=#{robot.brain.get(CHOUSA_LIST_KEY)}"
    if command == "get"
      msg.send "#{robot.brain.get(CHOUSA_TMP_KEY) ? []}"
    else if command == "set"
      if typeof(sub_command) == 'undefined'
        msg.send "plz set members list"
        return

      list = sub_command.split(',') || []
      robot.brain.set(CHOUSA_LIST_KEY, list)
      robot.brain.set(CHOUSA_TMP_KEY, list)
      msg.send "setted #{list}"
    else if command == "assign"
      tmp_list = robot.brain.get(CHOUSA_TMP_KEY).concat() ? []
      msg.send "tmp_list = #{tmp_list}, length: #{tmp_list.length}"
      pick = msg.random(tmp_list)
      tmp_list.splice(tmp_list.indexOf(pick), 1)
      # tmpが空になったら再補充
      tmp_list = robot.brain.get(CHOUSA_LIST_KEY) if tmp_list.length <= 0
      robot.brain.set(CHOUSA_TMP_KEY, tmp_list)
      
      msg.send "assigned #{pick}"
