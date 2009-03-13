#!/usr/bin/perl

use strict;
use warnings;

use Date::Language;
use Data::Dumper;
use GD::Graph::lines;

# Open a file and parse NEWSDAQ values out.
sub parse_newsdaq( $ ) {
	my $log_file = shift();
	
	my $lang = Date::Language->new('German');
	my $time_offset = 0;
	my %log_hash = ();
	my $last = "";

	open( my $LOG, '<', $log_file ) or die( "FAIL" );
	while( <$LOG> ) {
		if( $_ =~ /^---\sLog\sopened\s..\s(.*)$|
			^---\sDay\schanged\s..\s(.*)$/ox ) {
			$time_offset = $lang->str2time( $1 ? $1 : $2 );
		}

		if( $_ =~ /^([0-2][0-9]):([0-6][0-9])\s
			<.twilight(?:Blanc|Noir)>\sNEWSDAQ:\s
			.*?([0-9\.]+).*?([\-0-9\.]+)
			.*?([0-9\.]+).*?([\-0-9\.]+)
			.*?([0-9\.]+).*?([\-0-9\.]+)
			.*?([0-9\.]+).*?([\-0-9\.]+)
			.*?([0-9\.]+).*?([\-0-9\.]+)
			.*?([0-9\.]+).*?([\-0-9\.]+)
			.*?$/oix ) {
			my $time = $time_offset + (60 * 60 * $1) + (60 * $2);
			if( !($last eq "$3/$4, $5/$6, $7/$8, " .
				"$9/$10, $11/$12, $13/$14") ) {
				$last = "$3/$4, $5/$6, $7/$8, " .
					"$9/$10, $11/$12, $13/$14";
				$log_hash{$time} = {
					'shota_value' => $3,
					'shota_change' => $4,
					'pantsu_value' => $5,
					'pantsu_change' => $6,
					'oneesan_value' => $7,
					'oneesan_change' => $8,
					'imouto_value' => $9,
					'imouto_change' => $10,
					'seal_value' => $11,
					'seal_change' => $12,
					'lion_value' => $13,
					'lion_change' => $14,
				};
			}
		}
	}
	close( $LOG );
	return( %log_hash );
}

sub save_csv( % ) {
	my %log = @_;
	open( my $OUT, '>', 'newsdaq.csv' );
	foreach( sort( keys( %log ) ) ) {
		$OUT->print(
			"$_," .
			$log{$_}->{shota_value} . ',' .
			$log{$_}->{shota_change} . ',' .
			$log{$_}->{pantsu_value} . ',' .
			$log{$_}->{pantsu_change} . ',' .
			$log{$_}->{oneesan_value} . ',' .
			$log{$_}->{oneesan_change} . ',' .
			$log{$_}->{imouto_value} . ',' .
			$log{$_}->{imouto_change} . ',' .
			$log{$_}->{seal_value} . ',' .
			$log{$_}->{seal_change} . ',' .
			$log{$_}->{lion_value} . ',' .
			$log{$_}->{lion_change} . "\n"
		);
	}
	close( $OUT );
	return();
}

sub make_graphs() {
	system( 'ruby', 'graph.rb' );
	return();
}

sub rg( $ ) {
	my $value = shift();
	return(
		'<span class="' . (
			$value < 0 ? 'change_negative' : 'change_positive'
		) . '">' . $value . '</span>'
	);
}

sub save_html( % ) {
	my %log = @_;
	open( my $OUT, '>', 'index.html' );

	$OUT->print(
		'<html><head><title>NEWSDAQ</title>' .
		'<link rel="stylesheet" type="text/css" href="style.css">' .
		'</head><body><h1>NEWSDAQ</h1>'
	);
	
	$OUT->print(
		'<h2>Normalized change - Recent</h2>' .
		'<p><img src="change_recent.png" alt="Change, Recent" /></p>' .
		'<h2>Normalized change - Overall</h2>' .
		'<p><img src="change_overall.png" alt="Change, Overall" /></p>'
	);

	my %names = (
		'shota' => 'Shota',
		'pantsu' => 'Pantsu',
		'onee' => 'Onee-San',
		'imouto' => 'Imouto',
		'seal' => 'Seal',
		'lion' => 'Lion',
	);
	foreach( 'shota', 'pantsu', 'onee', 'imouto', 'seal', 'lion' ) {
		$OUT->print(
			'<h2>' . $names{$_} . '</h2>' .
			'<p><table class="graphs">' .
			'<tr>' .
			'<td>Overall</td><td>Recent</td><td>Change</td>' .
			'</tr>' .
			'<tr>' .
			'<td><img src="' . $_ . '_overall.png" alt="' .
			$names{$_} . ', Overall" /></td>' .
			'<td><img src="' . $_ . '_recent.png" alt="' .
			$names{$_} . ', Recent" /></td>' .
			'<td><img src="' . $_ . '_recent_change.png" alt="' .
			$names{$_} . ', Change" /></td>' .
			'</tr>' .
			'</table></p>'
		);
		
	}
	
	$OUT->print(
		'<h2>Raw data (' .
		'<a href="newsdaq.csv">CSV</a>' .
		')</h2><p><table id="raw" cellspacing="0" cellpadding="0">' .
		'<tr>' .
		'<th></th>' .
		'<th>Shota</th>' .
		'<th>Δ</th>' .
		'<th>Pantsu</th>' .
		'<th>Δ</th>' .
		'<th>Onee-San</th>' .
		'<th>Δ</th>' .
		'<th>Imouto</th>' .
		'<th>Δ</th>' .
		'<th>Seal</th>' .
		'<th>Δ</th>' .
		'<th>Lion</th>' .
		'<th>Δ</th>' .
		'</tr>'
	);
	foreach( reverse( sort( keys( %log ) ) ) ) {
		$OUT->print(
			'<tr>' .
			'<td><strong>' . localtime( $_ ) . '</strong></td>' .
			'<td>' . $log{$_}->{shota_value} . '</td>' .
			'<td>' . rg( $log{$_}->{shota_change} ) . '</td>' .
			'<td>' . $log{$_}->{pantsu_value} . '</td>' .
			'<td>' . rg( $log{$_}->{pantsu_change} ) . '</td>' .
			'<td>' . $log{$_}->{oneesan_value} . '</td>' .
			'<td>' . rg( $log{$_}->{oneesan_change} ) . '</td>' .
			'<td>' . $log{$_}->{imouto_value} . '</td>' .
			'<td>' . rg( $log{$_}->{imouto_change} ). '</td>' .
			'<td>' . $log{$_}->{seal_value} . '</td>' .
			'<td>' . rg( $log{$_}->{seal_change} ) . '</td>' .
			'<td>' . $log{$_}->{lion_value} . '</td>' .
			'<td>' . rg( $log{$_}->{lion_change} ) . '</td>' .
			"</tr>\n"
		);
	}
	$OUT->print( '</table></p>' );

	$OUT->print( '</body></html>' );
	
	close( $OUT );
	return();
}

my %log = parse_newsdaq( "/home/halcyon/irclogs/RIZON/\#news.log" );
save_csv( %log );
make_graphs();
save_html( %log );