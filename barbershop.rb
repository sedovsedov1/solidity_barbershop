require 'sinatra'

get '/' do                                     # первый заход пользователя
	erb :index                                   # выводим вьюху для записи посещения
end

post '/' do                                    # post-заход пользователя (заполнил форму)
	@user_name = params[:user_name]              # сохранили имя пользователя
	@user_phone = params[:user_phone]            # сохранили телефон пользователя
	@date_time = params[:date_time]              # сохранили дату и время визита

	@title = "Thanks You"                        # заготовили приветствие и сообщение
	@message = "Dear #{@user_name}, we wait you #{@date_time}"

	f = File.open 'users.txt', 'a'               # открыли файл на дозапись (создание)
	f.write "User #{@user_name}, phone #{@user_phone}, date #{@date_time}\n"
	f.close                                      # записали строку и закрыли файл
	erb :message                                 # выводим вьюху для сообщения
end

get '/admin' do                                # заход пользователя как админа
	erb :admin                                   # выводим вьюху для ввода логина/пароля
end

post '/admin' do                               # post-заход пользователя (заполнил форму)
	@login = params[:login]                      # сохранили логин
	@password = params[:password]                # сохранили пароль
	if @login == 'admin' && @password == '1234'  # если все верно, то @file = данные из файла
		@file = File.open("./users.txt", "r")      # выводим вьюху с результатами
		erb :result
	else                                         # если все не верно, то готовим строку-ошибку
		@report = '<p>Error login or password. Try again...</p>'
		erb :admin                                 # выводим вьюху для ввода логина/пароля
	end
end
