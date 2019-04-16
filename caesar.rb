require 'sinatra'
require 'sinatra/reloader' if development?

def encrypt(phrase,shift)
  chars = phrase.split('')
  new = []
  chars.each do |c| new.push(convert(c,shift)) end
  return new.join
end

def convert(c,shift)
  if !/[A-Z]/.match(c).nil?
    #uppercase
    base_char = "A"
  elsif !/[a-z]/.match(c).nil?
    #lowercase
    base_char = 'a'
  else
    return c
  end
  shifted_num = ((c.ord-base_char.ord) + shift) % 26
  shifted_char = (shifted_num+base_char.ord).chr
  return shifted_char
end

shift = 0

get '/' do
  phrase,shift = params['phrase'],params['shift'].to_i
  encrypted = encrypt(phrase,shift) if !phrase.nil?
  erb :index, :locals => {:encrypted => encrypted}
end
