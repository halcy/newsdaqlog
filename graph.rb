require 'rubygems'
require 'gruff'
require 'csv'

theme = {
	:colors => [
		'#6886B4',
		'#FDD84E',
		'#72AE6E',
		'#D1695E',
		'#8A6EAF',
		'#EFAA43'
	],
	:marker_color => 'white',
	:font_color => 'white',
	:background_colors => 'transparent'
}

@data = CSV.read( 'newsdaq.csv' )
@time = @data.map{ |a| a[0].to_i }
@shota_value = @data.map{ |a| a[1].to_f }
@shota_change = @data.map{ |a| a[2].to_f }
@shota_normal = @data.map{ |a| a[2].to_f / a[1].to_f }
@pantsu_value = @data.map{ |a| a[3].to_f }
@pantsu_change = @data.map{ |a| a[4].to_f }
@pantsu_normal = @data.map{ |a| a[4].to_f / a[3].to_f }
@onee_value = @data.map{ |a| a[5].to_f }
@onee_change = @data.map{ |a| a[6].to_f }
@onee_normal = @data.map{ |a| a[6].to_f / a[5].to_f }
@imouto_value = @data.map{ |a| a[7].to_f }
@imouto_change = @data.map{ |a| a[8].to_f }
@imouto_normal = @data.map{ |a| a[8].to_f / a[7].to_f }
@seal_value = @data.map{ |a| a[9].to_f }
@seal_change = @data.map{ |a| a[10].to_f }
@seal_normal = @data.map{ |a| a[10].to_f / a[9].to_f }
@lion_value = @data.map{ |a| a[11].to_f }
@lion_change = @data.map{ |a| a[12].to_f }
@lion_normal = @data.map{ |a| a[12].to_f / a[11].to_f }

change_overall = Gruff::Line.new("900x500")
change_overall.maximum_value = 1.5
change_overall.minimum_value = -1.5
change_overall.hide_dots = true
change_overall.left_margin = 0
change_overall.top_margin = 0
change_overall.theme = theme
change_overall.data( "Shota", @shota_normal )
change_overall.data( "Pantsu", @pantsu_normal )
change_overall.data( "Onee-San", @onee_normal )
change_overall.data( "Imouto", @imouto_normal )
change_overall.data( "Seal", @seal_normal )
change_overall.data( "Lion", @lion_normal )
change_overall.write('change_overall.png')

change_recent = Gruff::Line.new("900x500")
change_recent.maximum_value = 1.5
change_recent.minimum_value = -1.5
change_recent.left_margin = 0
change_recent.top_margin = 0
change_recent.theme = theme
change_recent.data( "Shota", @shota_normal[-11..-1] )
change_recent.data( "Pantsu", @pantsu_normal[-11..-1] )
change_recent.data( "Onee-San", @onee_normal[-11..-1] )
change_recent.data( "Imouto", @imouto_normal[-11..-1] )
change_recent.data( "Seal", @seal_normal[-11..-1] )
change_recent.data( "Lion", @lion_normal[-11..-1] )
change_recent.write('change_recent.png')

shota_overall = Gruff::Line.new("300x200")
shota_overall.left_margin = 0
shota_overall.top_margin = 0
shota_overall.hide_legend = true
shota_overall.hide_dots = true
shota_overall.theme = theme
shota_overall.minimum_value = 0.0
shota_overall.maximum_value = @shota_value.max
shota_overall.data( "Shota", @shota_value )
shota_overall.write('shota_overall.png')

pantsu_overall = Gruff::Line.new("300x200")
pantsu_overall.left_margin = 0
pantsu_overall.top_margin = 0
pantsu_overall.hide_legend = true
pantsu_overall.hide_dots = true
pantsu_overall.theme = theme
pantsu_overall.minimum_value = 0.0
pantsu_overall.maximum_value = @pantsu_value.max
pantsu_overall.data( "Pantsu", @pantsu_value )
pantsu_overall.write('pantsu_overall.png')

onee_overall = Gruff::Line.new("300x200")
onee_overall.left_margin = 0
onee_overall.top_margin = 0
onee_overall.hide_legend = true
onee_overall.hide_dots = true
onee_overall.theme = theme
onee_overall.minimum_value = 0.0
onee_overall.maximum_value = @onee_value.max
onee_overall.data( "Onee-San", @onee_value )
onee_overall.write('onee_overall.png')

imouto_overall = Gruff::Line.new("300x200")
imouto_overall.left_margin = 0
imouto_overall.top_margin = 0
imouto_overall.hide_legend = true
imouto_overall.hide_dots = true
imouto_overall.theme = theme
imouto_overall.minimum_value = 0.0
imouto_overall.maximum_value = @imouto_value.max
imouto_overall.data( "Imouto", @imouto_value )
imouto_overall.write('imouto_overall.png')

seal_overall = Gruff::Line.new("300x200")
seal_overall.left_margin = 0
seal_overall.top_margin = 0
seal_overall.hide_legend = true
seal_overall.hide_dots = true
seal_overall.theme = theme
seal_overall.minimum_value = 0.0
seal_overall.maximum_value = @seal_value.max
seal_overall.data( "Seal", @seal_value )
seal_overall.write('seal_overall.png')

lion_overall = Gruff::Line.new("300x200")
lion_overall.left_margin = 0
lion_overall.top_margin = 0
lion_overall.hide_legend = true
lion_overall.hide_dots = true
lion_overall.theme = theme
lion_overall.minimum_value = 0.0
lion_overall.maximum_value = @lion_value.max
lion_overall.data( "Lion", @lion_value )
lion_overall.write('lion_overall.png')

shota_recent = Gruff::Line.new("300x200")
shota_recent.left_margin = 0
shota_recent.top_margin = 0
shota_recent.hide_legend = true
shota_recent.theme = theme
shota_recent.minimum_value = 0.0
shota_recent.maximum_value = @shota_value[-11..-1].max
shota_recent.data( "Shota", @shota_value[-11..-1] )
shota_recent.write('shota_recent.png')

pantsu_recent = Gruff::Line.new("300x200")
pantsu_recent.left_margin = 0
pantsu_recent.top_margin = 0
pantsu_recent.hide_legend = true
pantsu_recent.theme = theme
pantsu_recent.minimum_value = 0.0
pantsu_recent.maximum_value = @pantsu_value[-11..-1].max
pantsu_recent.data( "Pantsu", @pantsu_value[-11..-1] )
pantsu_recent.write('pantsu_recent.png')

onee_recent = Gruff::Line.new("300x200")
onee_recent.left_margin = 0
onee_recent.top_margin = 0
onee_recent.hide_legend = true
onee_recent.theme = theme
onee_recent.minimum_value = 0.0
onee_recent.maximum_value = @onee_value[-11..-1].max
onee_recent.data( "Onee-San", @onee_value[-11..-1] )
onee_recent.write('onee_recent.png')

imouto_recent = Gruff::Line.new("300x200")
imouto_recent.left_margin = 0
imouto_recent.top_margin = 0
imouto_recent.hide_legend = true
imouto_recent.theme = theme
imouto_recent.minimum_value = 0.0
imouto_recent.maximum_value = @imouto_value[-11..-1].max
imouto_recent.data( "Imouto", @imouto_value[-11..-1] )
imouto_recent.write('imouto_recent.png')

seal_recent = Gruff::Line.new("300x200")
seal_recent.left_margin = 0
seal_recent.top_margin = 0
seal_recent.hide_legend = true
seal_recent.theme = theme
seal_recent.minimum_value = 0.0
seal_recent.maximum_value = @seal_value[-11..-1].max
seal_recent.data( "Seal", @seal_value[-11..-1] )
seal_recent.write('seal_recent.png')

lion_recent = Gruff::Line.new("300x200")
lion_recent.left_margin = 0
lion_recent.top_margin = 0
lion_recent.hide_legend = true
lion_recent.theme = theme
lion_recent.minimum_value = 0.0
lion_recent.maximum_value = @lion_value[-11..-1].max
lion_recent.data( "Lion", @lion_value[-11..-1] )
lion_recent.write('lion_recent.png')

shota_recent_change = Gruff::Line.new("300x200")
shota_recent_change.left_margin = 0
shota_recent_change.top_margin = 0
shota_recent_change.hide_legend = true
shota_recent_change.theme = theme
shota_recent_change.data( "Shota", @shota_change[-11..-1] )
shota_recent_change.write('shota_recent_change.png')

pantsu_recent_change = Gruff::Line.new("300x200")
pantsu_recent_change.left_margin = 0
pantsu_recent_change.top_margin = 0
pantsu_recent_change.hide_legend = true
pantsu_recent_change.theme = theme
pantsu_recent_change.data( "Pantsu", @pantsu_change[-11..-1] )
pantsu_recent_change.write('pantsu_recent_change.png')

onee_recent_change = Gruff::Line.new("300x200")
onee_recent_change.left_margin = 0
onee_recent_change.top_margin = 0
onee_recent_change.hide_legend = true
onee_recent_change.theme = theme
onee_recent_change.data( "Onee-San", @onee_change[-11..-1] )
onee_recent_change.write('onee_recent_change.png')

imouto_recent_change = Gruff::Line.new("300x200")
imouto_recent_change.left_margin = 0
imouto_recent_change.top_margin = 0
imouto_recent_change.hide_legend = true
imouto_recent_change.theme = theme
imouto_recent_change.data( "Imouto", @imouto_change[-11..-1] )
imouto_recent_change.write('imouto_recent_change.png')

seal_recent_change = Gruff::Line.new("300x200")
seal_recent_change.left_margin = 0
seal_recent_change.top_margin = 0
seal_recent_change.hide_legend = true
seal_recent_change.theme = theme
seal_recent_change.data( "Seal", @seal_change[-11..-1] )
seal_recent_change.write('seal_recent_change.png')

lion_recent_change = Gruff::Line.new("300x200")
lion_recent_change.left_margin = 0
lion_recent_change.top_margin = 0
lion_recent_change.hide_legend = true
lion_recent_change.theme = theme
lion_recent_change.data( "Lion", @lion_change[-11..-1] )
lion_recent_change.write('lion_recent_change.png')
