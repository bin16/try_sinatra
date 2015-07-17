$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'digest'
require 'net/smtp'
require 'db.rb'
$auto_md5 = true
$s_mail = ""
$s_pass = ""




class SerAuth
	@mail
	@id
	@pass
	@passmd5
	@passsha1
	@now
	@time
	@status_register
	@status_to_confirm
	@status_confirmed
	@key
	@s_mail
	def initialize(mail)
		@mail = mail
		@now = Time.new
		@time = @now.strftime("%Y-%m-%d %H:%M:%S") 
		@status_register = -2
		@status_to_confirm = -1
		@status_confirmed = 0
		@s_mail = $s_mail
	end
	def md5a(str)
		if ($auto_md5==true)&&(str.length<32)
			# p "a"
			return md5(str)

		else
			# p "b"
			return str
		end
	end
	def md5(str)
		Digest::MD5.hexdigest(str);
	end
	def sha1(str)
		Digest::SHA1.hexdigest(str);
	end

	def reg(pass)
		@pass=md5a(pass)
		@passsha1 = self.sha1(@pass)
		db = DBManager.new
		if db.is_user_mail_repeat(@mail)==false
			db.user_new(@mail,@passsha1,@status_register,@time)
			return 1 
		else
			return -1 # mail repeat
		end
	end

	def log(pass)
		@pass=md5a(pass)
		@passsha1=sha1(@pass) 
		db = DBManager.new		
		if db.is_user_pass_correct(@mail,@passsha1)==true
			db.user_logtime_update(@mail,@time)
			return 1
		else
			return -1 #user/pass error
		end
	end

	def makeKey
		now = Time.new
		ran1 = rand(100000000)
		ran2 = rand(1000)*rand(1000)
		a = @now.to_s
		b = ran1.to_s
		c = ran2.to_s
		t = a+b+c;
		s = md5(t);
		return s
	end

	def sendMail(toAddr,fromAddr,subject,content)
		message=<<MESSAGE_END
From: Me <#{fromAddr}>
To: A Test User <#{toAddr}>
Subject: #{subject}

#{content}
MESSAGE_END
# puts message

		Net::SMTP.start("smtp.qq.com",25,"localhost","#{$s_mail}","#{$s_pass}",:plain) do |smtp|
			smtp.send_message message,fromAddr,toAddr
		end
	end

	def preConfirm
		@key = makeKey
		db = DBManager.new
		db.user_key_save(@mail,@key)

		sendMail(@mail,@s_mail,"Security Confirm",@key)
		db.user_status_update(@mail,@status_to_confirm)
		@key
	end

	def confirm(key)
		db = DBManager.new
		if db.is_user_key_correct(@mail,key)
			db.user_status_update(@mail,@status_confirmed)
			return 1
		else
			return -1
		end
	end

end # end SerAuth



class SerUser
	@id
	@status
	@mail
	@name
	@sign
	@about
	def initialize(mail,id=0)
		@mail = mail
		@id = id
		db = DBManager.new
		data = db.get_user_data(@mail,@id)
		@status = data[0]
		@name = data[1]
		@sign = data[2]
		@about = data[3]
	end
	def saveNewData(sign)

	end


	def putsAll
		p @id
		p @mail
		p @name
		p @sign
		p @about
		p @status
	end 

end

