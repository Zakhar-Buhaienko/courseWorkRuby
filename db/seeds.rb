require 'open-uri'

# Очищення бази даних
# Order.destroy_all # якщо є таблиця замовлень, яка посилається на продукти чи користувачів
# DeliveryOption.destroy_all # очищаємо залежності
User.destroy_all
Product.destroy_all

# Створення тестових користувачів
admin = User.create!(
  email: 'admin@example.com',
  password: 'admin1',
  password_confirmation: 'admin1',
  admin: true
)

regular_user = User.create!(
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)
regular_user = User.create!(
  email: 'zakhar.buhaienko-ip213@nung.edu.ua',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

puts "Створено користувачів: #{User.count}"

# Шлях до локальних зображень
image_path = Rails.root.join('db/seeds/images')

# Створення продуктів
products = [
  { name: 'Хліб', description: 'Свіжий хліб із пекарні', price: 20, stock: 50, image_file: 'Хліб.jpeg' },
  { name: 'Баранина', description: 'Баран', price: 30, stock: 100, image_file: 'Баранина.jpeg' },
  { name: 'Яблука', description: 'Соковиті яблука Закарпаття', price: 80, stock: 30, image_file: 'Яблука.jpeg' },
  { name: 'Яйця', description: 'Дюжина свіжих яєць, 10шт', price: 50, stock: 60, image_file: 'Яйця.jpeg' },
  { name: 'Гречка', description: 'Гречка вищої якості, 1 кг', price: 45, stock: 80, image_file: 'Гречка.jpeg' },
  { name: 'Молоко', description: 'Молоко, 200 мл', price: 25, stock: 40, image_file: 'Молоко.jpeg' },
  { name: 'Чай', description: 'Чай чорний, 200 мл', price: 20, stock: 50, image_file: 'Чай.jpeg' },
  { name: 'Сік', description: 'Яблучний сік, 300 мл', price: 35, stock: 30, image_file: 'Сік.jpeg' },
  { name: 'Вода', description: 'Мінеральна вода, 500 мл', price: 15, stock: 100, image_file: 'Вода.jpeg' },
  { name: 'Лимонад', description: 'Домашній лимонад, 300 мл', price: 40, stock: 25, image_file: 'Лимонад.jpeg' }
]

products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    description: product_data[:description],
    price: product_data[:price],
    stock: product_data[:stock]
  )
  product.image.attach(
    io: File.open(image_path.join(product_data[:image_file])),
    filename: product_data[:image_file],
    content_type: 'image/jpeg'
  )
end

puts "Створено продукти: #{Product.count}"

# Створення напоїв
drinks = [
  { name: 'Молоко', description: 'Moloko, 200 мл', price: 25, stock: 40, image_file: 'Молоко.jpeg' },
  { name: 'Чай', description: 'Чай зелений, 200 мл', price: 20, stock: 50, image_file: 'tea.jpeg' },
  { name: 'Сік', description: 'Апельсиновий сік, 300 мл', price: 35, stock: 30, image_file: 'juice.jpeg' },
  { name: 'Вода', description: 'Мінеральна вода, 500 мл', price: 15, stock: 100, image_file: 'Вода.jpeg' },
  { name: 'Лимонад', description: 'Домашній лимонад, 300 мл', price: 40, stock: 25, image_file: 'lemonade.jpeg' }
]

drinks.each do |drink_data|
  drink = Product.create!(
    name: drink_data[:name],
    description: drink_data[:description],
    price: drink_data[:price],
    stock: drink_data[:stock]
  )
  drink.image.attach(
    io: File.open(image_path.join(drink_data[:image_file])),
    filename: drink_data[:image_file],
    content_type: 'image/jpeg'
  )
end

puts "Створено напої: #{Product.count - products.size}"

DeliveryOption.create!([
  { name: 'Стандартна доставка', price: 10.0 },
  { name: 'Експрес-доставка', price: 25.0 },
  { name: 'Доставка кур’єром', price: 15.0 }
])
