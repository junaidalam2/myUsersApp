require 'sqlite3'
   
db = SQLite3::Database.open "db.sql"
db.execute "CREATE TABLE IF NOT EXISTS users(firstname TEXT, lastname TEXT, age INT, password TEXT, email TEXT)"


class User
    @@db = SQLite3::Database.open "db.sql"
    @@db.execute "CREATE TABLE IF NOT EXISTS users(firstname TEXT, lastname TEXT, age INT, password TEXT, email TEXT)"
    
    def self.create(user_info_hash)
        begin
            @@db = SQLite3::Database.open "db.sql"
            @@db.execute "INSERT INTO users(firstname, lastname, age, password, email) VALUES(?, ?, ?, ?, ?)", [user_info_hash['firstname'], user_info_hash['lastname'], user_info_hash['age'], user_info_hash['password'], user_info_hash['email']]
        rescue SQLite3::Exception => e 
            puts "Exception has occured"
            return nil
        ensure
            @id = @@db.last_insert_row_id
            @@db.close if @@db
            return @id
        end

    end


    def self.find(object_id)
        begin
            @@db = SQLite3::Database.open "db.sql"
            @@db.results_as_hash = true    
            user_record_hash = @@db.execute "SELECT * FROM users WHERE rowid = ?", object_id.to_i
        rescue SQLite3::Exception => e 
            puts "Exception occurred"
            return nil
        ensure
            @@db.close
        end
            
        return user_record_hash
        
    end


    def self.all()
        begin
            @@db = SQLite3::Database.open "db.sql"
            @@db.results_as_hash = true
            all_users_hash = @@db.execute "SELECT * from users"
        rescue SQLite3::Exception => e 
            puts "Exception occurred"
            return nil
        ensure
            @@db.close
        end
        
        return all_users_hash

    end 


    def self.all_with_rowid()
        begin
            @@db = SQLite3::Database.open "db.sql"
            @@db.results_as_hash = true
            all_users_hash = @@db.execute "SELECT rowid, * from users"
        rescue SQLite3::Exception => e 
            puts "Exception occurred"
            return nil
        ensure
            @@db.close
        end
        
        return all_users_hash

    end


    def self.update(user_id, attribute, value)
        begin
            @@db = SQLite3::Database.open "db.sql"
            @@db.execute "UPDATE users SET '#{attribute}' = '#{value}' WHERE rowid = #{user_id}"
        rescue SQLite3::Exception => e 
            puts "Exception occurred"
            return nil
        ensure        
            @@db.close if @@db
        end
        return self.find(user_id)
    end 


    def self.destroy(object_id)
        begin
            @@db = SQLite3::Database.open "db.sql"
            @@db.execute "DELETE FROM users WHERE rowid = ?", object_id.to_i
        rescue SQLite3::Exception => e 
            puts "Exception occurred"
            return nil
        ensure    
            @@db.close
        end

    end


    def self.authenicate_login(email, password)
        begin
            @@db = SQLite3::Database.open "db.sql"
            id = @@db.execute "SELECT rowid FROM users WHERE email = ? AND password = ?", [email, password]
        rescue SQLite3::Exception => e 
            puts "Exception occurred"
            return nil
        ensure
            @@db.close
        end
            
        return id[0][0]

    end

end

# user_info = ['firstname', 'lastname', 200, 'password', 'email']
#  new_user_hash = {'firstname' => 'FN2', 'lastname' => 'LN2', 'age' => 3000, 'password' => 'PW1', 'email' => 'EM2'}
# user = User.new(new_user_hash)
# puts User.find(5)
# puts User.update(1, 'age', '153')
# puts User.all()
# puts User.all_with_rowid()
# puts User.authenicate_login('email@test.com7', 'passwordtest7')
# puts User.firstname