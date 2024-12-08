require 'json'

# Substitua o caminho do arquivo pelo caminho do seu arquivo JSON local
file_path = 'data/exercise.json'

# Função para renomear arquivos
def rename_file(file)
  file_rename = file.gsub(/\d+/, ' ').gsub('_', ' ').gsub('-', ' ').strip
  file_rename.split.map(&:capitalize).join(' ')
end

# Função para processar os exercícios
def process_exercises(exercises)
  if exercises['data'].is_a?(Array)
    original_exercises = exercises['data']

    unique_exercises = original_exercises.uniq { |exercise| exercise['id'] }

    total_original = original_exercises.size
    total_unique = unique_exercises.size

    puts "Total de registros originais: #{total_original}"
    puts "Total de registros únicos: #{total_unique}"

    saved_count = 0

    unique_exercises.each do |exercise|
      # Extrair o nome do arquivo da URL e remover a extensão .png
      img_name = exercise['image_name'] ? File.basename(URI.parse(URI::DEFAULT_PARSER.escape(exercise['image_name'])).path).sub('.png', '') : nil
      vdo_name = exercise['video_file'] ? File.basename(URI.parse(URI::DEFAULT_PARSER.escape(exercise['video_file'])).path).sub('.mp4', '') : nil
      # vdo_name = img_name # Atribuir o nome base de image_name ao video_name

      video_name = rename_file(vdo_name) if vdo_name
      image_name = rename_file(img_name) if img_name

      puts "video name: #{video_name}"
      puts "image name: #{image_name}"

      exercise_instance = Exercise.new(
        name: exercise['name'],
        video_name: exercise['video_name'],
        image_name: img_name,
        exercise_type: exercise['exercise_type'],
        instructions: "default",
        video_url: vdo_name,
        is_favorite: exercise['is_favorite'],
        equipaments: exercise['equipments'] || [],
        num_exercises: exercise['num_exercises'],
        # target_muscles_id: exercise['Target_muscles_id'],
        # synergist_muscles_id: exercise['Synergist_muscles_id'],
        # body_part_id: exercise['body_part_id'],
        # video_file: exercise['video_file']
      )

      puts exercise_instance

      if exercise_instance.save
        puts "Exercício #{exercise_instance.name} salvo com sucesso."
        saved_count += 1
      else
        puts "Erro ao salvar exercício: #{exercise_instance.errors.full_messages.join(', ')}"
      end
    end

    puts "Total de registros salvos: #{saved_count}"
    puts "Processamento completo."

  else
    puts "Erro: 'data' não encontrado ou não é um array."
  end
end

# Função para ler o arquivo JSON com tentativas de reconexão
def read_json_with_retries(file_path, max_retries = 3)
  retries = 0

  begin
    file_content = File.read(file_path)
    exercises = JSON.parse(file_content)
    process_exercises(exercises)
  rescue Errno::ENOENT => e
    puts "Erro ao ler o arquivo: #{e.message}"
  rescue JSON::ParserError => e
    puts "Erro ao analisar o JSON: #{e.message}"
  end
end

# Chama a função para ler o arquivo JSON
read_json_with_retries(file_path)


require 'fileutils'
require 'pathname'
require_relative '../config/environment'
require_relative '../app/models/exercise'

=begin
  função para fazer o upload de arquivos
  tera que ir na pasta data/downloads/images e data/downloads/videos
  renomear os arquivos dessas pastas.
  depois ele ira fazer um each na pasta e em arquivo por arquivo 
  ira fazer um find_by para encontrar o exercicio e fazer o attach
  sabendo que o nome do arquivo é o mesmo do exercicio e o campo do upload 
  has_one_attached :image_file
  has_one_attached :video_file
=end

# def upload_files
#   FileUtils.cd('data/downloads/videos')
#   Dir.glob('*').each do |file|
#   #  new_filename = file.gsub(/\d+/, ' ').gsub('_', ' ').gsub('-', ' ').strip
#   #  new_filename = new_filename.split.map(&:capitalize).join(' ') + "4" # video
#   #  #new_filename = new_filename.split.map(&:capitalize).join(' ') # imagem
#   #  File.rename(file, new_filename)
#   #  puts "Renomeando arquivo: #{file} para #{new_filename}"
#     exercise = Exercise.find_by(video_name: file)
#     if exercise
#       exercise.video.attach(io: File.open(file), filename: file)
#       puts "Arquivo #{file} anexado ao exercício #{exercise.name}"
#     else
#       puts "Exercício não encontrado para o arquivo #{file}"
#     end
#   end   
# end


# def upload_files
#   # Mude para o diretório especificado
#   video_directory = 'data/downloads/videos'
#   return unless Dir.exist?(video_directory)

#   FileUtils.cd(video_directory) do
#     Dir.glob('*.mp4').each do |file|
#       next unless File.file?(file) # Certifique-se de que é um arquivo e não um diretório

#       # Remove a extensão do arquivo para buscar pelo nome do exercício
#       file_name_without_extension = File.basename(file, '.mp4')
#       puts file_name_without_extension
#       # Procure o exercício pelo nome do arquivo sem a extensão
#       exercise = Exercise.find_by(video_url: file_name_without_extension)

#       if exercise
#         begin
#           # Anexe o arquivo ao exercício
#           file_path = File.join(Dir.pwd, file) # Caminho absoluto do arquivo
#           exercise.video_file.attach(io: File.open(file_path), filename: file)
#           puts "Arquivo #{file} anexado ao exercício #{exercise.name}"
#         rescue => e
#           puts "Erro ao anexar o arquivo #{file}: #{e.message}"
#         end
#       else
#         puts "Exercício não encontrado para o arquivo #{file}"
#       end
#     end
#   end
# end
# 

# def upload_files
#   # Mude para o diretório especificado
#   video_directory = 'data/downloads/images'
#   return unless Dir.exist?(video_directory)

#   FileUtils.cd(video_directory) do
#     Dir.glob('*.png').each do |file|
#       next unless File.file?(file) # Certifique-se de que é um arquivo e não um diretório

#       # Remove a extensão do arquivo para buscar pelo nome do exercício
#       file_name_without_extension = File.basename(file, '.png')
#       puts file_name_without_extension
#       # Procure o exercício pelo nome do arquivo sem a extensão
#       exercise = Exercise.find_by(image_name: file_name_without_extension)

#       if exercise
#         begin
#           # Anexe o arquivo ao exercício
#           file_path = File.join(Dir.pwd, file) # Caminho absoluto do arquivo
#           exercise.image_file.attach(io: File.open(file_path), filename: file)
#           puts "Arquivo #{file} anexado ao exercício #{exercise.name}"
#         rescue => e
#           puts "Erro ao anexar o arquivo #{file}: #{e.message}"
#         end
#       else
#         puts "Exercício não encontrado para o arquivo #{file}"
#       end
#     end
#   end
# end
# 
# require 'open-uri'

# def upload_files
#   primary_muscles = File.open('data/downloads/primary_muscles.txt').readlines.map(&:chomp)
#   secondary_muscles = File.open('data/downloads/secondary_muscles.txt').readlines.map(&:chomp)
#   bodys = File.open('data/downloads/bodys.txt').readlines.map(&:chomp)

#   # Baixando arquivos para músculos primários
#   primary_muscles.each_with_index do |url, index|
#     output_path = "data/downloads/primary_muscle_#{index + 1}.webp"
#     download_file(url, output_path)
#     puts "Músculo primário: #{url} baixado e salvo em #{output_path}"
#   end

#   # Baixando arquivos para músculos secundários
#   secondary_muscles.each_with_index do |url, index|
#     output_path = "data/downloads/secondary_muscle_#{index + 1}.webp"
#     download_file(url, output_path)
#     puts "Músculo secundário: #{url} baixado e salvo em #{output_path}"
#   end

#   # Baixando arquivos para partes do corpo
#   bodys.each_with_index do |url, index|
#     output_path = "data/downloads/body_#{index + 1}.webp"
#     download_file(url, output_path)
#     puts "Parte do corpo: #{url} baixado e salvo em #{output_path}"
#   end
# end

# def download_file(url, output_path)
#   begin
#     URI.open(url) do |file|
#       File.open(output_path, 'wb') do |output|
#         output.write(file.read)
#       end
#     end
#   rescue StandardError => e
#     puts "Erro ao baixar o arquivo de #{url}: #{e.message}"
#   end
# end

# # Exemplo de uso:
# upload_files


def upload_files
  # Mude para o diretório especificado
  # primary_directory = 'data/downloads/primary_muscles'
  primary_directory = 'data/downloads/secondary_muscles'
  return unless Dir.exist?(primary_directory)

  FileUtils.cd(primary_directory) do
    Dir.glob('*.webp').each do |file|
      puts "Arquivos encontrados: #{Dir.glob('*.webp').inspect}"
      next unless File.file?(file) # Certifique-se de que é um arquivo e não um diretório

      # Remove a extensão do arquivo para buscar pelo nome do exercício
      file_name_without_extension = File.basename(file, '.webp')
      puts file_name_without_extension
      
      # primary_muscle = TargetMuscle.create(name: file_name_without_extension)
      primary_muscle = SynergistMuscle.create(name: file_name_without_extension)
      unless primary_muscle.persisted?
        puts "Erro ao criar TargetMuscle: #{primary_muscle.errors.full_messages.join(', ')}"
      end


      if primary_muscle
        begin
          # Anexe o arquivo ao exercício
          file_path = File.join(Dir.pwd, file) # Caminho absoluto do arquivo
          primary_muscle.muscule_file.attach(io: File.open(file_path), filename: file)
          puts "Arquivo #{file} anexado ao exercício #{primary_muscle.name}"
        rescue => e
          puts "Erro ao anexar o arquivo #{file}: #{e.message}"
        end
      else
        puts "Exercício não encontrado para o arquivo #{file}"
      end
    end
  end
end
upload_files