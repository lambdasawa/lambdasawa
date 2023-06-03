import os
from sqlalchemy import create_engine, MetaData, Table, Column, String, Date, Numeric
from sqlalchemy.dialects.postgresql import ARRAY
from sqlalchemy.sql import text

engine = create_engine(os.environ['CONNECTION_URL'])
connection = engine.connect()

table_name = 'hello_world'
table = Table(
    table_name,
    MetaData(),
    Column('id', String(36), primary_key=True),
    Column('start_date', Date),
    Column('end_date', Date),
    Column('name', String(50)),
    Column('amount', Numeric),
    extend_existing=True
)

for data in [
    {
      'id': 'id1',
      'start_date': '2023-06-01',
      'end_date': '2023-07-01',
      'name': 'foo',
      'amount': 100
    },
    {
      'id': 'id2',
      'start_date': '2023-07-01',
      'end_date': '2023-08-01',
      'name': 'bar',
      'amount': 200
    },
]:
  stmt = text(f'''
      INSERT INTO {table_name} (id, start_date, end_date, name, amount)
      VALUES (:id, :start_date, :end_date, :name, :amount)
      ON CONFLICT (id) DO UPDATE
      SET start_date = excluded.start_date,
          end_date = excluded.end_date,
          name = excluded.name,
          amount = excluded.amount
  ''')

  connection.execute(stmt, data)

connection.commit()
connection.close()
