# try_sinatra

Learning Ruby, Sinatra, and SQLite3 and More

--------------

Files

`main.rb`
```
#
```
`db.rb`

``` ruby
class DBManager # wait to update
  @db
  @user

  def initialize
    @db="t2_db.db"
    @user = "user_table"
  end

  def create_table_user
  end # create_table_user

  def user_new(mail,pass,status,regtime)
  end # user_new

  def is_user_mail_repeat(mail)
  end # is_user_mail_repeat(mail)

  def is_user_pass_correct(mail,pass) # replaced by user_status_update
  end # end is_user_pass_correct

  def user_mail_sent(mail) # replaced by user_status_update
  end # end user_mail_sent

  def user_status_update(mail,status)
  end # end user_mail_sent

  def user_data_set(id,name,sign,about)
  end

  def user_logtime_update(mail,logtime,id=0)
  end # end user_logtime_update

  def user_mail_confirmed(mail)
  end

  def user_pass_changed(mail,pass,id=0)
  end

  def user_key_save(mail,key)
  end

  def is_user_key_correct(mail,key)
  end

  def get_user_data(mail,id=0)
  end

  # other methods

end #end class DBManager
```


`service.rb`

``` ruby
class SerAuth
  # wait to update
end

class SerUser
  # wait to update
end
```
