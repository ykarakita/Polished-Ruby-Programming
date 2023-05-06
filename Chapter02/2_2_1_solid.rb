

# SOLID 原則
# SRP (Single Responsibility Principle) 単一責任の原則
# OCP (Open Closed Principle) オープン・クローズドの原則
# LSP (Liskov Substitution Principle) リスコフの置換原則
# ISP (Interface Segregation Principle) インターフェース分離の原則
# DIP (Dependency Inversion Principle) 依存性逆転の原則

# 単一責任の原則

str = String.new
str << "test" << "ing...1...2"

# q: ARGV とは何か
# a: ARGV は Ruby で実行したコマンドの引数を格納する配列
name = ARGV[1].
  to_s.
  gsub("cool", "amazing").
  capitalize

str << ". Found: " << name
puts str
