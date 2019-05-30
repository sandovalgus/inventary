# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
group = Group.create!(name: 'Tecnico', admin: false)

User.create!(firstname: 'Tecnico', lastname: 'Tecnico', email: 'tecnico@tecnico.com', username: 'tecnico', password: 'tecnico-123', group: group)
User.create!(firstname: 'Arturo', lastname: 'Suarez', email: 'arturo@tecnico.com', username: 'Arturo', password: 'test-123', group: group)
User.create!(firstname: 'Nicole', lastname: 'Necochea', email: 'nicole@tecnico.com', username: 'Nicole', password: 'test-123', group: group)


DepositType.create!(name:'Automovil', description: '')
DepositType.create!(name:'Camioneta', description: '')
DepositType.create!(name:'Moto', description: '')
DepositType.create!(name:'Edificio', description: '')

TelephoneType.create!(name:'Telefono Fijo', description:'')
TelephoneType.create!(name:'Celular', description:'')
TelephoneType.create!(name:'Fax', description:'')

Category.create!(name:'Tecnologia', description:'')
Category.create!(name:'Accesorio para vechiculos', description:'')
Category.create!(name:'Inmuebles', description:'')
Category.create!(name:'Servicios', description:'')


Producer.create!(name:'Samsung')
Producer.create!(name:'Sony')
Producer.create!(name:'Tenda')
Producer.create!(name:'Acer')
Producer.create!(name:'TP-Link')

TaxCategory.create!(name:'Monotributo Cat A')
TaxCategory.create!(name:'Monotributo Cat B')
TaxCategory.create!(name:'Monotributo Cat C')
TaxCategory.create!(name:'Monotributo Cat D')

# Withholding.create!(withholding:'IIBB')
# Withholding.create!(withholding:'Ganancias')
# Withholding.create!(withholding:'Retencion x')

VourcherType.create!(name:'Factura C')
VourcherType.create!(name:'Remito R')
VourcherType.create!(name:'Factura A')