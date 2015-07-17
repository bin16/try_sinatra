require 'sqlite3'

class DBManager
	@db
	@user
	def initialize
		@db="t2_db.db"
		@user = "user_table"
	end
	def create_table_user
		sql = "CREATE TABLE IF NOT EXISTS #{@user} (
			id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
			mail VARCHAR NOT NULL,
			name VARCHAR,
			sign VARCHAR,
			about TEXT,
			pass VARCHAR NOT NULL,
			island_id TINYINT,
			status TINYINT NOT NULL,
			regtime DATETIME NOT NULL,
			logtime DATETIME,
			key TEXT
		);"
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end
	end # create_table_user

	def user_new(mail,pass,status,regtime)
		sql = "INSERT INTO #{@user} (
			mail,
			pass,
			status,
			regtime
			)  
			VALUES ('#{mail}','#{pass}',#{status},'#{regtime}');"

		# puts sql
			
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end
	end # user_new

	def is_user_mail_repeat(mail)
		sql = "SELECT id FROM #{@user} WHERE mail = '#{mail}'"
		SQLite3::Database.open @db do |db|
			b = db.execute(sql)
			if b.length == 0
				return false
			else
				return true
			end
		end
	end # is_user_mail_repeat(mail)

	def is_user_pass_correct(mail,pass) 
		sql = "SELECT id FROM #{@user} WHERE mail = '#{mail}' AND pass = '#{pass}';"
		SQLite3::Database.open @db do |db|
			b = db.execute(sql)
			if b.length == 0
				return false
				# return -1
			else
				return true
				# return b[0][0]
			end
		end
	end # end is_user_pass_correct

	def user_mail_sent(mail)
		sql = "UPDATE #{@user} SET status = -1 WHERE mail = '#{mail}';"
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end
	end # end user_mail_sent

	def user_status_update(mail,status)
		sql = "UPDATE #{@user} SET status = '#{status}' WHERE mail = '#{mail}';"
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end
	end # end user_mail_sent

	def user_data_set(id,name,sign,about)
		sql = "UPDATE #{@user} SET 
					name = '#{name}',
					sign = '#{sign}',
					about = '#{about}'
				WHERE id = #{id};"
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end
	end

	def user_logtime_update(mail,logtime,id=0)
		sql = "UPDATE #{@user} SET 
					logtime = '#{logtime}'
				WHERE mail = '#{mail}' OR id = #{id};"
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end
	end # end user_logtime_update

	def user_mail_confirmed(mail)
		sql = "UPDATE #{@user} SET 
					status = #{0}
				WHERE mail = '#{mail}';"
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end
	end

	def user_pass_changed(mail,pass,id=0)
		sql = "UPDATE #{@user} SET 
					pass = '#{pass}'
				WHERE mail = '#{mail}'
				OR id = #{id};"
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end

	end

	def user_key_save(mail,key)
		sql = "UPDATE #{@user} SET 
					key = '#{key}'
				WHERE mail = '#{mail}';"
		SQLite3::Database.open @db do |db|
			db.execute(sql)
		end	
	end

	def is_user_key_correct(mail,key)
		sql = "SELECT id FROM #{@user} WHERE mail = '#{mail}' AND key = '#{key}';"
		SQLite3::Database.open @db do |db|
			b = db.execute(sql)
			if b.length == 0
				return false
			else
				return true
			end
		end
	end

	def get_user_data(mail,id=0)
		sql = "SELECT status,name,sign,about FROM '#{@user}' WHERE mail = '#{mail}' OR id = #{id}"
		SQLite3::Database.open @db do |db|
			b = db.execute(sql)
			return b[0]
		end		
	end

	def get_user_name

	end

	def get_user_sign

	end

	def get_user_about
		
	end

	def get_user_status(mail,id=0)

	end

	def user_offline(id,email)
		# no use
	end

	def user_online(id,email)
		# no use
	end
end

# a = DBManager.new
# a.create_table_user
# a.user_new("abc2@Sabc.com","xxx",-2,"2015-07-11 12:20:10")
# p a.is_user_mail_repeat("abc@abc.com")

# a = DBManager.new
# p a.user_mail_sent("abc@absssc.com");
# p a.user_data_set(1,"书","喜欢读书","读书");
# p a.user_logtime_update(1,"2015-07-16 19:45:09");
# p a.user_mail_confirmed("abc@abc.com");
# p a.user_pass_changed("asdf","0","abc@abc.com")
# p a.user_key_save("abc@abc.com","2a18c53b1fd1ad5cbf4ea407ac8e5c95")
# p a.is_user_key_correct("abc@abc.com","2a18c53b1fd1ad5cbf4ea407ac8e5c95")

