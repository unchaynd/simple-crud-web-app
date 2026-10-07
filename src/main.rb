require 'sinatra'
require 'coffee-script'

require_relative 'database'

## render the list of tables
get '/' do
	haml :schema
end

## create table
get '/new' do
	haml :create_table
end

post '/new' do
	name = SafeString.lift(params[:name])
	columns = Hash.new { |hash, key| hash[key] = {} }
	params.each_pair do |key, val|
		case key
		when /\Acol-([0-9]+)-name\z/
			columns[$1.to_i][:name] = SafeString.lift(val)
		when /\Acol-([0-9]+)-type\z/
			columns[$1.to_i][:type] = val
		end
	end
	DB.create_table(name, columns.values)
	redirect to("/table/#{name}")
end

## read table
get '/table/:name' do |name|
	data = DB.read_table(name)
	return 404 if not data
	haml :read_table, locals: {name: , data: }
end

## update table
get '/table/:name/edit' do |name|
	haml :blank
end

post '/table/:name/edit' do |name|
	haml :blank
end

## destroy table
get '/table/:name/delete' do |name|
	haml :destroy_table, locals: {name: }
end

post '/table/:name/delete' do |name|
	if params.has_key? 'confirmed'
		DB.destroy_table(name)
		redirect to('/')
	else
		redirect to('/table/%s' % name)
	end
end

## create entry
get '/table/:name/new' do |name|
	columns = DB.read_table_columns(name)
	return 404 if not columns
	haml :create_entry, locals: {name: , columns: }
end

post '/table/:name/new' do |name|
	DB.create_row(name, params.except(:name).transform_keys {_1.delete_prefix 'entry-'} )
	redirect to('/table/%s' % name)
end

## read entry
get '/table/:name/entry/:id' do |name, id|
	haml :blank
end

## update entry
get '/table/:name/entry/:id/edit' do |name, id|
	haml :blank
end
post '/table/:name/entry/:id/edit' do |name, id|
	haml :blank
end

## destroy entry
post '/table/:name/entry/:id/delete' do |name, id|
	haml :blank
end

get '/:name.js' do |base_name|
	coffee_name = "coffeescript/#{base_name}.coffee"
	return 404 if not File.exist? coffee_name
	content_type 'text/javascript'
	js_name = "javascript/#{base_name}.js"
	return File.read(js_name) if File.exist?(js_name) and File.mtime(js_name) > File.mtime(coffee_name)
	js_code = CoffeeScript.compile File.read(coffee_name)
	File.write js_name, js_code
	js_code
end
