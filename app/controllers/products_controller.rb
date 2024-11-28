class ProductsController < ApplicationController
    # Переконуємося, що користувач залогінений перед доступом до дій
    before_action :authenticate_user!
    # Авторизуємо адміністратора для захищених дій
    before_action :authorize_admin, except: %i[index show]
    # Знаходимо товар перед виконанням відповідних дій
    before_action :set_product, only: %i[show edit update destroy]

    before_action :authorize_admin, only: [:destroy]
  
    # GET /products
    def index
      @products = Product.all
    end
  
    # GET /products/:id
    def show
    end
  
    # GET /products/new
    def new
      @product = Product.new
    end
  
    # POST /products
    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to @product, notice: 'Товар успішно створено.'
      else
        render :new, status: :unprocessable_entity
      end
    end
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
      redirect_to products_path, notice: 'Товар видалено.'
    end
    
  
    # GET /products/:id/edit
    def edit
    end
  
    # PATCH/PUT /products/:id
    def update
      if @product.update(product_params)
        redirect_to @product, notice: 'Товар успішно оновлено.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    # DELETE /products/:id
    def destroy
      @product.destroy
      redirect_to products_url, notice: 'Товар видалено.'
    end
  
    private
  
    # Перевіряє, чи користувач є адміністратором
    def authorize_admin
      unless current_user&.admin?
        redirect_to products_path, alert: 'У вас немає прав для цієї дії.'
      end
    end
  
    # Знаходить товар за id
    def set_product
      @product = Product.find(params[:id])
    end
  
    # Перелік дозволених параметрів
    def product_params
      params.require(:product).permit(:name, :description, :price, :stock, :image)
    end
  end
  