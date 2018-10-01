module Posts
  # Handles #create request in posts_controller.rb
  class PostCreateHandler
    include ActiveModel::Validations
    attr_reader :header, :content
    validates :header, :content, length: { minimum: 3 }

    def initialize(params)
      @header = params[:header]
      @content = params[:content]
      @ip = params[:ip]
      @login = params[:login]
      raise ArgumentError, errors.messages unless valid?
    end

    def call
      set_user
      set_poster_ip
      @post = Post.create(header: @header, content: @content, user: @user,
                          ip: @ip, poster_ip: @poster_ip)
      @post
    end

    private

    def set_user
      @user = User.find_or_create_by(login: @login)
    end

    def set_poster_ip
      @poster_ip = PosterIp.find_or_initialize_by(ip: @ip)
      return if !@poster_ip.new_record? &&
                @poster_ip.user_ids.include?(@user.id.to_s)

      @poster_ip.user_ids << @user.id.to_s
      @poster_ip.user_logins << @user.login
      @poster_ip.save
      @poster_ip
    end
  end
end
