# Adapter パターン

class Adapter
  def initialize(conn)
    @conn = conn
  end
end

class Adapter::M < Adapter
  def execute(sql)
    @conn.exec(sql)
  end
end
class Adapter::P < Adapter
  def execute(sql)
    @conn.execute_query(sql)
  end
end
class Adapter::S < Adapter
  def execute(sql)
    @conn.exec_sql(sql)
  end
end

class MultiInsert
  def initialize(table, rows)
    @table = table
    @rows = rows
  end
end
class MultiInsert::MultipleQueries < MultiInsert
  def format_sqls
    prefix = "INERT INTO #{@table} VALUES ("
    @rows.map do |row|
      ["#{prefix}#{row.join(', ')})"]
    end
  end
end
class MultiInsert::SingleQuery < MultiInsert
  def format_sqls
    sql = "INSERT INTO #{@table} VALUES "
    first_row, *rows = @rows
    sql << "(#{first_row.join(', ')})"
    rows.each do |row|
      sql << ", (#{row.join(', ')})"
    end
    [sql]
  end
end

pp MultiInsert::MultipleQueries.new('a', [[1], [2]]).format_sqls
# => [["INERT INTO a VALUES (1)"], ["INERT INTO a VALUES (2)"]]
pp MultiInsert::SingleQuery.new('a', [[1], [2]]).format_sqls
# => ["INSERT INTO a VALUES (1), (2)"]

class Adapter
  def multi_insert(table, rows)
    sqls = multi_insert_strategy.new(table, rows).format_sqls
    sqls.each do |sql|
      execute(sql)
    end
  end

  private

  def multi_insert_strategy
    MultiInsert::MultipleQueries
  end
end

class Adapter::P
  private

  def multi_insert_strategy
    MultiInsert::SingleQuery
  end
end
