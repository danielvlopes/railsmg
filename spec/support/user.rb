User.class_eval do
  # User#fetch_projects! is called on save and we cant stub Kernel#open method
  def open *args
    File.open("#{Rails.root}/spec/support/sobrinho.github.yaml")
  end
end
