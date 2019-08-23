  require "pry"
def consolidate_cart(cart)
  carthash = Hash.new
  countarray = cart.each do |hash|
    hash[hash.keys.first][:count] = cart.count(hash)
    #binding.pry
  end
  countarray.each do |item|
    carthash[item.keys.first] = item.values.first
  end
  carthash
end

def apply_coupons(cart, coupons = [])
  coupon_cart = cart.clone
  cart.each do |item, value|
    coupons.each do |coupon|
      if coupon[:item] == item
        if coupon_cart["#{item} W/COUPON"] == nil 
            coupon_cart["#{item} W/COUPON"] ={}
        end
        if coupon_cart["#{item} W/COUPON"][:count] == nil
            coupon_cart["#{item} W/COUPON"][:count] = 0
        end
        coupon_cart[item][:count] = (cart[item][:count] % coupon[:num])
        coupon_cart["#{item} W/COUPON"][:price] = (coupon[:cost] / coupon[:num])
        coupon_cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
        coupon_cart["#{item} W/COUPON"][:count] += coupon[:num]
      end
    end
  end
  coupon_cart
end

def apply_clearance(cart)
  clearance_cart = cart.clone
  clearance_cart.each_key do |item|
    oldprice = cart[item][:price]
    if clearance_cart[item][:clearance]
      clearance_cart[item][:price] = oldprice - (oldprice / 5)
    end
  end
  clearance_cart
end


## CHECKOUT ##

def checkout(cart, coupons)
  total = 0
  
  def consolidate_cart(cart)
    carthash = Hash.new
    countarray = cart.each do |hash|
      hash[hash.keys.first][:count] = cart.count(hash)
      binding.pry
    end
    countarray.each do |item|
      carthash[item.keys.first] = item.values.first
    end
    carthash
  end
  
  cons_cart = consolidate_cart(cart)
  cons_cart.each_key do |item|
    total += (cons_cart[item][:price] * cons_cart[item][:count])
  end
  total
 binding.pry
end