class Admin::TipsController < Admin::AdminController
  # GET /tips
  # GET /tips.json
  def index
    @tips = Tip.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tips }
    end
  end

  # GET /tips/1
  # GET /tips/1.json
  def show
    @tip = Tip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tip }
    end
  end

  # GET /tips/new
  # GET /tips/new.json
  def new
    @tip = Tip.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tip }
    end
  end

  # GET /tips/1/edit
  def edit
    @tip = Tip.find(params[:id])
  end

  # POST /tips
  # POST /tips.json
  def create
    @tip = Tip.new(params[:tip])

    # if this tip is published make all other tips unpublished
    if @tip.published
      Tip.all.each do |tip|
        tip.published = false
        tip.save
      end
    end

    respond_to do |format|
      if @tip.save
        format.html { redirect_to admin_tip_url(@tip.id), notice: 'Tip was successfully created.' }
        format.json { render json: @tip, status: :created, location: @tip }
      else
        format.html { render action: "new" }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tips/1
  # PUT /tips/1.json
  def update
    @tip = Tip.find(params[:id])

    respond_to do |format|
      if @tip.update_attributes(params[:tip])

        # if this tip is published make all other tips unpublished
        if @tip.published
          Tip.all.each do |tip|
            if !tip.id.eql?(@tip.id)
              tip.published = false
              tip.save
            end
          end
        end

        format.html { redirect_to admin_tip_url(@tip.id), notice: 'Tip was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tips/1
  # DELETE /tips/1.json
  def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy

    respond_to do |format|
      format.html { redirect_to admin_tips_url }
      format.json { head :no_content }
    end
  end
end
