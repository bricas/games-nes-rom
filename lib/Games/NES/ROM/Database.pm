package Games::NES::ROM::Database;

=head1 NAME

Games::NES::ROM::Database - Known info about existing ROMs

=head1 SYNOPSIS

    use Games::NES::ROM::Database;
    
    my $db = Games::NES::ROM::Database->new;
    my $info = $db->find_by_crc( $crc );

=head1 DESCRIPTION

This database holds information about known game images. You can find out
which mapper to use, how many PRG and CHR chunks it has, if it is an NTSC
or PAL game, among other things.

=head1 DATABASE VERSION

The database has been synchronized with version 1.40 of the Nestopia emulator.

=cut

use Moose;
use XML::XPath;
use XML::Simple;

has 'xpath' => (
    is      => 'ro',
    isa     => 'XML::XPath',
    default => sub { XML::XPath->new( ioref => \*DATA ); },
    lazy    => 1,
);

=head1 METHODS

=head2 new( )

Creates a new instance of the database.

=head2 find_by_crc( $crc )

Given a CRC hex string, it will return a hashref of info from the database
or undef if it does not exist in the database.

=cut

sub find_by_crc {
    my $self = shift;
    my $crc  = uc( shift );
    return _nodeset_to_hashref(
        $self->xpath->find( "database/game[cartridge[\@crc='${crc}']]" ) );
}

=head2 find_by_sha1( $sha1 )

Similar to C<find_by_crc>, but uses an SHA-1 hex string.

=cut

sub find_by_sha1 {
    my $self = shift;
    my $sha1 = uc( shift );
    return _nodeset_to_hashref(
        $self->xpath->find( "database/game[cartridge[\@sha1='${sha1}']]" ) );
}

sub _nodeset_to_hashref {
    my $ns = shift;
    return undef unless $ns->size;
    return XML::Simple::XMLin( $ns->shift->toString );
}

=head2 find_by_rom( $rom )

Similar to C<find_by_crc>, but accepts a L<Games::NES::ROM>-derived object.

=cut

sub find_by_rom {
    my ( $self, $rom ) = @_;
    return $self->find_by_crc( $rom->crc );
}

=head1 SEE ALSO

=over 4

=item * Games::NES::ROM

=item * http://nestopia.sourceforge.net/

=back

=head1 AUTHOR

Brian Cassidy E<lt>bricas@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2007-2013 by Brian Cassidy

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut

1;

__DATA__
<?xml version="1.0" encoding="UTF-8"?>
<database version="1.0" conformance="loose">
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="001388B3" sha1="4BCD36C05FCAF45C74001257C65AFB7EC5FA53D7">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0021ED29" sha1="C039B782EDA5A79097BC3FA761A3F7C663AAB6DC">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="007BB58A" sha1="F53C7B12838584809F2F0AC2B589704F7CF75E2D">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="00837960" sha1="A39BCDAED0DFFDEC5E3FBECA39FE95D62CBDDA8A">
            <board type="NES-TSROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="008E2D30" sha1="1DD3691DE5D57353CA7D9D235C01BA124EE6B597">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="009AF6BE" sha1="48100033895E83877F554AB539CB028ACAAC44AC">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="00A53242" sha1="4C7DD4E3068259FF971D021AC380CBFDC3427116">
            <board mapper="113">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="00AD1189" sha1="9F42C6C9A34E808138EAFDD314BAE359D80E6FF9">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="00E95D86" sha1="8957393A397DB102BCE5A64B4D85384D1F2E5D20">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0123BFFE" sha1="B84C5A8EA62EF3F1EEF920968284DC6CD4D6055D">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="01357944" sha1="E0572DA111D05BF622EC137DF8A658F7B0687DDF">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="015D4555" sha1="A3791FE7928E8057E478F8D21B51B51C942325F5">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="016C93D8" sha1="657FAD06D36D1B2B953DEC8997A401E547F15CBA">
            <board type="HVC-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="018A8699" sha1="F65CC1B8A916E55B8AC025755AC6DC7FA3E40919">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="01934171" sha1="13A9FBEF2AFB54205CB4718E18846AAE92CDAB58">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="01B4CA89" sha1="FB4DA8C4F212D4ED2C7552681B7105C9691EC6E1">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="022589B9" sha1="540ADE2D664C628014CF3CD3BA0C1EF418ED00A6">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="rob"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="023A5A32" sha1="F81B28AF2A2CA7D784CDE8E9DCF90942A9F0D561">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="02589598" sha1="7752E5C89E3BECC24CAFEA211338E264B578D80C">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="02669C33" sha1="41186250E98BB11747D0E04375A32F58634C079E">
            <board mapper="185">
                <prg size="32k"/>
                <chr size="8k">
                    <pin number="26" function="CE"/>
                    <pin number="27" function="/CE"/>
                </chr>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="026C5FCA" sha1="EEB560ADE82C5C322CD515176E9E9B6F4847B0A6">
            <board type="BANDAI-74*161/161/32" mapper="152">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="026E41C5" sha1="998A7CD3140978FAD0E827C8543092CA705C1FC7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="028374F2" sha1="E233507D20777ECD6FA9C8D1D6A2017A12F62466">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="02863604" sha1="94B874EC112829801C899E6E9E509885ABC3D520">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="02B9E7C2" sha1="216A5B83111C2936998AF147E19A8A8CD73D8870">
            <board type="NES-SL1ROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="02C41438" sha1="17473C223453D2D80FCB9DCFA317947287DC5C52">
            <board mapper="179">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="02CC3973" sha1="4970AB23575CFD29DB8F95D4F8FA34169478CA6A">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="02D7976B" sha1="A0DEF24A28AF4DE20CA4059D5E8ED27D1B5F6B6A">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="02E0ADA4" sha1="8DC6CBF34EA4A5D4666D73720CF8E6E4F9C7D270">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="02EE3706" sha1="1DF12A7B72F3D2A0C506216ACF8ACC0A81B923F7">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="03272E9B" sha1="5ABC2616687E7E7A8C8749D16A3AA99778469D6E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="035DC2E9" sha1="BE348431A9C03D1A588A8363C0094B5A0722D9BE">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="035DC2E9" sha1="BE348431A9C03D1A588A8363C0094B5A0722D9BE">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="039B4A9C" sha1="9DC65B4848FFBB9E6D23986D1987803E7250337C">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="03B8DEFA" sha1="BBFDB9CD157624CD42A8E02727A5B3B126448F2F">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="03D56CF7" sha1="DC5FAA2F861E729B42492C361FBCA9927FF454C3">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="03E2898F" sha1="BDF3D18E9416A241F829E62A063FD6515128E856">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="03EC46AF" sha1="14289A6DFA8B85EF2C06FA81D6ED61AE7C2868D1">
            <board type="NES-BTR" mapper="69">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="03F899CD" sha1="42F15207D202B43802E92AF1F89300CEB9C99F12">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="03FB57B6" sha1="C26EEEEFB90F857DF8134FD267106DEE2F5A1CAA">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="03FDEFAD" sha1="4E84BE9A20C5E385AE71C466A02613D5A74DE01E">
            <board mapper="230">
                <prg size="640k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="04109355" sha1="C1C920379BBB9D78A88B918CCCBB149BA1EF862A">
            <board type="IREM-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="04142764" sha1="7E1C9F23BF9BECB7831459598339A4DC9A3CECFC">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="045E8CD8" sha1="B95BF9459CF2366EE20A25D6EA67E9DE9DDC849F">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="04766130" sha1="5E6216ABF99BF73ECBAC7D9D38BC2C515A671BA4">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="049325D9" sha1="53DC42A7CC733672981782406F023A0ECC571122">
            <board mapper="112">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="04BE2206" sha1="779283DA48571F00CCCB73D3E410F6C8A3951362">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="04D800DA" sha1="8016616E06ADE3D5BCA66879171427B44E5DD455">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="04F3354D" sha1="B942148A5145519DC48E7A574EBA55907F6A2869">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0504B007" sha1="A5030E82D7C38F2D51016D947CB29E6FF788367C">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="0504B007" sha1="A5030E82D7C38F2D51016D947CB29E6FF788367C">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="05104517" sha1="E83443C990D36DD3C851A317FAFC87F2ABF4A944">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="051CD5F2" sha1="190D95C18D0AE838C3E123BB1DF06C6797969F49">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="052AE3F5" sha1="AF50B627AF7127DA7EED3516012636A4DC38885B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0537322A" sha1="40F7287B34A8B9A5729685A58C65DF3078664DB8">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="05378607" sha1="2A371E9617262941B749C6C1198FB0CDB987B708">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0546BD12" sha1="999A8F7230EC8BC527924DA247400CA39B5E0859">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="054BD3E9" sha1="F5FA7807F2B70ADFE5707D9BF88F90DAC1436DB0">
            <board mapper="74">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="2k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="054CB4EB" sha1="AC57D9DBE0AB3EBD74808FB51CBA1656955E702F">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="0554394F" sha1="C637142DCAC082C2273525A327895594DE26F95D">
            <board mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="058F23A2" sha1="E856AC51C79DA5F4241D49B35CA42F5197C365D4">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="059E0CDF" sha1="A7324E0A32800734AF4F02B0E85AC063C3736A31">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="05A688C8" sha1="9705F4D78AA57882D2D12CD675930E3805F700F1">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="05CE560C" sha1="21A046EDEE62736BE1C1A29E8688A935C605C6CD">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="05F04EAC" sha1="51E651098CC6ECF97066C4A0C54EB5A7F1E6AA0A">
            <board mapper="82">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="06144B4A" sha1="DBEE392976D8C8F079CABC38F65B3A92001D30EC">
            <board type="IREM-74*161/161/21/138" mapper="77">
                <prg size="128k"/>
                <chr size="32k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="062DCB6D" sha1="837E594D6A70DF61E7E79BC7F1760B7E40BBE163">
            <board mapper="211">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="063B1151" sha1="03583A33DECF23F4167DFC428FFAD86D571494D4">
            <board mapper="209">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="063E5653" sha1="0D565384E36F490A0A3B555BED51F28B7939663A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="06406EB9" sha1="31074FB8EBD1B96F4A5F0F391E8F9CA5B1BA96AC">
            <board mapper="113">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="06689AA4" sha1="FACA8D0BAF523B8F49763CA63520F091A9AD366E">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="06961BE4" sha1="0757335F899F063F65934381DE36D0493A205B30">
            <board type="NES-SLROM" mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="06D72C83" sha1="F9809D020BC0AFF976CD657E3F923D81EBD6C6B1">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="06F15215" sha1="AF3DEF42D08B60B50ADC490D87BA8C6324B1EECA">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="06F9C714" sha1="98D97E0D12B0D15E9E5F9F63898E4C95152E0590">
            <board type="JALECO-JF-25" mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0719260C" sha1="787D23B486DBEB25BC7C0CE77B31183949975F52">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="073A0EBE" sha1="BFE1C463DC2B5C2F2DA2D2354C0714E377C9FFA3">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="074EC424" sha1="1188FB0F9BA9B0EE1DEE8D49941A201AE63F492A">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="078864F2" sha1="0A7FB7F9C29A99631532F31890F6FB76F3FA561D">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="078CED30" sha1="445EF49C918183F17EEF3D80C6FAF6E0CA8AC19E">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0794F2A5" sha1="4F5C643E6B2C960C3A9E010CB76499AED8408A7A">
            <board type="HVC-SUROM" mapper="1">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="07977186" sha1="8621D679733D683D22D813B5D6EB2D2E68714078">
            <board type="HVC-SLRROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="07D92C31" sha1="68D5E40403FF09FAE745FDF419F9244C9BCA507A">
            <board mapper="118">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="07EB2C12" sha1="D565A9C2B117447C310E4F59E4AFC30DF299EA4F">
            <board mapper="208">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0809E07E" sha1="C601C8952A10AA2FCFB683948FF932643E8495ED">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="083E4FC1" sha1="3D91043A9C56DD71F0759FD292E8ADAF46EB10A1">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="085DE7C9" sha1="93339F07696CE1B98F1272613067482A02F47B95">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="087211F9" sha1="49EF5B8257BFFFA911A5AD504F27F24167E40735">
            <board mapper="196">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0897021B" sha1="276C7C2CE4EAA4B838F8188DF60E2ECB9946215F">
            <board mapper="69">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="08CF510F" sha1="29616123AE0DBE9863B31B3A933A8781C8B093F9">
            <board mapper="83">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="08E11357" sha1="BEE749B86214CEC21E1CEBBE916B039890AC997D">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0902C8F0" sha1="27F4875524F31D8A7CC429D21B15E35BD88FC8B8">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="091ED5A9" sha1="61D0B87E5F0C6723BA203370DCF317F8FBAE7F0B">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="092EC15C" sha1="4CB9688319334367F8BE4FEC40A52D299D953D0D">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="0939852F" sha1="A67D3FB6E78305FDA82B2907C5C8D83FC38B0B63">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="093E845F" sha1="84BEF49E92897D4FCB4CA2C2103B7522D624B304">
            <board type="HVC-SJROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="096D8364" sha1="EB07B89AC4D5557A5921661F77D63C629CEED63B">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0973F714" sha1="304F98AE79CBC933EF23AD419C5E518AF1006669">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="09874777" sha1="EAAA0F6D5D94EC692EAF9A61F593674829289914">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="098C672A" sha1="D557D0BD3B3BCBD93A2C82F4F00DF7A9247E2A6D">
            <board mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="099B8CAA" sha1="A7A0A94B705E5B19E600B587805E5C66D013AE6F">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="09C083B7" sha1="87E7943769CE95747AC80DA044B2CF9E63410AF2">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="09C1FC7D" sha1="B09F1843D84D7D4A018C65D22E3A0B9217A584B5">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="09C31CD4" sha1="A1F093C411D52C17C8D5AAFB31ABC31AEE0A972C">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="09FFDF45" sha1="D144E4DC539A1B7AF88F6830F815BD10DC8E74CF">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0A0926BD" sha1="1A24546ED1E0AB0010BA7F7205E06EC121583D17">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0A3FC393" sha1="DE5D1C5C2E1CFA1573D18A050F816856869F233B">
            <board type="HVC-RROM" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0A42D84F" sha1="FBC6F08F4A2DE2B3B5286A179E25BFBD14880B21">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0A73A792" sha1="7B177AE1EB29847B8F8F58FEBC2C3A49CC920923">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0A7E62D4" sha1="C8909540BC7C1EF643EADC8AB9477F5532E52945">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="0AA49929" sha1="966D61DF2F514B8EA83B99ADE6E666A81A8647A9">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0AB26DB6" sha1="1BF58D195B2B3AEC88B58B48DECFE0384B66B7C4">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0ABDD5CA" sha1="8B62B3FC95957F52D146E7BC3C90AB33C4005AEC">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0AC1AA8F" sha1="EE09B857C90916EDD92A20C463485A610B0A76FD">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0AE3CC5E" sha1="485C257A8C84EF79157658EDFC44A7C4B4855A39">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0AE6C9E2" sha1="847D56E43754E402666A91188520737094E9ECFA">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="0AFB395E" sha1="CFFAC7D2ECB18A28C36E0E90A6682DFE5BA6E3D1">
            <board mapper="5">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="0B0E128F" sha1="977286FDC76C34A618E2A2D0270641BC36CFE89C">
            <board mapper="105">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0B13658B" sha1="8676000DC4EEDFF7FACF5151D530C98E3E2FE9E1">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0B1E9726" sha1="130422BC8A79C306396E54EB770D1EC6918EBAAF">
            <board mapper="164">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0B404915" sha1="789B550C09671C668E706BA0BB4F81186585CBC6">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0B58880C" sha1="4D55F5E718E6BEEA1AC0E72ECFC2D4C04DA68ECF">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0B6443D4" sha1="446C3D1AFC024D38C679F7CE5FBA9E34CE6CA47F">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="0B7FFE6A" sha1="FB05484E066CFE3FB79E7E15450EF8FA5B418632">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0B8E8649" sha1="A080522330FCB0C0A0CD988D7CCC47DA7AA286BF">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="0B8F8128" sha1="CF29201FB3D085B2AB5310232265EA1602DF210C">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0BB4FD7A" sha1="BC1734BEE472D34F489A6F5F2530A019F28055B7">
            <board mapper="236">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0BB5B3A0" sha1="293866007DADF623F9775DCF26AFF5F7CD64729A">
            <board mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0BBF80CB" sha1="6A641B880B90ADBED772120851CFE4630FA4B149">
            <board type="TAITO-X1-017" mapper="82">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="X1-017" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0BCAA4D7" sha1="C08BD7F4E786BCB1F6FE31B1BC4815BA83C69E23">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0BDD8DD9" sha1="317FB395B4D408F3A4BEF73DD54C92FBB7748F4D">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0BE0A328" sha1="EDD7A45A7F27E396B6D686F1861642D509863132">
            <board mapper="157">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0BF306D1" sha1="DE096811BA0FE0E0EFEDFCE2C664670601554066">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0C1792DA" sha1="35E9B4576DC45D5E67CFAD274D67D4FB37DFC921">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0C1FE23D" sha1="62342BDA0FB0654F381417782F85DBBE81E2BD28">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0C222495" sha1="8E5767E4A6D5842684E1538D21948538643E0393">
            <board type="MLT-ACTION52" mapper="228">
                <prg size="1536k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0C2E7863" sha1="AC559393AA094802F17DE952BD87099B0243A02E">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0C401790" sha1="CD665ACEA15A4542A9E4CF16A7CA2CE53C88726D">
            <board type="HVC-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0C47946D" sha1="4BA89EF5E844CBE869B185F5806C9856B9EE7573">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0C5A6297" sha1="6F4F809F7C4FB78A13C512CE0A4DC98E9C8803AE">
            <board type="SUNSOFT-3" mapper="67">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0C5F40A6" sha1="428659D51DAEF81218B1B08B92552AC227970E3C">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="0C783F0C" sha1="C8EA77EFBF82F12836467CAA9012914AF12A87A3">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0C7A7B3E" sha1="5317F8CB5C7B002FE91F64D68F26F5EFBDFD8046">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0C7E94C3" sha1="CC9EFAA2AEE5EB9D99E9EF01684EC8B30B0047E6">
            <board mapper="56">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0CC9FFEC" sha1="35C41BA88DD967CF6ECC406DAAAF246304AE7241">
            <board type="KONAMI-VRC-2" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A1"/>
                    <pin number="4" function="PRG A0"/>
                    <pin number="21" function="CHR A10"/>
                    <pin number="22" function="CHR A16"/>
                    <pin number="23" function="CHR A11"/>
                    <pin number="24" function="CHR A13"/>
                    <pin number="25" function="CHR A14"/>
                    <pin number="26" function="CHR A12"/>
                    <pin number="27" function="CHR A15"/>
                    <pin number="28" function="NC"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0CD79B71" sha1="3A75FB6966ED9D3793B8ACDC6FA9AEC7C2B3FE46">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0CF42E69" sha1="673731D5AF54D1008C4FC5FB16C64FA6F2134267">
            <board type="BANDAI-LZ93D50+24C01" mapper="159">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="0D14285A" sha1="52E60AFDFAF9A80F39124D49FE1924E2E2256B7A">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0D3482D7" sha1="9145A39E9F1FA75018FF734597F3151F220C69E9">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0D65E7C7" sha1="9336C1968359C55C3E4438579C7BF14C443EDEBE">
            <board type="SUNSOFT-5B" mapper="69">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0D98DB53" sha1="B1C74236FD17FAB4AB9AA6AB28E38864C66D6255">
            <board mapper="182">
                <prg size="256k"/>
                <chr size="256k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0D9F5BD1" sha1="8A8BBECC77FDF59826257754F357D38A7F825971">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0DA00298" sha1="7138B8F0E6CC530B70CEB8082BCA8F8FF06D7776">
            <board mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="0DA0E723" sha1="87516E3CA463123EA29ADF19841F1FFBC30A8E06">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familyfunfitness"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="0DA28A50" sha1="44C87C152740657E222F26646D6EF256B4EA52B4">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0DA5E32E" sha1="17C22C6A3E2601BD48518B6858C746CB1A4F3130">
            <board type="JALECO-JF-10" mapper="87">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0DB4B382" sha1="CE9EC034DCF083656DB5DBD2F74C927FA2B5C745">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0DC53188" sha1="0CEE27BCD6F8F10C4B6144FF1338BEDD56171D4F">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0E1683C5" sha1="60814331AE3BF1CFF00D96AA41FF8BCC94D3C574">
            <board type="TAITO-X1-005" mapper="80">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="X1-005">
                    <pin number="17" function="CHR A17"/>
                    <pin number="31" function="CIRAM A10"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0E197A5E" sha1="2CA762B0CF96CFF0CF54E0264BA2A071C867D579">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0E997CF6" sha1="E892B4F6166D16B3B8A1720216980253FD9A9319">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0EAA7515" sha1="85AF386E36FB9A5472CED6BFD1959C91120A0A1B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0EC6C023" sha1="63347651E2405BC6E50DFF42F050C60332221E03">
            <board type="NES-EKROM" mapper="5">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0ED96F42" sha1="6446B7BAE7C3FEAAB5B85543CB8E54F0F186097F">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0EF730E7" sha1="834BF676BE8761585D72B05E14B44AFB8F5A0F90">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="0F05FF0A" sha1="4C9C05FAD6F6F33A92A27C2EDC1E7DE12D7F216D">
            <board type="HVC-CNROM" mapper="185">
                <prg size="32k"/>
                <chr size="8k">
                    <pin number="26" function="/CE"/>
                    <pin number="27" function="/CE"/>
                </chr>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0F1BABE7" sha1="94473D4C394008AAC36D44D13E37940E0F982C75">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0F1CC048" sha1="96356DA50FF4CD4E3D399181AC19DAFBF298EEA8">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0F5410E3" sha1="2475B8CE83CA9E2686AB024E4FC886D5C18A3B30">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0F5F1F86" sha1="1B90E37458037C8F23F71FA4B45E54CC53A05139">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0F86FEB4" sha1="31C77EF1B9A5E8A4DF131F07F198A455F5AF5FC5">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="0FA322C2" sha1="7FD66E0A4CC0E404F404D8164FA221EE2ACB7A38">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0FB244C8" sha1="7C2F1A0D73F82D9C7A651F5B26A788FC353D269A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="0FC72A80" sha1="844FC3343F9AD78B0D92A0F09F0AAB34D5D7D72F">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0FC8E9B7" sha1="8E35196189E1A323FEE941FD7DA56CE1D04D3A15">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0FCFC04D" sha1="2EC08F9341003DED125458DF8697CA5EF09D2209">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0FD6BFC8" sha1="11A0605507A6191DB0D52EAA567ADD08FB8374E6">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0FEC90D2" sha1="7C97930E89975CC702534ACC610CEB9C13B7D54E">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="0FF6A3B5" sha1="875AD0494FB6C6E37A119A5F0811B9A31F3E2B8B">
            <board mapper="69">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="0FFDE258" sha1="27D25B95DD212854571BC8F5A083F84825631331">
            <board type="TENGEN-800030" mapper="206">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="10092781" sha1="6FEC63FAD8650996CEA1384939670A7339197AC3">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="10119E6B" sha1="1854E0A1FDEBEF05ED303CA85E9A4CC2849254C5">
            <board mapper="93">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="10124E09" sha1="F11AF8758F073BB9A130884E81A09E8AD86545BB">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="10180072" sha1="4BE0DAF0C891D8020B3B4CD0534B469677932C7A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1027C432" sha1="428B6712065580DF4C0060B83FFA84EAFCE475E6">
            <board type="HVC-UOROM" mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="103E7E7F" sha1="9976AD63F31B81049E6DE2950F5EE94C905DB5B3">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1066B66D" sha1="4EE3F7B0D3494A9F996054D34725C938204C119A">
            <board type="HVC-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="109F1ACC" sha1="FF67B81FB597AFDBABEAD2C118AE4567031F5F8E">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="10B0F8B0" sha1="5B90DA517234E576358A278C4F36076EF57232F2">
            <board type="TAITO-X1-005" mapper="80">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="X1-005" battery="1">
                    <pin number="17" function="CHR A17"/>
                    <pin number="31" function="CIRAM A10"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="10BAEEF3" sha1="CBC7E0328AA7242B7F8F99B2257D9849373E3680">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="10C8F2FA" sha1="7974126FFE8C5C064D6A0BDDA14646F874FA7109">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="10C9A789" sha1="4FE1D7FEDB5416CD8E4E2488B9056073AD401B3C">
            <board mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="10D62149" sha1="E8E2A31D40139C64442390FBEFBE6ECAF15EB89D">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1104A5B9" sha1="0E707C553AC3199CF1F6005F545D0E728A7F2C5A">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1117CE85" sha1="8F3B158CE2FA9EB4F65BD3A377E3BCDE6AE4C6D0">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="11D08CC6" sha1="D186EF4A396E9D80C3C5F105D80060DC3CB58008">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="12012CD9" sha1="881B6413FBCBFB9A0308583F0510C09283A72D2A">
            <board mapper="206">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="12078AFD" sha1="5B4615452F8219DA66EDD1D9103178BEFCA3AD0A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1208E754" sha1="C3463FC08A3553C77EBD6114C5F1910D63773A85">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="12481CC0" sha1="ED6D0314D8BB2BE055B08B4A6E301999A41779BF">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1248326D" sha1="52F51AC9BDCC1563B11559A33DF174A2A8DF0D32">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="126EBF66" sha1="8C7D9F0DFD482FDCE05612A4EFA78F97394B9DC7">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="12748678" sha1="CC24E62E5354DF897BDBF101E470E5AEE6F023FE">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="127D76F4" sha1="3F57551528B29C674D2ED928562BF991A8FE2E1F">
            <board type="NES-TKROM" mapper="4">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="12906664" sha1="DC7F8EDFB4EEF817CAA89DF7B64E753134D33B2E">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="12B2C361" sha1="C8895753A379903F7B06F1D4A5CFB654F53390BB">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="12B57E82" sha1="867CCB62B43C85B796687BEC339672119722F0C7">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="12C6D5C7" sha1="1E76A86398F069DA43B25351EF419BE664D630C5">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="12D2B6B0" sha1="826DD960111B3296FE74E8FC8D58B319AEC50DEC">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="12E6CB79" sha1="7F50975365E7A26ADE33945139D2D5B07A5005DB">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="12EE543E" sha1="38E01BBCD0C5FCF18B4AB6E2336BAFE8394AB9DE">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="12F048DF" sha1="D97027BC6666DB7C5251CE05CC3B92328C59D71F">
            <board type="JALECO-JF-22" mapper="75">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1300A8B7" sha1="4E2AD3F7CCDA57FD7E4D7CAC61EC6149BAAB807D">
            <board type="NAMCOT-3413" mapper="206">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1306EE62" sha1="6A2F56DBC6C693612FA3546BFA2E0C41C4E9E89F">
            <board mapper="90">
                <prg size="256k"/>
                <chr size="256k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="13332BFA" sha1="D4B221633548FEDDFF20185F28F82A3438A78BFD">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="13332BFA" sha1="D4B221633548FEDDFF20185F28F82A3438A78BFD">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1335CB05" sha1="8A49FE60B6A151C055A63639894CD366935A7EE9">
            <board type="NES-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1347D6C9" sha1="0AFD8CEF5474D86ABF632CEDAE8ACA2F14197EA3">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="1352F1B9" sha1="EC5498889CF0543DE2C71836788766BC0F5FB98B">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="1353A134" sha1="907BB39BEE4D1FC6B41F5980486F5381B76D456C">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="136CA449" sha1="491CF177C7648553FFBD278B0E7E20CF9A92A24A">
            <board type="BANDAI-LZ93D50+24C02" mapper="16">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="138862C5" sha1="3B5614A315F41DC19C2ED41F9924433314719799">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="138F0BB0" sha1="777913358C5E5245DBA90D80A57E0CC6A30FC195">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1394F57E" sha1="FD9079CB5E8479EB06D93C2AE5175BFCE871746A">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="16k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="139B15BA" sha1="8E1316D6C938DB9E46A4C1B5B23892098C68E2F4">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="139EB5B5" sha1="9E34B004694A8CB67D2CE2A2B0171192EC36F363">
            <board type="TENGEN-800030" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="13C6617E" sha1="A6C56AC787FF11A67921867FFC9F79A57A382657">
            <board type="NES-B4" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="13C774DD" sha1="FDBF0A18EA677EEC5F7437A80449B033526DD68B">
            <board type="NES-TL1ROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="13D5B1A4" sha1="A2D029E51A8E3D92BA17CB2E0A7D96FBC91D96CF">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="13DA2122" sha1="C7C3BCF30261157E49652CC51DFC50FEACD546F9">
            <board type="NAMCOT-3443" mapper="88">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="13E01649" sha1="0EFC8BA8A306C423B32853385274208F42626E2E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="14105C13" sha1="45C8F2C83CD25CFA7F8D4D01438FFE36B5F5AAC8">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1411005B" sha1="ACC238CA98811C8DA2290C29AAB143F7C3EF3EDC">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="14255C57" sha1="866F2E5DA7E07255E0CEFC8218D972EF93D4D144">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1425D7F4" sha1="E94E4C2F38137220BF2622E10BE96477ED67F472">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="143B2F27" sha1="4984FB582737CCC6F2B6D6F587BCAAD889C7A934">
            <board mapper="60">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="1460EC7B" sha1="86E2AC9F91D2B047C4E472B091667627A7EEDAF1">
            <board mapper="15">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="147733DF" sha1="39499923C8970B089E359AC256E71FB75AE3C0DE">
            <board mapper="226">
                <prg size="2048k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="149C0EC3" sha1="782AC8E9C9073D4ACC058164E6F5BCB6639B91E3">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="14A81635" sha1="1EB59BC8A07F9D8B41F6F04E5C16B98F2E9975EC">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="14CD576E" sha1="07CDE12D71BE979F9FED6FC6313142524FF0AA20">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1500E835" sha1="127B2C71AB249ECC197F7F88CEFC1FDE2EC7F2CE">
            <board mapper="48">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1512E0B1" sha1="7C2E7F9A785FF787E314D39B01B884873F08316A">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="15141401" sha1="071F91507490764E1D0C25AC4EF2FEF84D9C8C29">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="153EB948" sha1="B000F5FDFF6C7C9E2DFC60C6E683A23B17C59797">
            <board mapper="4">
                <prg size="64k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="partytap"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="1545BD13" sha1="DDEBE86096DAF3B6DCD714C33A91E912F91DA7CE">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="1590CF62" sha1="B38BF8EF9BB4522FADC6E27B71D087D50A98643F">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="159EF3C1" sha1="C145803B5FEE71172A890606A44C6D5DF6D2FA8F">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="15BFC1B4" sha1="FD184ED414E306C469A6601860E71D91CDF1DCF7">
            <board mapper="57">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="15F0D3F1" sha1="F7C9B6694362C244234257153B14A4F1A6093F6C">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="15FE6D0F" sha1="CE987AFB281F7D2B323AF43C3EF7BEC7DA045C63">
            <board type="NES-ETROM" mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="161D717B" sha1="19707A3B2444BF8D6EDF8213C81245D9A785E8E6">
            <board type="NES-TL1ROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="162CCBD0" sha1="18F71B0084F8CF65BD24CC3573B28ED65EC4688C">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="163A5EDA" sha1="372F4CB14180D8B962F87ACD3228B81167E29F43">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="163ECCAE" sha1="C44EE9A2670DAD440E5D8A47493FDCC8F05CE2A4">
            <board type="KONAMI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="1677D21D" sha1="D6629F40EE344EE0657F8C48132F480C1FAAE424">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="16A0A3A3" sha1="95B2782B26FD1CEF86997E59885358C410F832B0">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <arcade system="VS-Unisystem" dump="unknown" crc="16AA4E2D" sha1="52A06B9D7367845395EEB544AC5C73FD68A25B7D">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="16E93F39" sha1="519DE28E14FCAA3E574184A84AD614D250FDFA94">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="16EBA50A" sha1="9919837259C797EEA8862E0AE352FC3F587F4E91">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="171251E3" sha1="7F57EACE7CADA7C36412A50F2299231B304527A8">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="171251E3" sha1="7F57EACE7CADA7C36412A50F2299231B304527A8">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="174F860A" sha1="00DD4CFB090D608FBE667B4CCC9263831FAFB978">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="175C4A3C" sha1="CB9D5F7C4164DED9F9A507EFA0E7099791C32858">
            <board type="JALECO-JF-20" mapper="75">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="175EDA0B" sha1="F8EDF52C66444B36C148A3A93270BED9E3E9134D">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="1771EA8F" sha1="88B94AB854DC84FA375B778F5302987DB0EB63DA">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1773F76D" sha1="6DBEE225F87271F033BFA165E3560267249A3D11">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="179A0D57" sha1="0A491B125CA1D8BCEBFD19174527D9EEC13820D0">
            <board type="NES-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1829616A" sha1="2B5889759B3C5AFCF00F58F15879507945B33D57">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="183859D2" sha1="4037DB53D45DB20E3A131D722DCD317ADC966DEB">
            <board type="BANDAI-LZ93D50+24C01" mapper="159">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="184C2124" sha1="28DD1998DA8816EDEEA1C093087EC8C6916A359D">
            <board type="HVC-EWROM" mapper="5">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="32k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="18A04825" sha1="5705BEF5B0B172B56D21385AAE94BFA1F560E886">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="18A2E74F" sha1="C70DB279964E0F835427CA0A406D54A45AE7783A">
            <board type="NES-TGROM" mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="18A885B0" sha1="08A96B638CF480289406B3B85F2C86ECD3EAD812">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="18A9F0D9" sha1="2F8A9FD8CB6BB23E6C6285C2999A7D6E6B8CD686">
            <board type="NES-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="18B249E5" sha1="F18C7D82F624C6EFEB73E0A212997A28B90BDF85">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="18D44BBA" sha1="028C17789BCB480537A41FD576AD4454724B8339">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="192D546F" sha1="7DEA2FFBC0627C9616EF019088323CC77D33E485">
            <board type="NES-TL1ROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="19411BD7" sha1="6B54371423FCFE625E063341D8EDDE0A76D39E1E">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1948810E" sha1="B869E3963BFD529019042059386FAA50BB0853FE">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="194942DB" sha1="2DBACFD44D22D45B5B10FEDE3DD2AA224F4124CE">
            <board mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1973AEA8" sha1="EF6E092501D1C60000369E9463524101A450F360">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="198C2F41" sha1="FF6459BC3AF5743E3D303823999F33D74ABDF1AA">
            <board type="HVC-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="198C2F41" sha1="FF6459BC3AF5743E3D303823999F33D74ABDF1AA">
            <board type="HVC-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1992D163" sha1="FD88715A94381179834EEC298F78EC3B51FE43FE">
            <board type="NES-TEROM" mapper="4">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="19A7F794" sha1="30CED508809608EDB42C2A55A7FB43499A498A3C">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="19C1ED51" sha1="0E78391D3036D71C8241DB0206E7747F4E3892DC">
            <board mapper="243">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="19CE7F12" sha1="163EF0CF3614D303D9B29E8AA1F9C258030ECCA0">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="19E81461" sha1="87478B635FEFB25FA13C4876E20F505A97426C1B">
            <board mapper="157">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="1A128930" sha1="5BC5D7D50A37E1D9DA08883635CEE7BA0D3D08AA">
            <board mapper="241">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1A1D3CA2" sha1="4480BA11BBE733EA6B171696489F12000866C3F1">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1A2A7EF7" sha1="5437F45450954EF46B97E92517A9B48304772596">
            <board mapper="178">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1A2EA6B9" sha1="BEFA6B231A57EF9BC16EE8C6C68D909B7FF4F403">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1A39343C" sha1="8ED02893259C70B342BEF6701DE51F3140F30B1B">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1A7E97ED" sha1="3070AE548A4CF11BE2B21F1C05746E186B29C7A7">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1AA0DBAF" sha1="3EC81125B7FFB267B29603B8FBC3175EBD2DB8E1">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1AC701B5" sha1="70158A66CAA9C27033F4E11C4272C33E73893496">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerglove"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="1AE7B933" sha1="76D29C013CC6B09AA71875B9A458FFE92FF885F1">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1B0909AB" sha1="B5FA5CDFA0147A8E3DC1BCA8E6213C12C94BBEB5">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1B219E01" sha1="6B519F41BBD1984739B6A226140C0F0871889C2F">
            <board mapper="15">
                <prg size="1024k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1B3A3DB3" sha1="593FA4ED453BA5B0D0F1FFF16CA415307F247144">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1B421E9C" sha1="F6D26FD9C06EC1637B44881287DC1115D6F5F4C9">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1B45A73E" sha1="310B8C4A406B0CEB68C38E51FD0DBDFFE961A878">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="1B71CCDB" sha1="D4BB5EE1CBD7E5E9F55CA8544174589F697D6B6F">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1B7BD879" sha1="B07B17356A108874893C3D74DAC2178EB1314882">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="1B932BEA" sha1="8F6E3D7145E7856EAEC1BC1F195DF30631425C0E">
            <board type="NES-TGROM" mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1BC0BE6C" sha1="B4AA3F10908DC3D6B8152F5DEB1B8543B8B46BF6">
            <board mapper="195">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="9k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1BC686A8" sha1="334781C830F135CF30A33E392D8AAA4AFDC223F9">
            <board type="CAMERICA-BF9097" mapper="71">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="1BC686A8" sha1="334781C830F135CF30A33E392D8AAA4AFDC223F9">
            <board type="CAMERICA-BF9097" mapper="71">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="1C212E9D" sha1="C77EF94A6402A0C7A55C8F45367FAFA62F05A0D1">
            <board type="NES-TQROM" mapper="119">
                <prg size="128k"/>
                <chr size="64k"/>
                <vram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1C2A58FF" sha1="1353210C0760D1A647B8DAC8A7EDA1E9D3659E89">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1C66BAF6" sha1="E446B23889E56C2EDA2CB3EE4B75AC5C438450C2">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="1C9EA55C" sha1="5740DD443A07DCED95DF37ADC4CA567EC11A78D9">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="1CA45A6D" sha1="BDCD92FC82EDF09B00A9FF852DC2A96BEFAC1B99">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1CED086F" sha1="46C0B521B3C595409C05972388909CCB0D5F6369">
            <board mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1CEE0C21" sha1="8E699F08869D84CB8F310335E6D6BEC08C1ECE60">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1CF48EF1" sha1="CE7436159E3BB96B196F6C45D5F32DA5ABD01796">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1D0F4D6B" sha1="9C3BCD2BF8224B158B6FF2E47B67CDA66CB4AC39">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1D20A5C6" sha1="583E112FD794AD3B9BCDAE23EB22005C208AA4EE">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1D2D93FF" sha1="C2BC09AE256C6E95CDC2BF4E508DD94EF2168296">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1D41CC8C" sha1="053FC3A3A6D282CD8F843DADE2E0D53D6DBDD7E1">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1D5B03A5" sha1="813E6A8BC0A502BB393F8729B1BC19836D5421A5">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1D6DECCC" sha1="10B9E6EEE7305F8ECA3004A732D748212D947F52">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1D715C1A" sha1="CC8801CADD85C173821EDC751052572A8E8148F7">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1D89610E" sha1="839D7DE8101A228A69C7A067AECE9BEE79F4FCA7">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1D8BF724" sha1="3954B966C85FEE05E15DB443F00B7816D565BF21">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1DA2C17B" sha1="5361A708A2502F0E94D10CBF0E55777C59E16D61">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1DAC6208" sha1="76E71F32551D60D3AF26EB4AD15F4BDE7C6CA29B">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1DB07C0D" sha1="87E536B900DB2976E6B3BD682A4D7ED88AC19DCD">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1DBD1D2B" sha1="E36880D2189BC99BA345081B2F359307A6610532">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1DC0F740" sha1="97E7E61EECB73CB1EA0C15AE51E65EA56301A685">
            <board type="NAMCOT-163" mapper="19">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1E472E7A" sha1="C9056C8E07229240D626DD7A81B20FA2D0795847">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1E4D3831" sha1="31E4F407AE0B25BB37D118A6DCAC93C737683B46">
            <board type="HVC-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="1E66861F" sha1="EDF63A18C3DD2B6551528E20CE8D3581575ADA11">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1EB4A920" sha1="E54BB51B9D78810300F3A105F7437D73D7C8BCC1">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1EBB5B42" sha1="2E401097B7B6F5DE5B0F88E6A97C5675BD916801">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1ED48C5C" sha1="B0A69803C8CEEBABC09BA546227EECF1916F92ED">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="1ED5C801" sha1="31144C7C436CC78D7FD3AC42B224EEE3A6C2BABC">
            <board type="NES-TSROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1ED7D6BE" sha1="F664C1AB268FFD036E43C2B8F3E79320842DAE37">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1EEB3A4E" sha1="9DEA0F4631BF7BA1AFA9DED4A7AE15657339F3A4">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="1EFE38EB" sha1="5D940B2224946DEF3F9F9FAD13D879170F3BF494">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1F1326D4" sha1="CE1B236ED0EAC133A3DE5411AEF57228220885EF">
            <board mapper="121">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="1F2D9DB7" sha1="544203A8304A7922A46579512665C743527CA1E6">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-PAL-B" dump="ok" crc="1F6660E6" sha1="C22B448E263F25562816E09057233255B0AD735C">
            <board type="NES-SCROM" mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1F6EA423" sha1="A2E9E58D5E12A87BEAF14EE6E485D0BD95E9876E">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="1F74EA6C" sha1="37D8903AB381090873A6C51C39F6120A7213FB6D">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="1FA8C4A4" sha1="75E2F1D11AF7D3241610DB918291D06F2A4D09DC">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="2019FE65" sha1="4E38B4C231C44BB1408AC6C6F941A136DD33D0EB">
            <board mapper="68">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="20353E63" sha1="4C45D17B90B037FD3B7EA4778F217DD5B5E063D8">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2055971A" sha1="3A92C6FE11F730AC71023F80AD041D9813A93455">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2061772A" sha1="3A8D19E15566CA78C390854CA97F5527E54DA879">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="207E618C" sha1="F6D9E36C463C9285534B49BA70D8239749842BD9">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="208DF309" sha1="638EB5C6E5993F05FE79F2CE7601020F130DA9E9">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="209B4BED" sha1="84CCB974196FA5D9AB4A15111488C9C639CCB2EA">
            <board type="KONAMI-VRC-6" mapper="26">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="Konami VRC VI">
                    <pin number="9" function="PRG A0"/>
                    <pin number="10" function="PRG A1"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="209F3587" sha1="D04D27FF1F5161B29AD1BB1EE3A610439DD0C9B9">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="20A5219B" sha1="D51A5A4A9747E0F33A4BDD502B918395EE6EFA5B">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="20AF7E1A" sha1="2DCF131D8FC82C8157434E4CD7429426B0FF56CD">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="20C5D187" sha1="DC1F84680B755D429D7E2779CABA1D2986582F30">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="20C795EB" sha1="ED281797EFF64CBA96897B59D85AE5E61F67353A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="20CC079D" sha1="196F0CC52131AD059F26322EBD0CE68D9A8727D3">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="20DF0149" sha1="67E86430CA68FEAA1EC08E73B90AC1DF5FA75A25">
            <board mapper="45">
                <prg size="512k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="20F98977" sha1="F2E03874495CCC5AB416D8682D00B176D2FD2C1A">
            <board mapper="87">
                <prg size="16k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="20F98F2A" sha1="A1D674D1C7C633A317CFD516EFB9A0350CD0E45E">
            <board type="TAITO-74*161/161/32" mapper="152">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="213CB3FB" sha1="44B6EC42BEBD50E9165E502880198B1804AAA775">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2194BB29" sha1="228DC5CD2D067AB42C692BE38EAEE49F57DBFE66">
            <board mapper="159">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="219DFABF" sha1="3C23C5D89B870591FBB511346772305629305BED">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="21A653C7" sha1="40A801FF63DB5E719A8A53537C1C78F398483FC8">
            <board type="NES-DRROM" mapper="206">
                <prg size="32k"/>
                <chr size="32k"/>
                <vram size="2k"/>
            </board>
        </arcade>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="21DD2174" sha1="8323A68AB1C7C6B042F336E12C54AD7717FAC693">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="21F2A1A6" sha1="D72D5A390ADCA2210153E2B4DBC0A3229100D125">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="konamihypershot"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="21F85681" sha1="75095B48D380AE817F8CBC199905AF88818CB423">
            <board mapper="87">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="21F8C4AB" sha1="63274AE9DBC1ED078632DB1EDEEFCCEC79297E26">
            <board type="SUNSOFT-2" mapper="89">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2220E14A" sha1="EE36B29BDB4BD81043DC2B7BD273665F8CED6DA9">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2225C20F" sha1="209911D7BD15ABB7BEF2E35A473DF725B6738CD7">
            <board type="NES-SOROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="22276213" sha1="23670DE9B3E5B6BEE81F4515999CD13A2FFA02D0">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="227CF577" sha1="44FC14813924B380F94367818FE8DCA96DB9EE4B">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="22A228BD" sha1="854828F13DD7A6E94DE19442AC829B1BFE1CD746">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="22A711C6" sha1="F4BAC4C3C5AF2E656CF86C57E87FF83C673FBC2B">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="22AB9694" sha1="AD5C446E1C3368295CE6431C79569A3B321AAF21">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="22D6D5BD" sha1="123045D5E8CF038C2FD396BD266EEF96DAFF9BCD">
            <board mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="22EEEC6D" sha1="3DCFFF6ED1A6CEC9B0786C765A103C0233BC5BFD">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="22F95FF1" sha1="DF1676521E46F7B5482FF9C147B2C0BC6098B8B3">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="unknown" crc="231BC76E" sha1="3F405F60A43B2B577A2BAEF1FF50480C83418209">
            <board mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2328046E" sha1="03130F8464B3F4418427BF124EB15FBAEB86E09D">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="23386B90" sha1="F348AFBF12C38DB9E3342D3B13162375F62F4C7D">
            <board mapper="83">
                <prg size="256k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2370C0A9" sha1="0D173FA60B6D17592C1654463ECF0C20924C16C1">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="238E1848" sha1="CC04B90A653F3DF7F86C996424D9660202E0DADC">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2394AE1C" sha1="CA8905C8AB70154E77CA1C93FE014DB2DE51BF2A">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="23B87A6D" sha1="7EA54E459CC6094FD707C8A7425B5236D5746FCC">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="23BEFF5E" sha1="52CDBF7200F6664059C0C3ECC4BDC7553D3FA282">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="23BF0507" sha1="04ABBC1AB746B24D5EE71D53AB4A3F2051A15817">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="23C3FB2D" sha1="46CC4F6A0271828567419602CE19AB87F46062A5">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="23D17F5E" sha1="ACEDC9D3936D17FB0F05B45A5B468F6B00E389FB">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="23D7D48F" sha1="6A6579963319CC14DA457C963FA43741BFBF645C">
            <board mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="23D91BC6" sha1="1128ED677399F969E25D9453320B85EF3D3BA35A">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="23E9C736" sha1="835A0F9A3DDD516CECBCCF34FBE8F7632F297558">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="23F4B48F" sha1="6B25180C4F73928FD7BA773D41635D32A20FDF3D">
            <board mapper="4">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="240C6DE8" sha1="64952D7C1A1C79438C80BE9CBECC085C01E5636B">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="240DE736" sha1="4CF5D092693E94BBF7AFD3E15E05CC580CA33DF2">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="243A8735" sha1="7E4180432726A433C46BA2206D9E13B32761C11E">
            <board type="IREM-G101-B" mapper="32">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2447E03B" sha1="2185F8F3D0FD282C034DC397AE3301DE76139EB8">
            <board mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="24598791" sha1="FB853A77E02F1CEAE933DFF762CD0C2F6E0B2E27">
            <board type="HVC-RROM" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="24598791" sha1="FB853A77E02F1CEAE933DFF762CD0C2F6E0B2E27">
            <board type="HVC-RROM" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="24598791" sha1="FB853A77E02F1CEAE933DFF762CD0C2F6E0B2E27">
            <board type="HVC-RROM" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="24673747" sha1="8894ECCEF15B1AA253392FA18F2A34256FAF532E">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2470402B" sha1="2B1417C95FD68607401B27F145761A5C332FA600">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2472C3EB" sha1="95E86C77BB25DD23152D34FD0BB562A09535BE43">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="247CC73D" sha1="FDCDD1AF75B865107D3A8BEB2C35574033FE18D1">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="16k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="24826927" sha1="37219BDB448A21B52D180F118878ECE8868F8B29">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="248566A7" sha1="7A546CF7779765AA4CB2A76CDFB3CBAF7F804612">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="24BA12DD" sha1="C7FD43041FC139DC8440C95C28A0115DC79E2691">
            <board type="CAMERICA-ALGN" mapper="71">
                <prg size="256k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="24BA12DD" sha1="C7FD43041FC139DC8440C95C28A0115DC79E2691">
            <board type="CAMERICA-ALGN" mapper="71">
                <prg size="256k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="24BA90CA" sha1="B0DD9AD5FA5BF5C83ADDCE3F3FC48382DD03C937">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="24EECC15" sha1="A39E3BADB40CC79C9B6CF40301AA2DBEBD2E31FC">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="24F4F397" sha1="91180A88546C75C5BB5E80101D9694722D0887DF">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="250F7913" sha1="957ECC025DE4177AB582E7309DFF283F16DC7130">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2526C943" sha1="5C05955A2D8547AA3B2CAF582517EDFB98D93975">
            <board mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="252FFD12" sha1="A07BD0FDF7BA3A30FC4E40D50373CB77A9627EEE">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2538D860" sha1="897F017C7E5D5A19D5B72A9434FFB136D0DA6D46">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2545214C" sha1="240E445AB95C3A5AFBEF63E9239EACC9F9FE1E19">
            <board type="NES-SAROM" mapper="1">
                <prg size="64k"/>
                <chr size="16k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="25468546" sha1="80203670B3DFC48BF79083637A7122ECB192B470">
            <board type="BANDAI-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2554F9FD" sha1="D9FF58B855B24715E545AF7A86BB4E69DB59C871">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="25551F3F" sha1="7329A36D5C38270BBEBA4BC613A874550BE49CE8">
            <board type="NES-PNROM" mapper="9">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="256392F1" sha1="3251A05EDC09C57CF15F38CB568408A559871405">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2565786D" sha1="AFC90CCB61CED560AD36310BB0B0FA8702D3F999">
            <board mapper="19">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="25952141" sha1="65164022F5F3354B168972CC3FF85F4F01808169">
            <board type="NES-TKROM" mapper="4">
                <prg size="512k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="25EDAF5C" sha1="97450BF88F2F86D5E8EBB68AB44E01D2B57485E8">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="26049798" sha1="399965007CBAAFA80A51F1F19BD33675401A6D56">
            <board type="HVC-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="262B5A1D" sha1="1A63EFF5D4544473E2BBEC23D9DC0089EBF083FF">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="263AC8A0" sha1="CF3EE859EDAC2D22B508F71242D03BF4E8F70249">
            <board type="NES-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="264F26B1" sha1="54ECBE35A23A5AB81DEBF78F35A521E722B36385">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2651F227" sha1="C87B3E1F17670C028CE60AF3BBC7D688DC0F9DF3">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="26535EF5" sha1="4BEB2E1C8CB14CFBC4E37CC266DB2A1B2FEA23CA">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="26796758" sha1="7C414EB708C8A8E184C9602B9EFFEC87D6E92EEF">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="267DE4CC" sha1="A253DF603C207866373BE55076A5616E3BCAD2EB">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="268E39D0" sha1="784D6534D57AA7236E6194F0CB72DECFAF788DCB">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="26BB1C8C" sha1="F763405D61BF894F7919DCF9637DCD8CC07522A9">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="26BD6EC6" sha1="FEB3013505143AD926E5307ACF2F2EC177E18D4F">
            <board type="NAMCOT-3303" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="26BFED27" sha1="950031A1A44DFE6929E5EFC128DAD72F3C65FF27">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="26CEC726" sha1="042B6C21E7C895D2810463C4C3BFBFC52B839B3B">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="26D3082C" sha1="76DB18B90FB2B76FA685D6462846ED3A92F5CBD4">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="26E39935" sha1="3DC0CF9EBCFA2CA98073EA5F0B34C4CE67D2582B">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="26E82008" sha1="500A33B485EFDE268A876136F6FDABCDA23EBE50">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="26EF50E3" sha1="081D107B5AEFFD4F59108C76FA3942506FA36B1F">
            <board mapper="195">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="9k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2705EAEB" sha1="2B1042BC0380989A820526CBC6220AE21E4EE624">
            <board type="MLT-MAXI15" mapper="234">
                <prg size="512k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="270EAED5" sha1="E57A8C9ADF011A61D4BC6D9A5970E9B6AE542187">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2746B39E" sha1="06890A6B8DADFFC2875CE4DBF82C9B314BE97AE1">
            <board type="HVC-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="276237B3" sha1="91B6688A1EDBEE66FBC094FA5C0DBBE7A7CB5B46">
            <board mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="276AC722" sha1="42882AFB5A2224380E776A7FAA7510B5D91FEA35">
            <board type="BANDAI-LZ93D50+24C01" mapper="159">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2772F17C" sha1="4F573265EC6F0AB4A93036D3DB9C7C47F4F8A872">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="27738241" sha1="455C9E9975C8DB58DE87D3396D062EFA6F57422A">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="27777635" sha1="BF2E3B079771BC20C48BEFBA9F05BF6504C2D6FE">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="27777635" sha1="BF2E3B079771BC20C48BEFBA9F05BF6504C2D6FE">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="279710DC" sha1="D85C9FF489672534FBF61A15F8FA56FFF489A34B">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="27AA3933" sha1="0D8166E5EEEA84524F9711094F5F325A682C4E56">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="27C16011" sha1="780ED4C78F02001B364026649B42EF7D9104588B">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="27D14A54" sha1="020061B780EFB8CD71AE29F1944E3FD2D9D18172">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="27D34A57" sha1="34C0191C7252BBE6450AD7B19E45F8B0D676789C">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="27DDF227" sha1="64687D063CCBCF7B4C49604E0612A4D331D2AA88">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="27F3A202" sha1="11FDD6ACE7BB0FD549D8280E3C45C9B6F7237137">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="27F8D0D2" sha1="0EBCD821E2888E55E0436A95AF687848CC7D82B7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="280AD3C5" sha1="2B64B767559F9172644A97242912D97229114E02">
            <board type="NES-SCROM" mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="281326ED" sha1="DC8DDB78CBB575623B701954DF951F05E81388EA">
            <board mapper="142">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="282745C5" sha1="568BF236FB3085B8BD522FBD2C18C7831E3A2DD1">
            <board mapper="141">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="283AD224" sha1="91CECCFCAC90E417E9AEE80E8F7B560A20EB33CC">
            <board mapper="32">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="28492586" sha1="6E65B7AA2A88FD9BE63BE2C8FA1187497029074F">
            <board type="NES-TEROM" mapper="4">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="284E65E8" sha1="0CD79D2CB342297A25F487A3C3DFB84100C451D2">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="284E65E8" sha1="0CD79D2CB342297A25F487A3C3DFB84100C451D2">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2856111F" sha1="71EF9BC37658A99DCDB0EB5BF858ABC129351DC4">
            <board type="VIRGIN-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2858933B" sha1="86ADE7BE14F83EB0EC39FA52AA4A5DCD109AEFA1">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="286FCD20" sha1="B9BE6C9D21272DD6E60B27FC081F712B5C9797A8">
            <board type="KONAMI-VRC-4" mapper="21">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A7"/>
                    <pin number="4" function="PRG A6"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="28A377FC" sha1="2F883BB15BE852293AEEB595FA5B350D1248A1B9">
            <board mapper="58">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="28C1D3D5" sha1="E0D67E5E63554DCEBB2CC21CC2AA7CCC516A6839">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="28C2DFCE" sha1="78C6435AF4C99D6B36994F26547BB04F0EADBE8D">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="28F9B41F" sha1="20D7C80529312BCC24C4FBD8F727A304AFFF3102">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="28FB71AE" sha1="F367D283A17483BDC1B5C76A6686C74552BB5F97">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="291BCD7D" sha1="DBA7F9062891512736327FE09EFAE802B21FAF4D">
            <board type="HVC-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="29582CA1" sha1="647C17A93DD1428417239ADC38B58367173C59DB">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2969A5C1" sha1="BCED3C0D179920324C0A387F259447CADA4448EC">
            <board type="AVE-NINA-03" mapper="79">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="297198B9" sha1="C0AEC26DC3132A60E9E45C3FFAAE49B7906BC517">
            <board mapper="4">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="29DE87AF" sha1="2FFA0582F4B7755C18D4973F3CC4A1ABFF9C1E6C">
            <board type="BANDAI-PT-554" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="29E173FF" sha1="7A5B0785EA57173C3D30E1CA0BC3814675652B7C">
            <board type="TAITO-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="29EC0FD1" sha1="3E753D57F5F5E72810E8B11827FECDC714F1891A">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2A01F9D1" sha1="A4B57C424744D232C059ED7745ED41B280DFD73B">
            <board type="NAMCOT-3416" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2A1919FE" sha1="BFB57311EFD98A4C3E95023CA8262D044A6635F2">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="2A3CA509" sha1="1DA6DB935BFCCF9876BDB85667E7D814BCE85842">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2A46B57F" sha1="B5691E6297AE8A2557DD35E53E08AFFA8BA22C66">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2A5F4C5A" sha1="067D4633DF309A705FEFD3F2F82D456FC19B877D">
            <board mapper="132">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="2A6559A1" sha1="DFDC66923F7C99420002A2D98B67830EE49BE2DB">
            <board mapper="33">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2A662AC7" sha1="3B372EEA17FBC1DEE4DBF9AF28A3E61E0FAD4445">
            <board type="NES-AOROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2A7D3ADF" sha1="489D1FC30630D3AD60835992C2433250A8E0803E">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2A971204" sha1="AAF460ABFE0DE077CAF5E8DA1B2C9548831EB09D">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2AC5233C" sha1="C315D00648CBCCF5E78EDE4638532163DB8FAF50">
            <board type="KONAMI-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2AC87283" sha1="C9723C2C2722D26DE6712695C104FB139A734500">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2AE97660" sha1="2D48241F5453DDA96FEC840F9E9501979B07B73C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="2AF8332A" sha1="E6EC5A626CAC4DEDFEFDB5406DCACBF960D7B7B5">
            <board mapper="0">
                <prg size="32k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2B11E0B0" sha1="09D5FE3DBC077FCC3AC9438713F4E60B34749B43">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="2B1497DC" sha1="757AB53FBFF0ADF1C2C2E05A35AB861365021057">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2B160BF0" sha1="480D53A0C6FE97AD35BE8BFA6EA50D3FAD005486">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="2B20B022" sha1="4F94BDD09B7092C94A17FB48F38CD7A6F369891B">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2B378D11" sha1="4B0A6F62A5DF2B6022357AA0C18978798299459B">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2B462010" sha1="0F85A4D325B97D7977177B9C7808F0558239766E">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2B4D80AE" sha1="AC13516A0CD33273DBD92A013C14179B5ACC2DA2">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="2B511B51" sha1="6287B45DD16BD8366E9D58A6F135ECD81502A1B4">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="2B85420E" sha1="2191BC8619EF2EC4E242FFC42402E6764FB4A740">
            <board mapper="1">
                <prg size="64k"/>
                <chr size="32k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2BB3DABE" sha1="0E824AE30B83CFD1D3803CD6CC6222DD99883C08">
            <board mapper="82">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2BB6A0F8" sha1="1FB87E6A35EC7F9A7E6D193469F64A9016DAA4C1">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2BBA037A" sha1="B6D1C372A38D196112AA98905C709AD844BD6627">
            <board mapper="60">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2BC25D5A" sha1="CABE711271A3012BB6C37F33F07DB5A3D5B8C02F">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2BC67AA8" sha1="673A888C468ABE33FB0B3F063C6837DD21D5D32B">
            <board type="NES-TGROM" mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2BCF2132" sha1="B3B3801083713F538BCA1D9DF612E19603B4311E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2BE254E9" sha1="D85654B8C8009BB7B503B9ECA4DE61C23AFD0CA9">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="2BF0F9C5" sha1="1760FF410B7EC5A4540E9844686EE91932EAA1AD">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2BF61C53" sha1="2B8FBE96C01E329B116ECBB1C9D0B3B0862E0AE4">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2BFB1186" sha1="EF6E94731E57ED4AC971D8B3BE5D783C3546478E">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2C043781" sha1="E5E04E9E56AC9F0B7079AB6286E2D3A0F2D12E05">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="2C088DC5" sha1="0F2883D7D2DE3FFBF8A854EA66904D262592CCF9">
            <board type="NES-TKROM" mapper="4">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2C163614" sha1="7B721A638F710B277756BEA622E3EDF7FC096424">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2C2DDFB4" sha1="3EDFED96531AC671DD6F5BD468B708E73200A8FB">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2C33161D" sha1="85DC8BF106CBE7E3359B30337DFB07ABB43A31B2">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2C4421B2" sha1="869C2F50F936C17CB1B13E9016E44E474137A320">
            <board type="BANDAI-FCG-2" mapper="153">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2C5908A7" sha1="2A12752F779F83782196EB0CD4DC1E426059D305">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2C818014" sha1="B6F6BD9D78CDD264A117D4B647AEE3309993E9A9">
            <board type="NES-PNROM" mapper="9">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2CA9BF7F" sha1="B9F444FF60F60C177EEEC8671BEC3731B0F6FE49">
            <board mapper="223">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2CAAE01C" sha1="CC03A83C6AD9BBB858EE5FF04E9E7B2362EEA06A">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="2D020965" sha1="4FD939373EED4ADD41A1C68C9C2412BD3B428F32">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="2D1FEE70" sha1="2A0A444DAE8B5B02F4E5F1B789E16356F3AB08F0">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2D273AA4" sha1="3C7EECF8586D4C8370E27DB1815A6EE0E33FB683">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2D2F91B8" sha1="353CA084B7C69058CF7B8FC681A42A770F836B87">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2D41EF92" sha1="34C1981EF6407280B2C2EC2CAD0492C565DBB2ED">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2D664D99" sha1="47336976A531FAB2592AF636A630A290EB036D18">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2D75C7A9" sha1="7375E48509F05E91C9DE9B326E047C0D0C7ACFAD">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="2D782595" sha1="64033E61F1E27CE2D1707A5A6E66074194CA006C">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2DB7C31E" sha1="9BF95EEB404F103422E06214566C7D918ED4DC79">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2DC05A6F" sha1="1FCAB3D48706FD7C9E8EE0F06B7A111D9C888F77">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2DC331A2" sha1="D8897FA7E506F739F10A41312F7D7A7E1749D16B">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2DDC2DC3" sha1="512DAC9D8CB201C64176325FC7BD685DE14C4BD8">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2DFF7FDC" sha1="A08174EAC44CB2AC0412B65288AE72358A91080F">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2E0741B6" sha1="2F6EC4BE3CCC64DD4855924C2699D1BB9B8890B6">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2E1E7FD8" sha1="572F719D09C6538477AF240C81950D43B133C480">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2E2ACAE9" sha1="31E7A573CB6409774901EBBE8F09B056D34D0225">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2E326A1D" sha1="576CD388EC31CE20A89EFCCEC6E960388914C597">
            <board type="TENGEN-800002" mapper="206">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2E563C66" sha1="43C4FEA145A6812812F9F9A261816F05985C3F06">
            <board type="NAMCOT-3415" mapper="206">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2E6301ED" sha1="BB894D104C796F69BA16587EB66C0275F5C2FC02">
            <board type="NES-TSROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2E68ACFC" sha1="6775C06E3EF05AFFD891C96CAC14109D60FB8E80">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2E6B1432" sha1="8457ADAEDD883E57FC17734EDE4AC5F0BC9C0559">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="2E6EE98D" sha1="6BF4A9BF5EB2F512182A69073F42C09333473D38">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2EA8CC16" sha1="DD7B6084032EDCE204862153FD32039E32DA884C">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2EBF2E0D" sha1="0E37A2766280D73F2921567348A8D360707A5924">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2F2D1FA9" sha1="FFA15151EB16AFF9618FA99E159FADE06EB46F2B">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2F2E30F7" sha1="22E620EF21DE748F49E425DF1A35401922EB3406">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2F462388" sha1="FA1D3F4DC848F54DA644BC716FCCC5F685DBA6C9">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2F52BBE0" sha1="26C5CA15D5DDF84E8C1608EF3EED977F47C27657">
            <board mapper="148">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="2F55BE88" sha1="58BF3E3E50CA61DB95B9D1631312E8E01D2017D7">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2F66E302" sha1="0CFF857E3F0E1DA39E0F02A8A70B2EF9D263E503">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2F698C4D" sha1="3C0FF6F5760DE40C6701B7D07C1C6DFC6B022042">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2F8EC233" sha1="9D1E2E8DBA6DEBE0B6FFB075EA4AADB81A36F7DC">
            <board mapper="236">
                <prg size="128k"/>
                <chr size="64k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2FC1ABAE" sha1="157935D06A39E47C27F91AA7F3106C491871C61F">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="2FD2E632" sha1="5700DE705C481B919D7549A0FD1706E1BB1B5603">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="2FE20D79" sha1="AD99C84C67659AF576A57CB500B8DEE82ADED7DD">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="2FFDE228" sha1="956A4A32999E39CDACDC146664B87FA96BF0CBD6">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="303D4371" sha1="95AA585F630282E7A21B070732F9AA0D3171E150">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="304FA926" sha1="EFFE8CCAA78F94F061B142042557B478B4B213EE">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3057B904" sha1="FB1B06F9510BF0BFD6FDC431B71C82ADE4F34BD8">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="305B4E62" sha1="B630AF147818FA61A1B45551F35C4FB4BC1357AA">
            <board type="KONAMI-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL-B" dump="ok" crc="308DA987" sha1="3B26DCD54CF922A6AAA6265087B56DEF4C109A7E">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="30BF2DBA" sha1="5E5C20907A3EFA2768C0BD35AC518DAD607F7902">
            <board type="JALECO-JF-13" mapper="86">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="D7756C"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="30C5E6CF" sha1="AB207029D164BAAF87C802E4FDBBA06B575AEC06">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="30F9BB46" sha1="5D9D519B84E245891928F3482A42A071E4402B6C">
            <board mapper="242">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="313491ED" sha1="0FFE5AA3FBEE72601BD629849A30379937D170D7">
            <board mapper="50">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="31957AE4" sha1="AF9512072A2DC6343CD212D78109BFD09C17DA9D">
            <board mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="31B44C65" sha1="AD2EC724D6E2DC8E396995431DD2E10995222ED8">
            <board type="HVC-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="31C1BF98" sha1="BCB189393D73300D517F65FFF8A18FA15811F16E">
            <board mapper="163">
                <prg size="2048k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="31C7AD13" sha1="BF0B820725B2CBF8F888DCCAF034BB98E3A90DA2">
            <board type="HVC-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="32086826" sha1="5E3C02A3A5F6CD4F2442311630F1C44A8E9DC7E2">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="322F723A" sha1="E98B658B3EB07F5B70C97BA82A0D8A573753876B">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3256114C" sha1="D136CF62BD85A58994BD35AA8861C622655B0D8B">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="326AB3B6" sha1="C74D5CD42C2D29B3358A59FD66757EB00B130A75">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3275FD7E" sha1="62ECA1BE825B00DB305B4076CF6C078F6CF1965B">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="32CD7DE2" sha1="200E5B57CE68676E5B5159A551EBBE8EBFBA063F">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="32CF4307" sha1="754B1F27C3FCADA8FAC6871366146E0767A4AE37">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="32FA246F" sha1="1FB9DE53F0BB2AD79F3A30B78ADDC544321148B3">
            <board type="NAMCOT-3311" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="arkanoid"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="32FB0583" sha1="230FC31D2C2EB20E78711C82574F29F28117EBA3">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3306AAB2" sha1="CCC59C93EE66AACF3065128DE79AE23DF0B0E379">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="330DE468" sha1="C4BF6A7D0F5B3A68F18E355D8C45B8032D4D9661">
            <board type="BANDAI-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3322105A" sha1="84CA9A06B01C4E2EBEB46C73DF2F270FF5439986">
            <board type="NES-SHROM" mapper="1">
                <prg size="32k"/>
                <chr size="128k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="332C47E0" sha1="688768E19662F2A81B67EAE8BECC90D4A289E536">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="333C48A0" sha1="DC4E54BBC56129F2BD72481A4E7723147E843313">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3348E3BD" sha1="263409A1374F520BCA8656A17CB85344402AAAB6">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="336093EF" sha1="CDBA5D85EF27697D35B21E1F8994CE8F4E554CA6">
            <board type="HVC-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3368F7FB" sha1="4AFCADA217C73BE2242CBFD1D2CF11D9AA26D88A">
            <board type="NES-AOROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="339437F6" sha1="263B3E3FF9FEBA62B646851FADACA3E1E20B6FC9">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="33B899C9" sha1="757A4B9ED661DC6A6F33532AE64B0B063C79DBB3">
            <board type="BANDAI-FCG-1" mapper="153">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="33C5DF92" sha1="F99E8B7C7A2174BF0B2330F5457AEE478A938C93">
            <board mapper="195">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="9k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="" crc="33CE3FF0" sha1="C87E7E6A68DD9C7E24652CD2C7D390A14E8ADF04">
            <board mapper="85">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="340713DD" sha1="B60AA8A5FF628E00259872AF4E51CEBADDFDDCBE">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="3417EC46" sha1="9DF474AC357D05FC9AA86AE270CF561A025909EE">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="342727B1" sha1="89736BEB224B5C044DE00F04EC7C37CED329B6AC">
            <board type="TAITO-X1-005" mapper="80">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="343C7BB0" sha1="E675D418256854070F76136602DFC7545F5171AE">
            <board type="TENGEN-800008" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="345D3A1A" sha1="B7DF6A730C35B6EC4CD847EA22D2445054FDAB4A">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="345EE51A" sha1="9C801071D1AAC7B280468C38BF1B61FDE99B5FD0">
            <board mapper="245">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="34629104" sha1="95A47784396A06EB351D1184FD5A90B7E767FC5C">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="348D3FF1" sha1="18EA387B2DFA717D3208E054AF927F575963ED46">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="34BB757B" sha1="31C720F9A75EB2D069244BD257AA23DE6B5BCE8B">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="34C1E893" sha1="4BD6B3535FCC04F7570FE754645EB5D3997A02AA">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="34DDF806" sha1="CB319AE39B41D8ED695FA40BDD899BE4AA839F2D">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="34DEBDFD" sha1="084AC1E599F1BE679EEEBD5D51D604DC9E5708F3">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="34EAB034" sha1="3065EF157AB5F34FA05022261D7BF6EF79DAD5C9">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="350D835E" sha1="9282E87C643557682AEE674174821BF3A0FE3876">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="35476E87" sha1="37B143AB583244D64E9CE7F7AC90543202970F69">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="358E29DD" sha1="C699445B7943E5CFE3C72D838D8A3BD014E93254">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="35B6FEBF" sha1="351937AAFFC553F163343FAD3FE8B8DE2A20C328">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="35C41CD4" sha1="3460727CB7E7EB3886C69E0E75006F7ED0857C4B">
            <board type="NES-SJROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="35C6F574" sha1="2E3F613B2918D253D893E5210FE2E43543C88C59">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="35D8C961" sha1="3D115307A560A0552487F6293C5BD7A5899F5E7A">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="35EFFD0E" sha1="58FA3B8F76ADFF009035E8AF6C0A3C272A5D2331">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="360AA8B4" sha1="CBD7B6A22CA18F7F53ECC7F3E49EEA1C5F59D3A8">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="362000F0" sha1="33AEE768A53300386644A8A0ED394CEA2A7A14B4">
            <board mapper="90">
                <prg size="256k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="36584C96" sha1="D51CE62AC3C3B29DF076DEE1973FA5F9B4CC2609">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3674FFDB" sha1="EFA29E1B137E042BD0AA07EDD4312E25FBF5AF0E">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="368C19A8" sha1="1B8675B55DDD3D0430358EA3A2F888F210C8F680">
            <board mapper="34">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3691C120" sha1="869BACF32C403E92D0FEAAD853F97A9E6D386BF3">
            <board mapper="18">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="369DA42D" sha1="F9496F46DF292142DB317AC18ECBE1AE856C2724">
            <board mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="36B35988" sha1="0BF53ABFB80755F4570864432BC37A86AA93B3C8">
            <board type="AVE-MB-91" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="36C3B13A" sha1="EA4E90BED794AC2C1DB8BCFB74362F5223B816D9">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="36ECDE11" sha1="E05B0FCA7EA2F6433FA06DD204F7265417B91BBE">
            <board mapper="197">
                <prg size="128k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="37088EFF" sha1="780FB2A9ADBAEA8FC19C6064551F45E53DD1DDC2">
            <board type="NES-TKROM" mapper="4">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="370CEB65" sha1="43ABFA9259B10D3B6EE84D39B6F24AF7A71C85C4">
            <board mapper="70">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="37138039" sha1="D55E8202929D922A84122921EF5C9671135B3E77">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3719A26D" sha1="F8207CE6E3E8FBB450F84480436BB584DB90FDDD">
            <board type="NAMCOT-3407" mapper="206">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="37397194" sha1="73EB2ADA21C1A5A71E54F20DE986C3F41FA69916">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="376138D8" sha1="8C7D33753649A2BAF2EAAF8D5FFC2AE8E9316A13">
            <board mapper="33">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="37A5EB52" sha1="DA72F34057A1C8FEA703A3D68DA8F53D78A75EF5">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="37B62D04" sha1="5D6997B11ED701F2085288AF4D1B6E8E99F35736">
            <board mapper="118">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="37BA3261" sha1="4EF017EF87D84DC15B2C1F919E05066BE9559DC8">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="37C474D5" sha1="01D18E312DDC8233B4A98BC2C711DA907676D3D1">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="37CB1801" sha1="8940487A99647FD965732EB5791BBDEAE9E1FB8F">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="37F59450" sha1="1BA180792CD1560DBAC295A7A0292B52F458EA0E">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="3824F7A5" sha1="4AD06ED3FCAB7CFEBC7DC23E75C7B599928A889A">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3836EEAC" sha1="47B019360F011B0FDDE9203E5EA1EB023D5C3DC8">
            <board type="HVC-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="383CABBF" sha1="63B1B7ADDD85F6DF6AC46FA076A30C5BCB45590A">
            <board type="NES-TQROM" mapper="119">
                <prg size="128k"/>
                <chr size="64k"/>
                <vram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="38645C11" sha1="D004FFE696E267C7DE38F2B0098938F843060C66">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3869E598" sha1="BE883F2571A2D8CF01BAEA3DE80BFDFA325CA0E7">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3877CE9E" sha1="3BC3022D819729D9DDB83337CE0B6A84FC3A10AC">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="387A616E" sha1="C62265FFAACE487BBDC4186526F4DB5DC576656B">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="38810A91" sha1="65CAAC674F3847ED46654313382ECC0F854A0F54">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="38810A91" sha1="65CAAC674F3847ED46654313382ECC0F854A0F54">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="38946C43" sha1="57770A1B73CE69B2FEB9799A9AB98DFA41ADF86D">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="38971147" sha1="AD1FADDA8289119C14B9704653194C95B058BBDF">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="38B590E4" sha1="A601D165BBCDCD2D5EE1DC98E0E1292191AB675A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="38BFC03C" sha1="815A09CD230F05DCADE137B5510CB4F51AB9F28F">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="38D314DB" sha1="31AE0BD17A9C8C399F1384CA20CA09A1FF469362">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="38DE7053" sha1="8FF2B9DECAC9513D08A29E7BD45D3C31F36F2966">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="38FBCC85" sha1="90196DBFC5337B56106B33891C5FA4B2267F3732">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="38FBCC85" sha1="90196DBFC5337B56106B33891C5FA4B2267F3732">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="391AA1B8" sha1="AE64B6FBCC992EF8A2B3A6B7D80AD598B168E39D">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="394DF2DF" sha1="25C0E4D3A89531380F7C9A2F5CC0D857A10B3A42">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3963F12A" sha1="3D49A357362160B16F03CC4BE7D8EAFB7108708D">
            <board mapper="198">
                <prg size="640k"/>
                <vram size="8k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="396F0D59" sha1="D444D2FBC923BF82CAACB981FBA7C9FDF0F92B78">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="398B8182" sha1="5594476DE54A0A8182957111025ED9C37B615975">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="39B68AA3" sha1="7D1B4D76F2343251F8C3978BCA20AFE78C38DC43">
            <board type="KONAMI-VRC-2" mapper="23">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A1"/>
                    <pin number="4" function="PRG A0"/>
                    <pin number="21" function="CHR A10"/>
                    <pin number="22" function="CHR A16"/>
                    <pin number="23" function="CHR A11"/>
                    <pin number="24" function="CHR A13"/>
                    <pin number="25" function="CHR A14"/>
                    <pin number="26" function="CHR A12"/>
                    <pin number="27" function="CHR A15"/>
                    <pin number="28" function="CHR A17"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="39BB6616" sha1="642A6A16122667E232649DA2991BD9DCA3DBF807">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="39D43261" sha1="F94389BF89B493E52204371722B406CCFCDA16A1">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="39F2CE4B" sha1="A3F98A1EADF14071A4E0563B0DEBA234C638769F">
            <board type="HVC-ETROM" mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3A0965B1" sha1="A2F432FC557824AEE922774B16F31DDD1674BDE0">
            <board type="NES-UOROM" mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="3A1694F9" sha1="B776A18520FD7891EE2B683E4A20408080BAAF50">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="3A4D4D10" sha1="CDEA0B7036243E10C4E5455BE5A726B7D6A4D258">
            <board type="NES-PEEOROM" mapper="9">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3A8723B9" sha1="22D0C845B67F8F259A73F77D3E158AC90E69BD1B">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3A8F81B0" sha1="0B038EC611B12841E84B9618F207395BD83E411A">
            <board type="SUNSOFT-1" mapper="184">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3A990EE0" sha1="E9C997CB9D2829385F2822551EE03A2E794E97A3">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="3A990EE0" sha1="E9C997CB9D2829385F2822551EE03A2E794E97A3">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="3AC0830A" sha1="C34ED0F6CEE061DCBD0F36D05A49FFEB9E1D8461">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="3B00B967" sha1="E9C2F93FF3E7E9ACDCFFCCD0C1A1BDD0AE415B0C">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3B1A7EEF" sha1="8C79C09A31470072EB0ED70E58D147B7B2CD0960">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="3B3705A6" sha1="99B05C3B90BFAAEA2AAC649BB1D83878A7BD9E4F">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3B3F88F0" sha1="73F9B88DEF80756EF29C5AA1A724C3112E5918C1">
            <board type="NES-SAROM" mapper="1">
                <prg size="64k"/>
                <chr size="16k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3B7F5B3B" sha1="57F755C6A10C6681761070B0350DA72432A534E9">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="3BB31E38" sha1="E85469D8FE0D4C058EE6EF3EED28E2D131EC0C22">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="3BBFF3A6" sha1="79ADBDABC63C17DF8ADA9CEF5396CED8BD5BCF0E">
            <board type="HVC-SJROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3BE244EF" sha1="EA07509F4BDD45603F98126E66BF9F16291E7B4C">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3BE91A23" sha1="E12ACF2C53D22D85463991594AD929A7EAA871D3">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3BF55966" sha1="D284240412B82F6DA0EF95C0B4D7E0540A41EE14">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="3C54A0BF" sha1="36025A26D2F8696B4CA60EA74A2781F16DDFF361">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3C5C81D4" sha1="024859F211BD854AC9D4ECCC20C63BC8738ED133">
            <board type="NES-DEROM" mapper="206">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3C7E38F5" sha1="171AA5E2375DC17BB5D7AAE2A7B7B96806683969">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3CD6BB0E" sha1="713161AFE45327BD6484A27B3536692873C90587">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3CF67AEC" sha1="79322C45769008E40D01D83B15B9D872E160B40F">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3D0996B2" sha1="80E3F15ACD93C2DB6C2D58A45B39B0E22EF6C334">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3D1C3137" sha1="23D302B901C2B6C1E969BAB7B2A45C392C06FB5B">
            <board mapper="78">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3D1C4894" sha1="E664F304F9C5EB3899833550E4026003D28738DF">
            <board type="NES-TGROM" mapper="4">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3D3FF543" sha1="04D5624EBDF11E874061BC2897676757A35D26F8">
            <board mapper="113">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3D4B64F1" sha1="D02DEE86A84E99D6CD8F2B61A98B38C8555E71F1">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3D564757" sha1="016818BF6BAAF779F4F5C1658880B81D23EA40CA">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3D95D866" sha1="884685E7516817261D15186D703C19524C142446">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3DA2085E" sha1="0F90852C9BB9C47419153A262A23E83DF314DF5C">
            <board type="JALECO-JF-18" mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3DC64CC0" sha1="8C5694AFD16F2E69174F416B7C6CA5C36E278D96">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3DCADA42" sha1="81CADEF9E857181483C0E8B1900FC00E591635F4">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3DE9BB55" sha1="9528ABEA08B4C4AA4779D6FA38F8260932861C88">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3E00A373" sha1="14207DEC7078CEC02DF4B11BB44E1E5E648A28F7">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3E1271D5" sha1="1D3B449F06D9698A42CD6255E684D313D1DD98BF">
            <board type="AVE-NINA-03" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3E470FE0" sha1="8AAA8C63611C6CA64444DD4B12A4B3689BF3F0C9">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="3E58A87E" sha1="1EBE3145F47D9EBB874A54230D63DCD5716C68A1">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3E785DC3" sha1="2B52F9485E3D16D3AC107C905BBB8B353D0AD582">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="3E81DD67" sha1="E0BBE3502AA0A0A77088225D3BB7449A544B653F">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="64k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="3E81DD67" sha1="E0BBE3502AA0A0A77088225D3BB7449A544B653F">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="64k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3E95BA25" sha1="3816ED83B51D53691EE4E4BD3428847DF97E58D6">
            <board type="NAMCOT-3301" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3ECA3DDA" sha1="DCFC2EB1BC346FE7E8026E845E8711344696B1A6">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3ECDB1F7" sha1="3B54C4FD4CDE3A576223B8A745AE0331A808FE33">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3EDCF7E8" sha1="36842491BB513C80BEB9F2FB2AA30EDAA1121CA4">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3EEA372E" sha1="4704118A8525A2E4D8730D00E8D800B05FD3F2AC">
            <board mapper="189">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3EFF62E4" sha1="73720228DA40937DB5AB037F8898450658312EC1">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3F0C8136" sha1="CFF9FE0D8F2E9490E1DA787A93FCEF88D83153CA">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3F0FD764" sha1="98845D5716525E68EF7417E6FB55BE30A4C7130D">
            <board type="NES-SL2ROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3F15D20D" sha1="1D7417D31E19B590AFCEB6A8A6E7B9CAB9F9B475">
            <board type="BANDAI-JUMP2" mapper="153">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="3F2BDA65" sha1="9FE2047809314F14FC1CCDA622782BC02D35110F">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3F45C309" sha1="AA70C371FDD39AB0B49C3AAA71B5477E9FA45468">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3F56A392" sha1="7B18BAD6B95D710D07A232E3CEF5F48E214A2107">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3F78037C" sha1="CC5BAC121D94B23D7581F4F443DD42F6CFE8EB67">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3F7AD415" sha1="3EA83DB139C7E92ED1F7FF72DDBBA038A9A22EA6">
            <board type="HVC-SOROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3F8D6889" sha1="16CA1128F019C9DE9F152F7CB7F06FBA30B6B5AB">
            <board type="JALECO-JF-33" mapper="18">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="D7756C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3FA96277" sha1="9463CF636B4B37C5E9EE587D4335EE6C4CBBD6D9">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3FC1DC19" sha1="092E3772EC4117E83BA119326C4BB5A4865B77C3">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="3FE272FB" sha1="A12D74C73A0481599A5D832361D168F4737BBCF6">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3FEA656A" sha1="4FA97BB46C146F2D6487C956E20399CFF9C8EDE6">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="3FF44F87" sha1="6D707AA6E1BC88DD905269936FF16A50F65BFBCA">
            <board type="HVC-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="3FFA5762" sha1="5CD7C3A0080FE7CCC6AFE70AF85123FF77E89834">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="401349A8" sha1="57F86E49372AE44DA79F269973E7DB4F443D0B98">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="401521F7" sha1="AD84F67AFE85E87D055E14C67C563E8307F6CD09">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="4022C94E" sha1="022FACF54615AD37D269AC8F561DA6FF51334CC1">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="404B2E8B" sha1="7434AFE89BCAE2A5B73397CF5B7DB0B59D2953E0">
            <board type="NES-TVROM" mapper="4">
                <prg size="64k"/>
                <chr size="64k"/>
                <vram size="4k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4057C51B" sha1="38A64BE0202DB4761BC65065C1D9D8F3FC784F5E">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="40684E95" sha1="222E19511D64872E0B47A47D77ECC9BB3EBC52DC">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="407D6FFD" sha1="4DB565C13702AA461EE22A83F6E3E93E89A9F51B">
            <board type="NES-QJ" mapper="47">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="40A5E676" sha1="CC61D76FD73FD6FE66C068C5B806988AF78DCA25">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="40B8EE9A" sha1="42E5978B32C52A334991C55196083849B7C9368A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="40BFA660" sha1="5045A576844ED029103C997E7D18FA3D98E26A1E">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="40C0AD47" sha1="F949FC16932808C426074AB1628F246B0435C52C">
            <board mapper="48">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="40D159B6" sha1="3DE60E3341975C5E96C194A5ABBF20C0D62C4C8D">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="40DAFCBA" sha1="2809B947227C8C703981C96D3007193434D5BCDD">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="40DBF7A2" sha1="AF6EA3403D0966A907A1A17E117F6DD02ABA9F3E">
            <board mapper="150">
                <prg size="64k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="40ED2A9D" sha1="D4E9126D02C9923C3871FD352248F41298498D4E">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="41496EBD" sha1="4CF486B9F7F612A8033226136ABA10CE4B765180">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4156A3CD" sha1="376788E0C10D06AD191E528D474A7D83734276A8">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="415E5109" sha1="68BE6DAE20CE20B3CEEFAA58D540CEEF17E2BC80">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="41632CB6" sha1="0D528F7DFA126CCF9BF4B943787ACD054B858313">
            <board type="HVC-SJROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="417271A8" sha1="C11BF71AF952AB025683148EB8D0922268AC1A0B">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4178497A" sha1="F1B35EFDECC98F52A560B32ACB75EBD719CBC9DE">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="419461D0" sha1="4F55AFAF521841B3D50F8076BE674321C1CF4623">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="41CC30A7" sha1="527A3091C658CEF2D8D6E128AE2FEF16EF82E4FF">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="41CF5B6A" sha1="D132723FEC0275137CD1A3C65B0CC41C40D78F86">
            <board mapper="246">
                <prg size="512k"/>
                <chr size="512k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="41D32FD7" sha1="F1FFBECBC99558EEF25E8C6DB1EEB9C408E2F33E">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="41EF9AC4" sha1="3B71320B8BBE46B44CB95735A1BED948DB4E436A">
            <board mapper="167">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="41F5D38D" sha1="8510F084C4CD77A84D385B5D0D4BB556FAF33937">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="41F9E0AA" sha1="82BE2D76A4EE8C391D673977A27180C4283E55B1">
            <board type="NES-TLSROM" mapper="118">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4220C170" sha1="A5C723F5B532623DCECBF5195ACDD822F093D1E2">
            <board type="NES-AOROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="4232C609" sha1="B8238D7C9A1CAE700632FC3EED4C4200E96F5ED1">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="423ADA8E" sha1="5A6F865718F24AFC9B1D65FA9A33246481C91970">
            <board type="KONAMI-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="423FEDF3" sha1="38EFD97A91703CD25A628EE09477F2BDF71108F2">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="426BD504" sha1="782F9C478CE9D9DE2B748B0662A936F6A415E896">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="42749A95" sha1="5F274A500ABCADDA1BB5AE4DD898B5E006C08212">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="429103C9" sha1="0B5DD380A4656FDE916E5A5D99DAC64A7D9B71FB">
            <board mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="42EDE8CB" sha1="9EA267DA141F32F9B44E8C5871DE685FC4A2D05D">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="4318A2F8" sha1="6757C210403E2DB99ECD1B84CCA5E73B44882D0C">
            <board type="NES-SCROM" mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="43287E79" sha1="1DE98DF98D15043B766C885B68A8CA237855B152">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4339865C" sha1="ABD2AEE89314E486D8E1B5EF942744A393E4EE39">
            <board mapper="69">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="43539A3C" sha1="AEE6BB2338E71CC9390FBB845225C19E194CDD21">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="435AEEC6" sha1="FA7DCADBFD76DE0320326EF3EE900D55020925E9">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="437E7B69" sha1="305CDB42702AAC5F6D250E34C166AD9718BFC3F6">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="43B0944B" sha1="35E12D1FAE4BD494C72A874B1323F0D210B83E7B">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="43D01C10" sha1="C8CA009CFB56EDB86ACD8BB8F05D96D19132AD66">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="43D30C2F" sha1="78FAFABFF0EE4092CC505E003385CEFA43AF3CB5">
            <board type="TENGEN-800003" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="441AEAE6" sha1="3EB406F0518DBDF513C0C192F09695F4E4F9CDA2">
            <board type="HVC-UN1ROM" mapper="94">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="441DE6D8" sha1="35D219EC3615A63FF810ABC981835D0867DCEA39">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="443FC6CD" sha1="DD8FBD45DD766E0BDBFE423F5A39F1A0B6BA2031">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4496F2F2" sha1="B4BFACB300B2F758759A6D08A8C9D522DEDACFE4">
            <board mapper="57">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="44B060DA" sha1="DC5A63F35E4869DAA30F4A21CC327DB59E39BC27">
            <board type="HVC-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="44C20420" sha1="6282051DA49C286863463AF105F851AACF896563">
            <board mapper="199">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="8k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="44D21F83" sha1="D850B48ACA4A3B1E503D2A483508564D774C536C">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="44F34172" sha1="D2327AC8751BA04B09E420B6E259BA21B3FFFF81">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="44F92026" sha1="9266BE2FD5D0C712FE7BF873D32AE50506A9B277">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4536FE1C" sha1="5FB00544164DABA035D09DA075A2AE20C8294372">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="455CA7DE" sha1="E9755EDF12F465903EEFCDA2672469AF84E8B884">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4582F22E" sha1="213F2AA4C56FB80CC4AE5F46FA4C36E9BBA52AFD">
            <board type="HVC-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="45878D7F" sha1="7D47CD172B886ECE5B98CCB8FEACBACEFA465C3A">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="459D0C2A" sha1="60B9C7760A64CDBF296AA26898E229B964E4E8EE">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="45A41784" sha1="A602168CD5E0143F28EBC59B914F84C0ABA352C2">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="45A9DB6F" sha1="FE81F6B0EB309C5484E18FE1D0E859ADD29A8DBD">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="45F03D2E" sha1="376250E7C5FB2455CF5ED94F29D67C18C7366698">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="unknown" crc="46135141" sha1="C8293D5632795058BFE3E987B471710B2F8D69F1">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4640EBE0" sha1="0EF017518FD8B00F68FE0D094BE2E1C8706C99E3">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4642DDA6" sha1="D9FE4F00109B7D75456E1673C2B30DE68A125A5B">
            <board type="NES-SOROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="46480432" sha1="7DC498425A46DF90C16BC0B97ABFD3571EBAB099">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="464A67AB" sha1="DE7C148907F5E2DE0946FA2022688BE1AD5999A3">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="465E5483" sha1="58F3298537D85230CF4228DE76C1B0723BD1F5C4">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="466EFDC2" sha1="E6296AD3E929E9B0219AC1D4364990E2BA912F4C">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4681691A" sha1="7F6E6176A4FAA7ECE178BDDC1CCAED8C5675565C">
            <board type="NES-SL1ROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4686C5DD" sha1="C0C1E49CB73067F76AAF0A3858FA718FA99321B7">
            <board type="MLT-CALTRON6IN1" mapper="41">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="46931EA0" sha1="7FA39DF49E4EF9DC5D826B38FD832A871BD876B3">
            <board mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="46B5751B" sha1="DA7FEA10043E16D57D825B319FC613C0F8F50B92">
            <board mapper="244">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="46CA6CF0" sha1="4F353C3B437A65371DE306481D5294DDAD5EDCAD">
            <board mapper="57">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="46FD7843" sha1="E535C353C90C0866B8AFC681B938D3717D9EE049">
            <board mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4706DB1D" sha1="2F63CA21B53C8F7FD5DC5F7D8DFC9780E6712F69">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="471173E7" sha1="62A6B4DB403911F74A0EAA1B726F3D127EA48242">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="16k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="topriderbike"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="47232739" sha1="8865F4B54B725B95A1A86E6046AEF401B5C2B6A5">
            <board type="HVC-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4751A751" sha1="D32CCAFB8B336BFCB0666DBD60B1364CF226C3FC">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="475CDBFE" sha1="ACD1BB22186A1BD068F9B58B10BA69A51C695714">
            <board type="JALECO-JF-17" mapper="72">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="476E022B" sha1="AEBDCDA1709DEAA6E3E9A05C92D8531501F296CF">
            <board type="NES-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="47918D84" sha1="587E90896E17897682E80B43643A22EC336ED54E">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="47B6A39F" sha1="C51A1E56FA794D8F2BCB368C604A1999B2FD8E44">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="47C2020B" sha1="216A5F2ADE63C6541C850030527C99ED4C2F131A">
            <board mapper="19">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="47FD88CF" sha1="AF4C0203CC3244EF2850DFDD793BB6D5E4FC9A83">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="481519B1" sha1="161FB56493F43A826EADF56C9EB18BC619EEB416">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="48239B42" sha1="B4F46FD070902D36984FCCC525E7E79FA6B7CFB8">
            <board mapper="79">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4823EEFE" sha1="017E9F14580B76AAE9ED2C0F1BF36864D1F6E165">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="48244391" sha1="C7F98D75930395BE4FDC61F191C815F868B8AA1B">
            <board mapper="164">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="482C79AF" sha1="58966AE7411634E35CA8EAA795FC2E32D92D937D">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="48349B0B" sha1="538E641861695C5D2CF219AD72E9F5C5C9F5EE11">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="484A60DB" sha1="DECB7197AAFBEDCE23F3C9DA0F51BC27DF06C399">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="484B03DB" sha1="B6C8A465E58BA0A268C60620623F412D65B80F4C">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="485AC098" sha1="B6816ECC850BB0DBD888955F6CA36565C97A103C">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4864C304" sha1="5D8CBA2011229DC67CCFF6C99E647238F260E7AF">
            <board type="HVC-HROM" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="4864C304" sha1="5D8CBA2011229DC67CCFF6C99E647238F260E7AF">
            <board type="HVC-HROM" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="4864C304" sha1="5D8CBA2011229DC67CCFF6C99E647238F260E7AF">
            <board type="HVC-HROM" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="489D19AB" sha1="2F943C939196B0814863BC2F6AD590CFD3B91A6A">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="489EF6A2" sha1="840447EB95379F31DD4650DDDAE3BF4587108DB2">
            <board type="NES-SH1ROM" mapper="1">
                <prg size="32k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="48B8EE58" sha1="085FB03A2990257D37FCE143FC7407E201765076">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="barcodeworld"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="48CA0EE1" sha1="2DBC7AF03E591D7EE0FD9198AF86C459272367FE">
            <board type="SUNSOFT-FME-7" mapper="69">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="48E904D0" sha1="1B2F59243D2B076369DE163D2A52E7077166CD9E">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="48F0419B" sha1="A934245BBEE4C13FC150EDF98C931584F1176837">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="48F68D40" sha1="B04D740D624329826035E9FFCEFA6BEDEBB4A80F">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="48F68D40" sha1="B04D740D624329826035E9FFCEFA6BEDEBB4A80F">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="48F68D40" sha1="B04D740D624329826035E9FFCEFA6BEDEBB4A80F">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="490E8A4C" sha1="81074D89B619D97E544B3CB6F4BA781BAF49C72F">
            <board type="KONAMI-VRC-4" mapper="25">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A2"/>
                    <pin number="4" function="PRG A3"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="49123146" sha1="D43D51E63AB14F5DEB38FD2C393E7550705675B4">
            <board type="KONAMI-VRC-2" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A1"/>
                    <pin number="4" function="PRG A0"/>
                    <pin number="21" function="CHR A10"/>
                    <pin number="22" function="CHR A16"/>
                    <pin number="23" function="CHR A11"/>
                    <pin number="24" function="CHR A13"/>
                    <pin number="25" function="CHR A14"/>
                    <pin number="26" function="CHR A12"/>
                    <pin number="27" function="CHR A15"/>
                    <pin number="28" function="NC"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="491ACB83" sha1="D17E19BB52E9C83D11D7A3362C4AAA733EFBD553">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="491D8CDB" sha1="17B90FCF73B3D6650739DEEFA3C6C4AA303C527D">
            <board type="NAMCOT-3406" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="493BD2FF" sha1="E516CB54DE0C683202D4BC2C97FC11000D8E5642">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4942BDA8" sha1="BD564D7C6B1C5CA9E81A531489A146523A1E2FCE">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4962C024" sha1="067CAB3002DA9E30B6E6162EAA36724410ECE603">
            <board mapper="227">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="498187B6" sha1="E0B8709E9D8B803733BAAF1C9FB466C1283A41BC">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="49AEB3A6" sha1="BA8D9227A0D02B62EE6CB9E691FA5A5134C303A8">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="49AEB3A6" sha1="BA8D9227A0D02B62EE6CB9E691FA5A5134C303A8">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="49DA2F76" sha1="F81FC442A1C5B3F1D8216A0779F706C69B6A3F35">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="49E35593" sha1="406C328170750DFC864932197B855BBE90A066B9">
            <board mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="49F745E0" sha1="57690BE45879AA00DD825B89FC525E31FDC041FF">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4A601A2C" sha1="993F0DAF561292831A65164CDC71BF4380D59513">
            <board type="KONAMI-VRC-4" mapper="25">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A2"/>
                    <pin number="4" function="PRG A3"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4A99B47E" sha1="F37AA34F80A6D87C121271A99E78B2416983FBBC">
            <board type="HVC-RROM" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4AE58F5D" sha1="3FE256CD3D4FC47C83CCB7847E1A58A99B1323F4">
            <board type="JALECO-JF-23" mapper="18">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="D7756C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4AEA40F7" sha1="7F637704891587B73CDFD6EC5B6CEC96DE00318A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="4B041B6B" sha1="61DF677041A4899A8CD6EEEB1F789A2C70ADB482">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4B0DACCE" sha1="5531A47BD1EAA076301F2AC4C93F2387849D4CEB">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="4B1ED62E" sha1="3F097632E2387FBC26D2F808438EA544CEBE3D95">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="4B5177E9" sha1="C29DA974D39A76B7D1134A81CADAF00B51208151">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4B6EF399" sha1="153CF8E6D76A5D2DE991C3C01FC966EFE2E0AE7F">
            <board mapper="188">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="4B750880" sha1="8B1A335ADF8F8CA372B3D84831F61A6571B3DED1">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="4BB9B840" sha1="FCD91E2B0E7E5FEE9018F7C66B65640128A016D4">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4BD3BECF" sha1="548D63157F2985A13CEADCD0A3FCD92B624366D9">
            <board mapper="61">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4BF72F9D" sha1="21D5D90B64CB5B398D94A84B78E1B453296B44F3">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4C049CFE" sha1="0517B57FD5DAFB037DE7DBAC1DC1DE7A0F9D22A0">
            <board mapper="69">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4C0E8BBB" sha1="7F3228EEF529866FBE487BD0F98D002F27B94444">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4C13B5D0" sha1="CC82C4141D457F57026A9D8FAB69DB54B97A729F">
            <board mapper="187">
                <prg size="256k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4C5836BD" sha1="15D18D54FA3C3739F9457FF92805C11FE930DDB7">
            <board type="NAMCOT-163" mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4C7FDD56" sha1="1108F81784648D48BB23C00FD5F23D926FE03831">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4D1AC58C" sha1="9D10FAD575B580267555BA63F8EC8BFB52FFCBB1">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="4D1DF589" sha1="4C33CE3EE708AD9D3C9F1809EA47BF7A2797EAE7">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="4D345422" sha1="075C7EE0179B61D5F87B597B1144FB42943587A5">
            <board type="NES-SHROM" mapper="1">
                <prg size="32k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4D3FBA78" sha1="B64AC92C97B3ABCEC8C4DD35A3261D11B159AA34">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4D527D4A" sha1="2028940CF7C757A3A7931A741D5EC79C3554D38C">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="unknown" crc="4D68CFB1" sha1="8E7260F2F2775CFF1A774F61A157F8B4477D1038">
            <board mapper="38">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4D7859A9" sha1="25AD2F34FFB87CFFE006F082D121B878EBC91015">
            <board mapper="69">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4D825E11" sha1="8EDF62653AA789163094C4440BD95A73D9D7C506">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4DCD15EE" sha1="133A3C81A63C329FC0946B5986729C2CDEB5020F">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4DFD949E" sha1="49C9CEA40C8C8DE53B4E3F3D8CD59D7AEFB1E5B6">
            <board type="IREM-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4E22368D" sha1="C192B29063912E15A8E91A97F4785EAEB4A13FB9">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4E42F13A" sha1="619C8C45C14BB26FEE93D0F8646127F30E336128">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4E44FF44" sha1="68837B38CFCB50EF4DA5AF50BFCE3F216945D745">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4E5257D7" sha1="B29BE1824BD08F99E1D17CECCA92A0BDC0F06037">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4E7729FF" sha1="5FA23F88432006DCF6874EA36E9E7DA8934427BE">
            <board mapper="182">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4E77733A" sha1="FCE0C7B0A152DBC3B5992320211CC674E8A1622B">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4E7A6181" sha1="BCB273C1D62B2EFF3836A3717B8CEAABEC66DC8C">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4E800048" sha1="DAC50763B69224770EC3D13C4BD5FC6F54435600">
            <board mapper="115">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="4E959173" sha1="FAAED4082BCF7424C040847DAA3A44C1462B1542">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4E99CEA4" sha1="8D762533BE2E15D737A873432FFA188F8B22CCF1">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4EAA8D0E" sha1="E10696CCA08F43467BCF1EC886A7E29AE20EED6E">
            <board mapper="45">
                <prg size="1024k"/>
                <chr size="1024k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="4EC0FECC" sha1="B12B3C850A11A05334C04AC19C2CDAF9A8427843">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="4ECD4624" sha1="FEB5C3D0897EF256132E82049A8F7582C6BF03AB">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4EF429CC" sha1="EDC3D903E3865E94C77523198EB139D55D60B14B">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4F032933" sha1="B23BF471B1E0F260126713ED5B3A514357C93470">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="4F089E8A" sha1="0ADDA9F12AF174BF7E724C9F23745E13F66194BA">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4F16C504" sha1="B1C59289C74E0836D7C280996DA5BB28D34723FE">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="4F2F1846" sha1="0CE769F52E0BB8EF3F3C531A621B1261C052A640">
            <board type="NAMCOT-3416" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="4F3B2E57" sha1="36DE100A55828576264B449895EF3EBC4BBBEC3F">
            <board type="NES-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4F467410" sha1="DE22259E9D662530A327395F7EBDFF292E0B9263">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="4F48B240" sha1="A4A60000249DE76D2D4100CDB5C3DAE0C7137F15">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="4F9DBBE5" sha1="2319EE8B39E402C8071FDF137A6EE2B3A5C318AC">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4FBBFA74" sha1="533C3A0574E7322F5F340A4E715EF8BCF2D5DA85">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4FC2F673" sha1="73484559D0BED4F28BCDA32107AF2681244DBA4C">
            <board mapper="75">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="4FFD17F0" sha1="27CB8AEAF0EA97A6C69D3D90BC056C5EB61695F6">
            <board mapper="194">
                <prg size="256k"/>
                <chr size="256k"/>
                <vram size="2k"/>
                <wram size="9k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="505F9715" sha1="0305A626ACDC6523FF168725C402C6F81EC5B106">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5062A34B" sha1="4094D8372893D3B7069BA3A5427B5CA731228500">
            <board type="SUNSOFT-1" mapper="184">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="506E259D" sha1="1B3DC265BA0D7E4B2CEF9B3F8B0BE0847DF67C3C">
            <board type="NES-SUROM" mapper="1">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="50893B58" sha1="09083998F424E626F68A260BBF6925A73D0D2D84">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="509E6032" sha1="D5A685D4E79B84FB19542860F5371AB449905E78">
            <board type="NES-UOROM" mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="50A1B3FE" sha1="13B0A34B255C7C2C97098B057A7958F95AA02818">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="50CCC8ED" sha1="4946AD51863998F11BA26394BBF4B49C864D2176">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="50CCDA33" sha1="BAA6D3D3FC6D3932A7A387C147EC707BBC0D9891">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="50D141FC" sha1="C62EE99255721AB3112DB7ABF1B7353DBEA706CA">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="50D296B3" sha1="EA2187D4F7A15734F6B5A855421C635F298AAE9E">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="50DA4867" sha1="AB8B619D832EFF3E3D4CD52835E7C80D6887FFEF">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="50F3E338" sha1="0CD87E8627E57A8C62492A3E886F4D1089809EBA">
            <board mapper="188">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="50FD0CC6" sha1="15A70240CB7D6D029E67E6AA6C66F5987DA68101">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5104833E" sha1="6EAFE44984FC52E27E55818534ECF84C8877C752">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="5112DC21" sha1="598958B8253CB1E6319D351B8FC50A169D863472">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="5112DC21" sha1="598958B8253CB1E6319D351B8FC50A169D863472">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="51392C01" sha1="1BE14256E0C0A59596495290E41D76C4080808EF">
            <board type="KONAMI-VRC-4" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A1"/>
                    <pin number="4" function="PRG A0"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="513EB779" sha1="E25DD3EA07926DB514766BDC1E3895700CCA4AD8">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="516B2412" sha1="0A745CE1BCE224C7A6972CB590B806BDE7F61D80">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="51BD8336" sha1="900949CDED16D32358E06C05EE5C3478872F54C1">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="51BEE3EA" sha1="1CCE6AD433E22F3C0933AAE4B8C61E7299083968">
            <board type="NES-SHROM" mapper="1">
                <prg size="32k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="51BF28AF" sha1="81721D79F99016672651CE58C2481D58B97C4522">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="51C0B27E" sha1="F7C8999719D5A8B8F795F9F3D9650740DEFBDBF5">
            <board type="MLT-ACTION52" mapper="228">
                <prg size="1536k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="51C51C35" sha1="2ADF1ECDD66937A5FF1BA7DF666BDC14E1326A80">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="51C70247" sha1="DDA5AB92A35981B38D74EE35DBEA06BD687A98AA">
            <board mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="51CEAC29" sha1="41CADABCE79D19E7C9A94CFAF8A5E89DB2102E6B">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5229FCDD" sha1="F0D4A36B8BAC7ED47978CE9C8A308AE0ABF0E768">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5248CAF3" sha1="E5AE9D92A951FDA007ACF02E5E7030A5115612FA">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="524A5A32" sha1="E13626A09AD745BC5D9FB0972383DBF358DEADDC">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="52880295" sha1="14C46252AD24EE5C219A37E906751FEA3FC0497F">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="529B621F" sha1="0BDF3689D35EFD001FF65229EC871F15DA80B20B">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="52B58732" sha1="44AAE1649A4AD3AE73D5F24962590C2B7C0314EA">
            <board type="NES-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="52C501D0" sha1="3F9CB2322FBAD6671DF328A77D5B89FB8299F213">
            <board type="NES-DRROM" mapper="206">
                <prg size="64k"/>
                <chr size="64k"/>
                <vram size="2k"/>
            </board>
        </arcade>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="52D8EE1C" sha1="2CFC3A144BA35A65F7FD77152A623040A0B169D7">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="52E2B5E0" sha1="E250DA736512E431146750CB71FEB2C37B327F32">
            <board type="HVC-TSROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="530BCCB4" sha1="56FF3A2641FD2DECD5B334AEF586739B1532DEF3">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="530F8B13" sha1="A09FCC1C961C2D49023534439EF56FBB421A5B06">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5318CDB9" sha1="026D0BD1E7C63B6963B89C59EC7FA725273AB26D">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="532A27E6" sha1="B3C1140173115651E50CCDF906CF078BCABBE3C7">
            <board type="NES-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5337F73C" sha1="37063D9F894586E22C8ED81890946497F3FBEB16">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="535C5446" sha1="70366165EBC7D60A23A3091C096B01EF118C6EE8">
            <board mapper="148">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="535E6152" sha1="CAE9CB4C0452C56BED58AEACCEACE8A3107F843A">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="8k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="538218B2" sha1="460BBE5F79BBB9A7526C5047974D17BB7CFE16C0">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="538CD2EA" sha1="5C5A9D8B12DB810567E3F4EADFD0005956A2890F">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5393D949" sha1="F60102AB3B1470ECFBB7FE31FD9392E6B4BFBFBA">
            <board type="NAMCOT-3446" mapper="76">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5397E80B" sha1="42334307B843D411501150CD6B9E968364636C62">
            <board type="NAMCOT-3416" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="53A9B53A" sha1="1826D7C39AC1D49B20F07E9CFBBA6B87C0493797">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="53A9E2BA" sha1="8E9BD7F4D3999C973C1F2C28A995311267586C87">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="542BED56" sha1="FC9C3E181094AC266321F0C198FA1EAFFD18BB8A">
            <board mapper="225">
                <prg size="1024k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="543AB532" sha1="F3983E3D1E87B64FC83DEC5E2428AD8809D969D7">
            <board mapper="7">
                <prg size="128k"/>
                <chr size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="543C6EDE" sha1="BF03DA873D76A87AB669688D0C47D7554C08C176">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5440811C" sha1="ABF9B5A432C2C5439017AEAC15DF6FF64857ECCC">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5452966E" sha1="2EA36E5084F72F0361871166EEF34124A2E8F8D8">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="548A2C3C" sha1="C47212AC87BE920C81726F81E787F5053798F236">
            <board type="NES-DE1ROM" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="54A652F0" sha1="A2F36A9CA3914F1C9184A85E914D7A163DAA135B">
            <board mapper="60">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="54E43C57" sha1="1F6072AE901F3D3530ADCD3C136178E3C7354990">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="5529431F" sha1="1445A4488DCC4E20F6A6C757827AC6E1EA936E82">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="55397DB3" sha1="EF849128916713A91A287660D819075059D39CBA">
            <board type="HVC-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="555042B3" sha1="23E2F2EA74532766EABB7DF574D01C4540DE6617">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="555A555E" sha1="5C6A513E04B9C3B7390BB076A7D94DAAECC5ED39">
            <board mapper="191">
                <prg size="256k"/>
                <chr size="128k"/>
                <vram size="2k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="55761931" sha1="2B93ED16C1BCAF1954736FA6A3F19F7FB50AF517">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="55773880" sha1="493CAEBAF648DCE5F585BECE276C73B7015E77CE">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5581E835" sha1="5559687CCC4514A309390938884DAF95F42C649E">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="55CF4969" sha1="66C5E48AF182E8D2BDB9D1D5559583D52E3DEA48">
            <board mapper="45">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="55DB7E2A" sha1="FD51F5BE5634724DBBB434A960EC2FA5A6BF5C4C">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="560BF5A6" sha1="3F9121D5C2F6F3D6A1524D674465B0084C288706">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="562D3A94" sha1="3533F8FA1C0D35852F71769BD94E7E4CCB212806">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="563C2CC0" sha1="33F5F00D06B5BEC13962BBFF49DC6395BC19B42E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="565A4681" sha1="76218A9A6CCAC652ACD182153FCFEA45E9ED4369">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="565B1BDB" sha1="E97F2ACF42183A3559103910E06FA5EE616CEB87">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5674D1F3" sha1="6AC4EF96CD77BE7A112B0833AE2E9F3D4C1CC386">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="56756615" sha1="6DD9020FD8D525A87BE93F3A0E1A87D12100475E">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="567E1620" sha1="5D8B88A2809DAE29F94750B71AC3C873AF2CD480">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="56A0D271" sha1="D09EF8127C64CBE817B45DF33C4D43E7B441E381">
            <board mapper="164">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="56F05853" sha1="DDE1A3900E54047AFDB65C5E48B0480639E98F7E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="5734EB9E" sha1="22806F1070617B4D3AA0FD82D005C1DED6CF8779">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5746A461" sha1="0BD17A939A1382BD1F6BE776708B5F375E987C4A">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="576A0DE8" sha1="1C155F37B098ACC963D1EE181854AED47D2EA107">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="57783E71" sha1="2F5BD5265AABDEBACC2364CF77CC579A59FAAAD6">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="579E5BC5" sha1="6654BAB6D46F3BFFA0BC7B94F08A69FB59450F5F">
            <board mapper="42">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="57A125B0" sha1="21CD96D8F72DCEB80A73A133DFF8501F41B208E2">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="57AC67AF" sha1="43AC7C7AAF1846EAD7B544302BB9131E4964FD32">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="57C2AE4E" sha1="BE56DF3A7FA18ED2C6B1C5EE991866916373FC3C">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="57D162F1" sha1="1153999DB45A7FAEDEFEBE9DA8C5448084B8AE23">
            <board type="HVC-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="57DD23D1" sha1="5B05C8859F356013D37F0545F5DE5FA1693DA5DA">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="57E220D0" sha1="8690012D6F4D6D11D16FD9AF7B200D9B6EA2504E">
            <board type="HVC-TNROM" mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="57E9B21C" sha1="1CDC08894F9CCE3BF0550CC271390379EC0CF5E6">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5800BE2D" sha1="577017FD038B0F5D0B2835E3259C2165D4860A21">
            <board type="TENGEN-800030" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="58152B42" sha1="1E49BDA9CEF18F6F5C2DA34910487713D364AA68">
            <board mapper="79">
                <prg size="64k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5816CCC5" sha1="667D3020B4B30D7F4954E2526CE164897DE30392">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="58507BC9" sha1="947E5F3D386D2F4631FACEC26CE9A25FDFFC4889">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="585BA83D" sha1="D4C7E42BED5F279FD0C40A7D1108D78B3E757B48">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="586A3277" sha1="2D01EEDA7638FD05F24DA7A7E26E2A60B5C394DF">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="588A31FE" sha1="40236889D1A2F153A2925A986064DB942E22C136">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="588E7492" sha1="FA414894A761A6A7837EDF8A032FBAC05ABC1249">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="58C7DDAF" sha1="A13AA4971F1421E93312FA3574FCBE178B87977E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familykeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="58C94F66" sha1="E9CFA35A037CC218F01BFB4A1EB5D1D332EA2AA9">
            <board type="HVC-FAMILYBASIC" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <wram size="2k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="58CFE142" sha1="C0CF1CDFEEA5F3529A3126B366DF8E331C804CC7">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="58E63E82" sha1="CA4FF4383B7800CE1950067C5B408A3BAE4BEE88">
            <board mapper="112">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="59005CCE" sha1="5411957399A2B6E68D76C63ADDF8E1EC57A4A68F">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="59114E78" sha1="E6EF147025AC53D1566E5E8A33700B2C5F6C1EFB">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="59280BEC" sha1="651EEB93D4781C578E21A34893A4D7906F564C26">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5931BE01" sha1="9D6C39D58EA5EDBC38FC87A58702718D9FEEE46E">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="59449E3B" sha1="E0B5047668E4F04BAC1609D649D78776E793638A">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5991B9D0" sha1="617B59E8FA49CB78EF867DBE517695048F247F08">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="59977A46" sha1="3959DE9E2F63B34BC992A60DDCC73027F401DC64">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="59977A46" sha1="3959DE9E2F63B34BC992A60DDCC73027F401DC64">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5A0454F3" sha1="22D27B765927ECBAA31EAC4C1C305BC5B2987BA2">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5A18F611" sha1="77241A57CB0B40D9ECAC451F86198ABBACBC717C">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5A4F156D" sha1="75F7483E74DF80674E81F0714DD31F3067828DE3">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5A5A0CD9" sha1="094E30B8F9E59EEA7FEDDA6DC972370B4312EEB6">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5A6860F1" sha1="5E4858A07330A7C1FE6EB9ADFDCE778043ADA5C6">
            <board mapper="4">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5A8B4DA8" sha1="C3FB75748E0E3D6C4CCE37DBB6BB10573CE117FD">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5A9664D0" sha1="232E54DA6FAF7BAC4A29769FA0379570D83EC32E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5AB54795" sha1="5B767C82A6A3EA307B25F11343E1BA0958B74635">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5ADBF660" sha1="6A493CC7A3745F44E2EC4BA0FA71BFA89FF5CF37">
            <board type="KONAMI-VRC-4" mapper="25">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="2k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A0"/>
                    <pin number="4" function="PRG A1"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5AEFBC94" sha1="0941ABB51EF88587303DBF018770758ECDDD5C20">
            <board mapper="133">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5B064824" sha1="3C54660F863EE32427259FA8790DA936C1A9154E">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5B16A3C8" sha1="2FA3C27F43E4649D00F70B921B1022B662BC1652">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="5B2B72CB" sha1="93AD05EB932A11523AEE76EB39681A199BE166BD">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="5B2B72CB" sha1="93AD05EB932A11523AEE76EB39681A199BE166BD">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5B457641" sha1="533170D5EB685231CCD27B9C136FFA4FAD68A7B8">
            <board mapper="157">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5B4B6056" sha1="0A0C3C8693DF47B988C12F720428473800B67640">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5B4C6146" sha1="8904A8BF6F667ED977F2121AC887C7FE0CB969F0">
            <board type="NAMCOT-3414" mapper="206">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="5B5AB1F8" sha1="CFA1B425D6E30DBEA99AECC9657BF884109C85B5">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5B5FBE84" sha1="AC06F0A41B6F9C72B11BE6C3B6E5502576585017">
            <board mapper="44">
                <prg size="1024k"/>
                <chr size="1024k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5B6CA654" sha1="58011155EA6D62AF65C8A9D776DD8363FF40EDDD">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5B7AC91F" sha1="3B433F901CFB0EA7C9CD2EA2DF4550D2DF7CBA14">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5B837E8D" sha1="F116EB809C5A46017807335E11DC1D89FFA63E8C">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5BB62688" sha1="D6615439A90FC68758C4149F0CBBE6D1331451F3">
            <board type="NES-DEROM" mapper="206">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5BC3F47D" sha1="8485A34DEB0AD1D15F10486E61D6EA797C38EC9C">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5BC9D7A1" sha1="B72BBF0EE778702BFB56914958F4C8B18B055657">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="5C123EF7" sha1="146EE572C31C4FE04F9A06F75ADA988AC743F40C">
            <board type="HVC-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5C5A1AB8" sha1="3542E1AD16969F1FFED2427C08AA231C0EDEA06C">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5C9063E0" sha1="CE5CE75848FCE78807441386B1430BA0F8F22EEE">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5CAA3E61" sha1="80CD18BB63A5B52B1F3AD36C9191845EB29DD807">
            <board type="AGCI-50282" mapper="144">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5CD5FDA4" sha1="9E93C33022059FA4F7ABD1AEBD83246C5524BAE3">
            <board mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5CDB2823" sha1="2716EA4476FD4C6CDCBBF184F94558B5F233B3AE">
            <board type="NAMCOT-3301" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="5CE55F5B" sha1="A75903006B1AD7E0CB1DD18F9E59DBCF1B24B50E">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5CF536F4" sha1="293FB5EEC8DA879960E2C86FD612028394E965E9">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5CF6A82E" sha1="1F79C15EEEA159E1218167FB6258A843F2C6164A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5D044347" sha1="8EB7512C7B6FEFD332A6C667C76017A443692645">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="5D0D3047" sha1="CE67D67445BDF3900CE7947E78D5D54053DDE3D3">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5D105C10" sha1="A74747BCDF980706F8CFC8D47642BCD16221649F">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5D1301C5" sha1="E22B95C6687AD703FDEC22F4FE79556DA6A2256B">
            <board type="NAMCOT-3302" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5D2444D7" sha1="F602F841744E7B077148655DF01B0F03E4EDA625">
            <board type="JALECO-JF-13" mapper="86">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="D7756C"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="5D2B1962" sha1="50BD6D656759EC982F600FAEEA0EC674DFF86868">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="5D99053D" sha1="8456C28C0BE7B60FB185CC76312AF7A5E188A886">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5DA9CEC8" sha1="3166BB69095B7CBBD514AF6122C5ECE1257D76DB">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5DBD6099" sha1="F2F932F772E449A29854DCC4B4BF2EFBB09CD0AD">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5DCE2EEA" sha1="5AAD6D1022C7EA13F69056A5A64FCF4C7BB737A6">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5DE61639" sha1="B2662816D0367143D41A697B7B714F312E9AC125">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5DEC84F8" sha1="A9EFCA330437CB9C5B516B575CB6851BE4003A08">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="5E073A1B" sha1="A70631CAE908EC08EC4702204661D77B9A25E3B9">
            <board mapper="167">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5E1ADD91" sha1="D4F2A2B4AECCE7C916DA4752802C8FEF2CF9067D">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5E24EEDA" sha1="AEE6B98C78C7969B8E62292344050E2BDE2A5266">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5E345B6D" sha1="94B26D160DDD88A691F8E13C380CD6C28AB68678">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="5E36D3BE" sha1="9BDDFD1440E001B2F5B70657266A118FC6478C80">
            <board mapper="113">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5E5D5963" sha1="002558E62EABCE7B2739039B296171DDE472DF1D">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5E66EAEA" sha1="3E24EDD8C06713B775EAA66F3468F71693A542A9">
            <board type="NES-CPROM" mapper="13">
                <prg size="32k"/>
                <vram size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="5E6D9975" sha1="D3F63259229B951DD55E59CE65D3415E3D993577">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5E767671" sha1="7BB6A8737AE0065017507D9DB213D5A973E6F146">
            <board type="KONAMI-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5E900522" sha1="C1A8F6A9316080487CFEACA62F3D573CD9D484E9">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5EA7D410" sha1="89C49A4F8D0FA4C970EC096147932839771B0427">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5EAE26ED" sha1="446F21B3208E3F0F0A3BBACA4713406573717368">
            <board mapper="254">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5EB8E707" sha1="C7D8BEC141D8C9CB5353CC19426970C59B1DA34F">
            <board type="NES-SLRROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5ECB6FC2" sha1="DFB937C15F1BF946D1E53ABDCFCFD5495E8D855E">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5ED6F221" sha1="118307DA6C77A592F0884BAAD14120301D8D3A1B">
            <board type="NES-TKROM" mapper="4">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="5EE6008E" sha1="DC65B02ADCFA5DEFCAE46E8E27DF8E3C5D7B56C7">
            <board type="NES-SCROM" mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5EFBDED8" sha1="9E8340530788733F0AD89E6B88C63E43CF0B7038">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5F0BCE2A" sha1="4ECAC35E6412D1CC0D1AE0881B040553EB38F356">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5F14DC48" sha1="006674B64A745443268EF4001B90C8F7A0FAD6DD">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5F2C3195" sha1="8DD5D662B835305CAB7659CBF50E7FA149D867A2">
            <board type="TENGEN-800002" mapper="206">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="5F6E8A07" sha1="179C5E1AE581B52B7F9B90F16340CB9B0D60DEE4">
            <board mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="5FAB6BCE" sha1="865A7A740F67B14BE84D496E49D434CDEDEAF210">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="5FD2AAB1" sha1="B079346EAA7F465042724791D921D91DF3299C02">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="600E717B" sha1="0C7CA363EA26632E1A61C7F40E0FE8E8538ED76A">
            <board mapper="192">
                <prg size="256k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="602D7E1B" sha1="6693AD2B0E98E4153D572E3585A2B809DE03830A">
            <board mapper="45">
                <prg size="512k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="603AAA57" sha1="6780B3FCC547C013EE45AFAC6BB30C6FC6D8B46E">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6058C65D" sha1="5661B46D1EA6C518FA56D1CAAFBB48F62A49C7D4">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="605F5D51" sha1="4AE75902A54EE377175DBA33D6AF0BA2EB769850">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="607BD020" sha1="A3DFCB2157A9C4C3E5CAF0BEB90433DC6C1E15EC">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="60925D08" sha1="E9258B877DF77EEA71CDBFDC0691524A34D30F2F">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6096F84E" sha1="60FC5FA5B5ACCAF3AEFEBA73FC8BFFD3C4DAE558">
            <board mapper="104">
                <prg size="1280k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="60A3B803" sha1="F2CF26977CAA9883BC2C92F27B268EB6892217AB">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="60A59624" sha1="C342904B63E84B8CCABF220C6E5598829C481BA6">
            <board mapper="113">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="60AD090A" sha1="8E3E1EEDFAF913658ED81BC65481FD8E18E41138">
            <board type="BANDAI-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="60BFEB0C" sha1="BFE1A8EFE7539B20E09FFD472963F271AC9F2AEC">
            <board mapper="90">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="60E563F1" sha1="7D354B7C793C44FBEFBF129D5C35771B8632379F">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="60E63537" sha1="63CEE1A049BF11967202FB6F903884A561B01D3C">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="60EA98A0" sha1="84CDE9618CB026B98C2FFFF36DDC2326099C3155">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6104C630" sha1="5B36025DE695A5C84CBECDDC5F2C7F925E898370">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="61061352" sha1="026360E0DEB05C1A3B04F987CBD5A4051B004175">
            <board mapper="112">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="61179BFA" sha1="8CF2EA5C72FD2EB3DD4493494DD959E4FC00BA2A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="61253D1C" sha1="2EB840E8281F5FB2AA2F1AC62181B2E36BD77897">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6150517C" sha1="3E9DC769E1B63E73834786EC7FE9EDE7E706C72F">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="61721163" sha1="0292FDF6D60EA9C7B60E76D7F4EFAFFE8BD91D30">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6175B9A0" sha1="4692A622AF6A3D79514BF3E5FB4E9FBE6C6080FC">
            <board mapper="235">
                <prg size="2048k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="619BEA12" sha1="E6BC228FEF1CA18C49E80CFD6AE7F61EF2820814">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="61A852EA" sha1="CD95D48536382AC6C3182BD89023DC6FEB20A2D8">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="61B4295A" sha1="8AB5DDEE899D895C39C46474875F2407DD050AC5">
            <board type="JALECO-JF-08" mapper="87">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="61D86167" sha1="A9B751AFA8B5DBC1FC47BB696B5FF944A25DAF37">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="622F059D" sha1="D717462255EB48983C787DCC85754C3D14DFD5ED">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="626ABD49" sha1="5CBF93FF75E0A997EEC79E254AFEAB50F99F97CE">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6272C549" sha1="B57C4E9CE3212F4E75B71A733FF2907970521D40">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="62B90A0C" sha1="105B66F3941C46D8F19D2F1E0ADF546717EA2E29">
            <board mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="62C67984" sha1="14CFB1BB84C5B26EA996F9D53DF645EC5DBB4E81">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="62E2E7FC" sha1="E6DBBA9AFD18A3868C2280AF2E796CF7AF54882C">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="62EF6C79" sha1="6F288136923ADFA0B1DC7C5CA5782BF0892DFCE1">
            <board mapper="232">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="unknown" crc="6332E4CA" sha1="94FB2B4BBBE483C2C072DB534D08A21277339C2C">
            <board mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="63338C3C" sha1="135361D6BB5FADB44696D32C73D43C4091A5DDB5">
            <board type="JALECO-JF-02" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="63469396" sha1="C6FEF52264372FAB620D1E5EE6A3E60E46262775">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="636923BB" sha1="57E44EF692FF5DD190A323ABEAD26855174A979E">
            <board type="IREM-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="637134E8" sha1="334DCB823B480957057C2B4C72686BE26823C12A">
            <board mapper="193">
                <prg size="128k"/>
                <chr size="256k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6377CB75" sha1="8E9273ADB4677B03C4E1265CF40A17242732746C">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="16k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="637FE65C" sha1="C1F4CFEFEDED884071A5BBFB8943C8D488DE4117">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6396B988" sha1="B326D1984D5D369BC168028AD7672D2EFC2ECDDB">
            <board mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="639D74E4" sha1="86C6CD52EBD84A16CE254D504EC9AD627D222F29">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="63ABF889" sha1="CDE1ECAF212A9F5A5A49F904F87951EDA15D54DD">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="63AEA200" sha1="4E7EB3AC57E95B975B6670253FA8D0748ED09D37">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="63C4E122" sha1="58B6B97100127B4509521487D8EB9C6EC21CF4EC">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="63DDD219" sha1="6C11725F82F233981C078B14E8692809398E49C6">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="63DDD219" sha1="6C11725F82F233981C078B14E8692809398E49C6">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="63E992AC" sha1="AADCA8DC793CD310FA0D1FE78FF1C8EFD3DDE843">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="63FCC0DD" sha1="6B5EF7C642EF237BBB616FDBEDDEE47259E9997C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="6435C095" sha1="09FF25A8CA289CE40E6FB026A02041FCD05E7C4F">
            <board type="NES-SBROM" mapper="1">
                <prg size="64k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="644DFE2B" sha1="D5059E8B1A9E709A129EF830A4D5257C8BFD389B">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="644E312B" sha1="381131E3E8FBCE9F689FB20A0C006195572D95DA">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6479E76A" sha1="1AB6164393DB3E3DDACB3DB506171B0E5387AD4E">
            <board type="JALECO-JF-24" mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="D7756C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="64A02715" sha1="D3CBC72802AC0D56E4F992652E16A60383BD93C3">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="64B710D2" sha1="2875F130DAC4C13FFB1D2FDB655A89AED7FEB44A">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="64BBCB77" sha1="C667C5DC1C1760766198FC13CD5C9D8F61FCB940">
            <board type="NAMCOT-3301" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="64BD6CDB" sha1="EC9F11690B0076FC66420CCF963881F6DE41D453">
            <board mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="64C0FA3B" sha1="C13D846602AB89A96948948C8829B182D457F15B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="64C96F53" sha1="03A27A69B745BC02ACD8DFDA91A223D22A40010D">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="64D56316" sha1="8070CE470CFF6B9B6D4CF4FFB6A55EDD2A7C5858">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="64FD3BA6" sha1="ED8A0B142B42BB7571D97CA934AB58E7C3295716">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="652F3324" sha1="4E95EE4C36680E4D5171F3B59F4CCA66A6578051">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="654F4E90" sha1="1393FE50051DCD71500D396FFB995020222053CB">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="65518EAE" sha1="D08992699355195E9ED4DCA2110FE9FC338ED652">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="655EFEED" sha1="744C6638C3D7E39BD331A3B88F56AFFA9A0C4E4B">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="656196A6" sha1="06E0A75C56D8EB496CA0A0B4939A60C4A3040569">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="656D4265" sha1="9DF9BB3775E8CCA0214E3765CDC0443EF81636C4">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="656D4265" sha1="9DF9BB3775E8CCA0214E3765CDC0443EF81636C4">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="656D4265" sha1="9DF9BB3775E8CCA0214E3765CDC0443EF81636C4">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="656FA3B5" sha1="FEBC958C90F10BBE7C095A3842A5BC897EF18A43">
            <board type="JALECO-JF-07" mapper="87">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="657F7875" sha1="A54E246F1C4E7336ED71AED2656288D943C6E36C">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="657F7875" sha1="A54E246F1C4E7336ED71AED2656288D943C6E36C">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="65D1AB64" sha1="809A5DAEDB8CB79C6D67F3CB34A1AB414281539A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="66066326" sha1="2B6CDE1D114FDD1DF91CAFC8D5947966A3BC1FC5">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="66471EFE" sha1="5CD3A16DEFAAEDC714CCC39F821E3034E5465D5F">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="664E9906" sha1="BC8666FC34CE665122AC576509468A5AE6F223ED">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="666BE5EC" sha1="EA388B7B826E14CB907FBEDC1651EE831FB22D41">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="668D1715" sha1="1CEC3B2E93E81F0353BE25AD139ADDAE881DC69A">
            <board type="NES-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="669EC739" sha1="BFDDB66E49C1AA3557F3B0CDFAD482DB75518169">
            <board mapper="12">
                <prg size="256k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="66DD04E1" sha1="A3E5B8D3FA1030DD3B877E7A37E8F803BDBB48B5">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="66EBDB64" sha1="1C8DDA6E0F1797AA5B9CBB56B11C33BC760BC3EB">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="66ED9C00" sha1="2228C8D8F5CDF6316A7825B31356096615EA7D21">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="66F4D9F5" sha1="5438D3F810767D07F5A7F2B39504ABDEF5E14346">
            <board mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="66F6A39E" sha1="4BE8094AF62FB61CA492D8B1DF800FDDB8F92F0C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="671F23A8" sha1="B0E798176E49A8BA3F533FE75EA4149BF41D77E3">
            <board type="NES-ELROM" mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="6720ABAC" sha1="D3431F1B7B6B3389271BDD0A7066A5147C957370">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="672BD0E4" sha1="085ACDCB5E1FB136F74DC5265C85F0C45CFE98AA">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="6733607A" sha1="D1DB84222573F0B1DA0A0ED52C1792622E1D8700">
            <board mapper="15">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="6750CA0F" sha1="E1BB6A1858E57D83AC84784075D89D7EDFE066ED">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="67555417" sha1="5E5F21581AE75A9460E1AE9987B67B095AC8E4A6">
            <board type="HVC-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6772CA86" sha1="06267536575F0002BC84A35F9867F4DD80A1D8F3">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="67751094" sha1="7356DD9D129EC32F5DBCBA5C9832E0494995398C">
            <board type="KONAMI-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="67755041" sha1="D62B7AA3779F23EC1AFAE7F17DF620C913198732">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6776A977" sha1="6787A80EC56775E5B78E7CC44124DC39F4A0005C">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="67811DA6" sha1="F423B0C665B22F5550EF1262B15A646A8EF1FB5E">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="67A3C362" sha1="2839CB202BA9C89F30348B3F8CCE454241FC0F3E">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="67CBC0A0" sha1="08FAF5CD84B9250D1048E2F749E9016F13EBDA1C">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="67D5C3F9" sha1="42E0AFDD1E603C4F301AEB030B799F69EEBE2E15">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="67DFCF8E" sha1="D6C44378CCA532091D85783FECF7A7A38DD491A7">
            <board mapper="194">
                <prg size="256k"/>
                <chr size="256k"/>
                <vram size="2k"/>
                <wram size="9k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="67F77118" sha1="CA74A7A9FE061CBD0AFFEF7BC358C789517A57B3">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6800C5B3" sha1="84DB85EEE17B616F38C6126703FF6C96298999E7">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="680D2EDA" sha1="9BC07B44D266E2207AADBF958F0A37979FFBFB65">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="16k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="680DA78D" sha1="D584942EA61915316302E85DE652D9F20479C0F5">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="68383607" sha1="5BCF47901533372B7D9828380FCF32F11C6F9CE8">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="684AFCCD" sha1="8F5199F68B3B1CD7D5D2D65E747ECB57E1E1C5AA">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="684B292F" sha1="02402F160743E867D4E3E98D66CB6B6C91AD9D02">
            <board type="NAMCOT-163" mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="687EBCD7" sha1="63D91DA0FB7067B6982A8B92A5E7A3064A35A7E3">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="689971F9" sha1="7A466684F5928FE656841DF20BCB458E74108239">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="68AFEF5F" sha1="17254F00C99AF0B12C069B5223505257DB14EBCF">
            <board type="AVE-74*161" mapper="3">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="68C62E50" sha1="25EB037737FD467CC3AA4EAA576460FEB481667F">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="68CF9B78" sha1="6576D3A7F52E509384A043E5230AE2DAB962E977">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="68EC97CB" sha1="A24FBF815C0677AD284C9746C4ED773980AFCB5B">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="68F9B5F5" sha1="3AAC8E5472A9D4C26CA50080D29D9EF937BDDC0F">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="68FE207F" sha1="7F73FE27B4B6F49099F1BB4170ABE04C394991CD">
            <board mapper="52">
                <prg size="1024k"/>
                <chr size="1024k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6944A01A" sha1="85A9C596E9916C77E5619700F0F82FC64020451D">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="694C801F" sha1="A12C57BCA1DBF24ECBB08FC7C6F510C062FCA75A">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="695515A2" sha1="46727422D4BD4AC0CA2A088D97E5A9365B06D093">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="69565F13" sha1="191D43B72A198E9D3D0F6BAD918CD71D710595A8">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="69635A6E" sha1="1453664EF61ED1F4C1EA49F0956362472704BB73">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="696D7839" sha1="CBDF18CCBCE9EDCF59B30D85281410B782FC8355">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6997F5E1" sha1="4C8716C4651973B5F6811D6CA9A0F1E2C4E26FA3">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="699FA085" sha1="27CA5BA9E920C21A6906F57E266A253C39FFADB6">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="69BCDB8B" sha1="0DFFB53FB89240FEF1967D51969508B15F8EEBBE">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="69D07DDB" sha1="70FAF6A01500624FA6DEF2ACC9476397C18DD7B3">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6A03D3F3" sha1="6BC97B7459DB034D5DD5B5828678CC4CAB073663">
            <board mapper="114">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6A154B68" sha1="F411C7903452C9470C8BF73FED334C485F14A8E4">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6A1F628A" sha1="E7869C683BD93275CDE4536CD2DDF37F230DD8D0">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6A457A43" sha1="C29DB95E06FC258CA45C029AF10CAA0C48B416BE">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6A483073" sha1="0CBCB3EB0AEB196D8564ADB4823A270DC213B5BD">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6A6B7239" sha1="B8ADCA55F31A709E3865EDD7564D53D1A3F1E0B8">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6A88579F" sha1="2A582A5C20533C781BE4D4E4D35603E9A08192B3">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6ABAD366" sha1="4A8C86610D6BCDAAD96612F194221F423EB43F90">
            <board type="NES-SF1ROM" mapper="1">
                <prg size="256k"/>
                <chr size="64k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6AE69227" sha1="C989DDC71BAAD83B6B724479A98247F6A20A1EBE">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="konamihypershot"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="6AE762AE" sha1="00F38F2F0725A5EED57F87A7B7B477F89D5F5D01">
            <board type="KONAMI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6B53006A" sha1="6027C3631B18C7352531E4339D7B33D12C4C4E97">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6B5CA5AE" sha1="FB9C7E587AAE4153C4D6942070BCC7625B5C850C">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="6B761858" sha1="68836AA74871F35A478DD66296C9DA090E981C29">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6BB6A0CE" sha1="1694A65DE6C5EDE691794BB58CC94924CCB698FB">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6BC33D2F" sha1="98CBF6D8D410C6725B59C08C35A22F29C3531AA8">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6BC65D7E" sha1="82DCC6650B17CD6CEFC837753986C7E150A5714A">
            <board mapper="140">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6BEA1235" sha1="0FFFCF24E8708775A764EBA4C38354A457FFBA2F">
            <board mapper="245">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="6C040686" sha1="6A6C235B96C5CC51A5BF6D6FBAF30E77AD789FC7">
            <board mapper="232">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6C15609F" sha1="19119E04C7542CD294A5B34844F0D4578E211DF8">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="6C1AB645" sha1="EE65317597D28B1B1207C6BE4DF18EC73DA9FD1C">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="6C4A9735" sha1="105ED9260CE18F3FD46A36DAB99F05B24885E717">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6C61B622" sha1="CB130F4E4CAE6DDB112CFE96024BE1D3292DD84B">
            <board type="JALECO-JF-17" mapper="72">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6C70A17B" sha1="29392A9709C089F0063030B8908ED23108A487EB">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6C71FEAE" sha1="F2A8BC888B888FA65DFB303126B130422E34942E">
            <board mapper="45">
                <prg size="1024k"/>
                <chr size="1024k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6C93377C" sha1="CE2A5EF736ADC5EDF7417609B0446E10B6E61C1F">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="64k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6C940A59" sha1="48C14F0D7BCDF2F7991626F924B2C012CC59EE0A">
            <board type="HVC-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="6CCA1C1F" sha1="BBE55E0446641404867EE1A800CA8EE33D09C682">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6CD46979" sha1="085D29641DEFC36FABB3D95A1DEA5D1665902104">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6CD9CC23" sha1="C880D8F166D99783BBCA0AB8FB9CC5F9783147D9">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6CDC0CD9" sha1="93289C300488B69F959EB08AD075965DCC3EF2F3">
            <board mapper="48">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6D65CAC6" sha1="7430FC3CE83AE2E587F3DC448DEA96F43E510200">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6D92DFF1" sha1="3A316BE8652A9A677FC6468767C69D3FF221BD25">
            <board mapper="60">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6DC28B5A" sha1="31FC500B759EC8AB5B4C977625DC8B33C116470F">
            <board mapper="25">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A0"/>
                    <pin number="4" function="PRG A1"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="6DCBAAFD" sha1="1F8DC272CD128597C050777F635BACDC6A0E20B1">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6DCE4B23" sha1="1DCF1660BE8C025B0C01B41B23CA9A74A0E94E97">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6DECD886" sha1="93AC61B69B9F21BDF0C662C1A0832A17A3E6BDEF">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6E0EB43E" sha1="A11BF13932E7B414CE89599635648A037887545F">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6E149729" sha1="50B5D92AD6C648A423F3CAAC6912DA44E83BFC64">
            <board mapper="189">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6E4697BF" sha1="9006DC63FE93111CC685547631C494E3FD90C00D">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="6E4DCFD2" sha1="2C9F305B818E8B642B9AA2A9D7598F7D38394BC1">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6E68E31A" sha1="656B6C5CAD6F9B9CD15987C8120D08BF6B475D12">
            <board type="BANDAI-FCG-2" mapper="153">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6E85D8DD" sha1="37AA4909803208FB05ED403621EFD25E608D5BA9">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6E9E5890" sha1="6C86DC304E986BF53BE1365A2596893F91CD2ED1">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6EC51DE5" sha1="8F8B117F837C0D8C84EFD678FB29346404E70BF6">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6ED1EC0B" sha1="CE0B8FFA329A47B09C67D030421E7CD7359A7E96">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="6ED3BA25" sha1="5F6F9ED014EEEB3BE842FEFBB0D68C0329D9D8D8">
            <board mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6EE4BB0A" sha1="6047E52929DFE8ED4708D325766CCB8D3D583C7D">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="6EE94D32" sha1="A82E4899D37E36EA6563514AE599DF3C706512E1">
            <board type="ACCLAIM-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6F10097D" sha1="84675A1966384AFDB0715672207ECE3997B92033">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="6F27300B" sha1="E1933E741206A9976C5773E0C6C1B316FC8759B0">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6F4E4312" sha1="99CF6CA63B173A2B86125F16BBE11885EF1AC377">
            <board mapper="5">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="32k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6F5D9B2A" sha1="8AA7D534C115E788D862CFD821FA2731B80A2E04">
            <board mapper="32">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6F6686B0" sha1="D4E26405B05ED3CDD3CDD2E2D267EFDE3A31CB62">
            <board mapper="65">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6F8AF3E8" sha1="DA4F0DAABA619C8EBFFAFC48D97B9699D78B014E">
            <board type="KONAMI-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="6F97C721" sha1="D222DBBA5BD3716BBF62CA91167C6A9D15C60065">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="6F97C721" sha1="D222DBBA5BD3716BBF62CA91167C6A9D15C60065">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="6F97C721" sha1="D222DBBA5BD3716BBF62CA91167C6A9D15C60065">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="6FB28AF7" sha1="C6A8EDF0CFB17BFC3B2029B13388ED5D13D202BC">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6FB349E2" sha1="5C29C234651DEFEA7CBAB55897CB1062CA038A01">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="6FD5A271" sha1="FB350A817DD9EDC7526695781C1867EF970E57B7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7002FE8D" sha1="5B0936D61DBF262F536B8EEB491075ED4311F865">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="70080810" sha1="FDBFC7871962F72A1EF57E5A7E456164FB93430B">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="701B1ADF" sha1="F627A9D5A2D8488AFDBEDFB650AA932656B0E439">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="703E1948" sha1="503E1AB57F37F4DDDDB8CFE0AB29449AC7777497">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="705BD7C3" sha1="C14D96279D2B7BA950BA05D339500B6E17172F19">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7075BF5E" sha1="D36E66E863395A20B80D61FB78317A7FD412B381">
            <board type="KONAMI-VRC-4" mapper="25">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A2"/>
                    <pin number="4" function="PRG A3"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7077B075" sha1="AEB92FCFE3E757C3D52C99FAB6ECA5A50D59F174">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7080D1F8" sha1="185189551A395701FDDDB9FBD7F270B48A8FDD50">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="70860FCA" sha1="7CE202E72B7942E3F6030EBF220E8BBB695DE9D8">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="70860FCA" sha1="7CE202E72B7942E3F6030EBF220E8BBB695DE9D8">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="708EA2BE" sha1="9C8F53AD0348EE58D842B86FB845C8014D10FA21">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="709C9399" sha1="CF5155ED1DC701DABD70EE8959214D07E91D8DAB">
            <board type="NES-SLRROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="70BB52D7" sha1="B45C5CD15E9D9ABAC2089C1464A523C2995F2633">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="70CE3771" sha1="9BC0211CF659608E375AA2D29CEC1ECDE463CF29">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="70F31D2C" sha1="9E6AE492746EF9D142DE17FF45A4722CE6E21425">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="70F31D2C" sha1="9E6AE492746EF9D142DE17FF45A4722CE6E21425">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="70F67AB7" sha1="BAFDA6F94945988966370FA377263E83A27DACE6">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="711896B8" sha1="2C430A5D4AF069A4C4B9082422B7F570ADA5AE31">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="711C2B0E" sha1="610A40EB37B7A0C27D2FA02A19FEEAFECCFCDC18">
            <board type="NAMCOT-3407" mapper="206">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="71358C06" sha1="9692457648D2B81BC3B94FDD0D0DB604C9D3B232">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7156CB4D" sha1="03A111AC0FA78E566814D6F9296454BFC34E7B3C">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="716C3FCE" sha1="795FCAEEF734728DF01C3612115F4CCA9C83E78A">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="716DAEA5" sha1="65A674581F9D67E77D957274A5CE3D611D83CD06">
            <board mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7172F3D4" sha1="6F3BDA5FAE9B6ED4EA4572307DA8C0CE13ECEC47">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="719571B3" sha1="9B6CD33AEAF2AF04F3DF5981683EEB616FAD6BC0">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="71BF075F" sha1="ADFE24B8CFB6411DDEA238058D027EC0458FA3C4">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="71C01B19" sha1="FA1C3508673F0B7050A982597923F53991A31093">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="71C01B19" sha1="FA1C3508673F0B7050A982597923F53991A31093">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="71C9ED1E" sha1="760F2447E0AABDFDCA2C4F58A380CBC291FDAF47">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="71D8C6E9" sha1="2BE4ADD0035AC8E5669E3E3B4B6C47F94291F555">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="721B5217" sha1="3C21F8539F04C04392CE50CD940AF336319C7786">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="728BFA8D" sha1="88AB3376937004970D38CF477C0A01C8C8B28EC1">
            <board type="SUNSOFT-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="72928698" sha1="7D10C6DD141DA35A1672F127791639B5816C692D">
            <board mapper="69">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="72D81DAA" sha1="4F78BD193365278F2207BB0722834C3404BDB11D">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="72E66392" sha1="7D92E71E23B35943147C513CAAB7AAB4B4927DD6">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="72FD0055" sha1="C403AA673405583FD18A0DA5E3E6275786E04128">
            <board mapper="60">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="73140EEF" sha1="D84C1C88FD0D5B0A65F6D8F28B1CA37A5AD36C91">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7329118D" sha1="206EC54F949572989E35A6EDD7CD592875AE1D27">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="732B0675" sha1="B50E2DCF63E724F3FE8E5ADED50F32AA95775676">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="73418721" sha1="49EAEBB4A208C630704485704546A9E1056F41EE">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="73620901" sha1="C49A237305362970FFB6FCB858CEECFDD4FA9ECB">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="738275D9" sha1="1AD2C5159794D24823BD0E27248396B778FC8B14">
            <board mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="73921674" sha1="D2F433638316A366C427DB2941818D44A12CD8C6">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="739A1027" sha1="BD815E9731C7685EE8820434F13A3242C091F285">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="73C246D4" sha1="6444C22F65686E48DEDF85BD7D86F11CAE13ED6A">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="73C7FCF4" sha1="F85DA3A5A252567F3905B112830B0F1C297CF34C">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="73D5F7D3" sha1="5CD657FBC29D9646AED6460FF798B16D15482D4F">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="73E41AC7" sha1="39616A91274232629E40546157C2BF413DEF5721">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="73F7E5D8" sha1="9820B7BFBA13097B4DE2BFA4AACEA4A4609F89D1">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="73FB55AC" sha1="2DB5555F8B9B99DCE2D0BAF378DA2F6AE052C4FF">
            <board mapper="150">
                <prg size="64k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7416903F" sha1="FE90ED67291B405970E911B0AA0FC489F1C9253F">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="74189E12" sha1="0761B7987C2F86F697221A191CF61DD8EEB5C510">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="74386F15" sha1="A6C4B53C76F4EE62DF4F2B6A6D81A06CD3E005E0">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="744A0721" sha1="28C9FE8DDD5F80242A5FD024483350154AA54EC6">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="744C93AE" sha1="049CD44D2D2E657E950D530FFFAE00FB7709199F">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="74663267" sha1="1B9047410F521A570F5A8189609D65736FE632AC">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7474AC92" sha1="F26B28562F78FC027C0CA8993F70F2F1F75C8D41">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="74BEA652" sha1="EBCFAE8EE711098B97ED6E1CF428AF0FCA8E2BBE">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="74F0A89F" sha1="1862126A3D8B8E37AC0571AA76309D0BB2DD8DB2">
            <board type="HVC-CNROM" mapper="185">
                <prg size="32k"/>
                <chr size="8k">
                    <pin number="26" function="CE"/>
                    <pin number="27" function="CE"/>
                </chr>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="75255F88" sha1="B2A0B2525BA713D1C7C7130992917F62E18375FB">
            <board type="NES-SL1ROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="752743EC" sha1="B811A528AD4D77E4AE5E7E061275E0461B184B95">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="753768A6" sha1="7C6B67AC78B39C6610C27EED0C54B836D7034847">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="75901B18" sha1="2BD0F4B345D8ECCDED95C1899099E8CEE0ADF967">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="759418D2" sha1="3F32F7FD57790C6DD72BB3FC2727E25E125FFD6E">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="75A7E399" sha1="9A4B84A9688ADE7506BED66389E81FB942EDDE1A">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="75B3EB37" sha1="5D5E929325CC1F0250A3FA1BEA194E9CDF825554">
            <board type="JALECO-JF-24" mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="75C3E7D4" sha1="D849DEE00FCEBFBB17F207089EF36F224A20B023">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="75C94DE2" sha1="C2DC1DA33A2CA6B6B21486B675A9AB57B945D54A">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7621D572" sha1="EF0B7BFDE852BC27BD012D48EC9A6C459AA92F11">
            <board mapper="171">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="7653103A" sha1="6BA46BF1BC03FF07BF3E55BD8500E0979AB0E461">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="766C2CAC" sha1="BBB0AF27B313D7C838A38FB772A6FE8AFBAFBB95">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="7678F1D5" sha1="31AFA3DC3A16134ADDE4C7B3E7E2AE1E84CD4434">
            <board type="TAITO-X1-005" mapper="207">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="X1-005">
                    <pin number="17" function="CIRAM A10"/>
                    <pin number="31" function="NC"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="768A1B6A" sha1="1A8984C30881B474C7D48FEC72440A6FF0783FDE">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="76C161E3" sha1="0711BC8D0BF42A0829391C2320393A0D3DF2DD1F">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="7712BD99" sha1="C57B1F474D78357141918BF777C10C8E68D47546">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="771C8855" sha1="D30741F41F76B34C08032FC61579DC5963F1443D">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="771CE357" sha1="3B7C9A0988F6246D253379D5DE725602A202F68E">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="77512388" sha1="2246F8FCAD97C5A370FCC57DB37437478B2B4DA7">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7751588D" sha1="68A55EAFCEFA3014A4771CB7983D7DB42F80456A">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="77833016" sha1="A9CD3C29722050E9F149F24128BB478ADFBB8E7D">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="77BF8B23" sha1="68EDB4E9B01F80AD6AF01B75222886F15E868C98">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="77DCBBA3" sha1="55E97984252FDD37ED8F95343792A41A4906D291">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="77F0F71D" sha1="42E4EE7065306EED87A72B796633313D332EBF4B">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="780F9F28" sha1="D4EA33F095BDD94A1173A590273F5077C0DC32C4">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="78211EBF" sha1="354C8AEA48273FA69B3A3B525B803991981EAA74">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7840B18D" sha1="711F249E65E1053C7A18CB2BC76637FB8826AFED">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="784272F2" sha1="442E17E80C889721754462DFF8FEF8E3B07B0513">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="78872BD7" sha1="14D47FE37850EE801109978DB87D8C98152B7FB2">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="78A48B23" sha1="88102904E085DFFD8B795A0F853F8CD063AA2FDC">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="78A97FCE" sha1="4B1A96B30A015DDFA5B1A04C40CB93DDD31469B1">
            <board mapper="229">
                <prg size="512k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="78B657AC" sha1="4ADBEB66F76F316FA0F92AF0DAAC017BE2B1576F">
            <board type="HVC-TLSROM" mapper="118">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="78C4460D" sha1="A9A3DC7F4C728B96CC175B2E833C6BA98BE3E222">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="78EB1CFF" sha1="454318DAB671EB6C2C8EC34E07879A51139A5D6C">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-PAL-B" dump="ok" crc="790B295B" sha1="0815625D4E5A767435F67C4F49C4A09978BB53DE">
            <board type="NES-TEROM" mapper="4">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="791138D9" sha1="FB0694EF61CC93ED8621D9AD6C5251EE68A90571">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="791138D9" sha1="FB0694EF61CC93ED8621D9AD6C5251EE68A90571">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="792070A9" sha1="62FED37D6919A3E5A89D9A127A144637F718CC58">
            <board type="CAMERICA-BF9096" mapper="232">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="794CAAB6" sha1="BA41FEA3FE23A834C9420F67D34BA591ECFE9FE6">
            <board type="KONAMI-VRC-1" mapper="75">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="795BC424" sha1="29320367B20F6D6243CFB53E094ECD14AAB7AF2A">
            <board mapper="137">
                <prg size="32k"/>
                <chr size="32k"/>
                <vram size="4k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="79698B98" sha1="A9989F97B18D676B39E282FFC32483C0DFDFCAFA">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="7980C4F7" sha1="628C939613699CE59A0699DE1341535E414D4C51">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="798EEB98" sha1="AB1567BE407C4F05CBAD8F1B434F2D3C745BCC84">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="79D48F34" sha1="6AAC31ADF8FB794AACCA20A4566D7FE94D4026D4">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="79D7624A" sha1="F1909844F201FD8A31A896352F6F890DD865D061">
            <board mapper="189">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="79F688BC" sha1="89E2C88E15258FC40A2E0F13A8EB1A0D97E1D4B9">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="79FBA5A2" sha1="8070DF4E3D4D3602A2A6B223340C2148E1B1D1DF">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7A0985A7" sha1="E2176C59FC2AA6144253169935ADA2DD4053B0AE">
            <board mapper="45">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7A11D2C9" sha1="F112EF87A5EDB12CAA09A81D2D57B86AA5C92514">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7A1281CF" sha1="6E03F1AF01460C8081C3792B75432FBAD597C4E2">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7A497AE3" sha1="807EFCB68CB3143E8B0EB039523329437EB47778">
            <board mapper="33">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="7A9BE620" sha1="DB295C6BAD1B58BC1170C4B300C1C8D2A6BC1A87">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7AA02377" sha1="FF77D280A645EC2AF30397C2E70C374E6F298C07">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7ABB83D5" sha1="7F5D3F5CB0AB6C5F396850ACE8FB99FB68542821">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7AE0BF3C" sha1="8CD5A43785089A8BF3B121D975E6D248B796A9D3">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7AE5C002" sha1="BDF3A7D2C0E9F2554963AEEBBADEDB5D7C765756">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7B0A41B9" sha1="A47FB03C1CF990124FD576BD947800B733C0A07E">
            <board mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="mahjong"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="7B44FB2A" sha1="5F04D72EB14A0014E44C2875F705C62913538E42">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7B4ED0BB" sha1="394395B825F3D16902DF427E93C2310302A2B9AF">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7B5206AF" sha1="FDB70F268671FB6833557216425540CBB65CF394">
            <board mapper="159">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7B55D481" sha1="152B471669CFD9712DAC55ECB87E33E4BB7A7E97">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="7B6DC772" sha1="EF9B45FC0C1C28823840743BC99D96424C0B69CD">
            <board type="NAMCOT-3425" mapper="95">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7B72FBA4" sha1="51CBA10AE65105F1FBEAF00994244C5402878840">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="7B837FDE" sha1="28E8EAC18D89CC92063EAF8FB50E3A7C1609A181">
            <board mapper="9">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7BA3F8AE" sha1="78D21A1A73393C4C37322AE3373B3CE910386B49">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="7BB5664F" sha1="E774BD7771510ACCD095E83F896C8CDADF00EDFD">
            <board type="NAMCOT-3405" mapper="206">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7BD8F902" sha1="60BA08558D5316686195F8F0B9765B4EE8B4543A">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="7BDD12F3" sha1="4C6C0FAFD66D2EF828B492550812C28371EC2917">
            <board mapper="241">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="7BF8A890" sha1="D088D3919325DAD722AB77BC18F3A73F85A286C2">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="7C108923" sha1="F8B565C462ACF24AF80D87A788A4A8F5AFA9ADC5">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7C27AB86" sha1="230D75848E475FECDEDA4A5564020593320F9160">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7C3D2EA3" sha1="69FA4907E229E88995949F362658185CACE009B8">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7C4A72D8" sha1="15F245161179AB1959B7DC20E82ADD024D23AA3D">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="7C596E45" sha1="5BE6EE745225269FFD69D0F194C40343CDDDE442">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7C6A3D51" sha1="1DBB1FFB39DDE15A006667331B98D52F1020B21F">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7C6F615F" sha1="271C03C6ADF5A2D310C7EF6ACCFF7BE0CF9F3510">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7CB0D70D" sha1="761BA83F7E90C11F8FBE35AEC510D33D8BB6F024">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="7CCB8D1E" sha1="F4867214E6E6F11C9E3A75576E74059302FB7BBF">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="7CFF0F84" sha1="91FA719B4B05ADBAC0B9D507D2051ED361D1DED4">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
                <wram size="8k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7D48D1EB" sha1="EC1D1BA0F52D7DC518C4AFE906ECC2A2AE2D2335">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="3dglasses"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="7D55CF29" sha1="02A4F14F2E697C6BB1B42ACFC1F4A9D28EFB3D7C">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="7D5F149B" sha1="B032A112350045E9BB37989504231AA2ED2ED9E8">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7D718B44" sha1="DBD23A53C8AA268C081D30DA8F6EB9B3B7EAA78E">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7DA77F11" sha1="A3C8FA1895CBC5CA28D2D45DF60DCBD31D07225A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7DCB4C18" sha1="692F7A326C9FF9303D986CF520A6D50467B4BFBE">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7DCBEA73" sha1="9F9143680558DF91BF8A0230B3AD4A02C46CF630">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7DE81BC5" sha1="7FB334A7375E17EA157415193DEE4FACC4EC2B34">
            <board mapper="198">
                <prg size="640k"/>
                <vram size="8k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7E053E64" sha1="65185A71DBBC4C2BE3CDB80182B10F761D75E848">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7E26C7D0" sha1="0E6C109588AD52BD2DECF8B307A3A4D5EF499E8B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7E449555" sha1="265D9503A0A6FFDADC7391B2709D8D487928A9FF">
            <board mapper="53">
                <prg size="2080k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7E4BA78F" sha1="CF7A17818BF91F546C8CB8F72A9B427572575C94">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7E57FBEC" sha1="EB86CEEFF011B93A81630B0D5118876581BFC72B">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7EABDA5C" sha1="E7A823763415A322923ABC5E0EE2A228A0D092BB">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7EAE9A13" sha1="0FFF06D3877C16C8F3ABE133F53AD3F73D566476">
            <board type="MLT-MAXI15" mapper="234">
                <prg size="512k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7EC6F75B" sha1="EB861BE7181AE1D19BA991D4EBE0E06A5CFAE0CF">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7EE02CA2" sha1="E22AE723541184ADF7A81D824AD003CFD59AB485">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="7EE625EB" sha1="EB392F6F2CA12186697C88111105263F0D027985">
            <board type="KONAMI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="unknown" crc="7F08D0D9" sha1="20681C215312CA47D97E13FBD4AD2DEA5436BE89">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7F1D087F" sha1="C503151302E52A7347F1A856D4EC39C637FA0A77">
            <board mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7F24EFC0" sha1="7D28FF707DF69A62E0ACF40464C2F35E2523EB0C">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7F3018F2" sha1="63274FBA3F72A0DCB62DBBD2D6EBB3500E0EE6B1">
            <board mapper="148">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7F45CFF5" sha1="42808D943102D97057F09D9C4235196825DF55CC">
            <board mapper="92">
                <prg size="256k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7F495283" sha1="1E4125A17D4858DF6DC0B2DC6266372FC8E6F6EF">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="7F4CB1B4" sha1="C6617721F3D3E26FD7122B30E8FE070B230AFD38">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7F7F2821" sha1="E4F88F1026997B6C150A6A3F237F9593A6835100">
            <board mapper="255">
                <prg size="2048k"/>
                <chr size="1024k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="7F801368" sha1="6A0B6E0CA8AFF6FC78D2D28CC747CACBB5F812AE">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7F9BC8E5" sha1="7080C8C56CCAAF569E94C5E270EF6547DEF97904">
            <board mapper="45">
                <prg size="512k"/>
                <chr size="512k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7FA191E7" sha1="C835985E31C1194073F5A843419F220D41C8AAFA">
            <board type="KONAMI-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="7FA2CC55" sha1="A1AF0DB0A81F051AE273709202C8028A265728D4">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7FB74A43" sha1="1EA793F52EA2FEA9CF58DBF67B7EBEEA344CFACF">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="7FEDC0D7" sha1="6FA646258CF5BF022B143E977EFF55291397B9C5">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="7FF76219" sha1="AD8690675ECF3F3A86278A07AD442ABDF7EFB768">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="80250D64" sha1="8404E8E40C1421ACA7436E69C58EABAC8BC6B677">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="803B9979" sha1="9C1DF13CEC60CDED981E5F6D4F8E9486CB2F31C1">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="804F898A" sha1="77B73614354BA2484DA87345CF194A2844EDB3E5">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="805F81BC" sha1="77B974504E279B06A071BE7E936AEF57B7E13F1C">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="806DE21E" sha1="7C856725CB324E2CC3994773FB9A2462DC91DC48">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="80796845" sha1="6FDEBA148A3C446E2B63B8E4F86A61D1F015EAA5">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="808606F0" sha1="DF2ACBD6F6F89AEFF03881DD3F9FE5041DE05468">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="80EB1839" sha1="C7F5F8222870AB03881AA9220D5EA7B777748BE6">
            <board mapper="215">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="80FB7E6B" sha1="867F8F37C10C737AF77FBCC8853BF95B9DE248EE">
            <board type="HVC-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8106E694" sha1="5BB28A4A063C47C1F9861C67C62C01CAC50D9ABE">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="810B7AB9" sha1="DCBB5B66E27BA66D90A3F11D35FB968A63033E8F">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8111BA08" sha1="CAA4D1AB710BD766F8505EF24F5702DAC6E988AF">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="811F06D9" sha1="184D7BA4CCFE4143BBE4B3C793F0A3554BBAEA63">
            <board type="NES-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="81210F63" sha1="D1EA0BB3E919C5B2E5FE3A13D1CDAB9849DB473C">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="81389607" sha1="30B6F8BFC726EBDD8F9893EBD5928DF2483EDB76">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="817431EC" sha1="2783BEF3CC207E9BF57A65EEA5AB9B68E2214AF0">
            <board type="KONAMI-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8192D2E7" sha1="27AE95C7A3A0D39DA9C919AC4189B44563755998">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="81A5EB65" sha1="BE4EF2B1260CBD0743B074BF3FC1D266C504D72D">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="81AF4AF9" sha1="ABA26002DFF0D265BC2AC27A2689924B4FE0ED81">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="81B2A3CD" sha1="7174874846725B03591619946CDCC125EB382C72">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="81B7F1A8" sha1="DBC81F0BFC06E116C4AC2C05566B96769AB2F055">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="81ECDA0D" sha1="76B3C6118C1B9186F692068A5C5B969917951B96">
            <board type="AVE-NINA-07" mapper="11">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="81F31409" sha1="9AE241C0017309021D5FE3C18697098277F42474">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="821F2F9F" sha1="3AE0469A8208023DAA32A7BB9925F3C5666FCB2D">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="821FEB7A" sha1="83A3ACD2E1C51CAA7E1460963FACC1D96707F230">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="822F17EB" sha1="7ECAB9AEE085B5C8ED96A8BEA64EABA88249F398">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="823AFD95" sha1="424B74B15AD9905DD6EC5C057F23C0C88646DAB6">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="828F8F1F" sha1="9DC376442DB43C7786230AEEB54D5D643A4104E6">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8293803A" sha1="6B6F19237E16B21374D4072D64A29D9B8683085A">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="82AFA828" sha1="49B60CEAA9AF08C5179103380BCFFBEF6288EEB5">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="82B9BBA7" sha1="8748CC32C35E56696EE258D58DEA97DDAC533052">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="82BE4724" sha1="4C6AEB1BA671C9426A13E939E81930F3E31CCF8C">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="82F1FB96" sha1="5DA695BEA9F4D93C553969DC95DAD1AE88A6E478">
            <board mapper="166">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="83000991" sha1="B1DC42EBA45471436ABE54F22D5727407B8EB4BB">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8308FED7" sha1="B26BAF7ED80D33B8DA1FF4EABB00D76E0ECFB03C">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="831E6E0E" sha1="BB74E4CE67E5DA734CDD3113D2E7B8A9F408E356">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="831F9C1A" sha1="615E810A5DBA3C34112628F0349C4ABC0E2AEE54">
            <board type="AVE-MB-91" mapper="79">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8324A464" sha1="66DA7A1AC2A313A64ED23231B5F7A4DC1AB0B7F7">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <arcade system="VS-Unisystem" dump="unknown" crc="832CF592" sha1="1B516CF7688792F5DBD669850C047A7AFE9EB59F">
            <board type="NES-TR1ROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="833458EF" sha1="A61DF501E846D74A6441F26CEE262ABF59889252">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="83431081" sha1="30A02CC539DCA8A4D5FDA59040B62E0C693CD7A3">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="836685C4" sha1="C3BE7FFA6FCA119B7A13160F6676CCC5FE9621B3">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="836C4FA7" sha1="55DC03A493150258E10166CF38ED76DFADE605D6">
            <board type="IREM-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="836FE2C2" sha1="FBEC10A6CFAA15F54B0DF380AF8C3DF8610F830B">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="837A3D8A" sha1="AEF7D49E2ABE78145CCC630F939B65DD93B3EA81">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="838BF76F" sha1="93BB4137FA33C1AD94DAFABD4E4C65856B33CA0B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="83CB743F" sha1="F6959620DD3FCD7E2591F63BEA97C54B0DF4E954">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="83EA7B04" sha1="E521AAB5156EE802D9A3D064580249E2011158FE">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="83EAF3B1" sha1="2EAD41321E8AD4DF377CCCAFC4745829ECB94EF0">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="83FC38F8" sha1="18922D40D3A0C94D9C03539F31EB3F45AAEA2123">
            <board type="NES-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="84148F73" sha1="ABB50CDC61112A03FC4089E30C49F82C8FDDA790">
            <board type="NES-SL3ROM" mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="841B69B6" sha1="13D2E9997C02462214FA789BC939F4DDAB6D65A1">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="842A3FD9" sha1="FD45A6F9710258CAA30E42B0EF792D5779610260">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="84382231" sha1="A4346A6D83A148933879F7A6A2CF67C1979704EE">
            <board mapper="9">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="8442B86C" sha1="98FB5C152850DC5D8EC298D66420EE6E356D5AF7">
            <board mapper="87">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="847D672D" sha1="283CFF70A55EECAA61A4CB4046A910F7EB3AA062">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="84BE00E9" sha1="73F400F1EEE931EA12750B5DE018D1FB70C55D98">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="84C00513" sha1="60009AB9F4D90C529DE0E709C9B0652C8C5C4548">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="84C4A12E" sha1="C00723784CE98FD9C1E60C02D1ECF592F0409D69">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="84D0E294" sha1="236EAFBA6F9713F28E7BB8B53606528E6A40B765">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="84F7FC31" sha1="633ADA8089578C04CCF18F8EBD4B02051AB43847">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="850090BC" sha1="8F0C529E2ABEC1F3C8ABF1A214E47AEAFFC5EED2">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="851EB9BE" sha1="23DD98169C6CE2C6C2E805FE7546B9013A75962F">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8531C166" sha1="DB74F1727BC108680B9F5B5F1E654E5718AA3B3F">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="85323FD6" sha1="DBAD715A5D9F14AA86DA62FD6F07294A2905F99C">
            <board mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="853FEEA4" sha1="BEA81444E93255CC1F38D166DA1FBA9B642CA6C2">
            <board type="NES-TEROM" mapper="4">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="856E7600" sha1="1630E4AD536FA1333CFA285F8D581B19502992FB">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="857381F0" sha1="99A8A79B22F4F2D00A8AE4DE4BC8E03352D33D47">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8575A0CB" sha1="D4C67493C046153D9C1848F4BAE8FE62853BC705">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8593E5AD" sha1="84D2B96C2821FDC246DD876932F4E1752DF1CA73">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8599D7A1" sha1="7EF667D9BF107B6512565177B9C62081077558F5">
            <board mapper="198">
                <prg size="640k"/>
                <vram size="8k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="859C65E1" sha1="89E72D6D1BD0F7B13DF664151C7EA0F65F81799D">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="85A6C0D5" sha1="3FE39BA5FCFA423C6591905C832C18D163D66E4C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="85BC0777" sha1="9DCCB2F1338A0A7AFAED2D682BF35285980E6FA6">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="85C5953F" sha1="87BD31BFC524650D5EAC5E79057C88EBF134DF58">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="85D79AB2" sha1="93FFD4C0B3031734EED4708A9180AC8C4BC782A6">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="85E0090B" sha1="724DDEDF0C115EED66146A5E134E004B66105B11">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="85F12D37" sha1="8EF9616555199946C3224125337016FC5CF13E95">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="8650BE49" sha1="0AC088F8F8576E0A759F6CFADC4A2DEB5A7A5D98">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8660371D" sha1="1615E0679A72C7113469D0AE2899697083B8F12F">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="86670C93" sha1="17EBB77B5A7258BBB83B5F1B2630067542DD7861">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="86759C0F" sha1="E065A0A51BC01A85DC96492501086A13BF803A3A">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="86867830" sha1="6A8747A4A6F9F0FA35E66ED12F8AD8027911B302">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="869501CA" sha1="9DF34897D002E8D0E4D53B76154F8CD46927CDF9">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="86964EDD" sha1="C9E1EAF2DA59F7CDD923B23E9D74DB2D430964FC">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="86974CCC" sha1="4014D36AB4E0696740D7D5528FCF80914FD3D6F2">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="869BCAF2" sha1="81DCB203107B207941AAC143F6BA39E677C21F66">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="86ACB36B" sha1="C77100CA6EABB0F0D10A516BE2A7C4C50E2D3943">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="86B0D1CF" sha1="4C1500B754A881F2D5F48583F92498F36EEB2580">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="86B206B1" sha1="EBDB34B7212704221E012572903E85E491614E66">
            <board mapper="156">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="86C495C6" sha1="19EEA64CB2922D4E30797CF34C75597EE86F2538">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="86CEFC12" sha1="55D6146D7CDDB4CA9BD368DCACD5A855999C1017">
            <board type="KONAMI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="86E02D65" sha1="0CA546F47D9D7DA12E4E25852E04EFFB67F60545">
            <board type="NES-TBROM" mapper="4">
                <prg size="64k"/>
                <chr size="64k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="872DE7A2" sha1="0F4E4C212A6BCCAD4561EA31889D522007FD5D81">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8752DCCB" sha1="52C06BBEB70DE38361945DDDC7679533737D431A">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="87CE3F34" sha1="6B7387610FED625C7932455C688B5E42927E34E8">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="88053D25" sha1="4E72277DC2AB3B70B29086C0664014CAF6E16CB2">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="88062D9A" sha1="0FE282955F5CA4BEB8E4D1755C2FF110E31DC921">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="882E1901" sha1="38A8CA06E6A97FA6E5AB2DB25B7DCB3C2433971D">
            <board type="AVE-MB-91" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="88338ED5" sha1="9AD5B208ECCDC28BFD103E8CFA023A997EC72A27">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="883454EA" sha1="9B340A52D6B496596B2D808053696B3DBA514E55">
            <board type="JALECO-JF-08" mapper="87">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="886B5BD3" sha1="A8C855473D179BD7D592C3914D8FB617A7292E0D">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8889C564" sha1="E886869F2E50BED902133A3DDB8FD7E7853002EF">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="889129CB" sha1="74C53FE9AC779F146C59AC01E701C9BF912B3C7B">
            <board type="NES-HKROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC6B" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8897A8F1" sha1="58A45FA6B22F0507D1575EA54E70122F469A600F">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="88A6B192" sha1="12F58963DD70D32CCA2784BC1D83EC889FEC8E5D">
            <board type="AVE-NINA-03" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="88C30FDA" sha1="33487D9A013F81F434323960203E564434F8D2F8">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="88CB68A7" sha1="08B88255F184FB005C5F16F7A9E6B2F99491F839">
            <board mapper="164">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="88E1A5F4" sha1="85A115E87951B11A8A8DD48643D8CB3E57E3C1BF">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8904149E" sha1="9FE6FED4E8DEC3DF34C69C6D4B2E528A288246D2">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="892434DD" sha1="DFD47797DEDDDB36F5CA73F0E7D994ED792E2ADF">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="892434DD" sha1="DFD47797DEDDDB36F5CA73F0E7D994ED792E2ADF">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8927FD4C" sha1="4B94BB29C17AED8467C51352382FA01F5809DC50">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="892CBBC2" sha1="0C4E40E7BDD45C51BFBFEFA7CB75E375B78833FB">
            <board type="HVC-CNROM" mapper="185">
                <prg size="32k"/>
                <chr size="8k">
                    <pin number="26" function="/CE"/>
                    <pin number="27" function="CE"/>
                </chr>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="894EFDBC" sha1="6F3C65BD945FE13305A7A39D8CD884A5BF314A8F">
            <board mapper="157">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familykeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="895037BC" sha1="8E90D9A6A6090307A7E408D1C1704D09BA8F94FC">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <wram size="2k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="89550500" sha1="B23C30B3A50F775391B2B2A6176F66DA9D8BE75B">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="89567668" sha1="8130BEA997EE417EBF2380A9BF5C0D0EBFE77680">
            <board mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8980D0E8" sha1="DBFCC70CC2DEC7A889429ED542267F0F1BD967BF">
            <board mapper="224">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="89821E2B" sha1="F1484A3E93F7F4D916FABB4808D3301B35E5BBF7">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="898E4232" sha1="D3C4B6BA78D0405AD95D5D5C17C10F0D4DB27C6A">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="89984244" sha1="C550AF552779C712F94BFC776899FD76A64B3CA5">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="89A45446" sha1="AA5E70773FBF29398E236F00015FEDB14533D1B1">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="89D42098" sha1="F278A5E39D319021E486BCE04565A4099F24D0DF">
            <board type="NAMCOT-3305" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="89E085FE" sha1="3B6E0EF1458C883799923F6B86D106B488B5C6A3">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="89EC53C8" sha1="68D966FAF6650F47C00F8678F2E39E998B38EF9B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8A043CD6" sha1="D4AAD6280818A38B60B9EEF997833C1FA0FFA462">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8A0C7337" sha1="6281D62C1CBB34B1734D20747A8E3D8DE2AF1443">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="8A12A7D9" sha1="05B791369A42E4999847374D3FE304D5678AD75C">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8A368744" sha1="55C7B3672C12CD57E7CCDD30D7A31675C65C7A9D">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8A5BC0D3" sha1="016638ED6012260CE7FB75DD6F6B5FAD8AC01FDA">
            <board mapper="4">
                <prg size="64k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8A640AEF" sha1="5BF8F3D23F0819E23B9BCC9F1DFAFD3B6106C4F2">
            <board type="NES-TL1ROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8A65E57C" sha1="13CE9937A83E975B06D6D760347B940DED688797">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8A7D0ABE" sha1="6C8AB8187BD71C42CBE8EC84914714F56395A609">
            <board type="TAITO-TC0190FMC" mapper="33">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8A96E00D" sha1="D273629B112C8C11A133FA944874B9C21295AEFE">
            <board type="KONAMI-VRC-2" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A1"/>
                    <pin number="4" function="PRG A0"/>
                    <pin number="21" function="CHR A10"/>
                    <pin number="22" function="CHR A16"/>
                    <pin number="23" function="CHR A11"/>
                    <pin number="24" function="CHR A13"/>
                    <pin number="25" function="CHR A14"/>
                    <pin number="26" function="CHR A12"/>
                    <pin number="27" function="CHR A15"/>
                    <pin number="28" function="NC"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8AB52A24" sha1="6519882612BA8D69DC6F580C9DB4DC0DF7FD8C56">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8ADA3497" sha1="E2D01473F433826590D7A1DFAABBCE42AF57D8D7">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8AF25130" sha1="F6BEA9EA9ABF81E604EA1BA09BD0D49F396EC8C6">
            <board type="NAMCOT-3401" mapper="206">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8B03F74D" sha1="2B1C7C4871FFE07639C75C1861AE8CA0F7638C60">
            <board type="KONAMI-VRC-4" mapper="21">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A2"/>
                    <pin number="4" function="PRG A1"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8B4A2866" sha1="CE9752550AE0E4520BA2BA77C994374865B7ADC5">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="8B4D2443" sha1="5F5968562D976DFA5A321B784A31DC8C9CBDC22C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="8B7D3C75" sha1="2D4FC2DDFD935291BF9DACE324037C56FA1198A8">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8B8E405A" sha1="F96B754886C99300EDA81D97FB98273B2CAF2DA8">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8B9CB8F2" sha1="EE29199873AADD6B71D987B1F63B3927A730C4FE">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="3dglasses"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="8B9D3E9C" sha1="B5EB3572FCA1FB005BA00C45EEBAA9754C3FA4CB">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8BA75848" sha1="9D6EEEF0CAD251F1CCDDB6078BB7D0CBE56B9231">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8BAA5FF2" sha1="7FB74587BE559B531C28F06CBE5FDD692711822C">
            <board type="KONAMI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8BCA5146" sha1="36EC0A750888DB2BAAA21651528807D70CA97C6B">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8BCB0993" sha1="86ECF88DC812D34BF93AC6D641A7404254F3E179">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8BCDE59A" sha1="DFE253487159220F1A0E293A63B7B5045626FD19">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8BF29CB6" sha1="BD21B1C548F183A136B1357A283E46F73702D08D">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="8C0C2DF5" sha1="D9B1B87204E025A637821A0168475E1209CE0C8A">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8C23DBC4" sha1="D3C101CA21E9EBEF8D35419CB2C2F332E8DB4794">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="8C252AC4" sha1="B50258243F94EC6FD140CC786466DF645A7F7CE1">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="8C4D59D6" sha1="A3689327B36092F7DAC1F4FBFA99B704960AD2C3">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8C5A784E" sha1="191A131E7E27E121D094CC412FED87C708147B2C">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8C5FFBBD" sha1="51AC48D839955CD76AB1033F6FD73E87265F1216">
            <board mapper="45">
                <prg size="512k"/>
                <chr size="512k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8C6631C8" sha1="3D49D060728F40BDC37E83FA21D4BEACA6260F4C">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8C88536F" sha1="21AFFEB0462B15A8D5A52B7610DF69AAA3B16805">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8C8DEDB6" sha1="62A1FE0392FFD226D954CA1A02109DA58E394F1F">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8CA72D80" sha1="78F7EED80D86A111352963619209C829F65B0497">
            <board mapper="82">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8CE01E14" sha1="43574475BD58401A606AABCF1F35976022B799AE">
            <board mapper="163">
                <prg size="2048k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8CE478DB" sha1="66031E07D25B899EA3175A222C3939568D874883">
            <board type="NES-ETROM" mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8D26FDEA" sha1="C7E44436CEF7F77ED1D9DD53025E35A9BD623214">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8D3C33B3" sha1="58D5706205299570666047B124D6F89786A238B0">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8D5B77C0" sha1="D8621C9AA030E60453D74E2EC1CEE1B45DD1B855">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8D77E5E6" sha1="D2332E93093C5ACD2AF8E3F1380459DB09776329">
            <board mapper="4">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="8D901FAD" sha1="3E7B1F68A8E758D34252E4F2755D392F987824EA">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8D9AD3BF" sha1="E17A4458A5C94C5A019A2B60FC27EDE742DE51B3">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8DA4E539" sha1="9E90A1E4B24A68AA006B09DB607479C2FEB19FC0">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8DA651D4" sha1="93FC7CCD3CE12BFC548E443A6FF80488C4DBADDE">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="8DA6667D" sha1="438BB1EA6185EC16F4070E6FD1E6648588423D0E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="8DB43824" sha1="29A9FC3DA955D368FDDB1BBA929652DB7BE9BA48">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8DCD9486" sha1="FAB900149946D2C61B7AFA477E372293E3B3CE70">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8DD92725" sha1="6CBD1B3018588D028F5CD69AEEF791A92BBC6A95">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8DEDEA07" sha1="0C6BA8CC8BFD6CB767D12349C845280124D5612B">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8E0D9179" sha1="9BB9C3DF064B7F0698AF58338EF4C8D901ECB54A">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="8E2BD25C" sha1="71FDB80C3583010422652CC5AAE8E2E4131E49F3">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8E373118" sha1="26E47E25ED56A8F8D730956CA10E9D203857F2B7">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8E62D229" sha1="E15B9FAFD48FC61A2A0921FC85FA017697308417">
            <board type="HVC-CNROM" mapper="185">
                <prg size="32k"/>
                <chr size="8k">
                    <pin number="26" function="/CE"/>
                    <pin number="27" function="CE"/>
                </chr>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8E7ABDFC" sha1="C8D644B58D442651748AD81B5552C5E890C10A58">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8E9AFEF0" sha1="0D04D57CBB8FB2498F219059428139D263883467">
            <board mapper="225">
                <prg size="1024k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8EAB381C" sha1="0AE47BD83202A5A2235B0BC16278F56D66038AB5">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8ECBC577" sha1="04E6319370D20DD452CD10BACC026375E0F02E64">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8EE25F78" sha1="86D2ED5BDF689CC0B0812654C21AEBCAD234DE3C">
            <board type="TAITO-X1-005" mapper="80">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8EE7C43E" sha1="424C7F40F5CC383634C2E454D95C64B3D92118AB">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8EEF8B76" sha1="77272C0C0E821E9BB1EA416EF1C983BD46188D68">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8F011713" sha1="689AD264345C45D8F5316901DC1D7AAE3117A3DE">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="8F197B0A" sha1="81CB1057C361ACAC0BB19BCC7B3B5E7C30D923FD">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8F4497EE" sha1="1E81DAD3E13866464240032F281466E1F52D0A46">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8F4FEC56" sha1="0934FCF5F83A6EBEF24D43CE577A547A31303615">
            <board mapper="231">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="8F628D51" sha1="7D48A2743B868647985A47682D3A08E43AB2043A">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="8F726DBC" sha1="9AE04F05D0A7BD8E392337BCB3E66C60D66BDBA8">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="8F7B2FE7" sha1="B0FA48AF696B7B7D39799B86564131291B202122">
            <board mapper="45">
                <prg size="1024k"/>
                <chr size="1024k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="8FA6E92C" sha1="3F2AE24C129EE19A50248F85111B513B9C7A402B">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="8FF31896" sha1="58D464400B8952DA23E79D42E3C9166036ABFA85">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="900E3A23" sha1="00C50062A2DECE99580063777590F26A253AAB6B">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="90226E40" sha1="EFBBADE43E5F820CC7E13FF70B25406856C5091F">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="902E3168" sha1="503B64A28E0EAD2EE7312A46A4646B334A899846">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="903A95EB" sha1="D1D19FC5BBC2B45C90AD1928158949AADB2FB82D">
            <board mapper="241">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="9044550E" sha1="55DD499F92B7536EE740E18785A9113257E18838">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="90600B85" sha1="32FCB3315187D9E75E873B2B3387E2F3A168B09A">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="908505EE" sha1="D3F03CEF09F84284AF3FA6DD95A7057E9B7EA33D">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="90C773C1" sha1="2043F789A7B75E72DE91847C4818256733D4B406">
            <board type="NES-TLSROM" mapper="118">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="90D68A43" sha1="7698CE7AE3B83F12518169ECFEEE4D76D643C842">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="90ECDADE" sha1="68BEAFCA8429001543BE0ABF23911866B98FECF9">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="90F3F161" sha1="CCDAA5DC16C314BC9BACC9D4AAF7C91818C1EF05">
            <board mapper="86">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="90F6FA33" sha1="1B5FC6A78299A66002F3EC522347E6DCBBEF4D9B">
            <board type="KONAMI-VRC-2" mapper="22">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A0"/>
                    <pin number="4" function="PRG A1"/>
                    <pin number="21" function="NC"/>
                    <pin number="22" function="CHR A15"/>
                    <pin number="23" function="CHR A10"/>
                    <pin number="24" function="CHR A12"/>
                    <pin number="25" function="CHR A13"/>
                    <pin number="26" function="CHR A11"/>
                    <pin number="27" function="CHR A14"/>
                    <pin number="28" function="CHR A16"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familykeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="912989DC" sha1="841499E9E87E24AD0AFDC0C6A6F3152ABE4E8643">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <wram size="2k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="91328C1D" sha1="4A8147011756D8AE802F3D4595CB28EE173964EC">
            <board type="KONAMI-VRC-4" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A3"/>
                    <pin number="4" function="PRG A2"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="91467F41" sha1="5FC8EBB41762769CF7EED671FB03EDB35D967895">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="9152CE50" sha1="4958C00E4031931B0392BE94332727261A3F5C0C">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <peripherals>
            <device type="konamihypershot"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="915A53A7" sha1="32B6BE4598DBCE05559BDE7675D5238638FAF9BE">
            <board type="KONAMI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="917770D8" sha1="3DEB589C2551A4FEA31EC5F6A5A6F67C59B19FAE">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="917D9262" sha1="9AF46C87A2FD46C5C46DC91E902CF7FF4337A220">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="9198279E" sha1="81DE1DE17FAF55735D1E13351BAB5E54BF715422">
            <board mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="91AC514E" sha1="BE575ABE0A31D0330A148396EE41441B334921DD">
            <board type="NAMCOT-3433" mapper="88">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="91B4B1D7" sha1="455773982E332BFC30E5CF33CDF5475F2B5E0490">
            <board type="NES-MHROM" mapper="66">
                <prg size="64k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="91D39B22" sha1="DE5BDC387AFE74B0C4E41869B30A694EE5A3C3D1">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="91D52E9A" sha1="324CC9A7A8CF0E6C0FD06244D2BC4C3A231CF440">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="91E2E863" sha1="BD806D7F7C318B8012433250CA10AA8387A962BB">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="92197173" sha1="6A280A9BCF01D756EBDA46F5158080FADEE6A737">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9235B57B" sha1="84908DC67C29BE8600184FC5525B9227C8AFF830">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9237B447" sha1="74E6899A01E04CFED701922558FE2C8FF29B68FB">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="923F915B" sha1="CEF84201B09F138C5552119F805B8AB2E4BE07DA">
            <board type="HVC-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9247C38D" sha1="6B5CC33CEA66A994959835CB814905BF88A71D73">
            <board type="NES-TQROM" mapper="119">
                <prg size="128k"/>
                <chr size="64k"/>
                <vram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="924CDE0B" sha1="653974F364C504FD7949E3945089E0B220107FA3">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="92547F1C" sha1="5064C11751EA56ACF28FDC63A866657E0035C42E">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="926F07AF" sha1="DD70E82A83A85E0B6AD92B264D7D0B962BB9AEE2">
            <board mapper="225">
                <prg size="1024k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9273F18E" sha1="642A492A15BFDC8E7670140B15CAEAB271EE80C1">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="927C7A3A" sha1="392B7B86C2B61080DC6EB5EAC60B6FCF3BB8F3B1">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="92924548" sha1="8CFE5CBA7D68728F4EEA403AC8C0A497CABC9248">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="92A2185C" sha1="339EB36ACBBBEC96C8D177F0265253A5764CC1FB">
            <board type="NES-PEEOROM" mapper="9">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="92A2A702" sha1="C0649F8DEAEAA05EA67F48A3DA0FA9ACBCB42929">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="92A3D007" sha1="68315AFB344108CB0D43E119BA0353D5A44BD489">
            <board type="AVE-NINA-01" mapper="34">
                <prg size="64k"/>
                <chr size="64k"/>
                <wram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="92C138E4" sha1="7BF2E5DAD66CE253C25EC97CF27461C6475F044D">
            <board type="NES-SJROM" mapper="1">
                <prg size="256k"/>
                <chr size="64k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="92F04530" sha1="16FEF4831587A738D76E85517A1C6EE5FD87CAC3">
            <board type="KONAMI-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="93146BB0" sha1="25DFBF1134262B5F8138325A8F7339BDF2DA77B5">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <wram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="93216279" sha1="6DF9AECF5787C0833B0F05A9A83D0E58A6153977">
            <board mapper="46">
                <prg size="1024k"/>
                <chr size="1024k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="93484CC9" sha1="E597182BE1BF430A4799CED61337AC16506A9ED8">
            <board type="MLT-MAXI15" mapper="234">
                <prg size="512k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="934DB14A" sha1="8DD8B4D44297E10FDC814660F9A33EDCDA4B0484">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9369A2F8" sha1="A369B2A4A468C9E69533709E0DC3495457C9B9B2">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="93991433" sha1="93B758FCCB9A4D9E69E851172D2647AEBABAD461">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="93A7D26C" sha1="A7D18986648C5B0F6A598EE0E1EB4532E8196AAD">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="93B2CEC4" sha1="F5266495334149BD825941622CDAA84359A51187">
            <board mapper="65">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="93B49582" sha1="A809C7CF028C7D71C1B18275DD178116C5F07196">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="93F3A490" sha1="579FBA48D99F9181EA39C42ACCFD430125F2614E">
            <board type="TENGEN-800032" mapper="64">
                <prg size="64k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="942B1210" sha1="4302E78042DEFE8219DDB174243034320E703BC7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="943FD73C" sha1="81C0A24DC278DFC508CDE1CB7314A8F6FCEC2BDA">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="94476A70" sha1="FDB6818E0EFCBBD33CB9D17F1CCA251734E268A5">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="948E0BD6" sha1="7DD93D3B1D3ABD4E4B9BAC8A4397D1DD68F5FB48">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9509F703" sha1="987DE59B4987056A29B53A11D93B76FCE4B34EAC">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="952A9E77" sha1="4D0E7CF517484775041EDB91816B492727B896E2">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9552E8DF" sha1="68D2E5453044D4DB2D8438DFD1BF977F134CFD9A">
            <board type="BANDAI-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9561798D" sha1="985A81E4018297A94249DBEB436C083CFC179AD9">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="956E3D90" sha1="062FB8526334D7A5A70F3BD72658F882DC5BFA7D">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="3dglasses"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="958E4BAE" sha1="EEA21970963519178DCC49DECEF5B0F6804C772B">
            <board type="NES-SCROM" mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="95CE3B58" sha1="7A63862DB65DDF30A5129DC4BC83DCCED9C80466">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="95E4E594" sha1="B0F6CAF1292865C998B6A4A93DAE3E66B7D00C39">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="96087988" sha1="338F99B32B26FFBEFB5BE92AC27AC3295713FDDC">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="9630A7E5" sha1="79FCF28F18E93A77A320731916451A0778A42260">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="9632C470" sha1="5D08218E39AE4D76925C6888BC0F03A1A3B829B2">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="967011AD" sha1="5B8B30E76DE530895114ECC8C01119D64D65D40C">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="96773F32" sha1="5AE432AE1CF9E838E7A0F42C36125C33C699B527">
            <board type="NAMCOT-163" mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="969EF9E4" sha1="899ACEF105506D2DF7D37AB1CC848699500E6499">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="96BA90B0" sha1="559C8EECF3FB93582407A100BCF78B6B6729B656">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="96CE586E" sha1="B094D9D20A193BF28BD57A1154EADA84F9F6C9CC">
            <board mapper="189">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="96CFB4D8" sha1="B97DBE5E62F7A30D7BE639F506D48553853F1C7B">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="96DFC776" sha1="43693DC477B86499760CFCEB375FF040E4465516">
            <board type="TENGEN-800030" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="96E6C1CE" sha1="AC70354B91596E7B20EDE132C9B1ACDB5C7D24B9">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="972D08C5" sha1="C8221914B4F67D01023BEFD3C0F8B438E40A9199">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="972D2784" sha1="65E12A86355AA7CF89FBF212DED36EC77B6E1E2D">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9735D267" sha1="A0939930D9655E7FD2C3FAE69D558614F2D27480">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="973BBF75" sha1="B77BD6EB083A0B7BCFA536A34E575BE4D0D2371B">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9747AC09" sha1="67FD2B7B9B72B8635515BB37926D77970720E3D6">
            <board type="NES-SLRROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="974D0745" sha1="F33FD92B697287626346296DA1314E617BC72DA4">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="974E8840" sha1="8F228F38437423388A2E0860C05B1798E20CFE95">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="976893D2" sha1="A24411362F4CBC0077A6A435544AD15736331C81">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="9768E5E0" sha1="F08357458FF1DBFEBE152CAE100ACEF62F84774B">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="979C5314" sha1="B29F4BB5B0C30ED133AD82CA5A2134C31C003862">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="97BC4585" sha1="D586FFF4C5ACDB3EB302AD9D03279FE62BF16E07">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="97C77719" sha1="E2CF6E04B8D620AE28E7CD26EE4FD74595DB6F9F">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="97CAD370" sha1="DD1D51FF6D57E83F2BE0517F1DE821C85ABE86AE">
            <board type="HVC-FKROM" mapper="10">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="97D52C06" sha1="12BB7B989AD815A0512020D845B9EB09B31E5547">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9806CB84" sha1="A93BF8DFC5E276B2A4E99E64620242185526672E">
            <board mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="98087E4D" sha1="067F1BC83F210657109AFB2194B4709B9F08EF0A">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <wram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="konamihypershot"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="980BE936" sha1="1D203ADBE5DEC06190D57367FE91328F1E9A309F">
            <board type="KONAMI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="982DFB38" sha1="8FC3A23A8E89B1E952AC137C1E3F7C7181CBE777">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="983948A5" sha1="D072661EC8A8C293A2C70C74047733DAD9555226">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="983D8175" sha1="29CC759D5CA214EEFC0CC1C6CE0F8B9111E58124">
            <board mapper="157">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="985B1D05" sha1="3AEADF8A86CED1B4E2D824AA39669F26AB00BB0B">
            <board type="KONAMI-74*139/74" mapper="87">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="988798A8" sha1="26D33987CFF21C651FE3D638F4A739C33A18C240">
            <board type="NES-TGROM" mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="988B446D" sha1="260166D22C895DF4F30AC63E4E8D0C3F1C7B1585">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="98977591" sha1="1B5A681C8C2B80781A395A7039AE22E6151CA4FE">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-A" dump="ok" crc="989C1019" sha1="B9607E670DA81FA5C72ED66A9BD8277D41C799F9">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="98A97A59" sha1="E8649D3005291B73723E3A9E1BA3D60A848007CC">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="98C1CD4B" sha1="0B58E16B7FD5ABE62B1D9B1841875582DF5A9195">
            <board mapper="192">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="98CCC9AB" sha1="0AEF90CD34800D03E7E49A8D14833C92510CABDF">
            <board mapper="68">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="98DC1099" sha1="4E2212B9897F3E45C8BBCCFBEA664989E78DF5C2">
            <board type="HVC-CNROM" mapper="185">
                <prg size="32k"/>
                <chr size="8k">
                    <pin number="26" function="CE"/>
                    <pin number="27" function="CE"/>
                </chr>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="98E3C75A" sha1="B21AA940728ED80C72EE23C251C96E42CC84B2D6">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
                <wram size="8k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="99083B3A" sha1="E68E0734B127FF92B93A2DCA7F466C90929165D0">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="990985C0" sha1="AA08F65D6333448F088D8DCE32F3895662B577DE">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="99240573" sha1="1F30FCB3972E73595D0A24C981886381602986CA">
            <board mapper="16">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="992AF039" sha1="43BFED8C950055A9C85B82518534D785B5439859">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9960A919" sha1="E8A7AED8BB86654BE7991F179713B93A74FBEC11">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="99686DAD" sha1="BF1EE3765229AA4A1F5B5E540AC0661107099CB6">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="997DAA54" sha1="7A2F5D69D5D1E9E43AF2AC644A024F35F8B102BB">
            <board mapper="60">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="998422FC" sha1="88F0DFA7F034B95308BC04E2A0A38FFB2320268B">
            <board type="NES-HKROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC6B" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9992F445" sha1="F325B1369CC39B47729EE5B0AA61B11EEB60B94D">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="999577B6" sha1="637D894A3704099F8519D1B048219395F14C6BB7">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="999584A8" sha1="6A21DA874662C9B0F9C8F81241D5FBC89F3E2323">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="99A28276" sha1="97A51781DD24AC527A690C656502BB7C97AC9D71">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="99A62E47" sha1="7A7A71A08B19D3357AC59187EB108887831752B4">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="99A9F57E" sha1="3954E690CBF5241181DC592F01E87BEFA5531374">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="99C395F9" sha1="685886553C8858B704D90456F2E8F52003352598">
            <board mapper="48">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="99C88648" sha1="8861C25D42E6BC24A8E746F286B111B242853459">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="99D15A91" sha1="0BB2C29B35517E08E5DCBA6DB9AAE4B18055A84F">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="99D38676" sha1="5659D62879EFCB0A9D103862D8A4CC0ECACA62CD">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="99DDDB04" sha1="3C011E4EA5EB7E93299347F8009E5BDF51E223EB">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9A2DB086" sha1="0C4992FC08D2278697339D3B48066E7B5F943598">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="9A43AB3C" sha1="97F216518CF6998775997B0F6B5C45E6D290D014">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9A808C3B" sha1="1C36FB794E4FABF4CB60407A928AD9C8E1EFEE6D">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9AACD75D" sha1="CC6C3161BD1C0C34A0FE195CD2E2E43FC92EF71B">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="9AB274AE" sha1="340DA5FB21BCAA3BCFED17D7D4D8B42CBBDC3BB0">
            <board mapper="228">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9ADB2AF7" sha1="44903AB69186ABBF7A86D37CBF5CBA7D64201817">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9ADFC8F0" sha1="371882429C5E4DA94BAEFEF79D361D4CD99069BE">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="9AE2BAA0" sha1="68DE623B2AD92BA19D18F17EAA0B97EE4523F6DF">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="8k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9B05B278" sha1="CA7AE22E8934A9ACA0853406D4A074F1807D58E7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9B208AB1" sha1="5B26C00AD2CD2DB81783AB039B2142E7B0A784D8">
            <board mapper="1">
                <prg size="32k"/>
                <chr size="16k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9B3C5124" sha1="A96BFC7B51E2F7FF69F42B024CC9FB85CA9A943D">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9B506A48" sha1="DEE513DAD7223CFC81BCD859D0AAC6746349CB25">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="9B506A48" sha1="DEE513DAD7223CFC81BCD859D0AAC6746349CB25">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="9B506A48" sha1="DEE513DAD7223CFC81BCD859D0AAC6746349CB25">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9B547E05" sha1="882E0017099CC5784F3D3EFA66FAB4C38F83EC46">
            <board type="HVC-FJROM" mapper="10">
                <prg size="128k"/>
                <chr size="64k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9B568CC4" sha1="7560AAA23D1936F13B9F995A6CFB7EA028C46C96">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9B821A83" sha1="3CB2C31F2F7E3A0F254353C4B88190103254703E">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9BAC73EF" sha1="6802A12A7A33D09C6DA6185A59DB69FDD5A9A6D9">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9BBF3E5D" sha1="123105A996B3F325E55B7080DDD83D4CF043E543">
            <board mapper="15">
                <prg size="1024k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9BD3F3C2" sha1="3F3B406AF421DCA25AE28A83C5AEF73A085193BD">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9BDCD892" sha1="21A07723CD1E509E966147BA6C72118C9F199D58">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9BDE3267" sha1="A042A3BD69C2EA5B944DDA26EA5F47321B175EB5">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9C04C8D5" sha1="9CCD7E334AB5578D72608BC3D8CD033B3E7BB588">
            <board mapper="159">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9C053F24" sha1="F42514CF16570B5C288C335617755BF5A0D6A1E1">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9C18762B" sha1="6197D576DD1C2A2304BE82B7BE6768A13C40BCF9">
            <board type="NES-ETROM" mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="9C304DEC" sha1="501F41735B20DF391733B1A21DB3A3144BD06C79">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9C3E8FC0" sha1="F80174D43CD6A508F3A3C6F95576F1BF1D7B9D69">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9C42E662" sha1="E594F1D824B7D4CF7AAA879E48BCAEC68D9E3157">
            <board mapper="83">
                <prg size="1024k"/>
                <chr size="1024k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="9C4589E3" sha1="C10C526F26273C4A1E180B968665910B74C78B86">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9C521240" sha1="3A36ED5C71472B59229FB2D03E281A1F0F3C2E31">
            <board type="HVC-CNROM" mapper="185">
                <prg size="32k"/>
                <chr size="8k">
                    <pin number="26" function="CE"/>
                    <pin number="27" function="/CE"/>
                </chr>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9C537919" sha1="12C64449B7470AECF096B32AD2D19CC62BF99635">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9C58F4A6" sha1="ACE5A3F65FB4AB801F1989C05BFA39FC7877F8EA">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9C924719" sha1="BD0CECB9A5B7B1A9B8164332CC154F4E64992927">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9C9F3571" sha1="C76212E682C0FB725B542AB11EFFB3A48137B0C8">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9CBADC25" sha1="49562C8D5649CE8119E83E9A34D2335D3D43A43E">
            <board type="HVC-EKROM" mapper="5">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9CBB0291" sha1="C8F85816A7D219B1AB9DE75B6A57EEC68DCA37E6">
            <board mapper="206">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9CBC8253" sha1="7AA2C4E1169F0BB1DB95F515456FB75E16461B60">
            <board type="NAMCOT-3415" mapper="206">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9CD5128C" sha1="D54CEB7771B5245F852B361BB9FB67277CB58250">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9CFA55E7" sha1="E7A9902E9800CEA94C8CC5D57A515606D0C403D9">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="oekakidstablet"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="9D048EA4" sha1="2D95C59CCD0B3FAED4B4E3E61AC2859352D59594">
            <board mapper="96">
                <prg size="128k"/>
                <vram size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9D21FE96" sha1="6D23562A4606E7F4FE5F1A620B7FF0A79C20AB41">
            <board mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9D34EDC5" sha1="2DCC26DFCA2CF215AFCAB0C61D4252030E842CB1">
            <board type="TAITO-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9D38F8F9" sha1="AB5DC98F1D6D220708F5DEC4E87BEC175BB635AB">
            <board type="TENGEN-800003" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9D45D8EC" sha1="C69C57F1B519381BD29707D6DCFB96ADD6799009">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9D976153" sha1="05779CC072CAFCECB91BE5C7EEB8FD86519A4A6B">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9D9A4A26" sha1="4125D36CB2F1B9CFC48B5E37008A69114A7FAD8F">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9DC96EC7" sha1="0F4A2534C1A11309079E7F488F71E72E75A04BC8">
            <board type="JALECO-JF-29" mapper="18">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="D7756C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="9DF58E80" sha1="ACC9C9EB5DEFDA865CB84BB6057D739EA4CFE5E0">
            <board type="NES-SJROM" mapper="1">
                <prg size="256k"/>
                <chr size="64k"/>
                <wram size="8k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9E356267" sha1="9666209B62FCF572EA695BAA2B8979AD06E69CFD">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9E36080E" sha1="82855B15F47A369888504F0AE0C865ED665AFBAF">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9E379698" sha1="52621D0E0782CD94B588B50860A6DE3DA94F2E63">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="9E379698" sha1="52621D0E0782CD94B588B50860A6DE3DA94F2E63">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="9E382EBF" sha1="C8BABE6EEC9BBE04A9C3916D75319AE88E61322D">
            <board type="NES-SBROM" mapper="1">
                <prg size="64k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9E4701CB" sha1="1FD1BFA72C2415A89FA27DD486D78E3F5449A459">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9E4E9CC2" sha1="92C3361B9E3B28A51FD30E7845C988A6D576EE65">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9E6092A4" sha1="8B3CA684081CC60B40EA76AAB6B4E6F32B27F8A7">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9E777EA5" sha1="EF0D82446ECE6DC69F53E1F9CE6FF07654F54081">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9E85A7D9" sha1="5EFC143614A9AD53884E82441150DB5C22CEBBC0">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9E898385" sha1="7EB88E7678AB484593168328F63125330DA64C6F">
            <board mapper="65">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9EA1DC76" sha1="C444DF09D81B20BA54E2F0A8AA01702FFE5F5C68">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9EBDC94E" sha1="16D8F322ED337255A15B607FD1FB77950D59AD56">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9ECB9DCD" sha1="3AE1C82AD66C5DCDB915A26AF3A8FCBAF68B1975">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="9EDD2159" sha1="FA189FC0F9277D5765E5DE19274AFBD28660F076">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9EE83916" sha1="D5DD29B9402DA87F9D8600A76BDCD7A9C191D2AA">
            <board mapper="72">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9EEFB4B4" sha1="15A7F8D5328B023FA10AD5AEBDA2378BD11BF45C">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9EFF96D2" sha1="E162437D0FAF6FAD0FD9267E6DF656C4FFC783B2">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="9F01687D" sha1="149ECA5642642BED5FD98B12D682235C02DEF342">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9F03B11F" sha1="1247ACC920241CD3AE5CC9D200B41403EDFA1A71">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9F056212" sha1="83ED4AF17E76975DC75EED7836C198A50EA2E51E">
            <board mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="9F119033" sha1="D1BA76E93F14E66D98543EE1599475DD0E79A4A4">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9F2712DF" sha1="F479C80513575F6AB71AF1B7A12C221AF7006B0C">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9F2EEF20" sha1="AC3F180C7CCB6EA35D24658B315E5AFA72904F74">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9F432594" sha1="67FC0E56C5A70604E8E6B060498FC3AF546DC53F">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9F5138CB" sha1="CB22AD7975FE4BE7FE576EA6F8F1467415BD2421">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9F6C119C" sha1="9134C3C0D9AA8341A00872FB22E028E2C0DF5D27">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9F6CE171" sha1="3A7D827513166F20E09B80E6EDC2870AFEA709FB">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="miraclepiano"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="9F8336DB" sha1="4E2B75E0B249D2A1DB6B73A2F35636F514F7175D">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="pokkunmoguraa"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="9F8F200A" sha1="5DE0FED56EFB2DDBE2ECC482A26CA064BA3D7263">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9FA33CF6" sha1="D4D4E9B739DFC0388B23CD135C8907EAF525E170">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="mahjong"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="9FAE4D46" sha1="7AF71B17ACD5D4C03C69C3CBBF38BA78A72D9AEA">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9FB32923" sha1="E8F38B21A2CB5373993B3CD61345B742A45747F5">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="9FD35802" sha1="C38AF729C2BE2940FCA620F86415FAE304F1D8C9">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="9FD718FD" sha1="D477320DC99B294B5D26995F1527ECA0233F2F46">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="9FFE2F55" sha1="9C716EA39A942C81284CA683FE85088AD6E57D5A">
            <board type="NES-SCROM" mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A0006B26" sha1="D9AA24B9625F66D928F31C7BC749ADE670057194">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A0230D75" sha1="7CF7192C0EEE713C3AAFF84D38D45D1846F1B105">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="A038AFF2" sha1="E374E472B7071A23CA966C5F002B79C85106802E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A03A422B" sha1="A2EB5FB422A88A1F38A9E7236164F9F251D32C24">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A0568E1D" sha1="725FED2FD8B59AA96CD641B74B2A6A7506DBCB44">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A07C1F81" sha1="BFFF492A1A6C180D9B1D5633342753FB31161531">
            <board type="BANDAI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A08B4701" sha1="702F010D37FDA6C419F52785F0A4AE498E1E0539">
            <board type="BANDAI-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A08D7CA9" sha1="2BD81901B36C89DC9513AE48D926ECD1EF819E57">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A09AA82C" sha1="13FF5A62AFE5EE7B4EA5D537EE92BFA253EB98F6">
            <board mapper="91">
                <prg size="128k"/>
                <chr size="512k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A0A095C4" sha1="880B523FD191564D71744FC891261CD0BBC4ED0C">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="A0A5A0B9" sha1="6822EE722C43CFBC255ED33F37A3C33D2A22FFEC">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="A0A6E860" sha1="F338CD17B4C78CFD2CE2F079DFF833845F07FFF5">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A0B0B742" sha1="A611B90B4833B20A364BF06EE3BE3B9093EA4DF9">
            <board type="NES-TSROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A0C31A57" sha1="FF85291101E5CDB71E4C29875E20B557EB97B269">
            <board type="NES-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A0DF4B8F" sha1="84661CFDB711405EACE0C9DAD8D99E4C44F49FA8">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A0F99BB8" sha1="1C1C8CB0BC821EA9F795B609596280741AB2BC73">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A166548F" sha1="6728C231090850C5B55E7954CC2BE8B45D4E5214">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A16AB939" sha1="1DCB72A2426174F1B52EED66ECC4D681FC35CE6F">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A1A0C13F" sha1="5353CDBD255E908B16382C6669F3A9D76138B749">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A1A33B85" sha1="87FEFD2FF030DC353BDCE2670D082158208CB307">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A1C0DA00" sha1="DBD1BF833A9D89A9AC41CCCED0FB508074A489D1">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A1FF4E1D" sha1="4C6D53EFFDB90A421F8E92C11738DD2AF2EC4495">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A2194CAD" sha1="9035459E43D13FCCC244FCA0FDAEA4EC335B34DC">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A21E675C" sha1="A6B1A2ACAE1E4034C5E048D1318541D67A86F17C">
            <board type="IREM-BNROM" mapper="34">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A222F5A0" sha1="25425A074B29326FFC2BD32E6A2333137C394233">
            <board type="JALECO-JF-03" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="A22657FA" sha1="D529E7FB2BA1AEEFD7F7A5258B53732461F85BA0">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="A232E8BE" sha1="A58F4EA8A47414E80C7D18BDF4590E6C6DEF7214">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A25A750F" sha1="168EB95578671562D0B1532AA78162AD13A363F8">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A2623BC1" sha1="1CE1BBA4E6BEFBE7145EA9A9078C8A6C1A5FA1A8">
            <board type="SUNSOFT-4" mapper="68">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A262A81F" sha1="875391ED9435C3B5A9D5F2A100B99205D8009B88">
            <board mapper="16">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A2AF25D0" sha1="7CBD0FBE356FFB45D42F76195A7714C06FA6350A">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A2C0CAB7" sha1="FA8790EC709E33781BFE6C41A327FCDF66FA5A1D">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A2F713C0" sha1="032122DA22D5B5779B2E491191139DFF8637166C">
            <board type="HVC-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A31142FF" sha1="01B042274AA9164C33769E61E299292875835678">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A342A5FD" sha1="C84D7288FF5578850456AE0F50AAFD2167A79798">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A38857EB" sha1="7704D094C6B2D1AFFCF84D9856548E5F17B041C4">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A38DF799" sha1="E32F04DBDA364A7A322F11CDE59A7016E6E1B2E4">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A39311CA" sha1="F2020072550518768D7FA46DBC7C2B987B9F75A5">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="A3BF2ADA" sha1="DF894C1D1D00834B28F7640E7B338A2CCA1F9FAD">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A3C0D49F" sha1="18E2415A94532AA583C80F2E1F8906646E1CC1FA">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="A3E37134" sha1="3F406EA2E41B5E725BB8DF31481D23F3CF6F1DBE">
            <board mapper="10">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A4062017" sha1="053DAE5A60DAB8AF9BDD8C70BE72A805276658EB">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="A46D7F02" sha1="A029442EDDA3A743B8DE2B6627030563ABC6206A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A485ABED" sha1="20EAD41AF2F51BAC2BDE8CAFDD248D8CF73745D3">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A49253C6" sha1="24445905810FA874EDC6758C4AF6B1A3845A7F0D">
            <board type="NAMCOT-3414" mapper="206">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A49B48B8" sha1="5759A9D658D253C8A6AAA38969C443D66E0F3349">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A4BDCC1D" sha1="8D7CA48394996EF45AB1094B582D00AD7B028F21">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A4DCDF28" sha1="0CCDBE9A46EDF08384BAC113AF9866D4EE89B925">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A4DCF72E" sha1="07B2DAC6D07FCE569F55424C30B46EDE177DFEAF">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A4E935DF" sha1="EB57555EE85606FF4974B37FBB5BCC6747BD2FEE">
            <board mapper="69">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A531E1AB" sha1="0A0772721642DE00FE575CA109891E274251D815">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A547A6EC" sha1="7674FF62D4F0F0D507B2F2AA9F69C2126CE72169">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="A55701DD" sha1="77D699D6B04BC55F14A1CCF931902A5F10EEEA18">
            <board mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A558FB52" sha1="AEF894686836EA03FB047FE87979AFEB079C350C">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A55FA397" sha1="35E99338DBD988F90D5636688C34C6B181FFEFF0">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A56208A0" sha1="62A7B899F2CA01BDBD0C6A0024C34C6F9AFB6228">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A563F0E1" sha1="C12A96D493DAC0B7953DA3067619E0E797A7130E">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A58A8DA1" sha1="1AD0D85866C887FA924C890E3E1ADBC0A9F5F0B2">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A58D7260" sha1="806787886BEC15C8D7E5694EF6398AC18BC410DE">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="A5B62A4C" sha1="0D7BDB4FF3FBE98C93541E12FA6BC9933DFCA221">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A5E6BAF9" sha1="4C1C5E1890A1CF4C25C6D543A2B5CDEAAD2220DF">
            <board type="NAMCOT-3416" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A5E89675" sha1="CA694984A4E4286D15EEAF9FCE4F5E4B47763EE4">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A5E8D2CD" sha1="2AC8BC78031EF613AA2D2E0E7968B34EA7E3398E">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A60CA3D6" sha1="0A6BF1E319A9EE7B5B7EF3C3BA20A04C57BD8C89">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A60FBA51" sha1="789AD828D2EE2CED8F83E2BB510264360B6424D5">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="A6153536" sha1="62DB914356EFE43D9E693E8D379D896D0213494E">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A63C6793" sha1="9BDFF9A19265D84979F43F0F6E925A735DDEB38B">
            <board mapper="242">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A6638CBA" sha1="E28BA80BE814BB032BBE4647C1B2104F868DFA25">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A6648353" sha1="E526665AE3551990B1BF4AE52FAFDB622B87C714">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A66596D9" sha1="3CC786F4B1B1E884354106793CE0A1159796C3D3">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="A66D5150" sha1="73396BA69AA122D64DED6F211F3548242DFDF229">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A69F29FA" sha1="8C13584F22D1FDE5711DB2C59940EB37E6FC1ECE">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A6A725B8" sha1="3B01A043EB47AA2503A28A861EB686F1505E9A76">
            <board type="NES-UOROM" mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A6B3F7B3" sha1="04D491944B90568D46E8DC7284AC9D1DA4026D48">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="A70C088B" sha1="92B570C3CF9A6F708FEBC268E2B61CA255C6A5FF">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A713DD30" sha1="985972817C937B24DF9A06F354B5C3C0B51B15D2">
            <board type="NES-JLROM" mapper="69">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A725B2D3" sha1="7352EFA485690B93E8FC1869696206CE06254385">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A72FDE03" sha1="0837F9FA65478CE511C96392B5249D21ABAA632D">
            <board type="HVC-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A74325EF" sha1="4F01044EEBDD831959EBC517A280AFD097CF9D01">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="A781FFAA" sha1="87C929090C3B04739BAAED90B9A8F40B29327FC2">
            <board mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A7B0536C" sha1="67C5BC4D8B1A4474A027A3B111E186EF816F88DE">
            <board mapper="48">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A7D227EF" sha1="8AC3C587F66A309F26EC8FF8652A0D6826467D6B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A7D3635E" sha1="9F3DE783494F7FF30679A17B0C5B912834121095">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A7DE65E4" sha1="89BB4EB23AD71FF3E1DDC0C7957C09309C93E11F">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A7E784ED" sha1="13B3425E69886438F4BCA50A1104B0B11E9542B5">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A80A0F01" sha1="C78F57623C4FCB10DDFDA88E519362BE87E432C0">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A80FA181" sha1="6501F61FD717AE603C2265D0DF074AC2A4DCB8C7">
            <board type="HVC-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A851CAE9" sha1="787B087959EB837200648484CF609A6D035ED4CF">
            <board mapper="159">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A86A5318" sha1="E58B61B031A9F0DC168525654BCB9883EF61A976">
            <board type="NES-SUROM" mapper="1">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A86B5732" sha1="92C9348B2EB38EACE339505538F91D5FC967643D">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A8784932" sha1="0B66FE6D5F724F4F66F1E1FE76A65A84AC876C7E">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A88D8E19" sha1="2B4B75AC401B3C5D843ADAC9129F313249BB14DA">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A8923256" sha1="F3C02A8900CDD78BA777DEDBE09701C1CCE3531E">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A8A9B982" sha1="22EAF03CC4A148EB7F96CCBDB878170B6D117940">
            <board type="HVC-CNROM" mapper="185">
                <prg size="16k"/>
                <chr size="8k">
                    <pin number="26" function="CE"/>
                    <pin number="27" function="CE"/>
                </chr>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A8B0DA56" sha1="261BB61193616DF80AFF5214DFCDF95FBDB06E90">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A8D93537" sha1="FE6A2F35CCD699C1324A786A733DFDAC26794C51">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A8E39EC6" sha1="CF34157DC5A68055FD828B481DECF50345304EA9">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A8F4D99E" sha1="A856DB911542DC835DB7CE67DAD3E159BD7A637F">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A8F5C2AB" sha1="DC2E87C1237276F93E418FE3A62A9DD7747C6559">
            <board type="TENGEN-800030" mapper="206">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A9115BC1" sha1="F459A9AD6F841169E0210436CEB06B1395169EAB">
            <board mapper="192">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A91460B8" sha1="758C9EC51D442DB2C02C4FB37A9AAA37CC8F6B05">
            <board mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A9217EA2" sha1="DEE9CF8DCC91DE3F9C65181A07E7E84F7570363D">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A923E441" sha1="5E261ADE5E65CA073313A61FA4D99856530B184A">
            <board mapper="133">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A93527E2" sha1="0EA29D38B0D1740234DED685546D5ED9E1B3699E">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A9415562" sha1="86788BD888F04D5EC2F6180B00C00E6C11225D78">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A94591B0" sha1="146432B03E8351D3128394AAA62A24E01C548C7E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A9541452" sha1="111D38E2FB41D0B43753E18757D427A91B0DBCB9">
            <board type="BANDAI-LZ93D50+24C02" mapper="16">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A95A915A" sha1="504632641D12B860819EE70F71859AD08F6F87F9">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="A9660690" sha1="0A571E3A0130D58431E5890966805230D2820C05">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="A97567A4" sha1="D70BCA094B244FAC0F126F80AF31139FA3F0C49D">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="A98046B8" sha1="49E7B12A17E9C339F93069895D5A98D10A43E266">
            <board type="HVC-FKROM" mapper="10">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A9842027" sha1="CBF1101A957071C1274E1C3C74097A61580AD8DC">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-A" dump="ok" crc="A99016C6" sha1="2EE025A0B953E9E9AC6241074173ED65A1CC4F07">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A9A9DD92" sha1="C9AAC4AD3095FDCB23A9338A01D9BCA62F71F848">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="A9BBF44F" sha1="A34E68372082513209A795786C8EEA493CC2CD14">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="A9C07FF3" sha1="0DAD6E91B420E6A3D41EC415BC9FF58331593559">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A9E70766" sha1="78F3FD3DA2DA3FAF88DCBD68AB94498B82F89F93">
            <board mapper="83">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="A9F0B6F3" sha1="D0FF30DDB02C7DD6804151B984C4D8634CD902CF">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AA20F73D" sha1="503EB23955475D105029FDD6AE082BCC14E7306A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="AA2F7D91" sha1="DA313C037BCDFD54BD071FB9D259E31FAECB1FA1">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="unknown" crc="AA2F7D91" sha1="DA313C037BCDFD54BD071FB9D259E31FAECB1FA1">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AA4318AE" sha1="48531166EF9E995A396431F1E8A86D1688527C89">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AA4997C1" sha1="D3ABFE1ED9FE84D3AA2F0B42EE41FB12DC6AA3B2">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AA6BB985" sha1="589453380642CBC4FDD88AEF2F1AFF0F26728A70">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AA74A4D8" sha1="D4E928142290DA7ABAED485051946E69AAB95A24">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AA9F9765" sha1="4F251D6E50D59DAF1ADCF9ADDE1DA83AB42F0FA3">
            <board type="KONAMI-VRC-2" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A1"/>
                    <pin number="4" function="PRG A0"/>
                    <pin number="21" function="CHR A10"/>
                    <pin number="22" function="CHR A16"/>
                    <pin number="23" function="CHR A11"/>
                    <pin number="24" function="CHR A13"/>
                    <pin number="25" function="CHR A14"/>
                    <pin number="26" function="CHR A12"/>
                    <pin number="27" function="CHR A15"/>
                    <pin number="28" function="NC"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="AAA985D7" sha1="9904A7DA9852C302F0DF9181948F9AE9225FD2AB">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AAC2E75E" sha1="5DFEED691D44AD7FE8AADCD6FBE2914A210032CB">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AAED295C" sha1="E9DDCFC47956FA55623621A2475BF6DF70489426">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AAF49344" sha1="44F2BA467EAE22E1D1133AFF56171A1B9C734D56">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AB2006B4" sha1="E25CE19D998243F6ECCF9998379D4FC65C563B2F">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="AB2006B4" sha1="E25CE19D998243F6ECCF9998379D4FC65C563B2F">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AB41445E" sha1="9E6345F7B49A53E4D78C9AA9641A81215A10481A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AB47A50E" sha1="465A71D1AB20207F98A8F85E49B644E93BD49733">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="AB671224" sha1="718FDB5225D4197CCFDF529CEE7188719218F6F4">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ABAA6F78" sha1="644B0B587B1DA22989EFC5E4FC1B62222A9CCE05">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="ABB2F974" sha1="C073CD6389E373CBB3433F81196ECE4D09C33BEF">
            <board mapper="39">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ABBF7217" sha1="F987C9C26EFA260DA38D38E2130DF7547BB7C557">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <arcade system="VS-Unisystem" dump="unknown" crc="ABE1A0C2" sha1="41DFF720139CED20A7D1F240D687D7F84FF4FD2E">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="ABE8E174" sha1="061C2DC8AAD44C2BA98E8D50A6AD634C013C57F2">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AC05EBB7" sha1="0CB06F97B032B3BCD1CDEAC06C7C767D421C47CD">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AC136F2D" sha1="5786C19ECB90F9C47A6C9A364B46B4E15BD57CFC">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="AC3E5677" sha1="4DD8200EFE2933481A173FD5C80AF31256F6E25B">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="excitingboxing"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="AC4BF9DC" sha1="00FCC73DEEE69E35C551D638EA106F0A5487825B">
            <board mapper="75">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="AC4F4E9F" sha1="CE87D812B408F5EF321F16B8BD8EC772B909FA04">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="AC609320" sha1="5595B7F939E179CFDBD26AE12C43C56A7B846000">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="AC652B47" sha1="2E8A1B6EF95C0C3ECC370A0EEB1AFD7497C986DE">
            <board type="KONAMI-VRC-3" mapper="73">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AC8DCDEA" sha1="DF3B2EC1EE818DA7C57672A82E76D9591C9D9DC1">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AC92E9E0" sha1="2F79A27F2157A0C5D3F1F5D1E7EA04A4331E0FCF">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AC97AA09" sha1="5160D9D2DAFA8BD055E3413B36981412534B3223">
            <board mapper="172">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AC9895CC" sha1="BB1967B0947989FFD9FCF6B10B81AE036110491A">
            <board type="KONAMI-VRC-2" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A1"/>
                    <pin number="4" function="PRG A0"/>
                    <pin number="21" function="CHR A10"/>
                    <pin number="22" function="CHR A16"/>
                    <pin number="23" function="CHR A11"/>
                    <pin number="24" function="CHR A13"/>
                    <pin number="25" function="CHR A14"/>
                    <pin number="26" function="CHR A12"/>
                    <pin number="27" function="CHR A15"/>
                    <pin number="28" function="NC"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="ACA145D8" sha1="5D5CACC3083DE2C2F211F82665CA30ADABA4262C">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="ACA15643" sha1="37267833C984F176DB4B0BC9D45DABA0FFF45304">
            <board type="NES-ETROM" mapper="5">
                <prg size="512k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familykeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="ACB8FE86" sha1="FD5E44AEF185200B56279D726090395CA0A4F7C5">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <wram size="2k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ACD4E5BE" sha1="3DAC6131EBF394A9EB24C4C2089D8CE2FB25C194">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ACE56F39" sha1="BA630648DCD774311273C6520119D18CE0A0AA61">
            <board mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL-B" dump="ok" crc="AD0394F0" sha1="808C851342D6662A60FCC705D883EFBDB6D4CD26">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AD12A34F" sha1="B116BBAA57C1D3FCDCE0CDE22290FA92C7D8418E">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AD66557F" sha1="7C8F2EF76159D396FCCC4EE3A93D1899B2B748B0">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AD730AF3" sha1="92CC033C1255F119B3A566EDCA10140C014FA479">
            <board mapper="198">
                <prg size="640k"/>
                <vram size="8k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="bandaihypershot"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="AD9C63E2" sha1="A906B9E67F0FFCFABB36C9B7140BC2CBA9E1F5A3">
            <board mapper="70">
                <prg size="64k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ADA1B12F" sha1="A039646E5DCD991DF0C40E440BFB2F647E76984F">
            <board mapper="148">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ADB09FF2" sha1="DD9A5853C6415A164C86F64987F6E9C5BA5F1E99">
            <board mapper="187">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="ADB5D0B3" sha1="FB9B7989B802C3D2748870775256DA0A5E4ABF44">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ADB810F8" sha1="FF93357A36F2B946E02F1A826A04C4F8C73EDF1B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="ADF606F6" sha1="6BBA730E2D3B30DECAA4D89EE4DC27EEDCE08F9A">
            <board type="TAITO-TC0190FMC" mapper="33">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ADFAD6B6" sha1="5AB1D9CD55978AF770A87749BD375741A63CB3D8">
            <board mapper="188">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="ADFFD64F" sha1="D8E653E5DDB20843B4220A4EBB8C9EAF7A72EA00">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AE128FAC" sha1="29F5B12F89AA6150FB34CBA0D5F6505F8F611582">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AE280E20" sha1="0A808A7EB907D1690927AD3468679CDD7A9158AD">
            <board mapper="4">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="AE321339" sha1="C851AFAE1BEA9BD0728E228A4D505A41786837A5">
            <board type="NAMCOT-3416" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AE52DECE" sha1="E95319304A88D63F832782F4CEC70518568E0672">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="AE5C3D94" sha1="956371512B5827526399E09186D14EB1BC6DF22B">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AE64CA77" sha1="40262A15EE764F676E752C90626A2F61DA370A1A">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AE854CEF" sha1="C1516B75575DB09C8820C00747C8A1F7291A84E0">
            <board mapper="74">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="2k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AE8666B4" sha1="D77B46806992AE91681791747EC812938A6A185E">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="AE97627C" sha1="00293FE817FCF7C242C08D27BE2A8F0A157EDF28">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AE9F33D0" sha1="AF71701A85A22CFC330A60000E62CA188ECE73E3">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="AEB2D754" sha1="6E4D4B34A4FFFDD569AF64ED622CA1E0DB6B57A4">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AEB7FCE9" sha1="844F12CDAEF0A3E62D24BB23277EB5B63805E2C8">
            <board mapper="33">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="AEBD6549" sha1="D67AB33824DF6873C5DE174C522959CABA799089">
            <board type="TAITO-TC0190FMC+PAL16R4" mapper="48">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AF05F37E" sha1="8A20080A4F8EF1268C1555913510733055031C5E">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="AF4010EA" sha1="07F71F67DCA8D96D63E5CF4E1B90510DE3FEE67F">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="AF4A01FF" sha1="CFF3A8ACCE7BA480675C72852531C1ABFC0B5C3A">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AF5676DE" sha1="D456FBFFDF41BBBA327D16CD1D776A6BDEDDB586">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="AF65AA84" sha1="9D0CDADB035F8CA61F4555B30AE0B8551A4188D6">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AFB46DD6" sha1="0D3594D714F6FEFD7DBC35E063B298701C3CC384">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="AFDCBD24" sha1="1168BCADC228F43B7FD9C66187D5F309131DD847">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="B037246D" sha1="C010A2F0D1D836CCA039E4C64412AFEFCBE7F763">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="B0480AE9" sha1="FFF7075DB4ED32FD75ECB7BC714FEF244940E182">
            <board type="NES-ELROM" mapper="5">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B049A8C4" sha1="D08C0D7D333D338FD5CA1994CEA81C5A9EED65E5">
            <board type="BANDAI-LZ93D50+24C02" mapper="16">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B04BA659" sha1="127C038C25AEC70CA1822C92AF6E45169BA3310B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="B066111A" sha1="AA177408E11B4DA57129DF21A58AF20C650F16F6">
            <board mapper="0">
                <prg size="32k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B06C0674" sha1="F7D1E21BFC9ABD9FCF517AA8D4DB7B51105EA117">
            <board type="KONAMI-VRC-1" mapper="75">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="B0BC46D1" sha1="318DA5731C33FC3C5A02EA8E405F8FD20F4148A1">
            <board type="NES-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B0CD000F" sha1="173D301EF2D7076C53011601E2848AB35DE9A9CB">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B0D6590F" sha1="55C73D7300DC935F99DDE99C4F1853F8BE696888">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B0EBF3DB" sha1="F8FAA774708E108984158FCD9BBC5482ED7165C4">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B1250D0C" sha1="C7361A39716DCD0364D0AD518D5D5EBD4BA56F87">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B134D713" sha1="FEB83967ED5418547D5A56DEA30A270684A6DF6C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="B13F00D4" sha1="999ACA2DFDBDCC164DDAB12282290247F4CE21E1">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B14E668E" sha1="E6EFC9A26392E15DD2017EA2068B2391EA54032F">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B14EA4D2" sha1="194868F5762204A50F2F0B699F81121C2CB5CE43">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B15653BD" sha1="C7AC4B1E6244B82FF964BE95FEF0E98746FF65FF">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B1612FE6" sha1="089F74F605C6267AB866C1474E0BA69D6E85839C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B166DAC9" sha1="55950F8468FADEFB6F0A6561B62FA61637D824BC">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B1723338" sha1="D0BF8684CE58EF5DAED904ACDA8A975C4447DA87">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B174B680" sha1="FCD1984D4CB3E0AB4D626ED2561C8E6D57198B76">
            <board type="NAMCOT-3301" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B17574F3" sha1="50E76171AA106895C745E7A4F8D9852DB72AAD12">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <arcade system="VS-Unisystem" dump="unknown" crc="B194CA80" sha1="21674A6571F0D4C812B9C30092C0C5ABED0C92E1">
            <board mapper="99">
                <prg size="48k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B19A55DD" sha1="830DED7847F0C53A7872BC8685517F2B081B3354">
            <board type="TENGEN-800032" mapper="64">
                <prg size="64k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B1A94B82" sha1="146B88A05126E40463C6B59FEA563F00688824BD">
            <board type="BANDAI-74*161/161/32" mapper="152">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B1A954C2" sha1="B2140792E8E6FBBA76AC31FBEA056A134A479858">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B1B16B8A" sha1="BB40175966F18EFAD8D82BEBEA3D4D8444A133E6">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="B1C4C508" sha1="E0F7BDBD2C96B14D4B8D2146A900AAAD17F9E3B1">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="B1C937C8" sha1="1E4F17174A70C408012FE32EF36E2F3E928702E0">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B20C1030" sha1="1BF9A2D3DB587F309D0E9D0A76FC9CA92530BBD4">
            <board mapper="93">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B20F87DE" sha1="86709E046E9292E586CAF06EA88B7F55E5409DAE">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B23508FF" sha1="0281C009D368A01702E42CE2C55B1590695C14D1">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familykeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="B2530AFC" sha1="E232C621BFEDBFC6B100677BFBFC50B910248282">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <wram size="4k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B27414ED" sha1="AEDECE9FBE7F399591816B6C642C6FB4779A8D40">
            <board mapper="233">
                <prg size="1024k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="B2781C19" sha1="FEDC255AAF15D7A9AA20E3142A30E1C9434B04D7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B27B8CF4" sha1="BE9DD65BE8DB897978DD34533DD3A037784A8EE9">
            <board type="KONAMI-VRC-2" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A1"/>
                    <pin number="4" function="PRG A0"/>
                    <pin number="21" function="CHR A10"/>
                    <pin number="22" function="CHR A16"/>
                    <pin number="23" function="CHR A11"/>
                    <pin number="24" function="CHR A13"/>
                    <pin number="25" function="CHR A14"/>
                    <pin number="26" function="CHR A12"/>
                    <pin number="27" function="CHR A15"/>
                    <pin number="28" function="NC"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B297B5E7" sha1="493398472DFF732C8EF99A123B51F70DCD33B291">
            <board type="JALECO-JF-19" mapper="92">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="D7756C"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="B2EF7F4B" sha1="58C55A1F872CAAC21E1D59BADC5F95C31874F740">
            <board type="NES-TKROM" mapper="4">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="B30599A1" sha1="0271D1630F4765151F0961E7FEB2981EA3B40CA6">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B3769A51" sha1="378805A01EBDF5FA426A9D7C62022CECC5FEDF87">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B3783F2A" sha1="B76593A8FBD39447CC5A5D85E525427B9ECEB6F8">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B399BEE4" sha1="F2BD6A2EE873E195722B2571F4954D71E8772F0E">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="3dglasses"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="B39A3F5B" sha1="15D67872A0E9D99FBCD388CB8DCD54226A5108D0">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B39D30B4" sha1="302B37E9D930CD31365AE278694A272544EC0926">
            <board mapper="255">
                <prg size="2048k"/>
                <chr size="1024k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B3BE2F71" sha1="AA4A742631396431074EF66B252D6956DA0E9D35">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <wram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B3C30BEA" sha1="2F7B28D0E6854BFE0825658A4AA5953D06BD0EE0">
            <board type="NAMCOT-3303" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B3D74C0D" sha1="75E3AB6D075DFC20FA88DC8E420A489ACA94BEF6">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="B400172A" sha1="D48DB138130628DD91BF4E02FFFE68DD6A06D380">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="B40457D5" sha1="CD8ABD9B2AF7BA54808CB5DEE6DA8F8276507E41">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B4113F3C" sha1="487904836E6A4EB0D2F46BCA5EC1E634D1A93348">
            <board type="HVC-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B422A67A" sha1="085EE66DB817A06D97670E8A80A0C41CCAD49E96">
            <board type="TENGEN-800032" mapper="64">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B4241FCC" sha1="4F6F7340B707EB50F1BD989157A201FC98A29FED">
            <board type="NES-SFROM" mapper="1">
                <prg size="256k"/>
                <chr size="64k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B4735FAC" sha1="4AC3E9136706AB009EE2F68C7D009422D73EE8E8">
            <board mapper="5">
                <prg size="512k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B47569E2" sha1="07AB48B38F3EAF0EF2CBB708ECAABC1ED891C70E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B477BF41" sha1="9DBC7D63781E733EA39FAA387C5AE11D7AE90D38">
            <board mapper="240">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B4C81ADB" sha1="3EE1DD44458BEA49B916D6D85069E513DA9719D2">
            <board type="NES-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B4CDF95F" sha1="F0211489E4D6ED6AC923F343E89ADAF930CF76C8">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B4E4879E" sha1="CA03C76B65F0FE5B1D05149D7E9A97B4D5F44A27">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B4FF91E7" sha1="2BA415420302708466C78FB1826D03BD0EF43BAC">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B5576820" sha1="AF74AE8FFBDEF1D10323EF3D18EBB421A4F4CB21">
            <board type="HVC-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B5D10D5C" sha1="4BE98A8264DE50AA3853010F04615B492CC1C16B">
            <board type="NES-AOROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B5D28EA2" sha1="2AB7CBFF5AAABC0122170286D64B8ADE1052B98F">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B5E24324" sha1="3CAF40E96BA3D8DD0E6986EBD05C7B6687BEFF7B">
            <board mapper="4">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B5E38091" sha1="7A2CD9F9306955B74ABCAE7F43916B105FBF3A02">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B5E392E2" sha1="5DA05FDF6AC67B1DFEE20E8DEF46AFF2A88F1578">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B5F7E661" sha1="58D85F49AA54B33BA211FE21D12AD75FEF3A9754">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B5FF71AB" sha1="442E581079AFB3A36FB110C5199F56BD2B5E496A">
            <board mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B616885C" sha1="DBD7DBAF79D2A77A09D9D4CF685CBD93281ED468">
            <board mapper="195">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B629D555" sha1="C9FE3F6CBED5C38C5989C4FE511A715E9A280398">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="B64078F3" sha1="08625DB56BA9A2A66E636590C51044C6726C5B26">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B6661BDA" sha1="C260D62429F2AE3A49C1F969F664D17F44319165">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B668C7FC" sha1="3DCB69A8C861C041AEB56C04E39ADF6D332EDA3A">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="B67D16F6" sha1="B2AC0CB323679B79A2DD07D296AE77512BF198B8">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="B683A856" sha1="48D87B70D1703095B629BDBD5BAF98632CCAD082">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="B68F9814" sha1="A3D9950DBCA728D9EAB6C3B288E3F2C79F4C5701">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B6A2B981" sha1="6126F91D6C34CC35D93F190EFA641D3960026456">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="B6A727FA" sha1="D4DA5CE961C325E0AE6A2BEF7929A4049F2003A7">
            <board mapper="79">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="B6B5C372" sha1="60065354F49A9880407E871AD8D9EB6784004CFE">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B6BF5137" sha1="DF3AD62F4503170770FE36FB2BA8840E120F0896">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B6D2D300" sha1="F92161296E7CBA0B9A573D00EABF8581914BCA56">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B70129F4" sha1="5BD2FB8D783090D50357A3941C3B3433B3EB2B36">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B7594365" sha1="0D16DE52ADD9EFEC448F4BB7DDB98AA104CE3744">
            <board mapper="45">
                <prg size="512k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B7773A07" sha1="0571F4972D470213440578A48D5EB84673DF7BD0">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B780521C" sha1="951A19474A1D9C2984F3D966FBC41C0F0360105E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B786AB95" sha1="FAECF3C6C169F8839BF3726C4E996D6298BEE2E8">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B786C2AC" sha1="C614BB7055A6DC7F09D1214C92BD61CD68AF15A7">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="B79C320D" sha1="DF8E74A0F5AF5F30710840A7D983EB3CA34F4389">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B79F5883" sha1="C85C0CF0206018AE9A6B789D7BAC06DC37EB2368">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="B7C37203" sha1="9E11D7BA0E3268B62EBB5B2865AF7E110DF9E836">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
                <wram size="8k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B7F28915" sha1="EB29844FDBC7BDCEBAE9FD2DB46DCC9DFFB7BEE5">
            <board mapper="159">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="B7F39933" sha1="EC6BA3A7D118783DF5AE9F1D0323B38A3348F333">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="B80192B7" sha1="A18E5D125AC4B057B3EC3EF3F0267577EF05F910">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B807446E" sha1="73A4FDF7CAB3D3205ACD328B66660DCC4DAE7B87">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="B811C054" sha1="17C48004AAE3CF2F444D0B798C2726BC288229E3">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B834EB30" sha1="6098F6CB768939BBFC41CE35161C04ADD7BBE639">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B83E8873" sha1="81D72ACD08A6255AE44639D40D6D90C1EFCF61AF">
            <board mapper="60">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B843EB84" sha1="9DC360FA868D61FF1AEAF39A41E43B93157B317E">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B8535CA3" sha1="8A94F5DC85EF1709A804DBCCD66CB4089ECBDBF8">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="B8747ABF" sha1="340F507CFC3F3827EE0B7269814E08D634B807F4">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="32k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="B87AB35A" sha1="BEE7C0C772FA05D1D0FBBF5FEFFA27CD1DDA05A3">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B89888C9" sha1="06990C8573128E5548C5DCD39479FABF67234926">
            <board type="CAMERICA-BF9096" mapper="232">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="B8B9ACA3" sha1="B038D3C653DAA0E3D671E373A3813C971EE8EC85">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="B8B9ACA3" sha1="B038D3C653DAA0E3D671E373A3813C971EE8EC85">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B918580C" sha1="5F86948D6CC9A1225EA142A6C63051A8D5F68DC4">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B95E9E7F" sha1="FA6222E73F910010B9CACF023D575E7E7B94E84A">
            <board type="NES-PNROM" mapper="9">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B976219A" sha1="10C6BA54D7D324F3BE1818F35C786FE16889F0DB">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B9762DA8" sha1="7DCDF7DB93B040D484B190FDFD976BB67AB72DB0">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B979CAD5" sha1="ABBC28A37F328D99F3CF2BF11D8D1633967F5635">
            <board mapper="32">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B9AB06AA" sha1="24FB3EC622FDF6D46F487A71B1AD5C645218928A">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="B9B4D9E0" sha1="80D04447C42A9C1394EEB9B7C6E00647ED58B11F">
            <board type="NES-TLSROM" mapper="118">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B9B7090A" sha1="9E29F4F3C49290210DE2C7479ADC6D61A212378D">
            <board mapper="45">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B9C20634" sha1="34AA2B5011BF236E2E25A26EDE9F494A980132FF">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="B9CF171F" sha1="6662E799365111B151B6D28D3570CD06A2CDE9D4">
            <board type="NES-SLROM" mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="B9FD16E1" sha1="788C372870B649328BFA5756ED7EADC7763D8BF3">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BA322865" sha1="11333ADB723A5975E0ECCA3AEE8F4747AA8D2D26">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="BA327FD9" sha1="3F46FA8DF32CD8B790523B485444A342A84194B9">
            <board type="NES-JSROM" mapper="69">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BA43568A" sha1="C2E2FCC4575754F19B3EBB557004C2FC146E8EC1">
            <board type="TAITO-X1-005" mapper="80">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="X1-005">
                    <pin number="17" function="CHR A17"/>
                    <pin number="31" function="CIRAM A10"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BA51AC6F" sha1="BC6F5A884FD31FE6B4439E83AD6C2A29D038E545">
            <board type="IREM-HOLYDIVER" mapper="78">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BA58ED29" sha1="56FE858D1035DCE4B68520F457A0858BAE7BB16D">
            <board type="HVC-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BA766EC6" sha1="7C6BED2EC057BA526ABD00290A1F935C20BC4770">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BAAAE9E8" sha1="426A818153615C87526C31542898C1EA9C5262C9">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BAC36179" sha1="578FC21E8E87C00A625B28D204ECFDD25919D433">
            <board mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BACA10A9" sha1="A965570E7A28DFF7340B31C3CBC635CCCB724959">
            <board mapper="33">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BAD36C17" sha1="989C2CD495A07D19B6B528F3782CDBFA68313303">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BAEBA201" sha1="CFA21CC3B97794AC5083E1239751852B0B5F0194">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BB435255" sha1="1D7F39341CB0CF7DB0B6B1B18365D583735D7316">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BB473A41" sha1="E6AF7E3B89DDF3EACFE5F3CB985F93262B46BEA4">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="BB63540A" sha1="01B0635D2A8BCFB6AD5B65C460967EE6BAEE89F5">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BB6D7949" sha1="B3228341C41EDD6751AF37FD3DC83B07899A6D55">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BB7F829A" sha1="BC7393653D04F3E3D35E3D0623ACA4A2C27E0AA1">
            <board mapper="5">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="BBA58BE5" sha1="A268031A553F9C61D5D4E023A4FEAC555B50A870">
            <board mapper="70">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="BBB710D9" sha1="4A9396C427A89886C93CE6C794C2EB4EF96E750B">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="BBE40DC4" sha1="D2899308F62272D0547E8D42240BD1D20C61F4E7">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BBED6E6E" sha1="F293929C23A30B0D1B96850F807A85095604A10D">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="BBFE23F4" sha1="2DEB284BAD9DDA37CDCACE0DEA9C689C3D853F29">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="BC06543C" sha1="0B84285DCC9F2DE240C813F4F52E6C0A44746BB8">
            <board type="NTDEC-N715062" mapper="3">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BC11E61A" sha1="11D089B5370F6DF6E9A60E6801AF2F8C91F85BBA">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BC1FBD7B" sha1="A1B6E11D5E7D7C4A3E1B574899BFD13AE9C90D5B">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="BC25A18B" sha1="6043A29002E732BC755BF2CA63784FF470AF4E93">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BC66994F" sha1="39233B4C3CF7C0F049E52B72D7CCAC58241FE1AD">
            <board mapper="62">
                <prg size="2048k"/>
                <chr size="1024k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="BC7364BB" sha1="547B72B4D8D808775C1BC261911A61025C5CDC78">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BC7B1D0F" sha1="56579E6C63B7BAAF50FB506F80FE775D8ACFF068">
            <board type="TAITO-TC0190FMC" mapper="33">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BC7FEDB9" sha1="153BAF5815CE17E6D094D59246844078E6D49C9A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BC80FB52" sha1="74DBA27392CA4451875AD0267E5466F92D835A62">
            <board mapper="5">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="BC9BFFCB" sha1="7C0FDAA6273EEF35EF0C085A892DF8D2D7183288">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BCACBBF4" sha1="A51518866864020C3B22F2E700DB07E26EED76C7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="BCCFEF1C" sha1="34C3DAC57A6532ED4B75F4D8B423BB55A3598876">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BCE77871" sha1="7AE08F6C3358B434D2782D646482FA37BC3FBE21">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BCF68611" sha1="D5C89CD8775808C8A85037BC34328BC457E0E696">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="BD14FCFB" sha1="9C5971922D353F5D726FC9E12EC1ACC2515C7241">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BD154C3E" sha1="F31824D16504B44948DE2CE53FD10C0CFAD3D41C">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="BD154C3E" sha1="F31824D16504B44948DE2CE53FD10C0CFAD3D41C">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BD1A6751" sha1="2B818553690D91E8A893F9756712FA19D5A98A6D">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BD25BDC0" sha1="C33C72C0FFE6D1F00739009E460C500A50404567">
            <board mapper="49">
                <prg size="512k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BD29178A" sha1="721514BE25E33105853BED9D7E318A5390253BCD">
            <board type="AVE-MB-91" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="BD339E75" sha1="380774901336F90C2A136084801B89B7F2256729">
            <board type="NES-UOROM" mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BD50F230" sha1="98D17F80CF72DCD80DBA480B5D6591AE0957AE22">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BD523011" sha1="7FA51058307DB50825C2D3A3A98C0DA554BC3C92">
            <board type="NAMCOT-163" mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="163"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BD9D0E85" sha1="F82654BE44E4B01B3F9627D81232A086B1CF7599">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BDA7925E" sha1="E70F2E52529B3677252342DE9602921F1A921596">
            <board type="TAITO-74*139/74" mapper="87">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BDA8F8E4" sha1="863F9A554B050F9E0325B8F0F018B1A6AC55F079">
            <board type="BANDAI-74*161/161/32" mapper="152">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BDBE3C96" sha1="E79FC613112CC5AB0FC8B1150E182670FB042F4A">
            <board type="UNL-603-5052" mapper="238">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BDC124E5" sha1="E777176ABF8D118EBAB9B7A64AC69FF9F93DCC8A">
            <board mapper="4">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BDC65C91" sha1="1552DDCA459A69ABB9B4FDE78002EB71E51C0730">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BDD73167" sha1="F52955ECC60CFDB34DB1BF12CE26A2C71FF10A58">
            <board mapper="163">
                <prg size="2048k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BDE3AE9B" sha1="5E4119E0771BEC24A46BAD4E874DF05521BB953C">
            <board type="HVC-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BDE7A7B5" sha1="24D4346AAF7DBA8881F7F7343FA953ECA6919BE1">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BDE93999" sha1="08202B80A3178D827D1A09238066E531345CDB12">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BDF046EF" sha1="6FC96949C5283911969F6F873B8ED52752AADABA">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BE06853F" sha1="B2089533E05FE95814D0D77F2729944CBEB95988">
            <board mapper="157">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="BE0E93C3" sha1="2E92FBE8B7C3ABC901057B8D8E6A5E882D7D4E10">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BE17E27B" sha1="B89D7FDEDD0AD1A8530AE9ECCF6B71C15D40725C">
            <board mapper="150">
                <prg size="64k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BE250388" sha1="4FFB1D8171589ED8ED66FECC6CEBB4501AF221B9">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BE2E1A20" sha1="7B3C828D8A9C434B3347EF62740603A84F897F97">
            <board mapper="57">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BE387AF0" sha1="73415E45E7E59A0E1237AA0E8512175C54DA2D89">
            <board type="NES-CNROM" mapper="3">
                <prg size="16k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BE3BF3B3" sha1="28D346FCD44CD94ABBC02A93FA65B4DF0D4216C8">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="BE898565" sha1="C01758105814D6B4B3087B64733E4F84ECF83AD6">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BE8A744D" sha1="F38AA059706E16F75F6A6B48D12768C576B10F5B">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BEB15855" sha1="D3A3E1FF0C4286A5E32E996B1A6D4248FCB9EC90">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BEB30478" sha1="CC78791139CB5A7241A4458E0BD219D6B84814F8">
            <board type="JALECO-JF-01" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="BEB8AB01" sha1="F3250A728E7A1C21E011F187B90EE553C2D7FA7C">
            <board type="NES-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL-B" dump="ok" crc="BEB8AB01" sha1="F3250A728E7A1C21E011F187B90EE553C2D7FA7C">
            <board type="NES-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="BED47813" sha1="CC69423D5B686304C3361E5A22B8988B196DF764">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BEE1C0D9" sha1="B0BFCC07619DEFD0530696731DCA37A088049270">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BEE54426" sha1="6D4F5B77981DFE702A27F87125969E563FAD44F0">
            <board type="AVE-MB-91" mapper="79">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BF09DA6F" sha1="7E46FBE4713E9391293521CF2B852C80DBEBCD7F">
            <board mapper="60">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BF250AF2" sha1="CE53F6B645874BD567F6F30D34034B8DD123D549">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BF3635CF" sha1="F8B38262C2AC00CF4E3E653F2987BDADC86F839E">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="BF4F4BA6" sha1="70822765F881D5F382F33B2441D32274D0C66F48">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="BF700470" sha1="A04F1DE29C02A602DD27E6F17EBB1991C5806C6A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BF7F54B4" sha1="2C0DADB3E0BBD9ACCFE681366A0EA8298ECED161">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="BF888B75" sha1="EAE5205928D3FA2AFEA0374B457D2BB91E414D99">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BF93112A" sha1="4B16892605A318C91A54E813A9680DF7CA106BE6">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="BFBFD25D" sha1="F77EB86932844A92834EF12C059A3F5B815DAC07">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BFC7A2E9" sha1="4EBC1ED9665C36913D0F05129E6A54787BAD3165">
            <board mapper="153">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="BFDE180C" sha1="297A10BDDD9A00A3B808B0EBD280A1E1A54E9A57">
            <board mapper="116">
                <prg size="128k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C0103592" sha1="5F95803CBD4392439FF7046D87830C8A66BA3EE1">
            <board type="NES-SLROM" mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C0303AA3" sha1="04A483B692F834757A60E17A3F3CDEB44ED244CA">
            <board mapper="242">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C05A365B" sha1="E896EF099042628C025DC3AB15735F3EC15B090B">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="C05A63B2" sha1="6A2D8D365B794624192424BD9DB8378CD3202734">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C060ED0A" sha1="0D723C21E6D4A3F4B5B12054F0A2DC3D8D746B01">
            <board mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C06FACFC" sha1="757560B286CB1064CD105ACCA55E5C2287ADC673">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C076D66F" sha1="017A692EF7D140565CC0827629BB16FA82E6FD7C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C0B23520" sha1="38444A3B1291B805E1B6D7798687A020A2989D61">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C0EDEDD0" sha1="72AEF6054BF5E8B3301FEA396187C71454C2465D">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="C0F251EA" sha1="B39BDA18F397132D63A37B6F7AC86EE82F96EC6B">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C0FB91AC" sha1="E5A58729DE15B26BB6C8A80488493EE770E8EB91">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C1719664" sha1="FFAFED6469C560790D1C158EBC980666A12477F9">
            <board mapper="155">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C1B43207" sha1="238A5A46DB79AC6E5252DC902F5BBDA669FA4DD7">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="partytap"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="C1BA8BB9" sha1="390443F9B8A69FEE3CFF5F234A3E92AAE8B48102">
            <board mapper="4">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C1C3636B" sha1="1B34BDC4AD9FCF68A91FB589B1BC6C3888261BD0">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C1D3082B" sha1="FE2E71636DC92A92C2BA7F7ABD501505B933346A">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C1D7AB1D" sha1="E8FF6B1C3A15464F792A114F16967A5DC38B9A4D">
            <board type="NAMCOT-3302" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="C1E91D3F" sha1="673F901A9EC447EA5442E693ABAC152D7E16578A">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C1FBF659" sha1="40A9324E9D5FFCF8618C9D95E22424A8EFE60C6E">
            <board type="KONAMI-VRC-4" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A3"/>
                    <pin number="4" function="PRG A2"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="C20E9CA7" sha1="D232F7BE509E3B745D9E9803DA945C3FABA37A70">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C22BC87B" sha1="6D528E12F8EC36C747C0E18311B812D83972DBB2">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C22C23AB" sha1="4CEA0ECDF0A22E678B827C9BFD8D80B5DEBB4094">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C22FF1D8" sha1="E666281A4E9930852F98194D93DECA4FF3F18755">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C247A23D" sha1="C3615A7DBF65D6B6AF607D5ACD9919AF48AF0DD3">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C247CC80" sha1="1C476C795CFC17E987C22FFD6F09BAF1396ED2C9">
            <board type="NAMCOT-163" mapper="19">
                <prg size="512k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="163"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C2730C30" sha1="764C9A41DB58D9A0F8DD56499CF1EA84C10ADDF8">
            <board type="NES-BNROM" mapper="34">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C27DA417" sha1="18E26B352DFCE579803EF41380DBF1B47A0DF131">
            <board mapper="222">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C2840372" sha1="50A8591A80C025E3B64261BB13B03520711C5254">
            <board type="BANDAI-LZ93D50+24C02" mapper="16">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C2A4612E" sha1="AB8342DF2C3AA946F2B54A5DF4A58EC2DFB8DC9E">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C2CFD9D9" sha1="B38D0EB978FFD1FA977A249D2E15AAD279D00171">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="C2EF3422" sha1="CE103FE6971E2F97B82F13B8011C592039F46265">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C30848D3" sha1="2BBADFBF3BA95DE8B4415FDE9CCE07AA0053092F">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C30C9EC9" sha1="FF7FAFF87BEEF1451C6C495B94AEE280EEE5D21F">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C313EF54" sha1="4912EBB244888B9680BD2A044CB157BD67475818">
            <board type="KONAMI-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="C32E9672" sha1="A8817276C2D287CE853A8CB725F4612C4B23806A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C3463A3D" sha1="3D58821DFB43AB1781E6974CAE212C6BBE4B303B">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C372399B" sha1="49DB2FC8812D10BDBEDAF9EAF99B71FE117AAB0F">
            <board type="NAMCOT-3406" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C37F225C" sha1="413B860B0F4513DF89D60041637632B4CFAC0C31">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="oekakidstablet"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="C3C0811D" sha1="32D71DD6C5A8D78A918FE1B9D6D6C4A570D9652D">
            <board mapper="96">
                <prg size="128k"/>
                <vram size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C3C7A568" sha1="8972F3B8324B3BDFA96A6E73ED8B750615DD47F5">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="C3C9D852" sha1="B70611AB96F7B9B001624A5D3E40767ADCDF927B">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C3CCC493" sha1="5A9B96ECD55949DA42B66CE59ADAB46E0CBE1E87">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="C3DE7C69" sha1="E847474C0576D394125245695D7E3A49D66F7956">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="32k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C42E648A" sha1="A8EE603B86CAEDCDB517904895241902C15DFC6A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C471E42D" sha1="2447D6133573F7ED2CC49DC95B3130427BD4DC35">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C47EFC0E" sha1="FD1696FD470998E09D37C48600D87B36D4C04738">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C48363B4" sha1="0C925717118087C7295503B7330FBCF0C70CB177">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C48DDB52" sha1="B61BDCC1E16016B7E4FCFE0A6ECF46EB72652A1B">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C4A02712" sha1="CCB306A328E6905D72A2E11C9F86A303D51D5A04">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C4B6ED3C" sha1="E39CA4477D3B96E1CE3A1C61D8055187EA5F1784">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C4BC85A2" sha1="351EDB1FDF4BCE3BFC56D1EECCCFDC6A21BB14F4">
            <board type="KONAMI-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C4C3949A" sha1="BF43D93D36D7198E65B9B7C4E41DB108FE43FCBA">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="C4C3949A" sha1="BF43D93D36D7198E65B9B7C4E41DB108FE43FCBA">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="C4C3949A" sha1="BF43D93D36D7198E65B9B7C4E41DB108FE43FCBA">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C4E1886F" sha1="6C2458AF83ECD6C19416E9477548D1881932E142">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="C4E81924" sha1="39333A8F71CB98A4283E2779D087C02E4E2EE400">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C4FEE54C" sha1="79EF0E55348C2011C036EC8AB4F570DA5E0052FE">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C527C297" sha1="6E14D69218F890D5B4806E19C599329F1B5079A1">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="C528ED56" sha1="70E6CB9E37D27DFB65E49B69D542A60617D19632">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C53CF1D0" sha1="A16F303BAA02EAAED3215FD4123BA09D32481774">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C5657C12" sha1="B30062EBE5A4870467B5D30A3AC5E53D682A0813">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C58EEA57" sha1="C90E8761CB4226852B9FEF204148DDBB6C48C792">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C5B0B1AB" sha1="3D6AC8691573FB5E21F8AE2D5AF06AC26C0B3DB9">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C5CFE54E" sha1="87D816CCBFCEEE1CD0261EE06E3F16A2286F39F7">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C5E5C5B2" sha1="9C8BB9BEB164CC6275284914537CB2B07D4F4108">
            <board mapper="115">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C5FB1766" sha1="6C21CB062664B6BE1F9E23B26AAA5516B83AC646">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C6000085" sha1="A596137B2300A326DD730EFC7ACD46A8C69F1BFE">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C6182024" sha1="8C98F1008EBA860F6E1CE396F4C8F93899762FCB">
            <board type="NES-SOROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C6224026" sha1="2D47CB78C94F4A69E73EC32B5AD52FB9E62217A3">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C6557E02" sha1="6F4905C30E58C58286F34117295F3091501EB2FF">
            <board type="NAMCOT-3406" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C67865A2" sha1="928A82D58C203BDF5D05150D891A236E3E3293E7">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="crazyclimber"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="C68363F6" sha1="003B7F1315F5EE0DC60C5F9D989EC8BAB0811ED4">
            <board mapper="180">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C6ADD8C5" sha1="196D7B083C0A93088D88472BB799069D47D40088">
            <board type="NAMCOT-3407" mapper="206">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C6B5D7E0" sha1="65B6D12F3009C83110C2AEB18F3E3F439AA9DFA8">
            <board mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="C6C2EDB5" sha1="BFE87FACFA2222D9E4984B8A893E033BD5796A8E">
            <board type="NES-SCROM" mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C6DD7E69" sha1="974BA6A6C95551FF5B5F8842D876BA02A827A778">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C6E1FF1D" sha1="67D0511BB6F21B63433474B225148B7EA122DD3A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C7197FB1" sha1="AD0F560CA3B41D8EF467A007E879D84DD0CCC045">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C73B82FC" sha1="BC89D81FBDEB044217582B8223585740E4CFE1EF">
            <board type="AGCI-47516" mapper="11">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C740EB46" sha1="989C15904EB8F9F6E77AE59300A76FFA935ABF43">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C7642467" sha1="FE1C4A88BC11977B10FC8E246E255E729D8A6AC6">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C769BB34" sha1="387A1C547CD2A671D6368F3757E3B539FDB23C00">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C76AADF4" sha1="FD573128FA399947A1EF6B31EEDE81C8043F33B5">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="C7EDBC2E" sha1="E4414C160C7E91136C62D99154336035E5636EEB">
            <board mapper="13">
                <prg size="32k"/>
                <vram size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C7F0C457" sha1="6F1112340AF9899BAE7CCEABCF65C5E3492F6577">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C811DC7A" sha1="F181DA5FFC76442A92662869C495E6CE2E34970D">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="C8228B54" sha1="6429FF0427AC2D614D553A356D48B66D06D1BDDF">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C8AD4F32" sha1="1EE3DBBB6673FE1E22A432AB086FC317D6B1713E">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C8EBD977" sha1="ABF3771857DB5AEC4E85AB254D54D5C3B7B24785">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C8EDC97E" sha1="260D54B2605075945767E1ADEE382C81CE9C4513">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="C8F203F9" sha1="533941E81D74CBD5F2A38B6A1A37156AEA74E765">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="C9187B43" sha1="055590BD669F7218B9BA737127AC45CF54C7F297">
            <board type="HVC-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C92B814B" sha1="A52A23560281455F8CBE6AE563153F7925CAEF7B">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C9484BB3" sha1="474B0728B0EB3D48ED3EF0C650F35230D526352D">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="C95321A8" sha1="1CF6AA8625AD1558E1F1AAF2E1710D5A09A2CED0">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C9556B36" sha1="215D399EE058D3BE160916ED7596BCAA12F9ADEA">
            <board mapper="1">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="32k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="C973699D" sha1="CEE869B39C4154723FEF6184053DD37A9211BC23">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="C9745875" sha1="2ACF2600DCB03E7BE9E29D75AA80D49CA7CC1940">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="C99B690A" sha1="94B8C2AF8A57300229CA948E6BA379F01A9275D7">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C9EDF585" sha1="B21EAC9CAF40298D5B33112AC019730E5F847A5A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C9EE15A7" sha1="8F4EBDE3E2439FBD33AEE788A318AAD6712F883E">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="C9F92BD9" sha1="6060EB360B9B4AE7ACA024C00ACE5B472371D721">
            <board mapper="226">
                <prg size="1024k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CA033B3A" sha1="EE797CF17EEF524117DC1EF3D6DDCE0C193ACFD1">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CA094848" sha1="FDF73D5B654BAD2D2FBA0F23E000E82AE5EFFBBD">
            <board mapper="32">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CA0A869E" sha1="3E814B7307730E30EC6067CB4487F2A826A3F7D6">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CA24A1A2" sha1="1693D06C9142DE5230ACF766F62FEBFF144A7370">
            <board mapper="67">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CA3CBFAC" sha1="B9FA78F1540A3BD6979ED55A5D481B4EDC9ECEB9">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="CA3E9B1A" sha1="1A4EC64E576BAD64DAF320AEED0BE1B8B50D21DF">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="CA503F32" sha1="070EC181FA7B21B25A99B841A5DC1A76ED3F8392">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CA594ACE" sha1="FF5BCACF7417B4DE1C49F9E54C2905D91391455B">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CA5EDBFC" sha1="E5EBF529CBDF70E5B9502F16CC0D7D69B2E26340">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CA69751B" sha1="08AAA87EDD792233E5B0D39AFC2C2CCFFDF839BD">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CA6A7BF1" sha1="C8BEB2DC507F868BB6BFF73B57321DBDC8D6F227">
            <board type="NAMCOT-3417" mapper="206">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CA730971" sha1="D48B10D9EE30B6891979985448B047B314A032AE">
            <board mapper="4">
                <prg size="512k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CA96AD0E" sha1="FD240D2B71F7F1BB723867C02827544CA89F0863">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CAB40A6C" sha1="B7A6D5782D0266A7E2F1C1C1C159A41FB122BD08">
            <board mapper="150">
                <prg size="32k"/>
                <chr size="16k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CB0A3AF4" sha1="7208EF3E502F895B604824F625992F1C78FBBBE8">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CB0A76B1" sha1="FF166FCAD80C61A17641A7C029DD2EB3D99495FD">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CB32E243" sha1="C002BE9213E53221C247B38BA27F4CF6C9D15796">
            <board type="HVC-TNROM" mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CB4D23A6" sha1="3CD767F70C533A8698612CF017A5DB3F52427CD4">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CB53C523" sha1="F5C62A5AC771C42D0F64A46D4A70D283EEEF58EB">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CB5ACB49" sha1="87E64F31A7F12F70F978D8FAE853B44F31B1F213">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="CB8F9AB7" sha1="0A3F0E133ED5B2B2497B5E05B956F244EFDBDEB5">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CBAD8B09" sha1="BCBE8991C333A2D4B33BAF7928FE6B9A1B454C6E">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="CBBEFD1F" sha1="77959F436F2A0D18249A44133FC4068B61029283">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CBF4366F" sha1="7955DBE5EC63F71BA591A9237D113AAA90849263">
            <board type="TENGEN-800037" mapper="158">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CBFB6DE5" sha1="2A0B875B954F2C494EB069EA14856785C25EE945">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CC3544B0" sha1="1A973BC6F601ADD532FF122AABB342C66013A72D">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CC37094C" sha1="CD7DFA05D4CBEA62BCA89C19F67DF9D0202B7101">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CC7A4DCA" sha1="02F29D89B919EFF7E401B1A13DE905F2B251D1B6">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CC868D4E" sha1="064802F6B3AB5433D441829C93DCD68C0D70F342">
            <board mapper="149">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CC8A8652" sha1="DFD5ADCCBCF6B1F6C4EBBC42F253746D75BF9CA6">
            <board mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CCAF543A" sha1="5A587CA6EB8F3B2D1CE4716B1FDBB7D46B7B2F62">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CCC03440" sha1="D4702A831A398107D8F87BC93BD56C4D8CA78F2A">
            <board mapper="156">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CCCAF368" sha1="29599EA4A52B88C06B80AA0BAB987E6EB329E707">
            <board type="CAMERICA-BF9096" mapper="232">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CCDCBFC6" sha1="00DFB78AC0E10F46BEDE9850636E2F3C6A305858">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="CCDCBFC6" sha1="00DFB78AC0E10F46BEDE9850636E2F3C6A305858">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="CD00249B" sha1="B856BEA832644F5B3942E3555AA51505AC7345BF">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CD10DCE2" sha1="EBA237B45A775D4ACB2DD7CDF2B8CD3489D571D3">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CD373BAA" sha1="D94B55C600975751A0BF8333029AECD076DE3E3A">
            <board mapper="14">
                <prg size="256k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CD50A092" sha1="97C351AA8201661C11CE32204F18DD4A6A1D5C28">
            <board type="TENGEN-800004" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <vram size="2k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="CD6549EA" sha1="26C25BD3518C317657ACA2F88F8C79830281249A">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CD7A2FD7" sha1="CC781A17F800614B9D5E5C1661FDCD32CEA7A7B8">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CDB8C6A5" sha1="529EAE7EEDDAF781BBF803B7DE65EB1C7514B16C">
            <board mapper="83">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CDC641FC" sha1="3F461C8A3056DFB168E3CD6067A36605F3B1FAE8">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CE00022D" sha1="8DFCACBD919F821D1FDC035184C278DF77827B09">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CE06F2D4" sha1="B67A9787BA2C9F9C8F1B4AE202429948D1E70032">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CE07194F" sha1="D8F1F3DF4B5A0C66D76A8ED6BC4F1BBC99F6E440">
            <board type="BANDAI-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="CE1A8CC7" sha1="C517A9ED1F163232D459C600596865125AA3E461">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CE228874" sha1="EECC4BCC7697BFFA04C6425D2399E7F451175AD6">
            <board type="NES-TEROM" mapper="4">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CE5ACB82" sha1="BD19E9068D40B78991F124F8F79670D08505FC67">
            <board mapper="57">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CE77B4BE" sha1="AD59864A6ED64F4B4DB36D2EE7D4C70C5A409C5A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CE94F92F" sha1="A6846F59E0A0BD90AB2FB2968CDA6D080239CFDB">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CEA35D5A" sha1="7B35D53714BB09962F7F5D7371F1EDFBA9250CF4">
            <board type="TAITO-X1-005" mapper="80">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="X1-005" battery="1">
                    <pin number="17" function="CHR A17"/>
                    <pin number="31" function="CIRAM A10"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CEB65B06" sha1="A14563325B0F33C358142E7363D31614722FDDB1">
            <board type="NES-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CEBD2A31" sha1="C9CFBF5455085E198DCE039298B083CD6FC88BCE">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CEC28502" sha1="6A1CB30D0EC613EBEBC1A1E42016377810DFF084">
            <board mapper="136">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="CEE5857B" sha1="55DF1D724F051B38630E2BD14BC02EDF2650F2BD">
            <board type="HVC-SUROM" mapper="1">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CF0C9D97" sha1="8885F4F00C0B73C156179BCEABA5381487DBEAAD">
            <board type="HVC-CNROM" mapper="185">
                <prg size="32k"/>
                <chr size="8k">
                    <pin number="26" function="CE"/>
                    <pin number="27" function="/CE"/>
                </chr>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CF23290F" sha1="F3878B89D8D3FC974D1CD1FA74586ABA1666A993">
            <board type="NAMCOT-163" mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CF26A149" sha1="20B84965ABAD72421F67854FE3C7959BED7E256F">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CF322BB3" sha1="1C474CCDC66D9F39D5AF8EB683090BDD94B8623B">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CF40B1C5" sha1="2F03CECD09059B8AAB0CA9553893C29F8AC1C1F5">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="CF4487A2" sha1="3E3EA36517BCA24892A2A360C470D3251B9920BF">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CF4DBDBE" sha1="F42B719D99DFF23951A912F8483F20E757FE4883">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="CF4E0082" sha1="325157B00D1EF2BEA53BA76929E1F65F866497B9">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CF5F8AF0" sha1="B5F64E766F3FD5C4DEC2673DA83E111782DAF0B1">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CF6D0D7A" sha1="C0FCC0E837E3EC8B075685BB27908037CB57AF2A">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CF701DA4" sha1="15D6A10515847F21504E9FF07CA1FF4960CE12FB">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="CF7CA9BD" sha1="85ABCFFDC088E1A7B9AF2C7EED0A75D72BB26CB4">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="CF849F72" sha1="4746A11F2A8156E1FAED5FE6074257E50AE8071A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="CF9CF7A2" sha1="6DDCD59DC386A2E6A69C32BF0CEB9A9FE3E80BFC">
            <board type="HVC-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="CFAE9DFA" sha1="29FB71F936A6A4FF8BFF8F8EBBAFE986B4A18CD3">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CFB224E6" sha1="54E39253DFA0E7E72CA603C3C744DEE1BA31046D">
            <board mapper="222">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="CFD4A281" sha1="A516F40DCBB75D2200469A1D2939D7497DBD879D">
            <board mapper="155">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="CFD5AC62" sha1="14A8D115EED9421035293191D83E0930A8327BE8">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="CFE02ADA" sha1="3C86F80062A16825B56A8669121A1CB1BEEC1168">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D029F841" sha1="1E4796EE09739C45F7FED2A9BBD1CEB132C4FF7F">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="D04A40E6" sha1="1C3771B7F116F439D684D04DF792570271C93F86">
            <board type="SACHEN-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D054FFB0" sha1="FCB1EF7398B842EBD28C3227852D7A132CE7B887">
            <board type="NES-HKROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC6B" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D074653D" sha1="A7F135CF49F92E0FD9D03B6F48C1BD65CE8BCC77">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D09B74DC" sha1="060FB59A6C4C7F8E4744CE6AE44263238D7AB10E">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D0A9F4E1" sha1="008AAD423DCDECCA9FC6B3BA8362556750E10AF5">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D0CC5EC8" sha1="ADBEAA030EF8713D45CC7CB596FCD1976CB1B780">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="D0DF525E" sha1="45A600EEE433132D97ABB788F65E965A9BA5B5D7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D0DF726E" sha1="9FB4CFD5F8B1EA4239C38E8A43BC3F657CFCCDCA">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D0E53454" sha1="4ABCBFBD83F0260F9D943F358A2FD8D5CFDA6C2E">
            <board type="TAITO-X1-005" mapper="80">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="X1-005" battery="1">
                    <pin number="17" function="CHR A17"/>
                    <pin number="31" function="CIRAM A10"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D0E96F6B" sha1="FECFE247AC67B369F55575BD4F0D9BC24298897A">
            <board type="KONAMI-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D0EB749F" sha1="859D4FDF229533A13DD1C75D6785E1F2D3CB2FA9">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D0F70E36" sha1="B65A7F6E36C2071D64A7ECD04B1E4732968AC410">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D114F544" sha1="8928F7293C12EE7D3FC90BECC68AE5261802EAA6">
            <board mapper="66">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D1397940" sha1="5793A718205861753574DB6F441738E7EB712519">
            <board mapper="97">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D152FB02" sha1="ABE4C47EC657B90699766394F42F157C803A9784">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="D153CAF6" sha1="0708F250DC4093EDD4B715F660E2F67B5777CBCD">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D161888B" sha1="D03873980D19D0620CB0717C3661A3F61CE97295">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D1691028" sha1="CE34B12A46AE8D4432D06F461342F729E8BE35E6">
            <board mapper="154">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D175B0CB" sha1="B17156E87D70C5ECCB3B54B931FE282ACB6FEF8E">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D188963D" sha1="97B4553899C7FD7076F5C93652664B22A7685636">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D18E6BE3" sha1="FBF9CFC78A76F27E537E585BDF08DF389F57E8E9">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D19ADDEB" sha1="C649505DCE1607ED1B5D201003194629C9C3A86C">
            <board type="NES-TQROM" mapper="119">
                <prg size="128k"/>
                <chr size="64k"/>
                <vram size="8k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D19DCB2B" sha1="A416A41C2EC885EEDE6BB1DB4078ABD662847FD5">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D1E50064" sha1="BD442A386741EE63C0DCBBD46B3F53FB60A6D45D">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D1EA84C3" sha1="16682A20548D3BE269F50B954B5A4F3C6E0DC05B">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D1F7DF3A" sha1="F8D8B86A80BA2E1AB6B95E587498CCC08549290D">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D2038FC5" sha1="E36FF62878BD9B32394E73F85D8B81139A660B38">
            <board mapper="32">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D20BB617" sha1="EBE76610430210576BBCEFC9986F079339263EEA">
            <board type="NES-TLSROM" mapper="118">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D2121F97" sha1="B2E1D462538D457C8A7C58EAFDFD0D69A5C28F0F">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="D229FD5C" sha1="ABDB48CE40F0ABB40AB8C1B71B19D6DEFFDB7F08">
            <board type="NES-PNROM" mapper="9">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D2562072" sha1="DA5DD98886A691950C22FD439DA5E2718709150A">
            <board type="ACCLAIM-AOROM" mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D2574720" sha1="C82E29639E2DFFA2754149025C6784EB2587B09D">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D2674B0A" sha1="358E092952DDAFF9703A75264A6732003952500D">
            <board mapper="132">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D2699893" sha1="A6434D116AD692938B73B1EA24F89E3E1336F43E">
            <board type="NAMCOT-3433" mapper="88">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="D26EFD78" sha1="36E695BA6CACC8A5098FB67D9C1F8E6828D6C2C6">
            <board type="NES-MHROM" mapper="66">
                <prg size="64k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D273B409" sha1="7D84A12D6394A4721E40B9934D60545738973D4D">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D27B9D50" sha1="2BE07F59A78DAC7319A024390A676F69A8411FCA">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D29DB3C7" sha1="070D4CE87EB4ABCC9F9D2A97B8010881CB57DEFA">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D2BC86F3" sha1="66D6D30C691B81DF9E3537D605FDC418BAD6EA93">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D2CCBACF" sha1="B47D8624B6387B9F6525F4FA3188B6CFEEF555A2">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D308D52C" sha1="BC526620B6815604E4D955101A58B0B652CB0644">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="D319144F" sha1="48F46D306CD2EFDCEF1B4066D7A5067AD5C57B34">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D31DC910" sha1="EA93F3F2FD561C1CEE59AD51CFCB10F3DD83766F">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D323B806" sha1="3D554F55411AB2DDD1A87E7583E643970DB784F3">
            <board type="NAMCOT-163" mapper="19">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="163"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D343C66A" sha1="31F5C7E3E4219134CD67E15E7C7B1B2CE4A4A2EC">
            <board type="BANDAI-FCG-2" mapper="153">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="D364F816" sha1="F62ACF9818E805E234875D11702DCC9E19D83AA2">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D3A269DC" sha1="FF645F86382012C203B21B42ECB5C34DF6FE191E">
            <board mapper="245">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D3AC6990" sha1="869AA9F1A25DCCBDC6C7B88172DFB043956EA902">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D3BFF72E" sha1="5AFD9664716116B498354B4048D743D98540BF79">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D445F698" sha1="FACEE9C577A5262DBE33AC4930BB0B58C8C037F7">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="D445F698" sha1="FACEE9C577A5262DBE33AC4930BB0B58C8C037F7">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL-A" dump="ok" crc="D445F698" sha1="FACEE9C577A5262DBE33AC4930BB0B58C8C037F7">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D44B412E" sha1="4AF52C8AAEAB49A2E74131F076BEA6D2CEDBA687">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D4611B79" sha1="A4F6CC93BDDFF749B5F078BB31074C86234358E6">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D467C0CC" sha1="E5F893A247FEE3FA24E5D32129AEC53F07304CBB">
            <board type="KONAMI-VRC-4" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A3"/>
                    <pin number="4" function="PRG A2"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D49DCA84" sha1="DF7315C617A1107880273925280CD2472609E508">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D4C7F0C3" sha1="15DEBB2D5A6ED2217B2E464A358A4F10C811D157">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D4D9E21A" sha1="DC851C8DD5F7D6B402D1402C4239400A88382A1F">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="D4D9E21A" sha1="DC851C8DD5F7D6B402D1402C4239400A88382A1F">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D5224FDE" sha1="FC7A8824CFDD37F85868C8D8624D8B517A7C3C02">
            <board mapper="195">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D532E98F" sha1="FA3EA6CFF2DEF85C8386FFF363B2619C90603BA4">
            <board type="HVC-EKROM" mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D534C98E" sha1="1DCA84FC0AA70AA7FBA8384585C4B82D0778BFF4">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D538669C" sha1="AFF6E72DA8B33FEB16F75FEAD549A1105373134A">
            <board mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D568563F" sha1="7C4B3149DB2E5CFF729B17B46B6E9719DF5B8A76">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D5941AA9" sha1="8C964BB1CB0586317191AF1E143AEBE245C42B76">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D5C64257" sha1="24A25F9DC3227687239FCA9E7BBB1F1B7664D6DD">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="D5C71458" sha1="92DF2BE0281E17C452CA0AF448B79BC2960434EF">
            <board mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="D5D6EAC4" sha1="DECD434E653062FEC675992E9EB62FB35F48E6F7">
            <board mapper="241">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D5ED8AC0" sha1="00539E7E0F3962406D5EDB57A9E07AADADAF6AF7">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D630EE8F" sha1="4B1055C6881E770D4C0A537A868879EC1BD67B0E">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D63B30F5" sha1="E4D7FBE95FC5FA25BDCE3F0213D2051B1D013A0C">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D679627A" sha1="BECA615EEB6304720F9430676A935CF8C1F54ED7">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="D67FD6A6" sha1="85DE67A28E01EF680F2FF6AAE80E4315491CEEE9">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="D68A6F33" sha1="34EE4D5913CD3D868A121AEB195DBF7C628AB359">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="D699AE69" sha1="87F156BC568959E7648973DE3AB401A85DC5502A">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D6AD4E9D" sha1="E6DBEAB6B373B44A2FABF778BB394EAC3A636F7A">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D6D2E486" sha1="0FE32DACEC0A5D6911FDC6A90FFB86809F0690E9">
            <board type="KONAMI-VRC-4" mapper="25">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A2"/>
                    <pin number="4" function="PRG A3"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D6DA2A1E" sha1="DF422A483AF41E886A0129A8382CE081734F0223">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D6F7383E" sha1="D3F455A15A5B21EA663A1E48AF352E55818FE89D">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D6FE9826" sha1="E18172B26E96182B83574AA28AC3BB1725A4051F">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D7215873" sha1="5C2376E02696E4170F9BD48855DB483147E7C3D8">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="D72560E1" sha1="19678B033701CF2FF999489ED89C7013BD6E0F52">
            <board mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D738C059" sha1="E2645645C72061DEDD43AEDBD1BF6D1C4EACCFD8">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D73AA04C" sha1="445819CCCAAF2C48D1A2864D3CE53DED33839B08">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D7458274" sha1="547B0E55054EC8EDC2E39E4F786AD30364528FCE">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="D745D7CB" sha1="47548D1BE1470F086DC94D6784AD01C1733D9AAE">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="D74B2719" sha1="EA660ABBC1CDB74E85F932E38013E4FA5B9F6BB8">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D7794AFC" sha1="32473799F96406D73AA37D5CF66E0E27F1F339DA">
            <board type="NES-TKROM" mapper="4">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D78BFB28" sha1="A9A6B03AE4E260D01067352B3E64915DAF2B4786">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D7AA0B6D" sha1="EE7CBA9F41466F71CDC6E285B0A7C24FD6D759F3">
            <board type="NAMCOT-3416" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="D7B35F7D" sha1="D9F4E6DF6BE501E6ED03EE1D8132ACCEC4E883C6">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D7CB398F" sha1="C7D971420D6A2679904F3EB4C0DABC25BCC80C72">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D7E29C03" sha1="9DF034FE5A7E451D8BF896EF9E5111D7F428E32B">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D7F6320C" sha1="010489462CEB0756DFB06D418F26445DDA9C002B">
            <board type="NES-SJROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D7FABAC1" sha1="5633AC906453F33819A79D395CC612B5098F0B8B">
            <board type="KONAMI-VRC-2" mapper="22">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC II">
                    <pin number="3" function="PRG A0"/>
                    <pin number="4" function="PRG A1"/>
                    <pin number="21" function="NC"/>
                    <pin number="22" function="CHR A15"/>
                    <pin number="23" function="CHR A10"/>
                    <pin number="24" function="CHR A12"/>
                    <pin number="25" function="CHR A13"/>
                    <pin number="26" function="CHR A11"/>
                    <pin number="27" function="CHR A14"/>
                    <pin number="28" function="CHR A16"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D80B44BC" sha1="0B74C3BC599086AB5428DCA824F0EEEC5D8CCD93">
            <board type="NES-GNROM" mapper="66">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="D81612F0" sha1="CB09180CA66A7A0441D09D7D80FBD3B0CAD83107">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D821A1C6" sha1="F7EF2DE117E76AC9DC458EAD70018514D6C3B4FD">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D8230D0E" sha1="5A265D61A71A0737183F1E7D5F17E0BDA6871E25">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D8578BFD" sha1="74D8E5818B719245BD9174C3CE64C860D47F30D4">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D858033D" sha1="0E51CF33DF34607D62B5BE38AE579F46AEAD7E23">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D871D3E6" sha1="71234F9DCA4C31B4E9F0719425963878F3F045C9">
            <board mapper="199">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="8k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D8748E0A" sha1="F3948B433C6255FA0AB8DEAAB38BE57A4C8F2B2A">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D898A900" sha1="EA068D20512105D1D5DA480A2544CEDE58BAA630">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="arkanoid"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="D89E5A67" sha1="EFA19C34C9DC95F7511AF979CAD72884A6746A3B">
            <board type="TAITO-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D8EE7669" sha1="6E85261D5FE8484680DECD2D5EDC319465887D2A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D8EFF0DF" sha1="C823768907793E5BF3BECF52E8A654CEE69EE116">
            <board type="KONAMI-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D8F651E2" sha1="F85050E16EE37A1092DF8CEF697BBEF284884C53">
            <board type="HVC-UOROM" mapper="2">
                <prg size="256k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D9084936" sha1="31F63524A90CE6392A6CDEF0805CBFCB0ABC2473">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D91104F1" sha1="D5C91381D98F6347BEEE398EA92B21C25DD48601">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D920F9DF" sha1="BE6D2C3D4E4A75323E74AAA2FFEAF8283D6422DB">
            <board type="TAITO-TC0190FMC" mapper="33">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D923EB5B" sha1="F42C43693C6819160E20DD06776AC75BE3544DAB">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="D9323EE6" sha1="ECC38571CD1D93B5FE19A5A112FFD38928CF40B9">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D96D9924" sha1="23869551E49AE905E7923B04D23E0D43F874EBD3">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D97595A3" sha1="0317E834CEAF841A5A167D36AE4EDC95FB9911BE">
            <board type="JALECO-JF-06" mapper="87">
                <prg size="16k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D97C31B0" sha1="136EE001E85EEBA653CA11BC2378BD4D219969CB">
            <board type="NAMCOT-3416" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="D9A532FC" sha1="85C2CCFEB771D6BE1E735FE6E1F20EE5C1BE60AE">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D9BB572C" sha1="6DB5A88F7FE6684A11B6604AA17734A0FB5256EC">
            <board type="NES-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D9C093B1" sha1="F663D004BEA0FE0518FB8B2E3A9070E1EF1D39F4">
            <board type="TAITO-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="D9F0749F" sha1="920B7E56F917690B89258A627EDACF2A4650685D">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="D9F0749F" sha1="920B7E56F917690B89258A627EDACF2A4650685D">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="D9F1E47C" sha1="F8B186609BBE3AD77D294A5E07F26B7E111A5564">
            <board type="HVC-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="partytap"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="D9F45BE9" sha1="748D702845DF060345FD621E4164A2B4CF4F2194">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DA07391E" sha1="980CB6613F0DD7C1728508B616267E6CCABB304D">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="DA2CB59A" sha1="E3704078FE0460A65FDB57A9406A5DAD4155C215">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DA430FB3" sha1="BB553D0FAC74BB910AFDDFF09625F3FF013BB98A">
            <board mapper="148">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DA690D17" sha1="45C5816845C047005F5123AAAA220E884C58AF72">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DA8E4AF4" sha1="712983EAA00029C307688DE015C1B698CC4BF064">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DAB84A9C" sha1="16685A7416E76ECDD79E6F492437A9AEDF989ED8">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DAD34EE6" sha1="B6904BEC7AF8E4E526073DD1752D60494E7E21E1">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DAD88CC5" sha1="9B33666D28E16094CD140361A9375C9ED9E4DBA7">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DAE467A8" sha1="2FE5C29EF0AFB6B0F578A68867C888E0E23B6884">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DAEE19F2" sha1="EF90A357F8CE3B060CA4C14973BCC910B2C6668C">
            <board type="NES-SFROM" mapper="1">
                <prg size="256k"/>
                <chr size="64k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DAF9D7E3" sha1="A1E0C590C038A71CAB862003372F5543395C0896">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DB05106E" sha1="8C9E26126BFA2C6F5C123E806DB468E1F0D66547">
            <board mapper="16">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DB196068" sha1="66132A311799A9B98661EBAB070D290BB881CB78">
            <board type="TAITO-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DB1D03E5" sha1="D6F0E6BEB129D5E4591B9FF81A5CF895A134245E">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DB479677" sha1="136D0406CE11BBB8C4727F5522FE8E640971F5CA">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="DB5169DC" sha1="AD19960CD32C5C1514FA2EB40DDFFC8B41129B13">
            <board mapper="82">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DB564628" sha1="9A5628DFB31B4E8F07079A30B58100884B5590A9">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DB99D0CB" sha1="5A4EF3B2F5880D3B4609AE4F3381D688B3A02CAC">
            <board type="CAMERICA-ALGN" mapper="71">
                <prg size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="DB99D0CB" sha1="5A4EF3B2F5880D3B4609AE4F3381D688B3A02CAC">
            <board type="CAMERICA-ALGN" mapper="71">
                <prg size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="DB9C072D" sha1="E5A1074A938001D01941B2BDD56F442090A267D1">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DB9DCF89" sha1="D2BF7BD570430902114F1E3393F1FEB8B1C76E4D">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DBB06A25" sha1="6CF59A2D94DEF6C300CFC350C21ABD85F6B59BEF">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DBECE74F" sha1="A76ADCDBEEBD380314EE67D16087C7A0F8940E42">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DBF90772" sha1="52F8113B2D1B3C2F59684425B9956AD790D3EF23">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DC02F095" sha1="83F6E20D75327C9B6586E9CBECF32996A1707D86">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DC1E07D2" sha1="53406E965C5C6E846342C5ED178C4E5C242B1B72">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DC45A886" sha1="E42B77A11280EB0C99D654CD08B8933FA8DDB999">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DC4DA5D4" sha1="55F06203902251AF642F404FBF35568A66EE02E4">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="DC529482" sha1="F78C4C9A33B5CEDCE9CF9DEEFE15D2C9E5B9E3E1">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DC52BF0C" sha1="B4AADED46AE0C09DA687BA9D22A137E7B3BC1682">
            <board type="BANDAI-LZ93D50+24C02" mapper="16">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DC5959D2" sha1="B735C1FC25CEDE37345DC5A133814EE509CB8CCD">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="DC621DD1" sha1="489D246754897678DFC1EA7B96C03006F559E276">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="3dglasses"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="DC75732F" sha1="DE40AB0B8AA715CE5924E4CE7040F8C45152EF09">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DCB7C0A1" sha1="932FC59188F00A3C99A5C4C65294295ABF075B0E">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DCB972CE" sha1="2EC29843A4DEB854DCB274EEE465C45820C305FC">
            <board type="BANDAI-LZ93D50+24C01" mapper="159">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DCD8D6F4" sha1="83E7FFAAC5E41C11D1E52F9F414E9B4EC3B49FDC">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DCDF06DE" sha1="E2F0A2A6D09BAF033EDA345550C43A276CC629F6">
            <board type="NAMCOT-3413" mapper="206">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DD062F9C" sha1="61D5635B1F15CC2A32916B671484CBBF2DC1DAE7">
            <board type="NES-AN1ROM" mapper="7">
                <prg size="64k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DD29FD59" sha1="F349533119E3D3FEBCD8109ABFD1A2460867D8FF">
            <board type="NAMCOT-3406" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DD4D9A62" sha1="2E0889131DA5BA9505A15B94887113F4360D98CD">
            <board mapper="209">
                <prg size="128k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DD7C8785" sha1="81465272D22BA4EC12DAE148D7AC02EF9409C009">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DD8CED31" sha1="8AF41D10961B700B95B0FEFB6E08A9E3969E9A5D">
            <board mapper="209">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DD8ED0F7" sha1="1CAA0DA81A56C0FCE9E5FAC7315295EDE0335C2F">
            <board type="BANDAI-74*161/161/32" mapper="70">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="DDA190F9" sha1="6CB91EF73979A7C8893896E1B45A3E56FAC9E832">
            <board mapper="146">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="DDC6D9C9" sha1="D12148A39748BDD3685E8D02965393178CDE4F4A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="DDCBDA16" sha1="142C71036B5D7A673C2EF7141413475C00DCBF92">
            <board mapper="150">
                <prg size="64k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DDCFB058" sha1="73468642E5E0F3D3AEE47949945C39C1F02CFE78">
            <board mapper="187">
                <prg size="256k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DDD90C39" sha1="B8F6BF251865A35571C04C509989A61065745440">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DDDC56B8" sha1="6CA388DD7D31EDCC88726AB45413D6C3E4BCF039">
            <board mapper="240">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DE25B90F" sha1="973DE9E0D7E96C789952E34B8AB66ADB5A1A5AF6">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DE395EFD" sha1="71334B2E4474CB3C184E90C66B1B1A347BE01D8D">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="DE581355" sha1="59B43881456C0720E9A35E391B11C4B2C55A8F91">
            <board type="HVC-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="DE581355" sha1="59B43881456C0720E9A35E391B11C4B2C55A8F91">
            <board type="HVC-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="DE7E4629" sha1="4D7BB49E2C36DBD0E6B2BBB27FEC1D80E4935250">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="DE8FD935" sha1="D270AC1F3A07D8526C29FCEE69896FDE8F4DCA5B">
            <board type="NES-TEROM" mapper="4">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DE9C9C64" sha1="FAE2635A6776EB9637A25F8D413D8DE856DD718B">
            <board type="TAITO-X1-005" mapper="80">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DEE05A23" sha1="1AEF57E09EE6C8B1FB3F7A22B23A30C1011ACC5D">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="DF31B364" sha1="DA1A99C2F921AB906B38FBC18D1AF1775550DB04">
            <board mapper="112">
                <prg size="64k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="DF343384" sha1="894BD6BE70CED0181DCFEBCDBC1230486B002A68">
            <board mapper="0">
                <prg size="32k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DF3776C6" sha1="0F38022BECCBF7054F7AABB966333964CBBD3A5E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="DF3E45D2" sha1="CEB7A4846390C81A883D06655BBF4954617F45E6">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="DF3EB610" sha1="38CCCF05D2FA9D92C799705DB0EABBAE5C9AD51A">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="DF43E073" sha1="EF814DFC42EA1461ABED357992ADCDAE1C82D408">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="DF4EDC13" sha1="B7404CF9222D6608DEC17AECC51AB5C0E480DF3C">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DF64963B" sha1="4CC68474658B796954402FCA71DA5F2FF8BAF5AE">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="rob"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="DF67DAA1" sha1="85B0031C86274A5805933C5422F7B8DCFAB75134">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-NTSC" dump="ok" crc="DF67DAA1" sha1="85B0031C86274A5805933C5422F7B8DCFAB75134">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="DF67DAA1" sha1="85B0031C86274A5805933C5422F7B8DCFAB75134">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DF81364D" sha1="012FD90B213454B76608E018E70F89F1E166DC82">
            <board mapper="235">
                <prg size="4096k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DFA111F1" sha1="9C7B802C47696DFC146D43D8FB096AC3DF09D925">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DFC0CE21" sha1="824BB64C887D2F06886A3E491D2FD899BA13CCBC">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="DFD70E27" sha1="E5C335B11989813F30E294D0B30F3C03697F25A0">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="DFEB7E98" sha1="16AC71461FE3D5C902A6BE0DD3EFCC048DD3CF4A">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E02133AC" sha1="23329989656C7F7FA9481293C6FD577DB006AA0C">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E043C6A5" sha1="9B9CBB645FCA88B8B66324CF5FF940C6D5986140">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E0604F76" sha1="D6D82CF48D97BD5702F17B3DDF6D06392A31A7E3">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E08C8A60" sha1="BAF3A4E0423A86E53234E806843149EF7D0974A9">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E095C3F2" sha1="19783C0724A495316FFA54F5D85A5729D6FE637E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E0AC6242" sha1="52FEE5216352E714B8E10EA136A2C3ACA640127D">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E0CBC2BA" sha1="72D76C486EF60E8C950FBA10C54B9AE63458B4B2">
            <board mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E0FFFBD2" sha1="E9B0106D5BB6B95D531653C656CC38B64A1FC0DE">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E116447F" sha1="95AB1F5AB2E01532537EEC517351ACF663FACEB3">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E124BC56" sha1="BFD029637CBD6061E838F2D890F174BF8E0B4FAA">
            <board mapper="91">
                <prg size="128k"/>
                <chr size="512k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E1383DEB" sha1="F002058527461A857BD74E51FEE2BF3820CE9BA6">
            <board type="KONAMI-VRC-6" mapper="26">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="Konami VRC VI">
                    <pin number="9" function="PRG A0"/>
                    <pin number="10" function="PRG A1"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E145B441" sha1="FF4E61F3D48E54FCE35E8A4E5DF8BCC92440CD2F">
            <board type="NES-SLROM" mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E1526228" sha1="EB576DCDE0BFA51F039D153804B8614D53B8F0C9">
            <board mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E15C973D" sha1="3C9A7771024DFC9622C87CF435D39526E9BE9AA4">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E170404C" sha1="94BD94C1DFC807074A3D6B319679E7E30E452693">
            <board type="BANDAI-LZ93D50+24C01" mapper="159">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="turbofile"/>
        </peripherals>
        <cartridge system="Famicom" dump="ok" crc="E19293A2" sha1="4FF9772497E604216463904B0572E3F1C6A87177">
            <board type="HVC-SJROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E19EE99C" sha1="9B51A9D91380D10DF03DA29788809F6024ECE485">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E1B260DA" sha1="F110AE847049723DB4AC9213A8EC5BFD23E644F2">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E1C03EB6" sha1="787410837C473B4EBA969FF708B8BBF7B1F18573">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E1C41D7C" sha1="CEAE211148EE2865673D94230DBA3EE5E8285FA2">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E1C59D94" sha1="E310219646244C6E11E0C11BCB29FD021510215F">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E211B93A" sha1="C8059DA94DFE63F6372B25C504043BA12E70996B">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E2281986" sha1="A48AD4C24648F0996CC5C06B5CBD1F284F04D40F">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E2313813" sha1="220939191A48FB2CF3A73C8FD713A60AD2EE34DF">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E24483B1" sha1="A497608C4638413BCD38E321F257C84BB6FE8DB8">
            <board type="HVC-SKROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E2482419" sha1="287AEF229E77B6BC2BFB500F906E9C906393862D">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E24DF353" sha1="704BCB055EEDE102D2489DC4533B5BE622DB0A2B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E292AA10" sha1="24F85D6EBFA6D958FAE9346F322C799E4896A32C">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E2A79A57" sha1="E0E46C9071480F2BC9959E5A6F858561CB001168">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E2B43A68" sha1="69D7C4BAB3B678D7527CE85A5CB29BB36481B924">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E2C4EDCE" sha1="E12500475AE3F76F36A2C49175B3A6B783DD904C">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E2C94BC2" sha1="EB35202CC4E9C2FAC320B04F36F3A6858B8916F2">
            <board mapper="48">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E3027EBE" sha1="AFF62C6D148CE1F7797D3824BD55E2256C65B6E9">
            <board type="NES-SJROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <wram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E305202E" sha1="18D1A1D01F114B310F2DDD52AE06ABF77B72F7BB">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E30B2BCF" sha1="EFE9DD039206C59420ECD58436EF0CD8E640E30C">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E3158E17" sha1="1852930EE75B8B961D9383250A5F3353197986CC">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E333FFA1" sha1="33DB1FD77797C63E8A0859DB373E94A60CA5FD42">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E349AF38" sha1="BEB7E005BCBAC031CE61613FA47DF24AD151E9AB">
            <board type="KONAMI-VRC-6" mapper="24">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="Konami VRC VI">
                    <pin number="9" function="PRG A1"/>
                    <pin number="10" function="PRG A0"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E3526D8B" sha1="38D6B94E1CBB1272188ACF8CA383FC6069C35867">
            <board mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E353969F" sha1="3F7A94CC4A663B9B5F90B0565717875C974693B3">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="E37A39AB" sha1="45442193F35F627959DFCC2C35B03F762492A35D">
            <board type="NES-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E37F82CC" sha1="343998C4226D8E574128542C9E2A2BDEFB654CCB">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E387C77F" sha1="7F1485F855165960C95562E19509A1E2380D13C8">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E3C5BB3D" sha1="85E43A81DBBB391122DF9FD39DA10F28F9329C34">
            <board type="KONAMI-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E3F3F6AE" sha1="70F41DF1BE9344ECB9B9E033341D173655609E34">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="E402B134" sha1="D44EDAF9390CC08298C25AD0FFC8643363882AAC">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E40B4973" sha1="217D01EDD1200D41588DA862926139E05BBAA02D">
            <board type="NAMCOT-3451" mapper="206">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E429F0D3" sha1="4A351F13CC60A4CFF9D109763C12644946AFEFDA">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E4362167" sha1="4A771856257130C4C867214BD173BA54ED80A919">
            <board mapper="85">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="partytap"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="E44001D8" sha1="A7800F88AF4D5C8BE68DC194ACAEE60C6E82D3C6">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="E45485A5" sha1="B35C68AC81CC2D2B13237B6FF3927F3DFC852226">
            <board type="NES-DRROM" mapper="206">
                <prg size="64k"/>
                <chr size="32k"/>
                <vram size="2k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E46B1C5D" sha1="9909918FE693A0DAFB90748A8534DAFEC28D98B4">
            <board type="JALECO-JF-11" mapper="140">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E47E9FA7" sha1="20E2254282E8EBBF1D1455DB46898D08113B85B6">
            <board type="TAITO-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E492D45A" sha1="ACE488D8FA6AD5FB528F759E6BED66B3CFEF042D">
            <board type="IREM-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="E4A6E151" sha1="D72724B55BE377D6D6663FF29A641593D07CF9CC">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E4A7D436" sha1="BB71A65706F75DA8008A1BAC02ECAE06EA176F1F">
            <board type="HVC-TKROM" mapper="4">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E4E3D2ED" sha1="D7EE5DF533B0C33128F0C0AFD05E8EDD42C0B1D7">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E50A9130" sha1="94B1E56B1745A84872F0F8C28B5866DAED19C337">
            <board type="NES-SBROM" mapper="1">
                <prg size="64k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E53F7A55" sha1="63D5AB59B1513A4D5D432077415789A36F1CD09A">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E54138A9" sha1="787FCA2F777B37D83945549E64F05BC74413E239">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E542E3CF" sha1="2990A31D46210DEF8E1F4A225587CD15F512979F">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E575687C" sha1="204C5B2EE0445E5ED45A5A911782C2403FC97344">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E57E5384" sha1="A322BA4CEFAFF2668763CC20491FCBFCACE7347E">
            <board type="NES-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="E583EC5E" sha1="63D0A29267431F37A1855B57FC69EF37303FB348">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="E5901A99" sha1="68C692CEBA716168DCB361AD79A2F4C985CDE32C">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familyfunfitness"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="E592F53A" sha1="6D0ADBBF93D948004E33CDF3B1CCAC1FB60D65C6">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E5A8401B" sha1="1E8B6630954E5C2A8CDCAA4EF7890B45BAFE103E">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E5A972BE" sha1="5328F9961DD96F117928EB45C797C062A7D37D07">
            <board type="NES-AN1ROM" mapper="7">
                <prg size="64k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E5D11921" sha1="4180276C50DF9958DEDD6C6D19C9E7AEBB75A89F">
            <board type="NAMCOT-3301" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="E5EA0EBE" sha1="BD4DC868EEAB2E53AF04816D2B7CC3333DE40DB1">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E5FCC4C1" sha1="EA170B7F53BC1DF483976641DE4B2D02716ED233">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E616FF0A" sha1="B7C8E914CCCE4B8BBD07B651D5ED0EC14752D189">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E62E3382" sha1="B74802F946D99A83E8E223B6F987E6482A8EC41D">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="E62E3382" sha1="B74802F946D99A83E8E223B6F987E6482A8EC41D">
            <board type="CAMERICA-BF9093" mapper="71">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E63D9193" sha1="9D22023F55E608687776B53E27E016BB5F81CAA6">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E64B8975" sha1="3133ACB9F6ACB59BA73460E3BA8EBA2C6F66CA4E">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E66010C4" sha1="9958BED493E8C5727F96937BF254AC33FA3BCF81">
            <board mapper="195">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="9k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E66BDDCF" sha1="259C8F859F63301F5C4D1D6E6C4F3222D467AB49">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="E681B300" sha1="BBAE8ED1C54B15A14B236BE3C89E9B97326A8D46">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="3dglasses"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="E6A477B2" sha1="CE70E57475F4058AC5A05DFED92163D42F0B8B96">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E6B30BB3" sha1="E27872845210495A86C8F0DE9639E9CA4EE71031">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E6C9029E" sha1="6D2C083AC45A7A0A1F7E7754875F8E6A993B7C17">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E6DF6616" sha1="D85F671830E18376840285D457A7F59659882B8B">
            <board type="KONAMI-74*139/74" mapper="87">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E6F08E93" sha1="DC50DB50702FB7A89BC7DB8132BFC805F3C9FC33">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E71D034E" sha1="3DFEFEA7715FC08AC6D0A983CA922366522F1B28">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E71DB268" sha1="D0C6AF83C44F2DC90BCB0792A69C93F8D167F988">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E73E7260" sha1="918BB59593DAA7C669458076A66D617EF0055AC2">
            <board type="TENGEN-800030" mapper="206">
                <prg size="64k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E74A91BB" sha1="5421AA6263F40D727990B9CC018CAF290F0F683B">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E74AA15A" sha1="5D7214C2A2C87C915F5B918980A12BF086ACC9E2">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E78A394C" sha1="52FE4814FF7031E067456928654B3C03247AFE9A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E7C981A2" sha1="D477C50188CB0051FE02CB057DB1B6A33DE59E01">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E7D2C49D" sha1="D4F52D21EF6C872FFACEA083161DBDA0234924D5">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E7DA8A04" sha1="9DB90BC01C24168D03169F371E97D827AA327662">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E7EAD93B" sha1="4E48695ED4EF4DB19FBB3806D25397C371A479CD">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B3"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E801F662" sha1="7F3549D3106500CCE9BEE2BC03DF336D4AE9EB4B">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E81C71E9" sha1="3256127D9069DA4A94DB51DAB3DF931A9AFC6048">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="E840FD21" sha1="5663EC56B23F5B9DBB1C63E5E1698BF4F86F683E">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="unknown" crc="E85B4D3D" sha1="11876755B50D6C48ADCBEA2B44BD3C77979E5D56">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E8829001" sha1="D59C66A1F24A823FC961A86C3B193278D3F8FE31">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E8AF6FF5" sha1="07A0C2F056AA23451FB94FDD163367747FC677F2">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="E8B20197" sha1="F8A0F2C5A4B7212CB35F53EA7193B3DD85D6E1CD">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E8BAA782" sha1="B3D401A0032D33A6484B054F3776C906BA194D2C">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E9023072" sha1="932238411C73866B99DA4BFE32F4D7AB3F1F8687">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E911BCC4" sha1="13854EF3982A19317B8AB96A6CA48DB71192A20A">
            <board type="NAMCOT-3301" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E9176129" sha1="D3D6C21E5E11AD325D66C49A6325DFE0B62D5C3E">
            <board mapper="4">
                <prg size="32k"/>
                <chr size="32k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E943EC4D" sha1="C4E43E5C9D3E63F5EC11831FE154EC80F7AAEED8">
            <board type="NES-SLRROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="E949EF8A" sha1="83661A1A58A5AD8285EAFFBBBE42C4A25AA211B1">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E94D5181" sha1="3473FD11551A399041DDEEF6ADB45AE9D8D08B7D">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E94E883D" sha1="C10575DBB211A5AB5321573D884041FE35BD15E3">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E95454FC" sha1="7F50C869600F7482B14925C9EA6EEC00897193CB">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E95E51E0" sha1="DD318C52E592212141E0EC966606D6DE8B610EB0">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E98AB943" sha1="B42B17E42551D6B187A3AC0598B0CC6618ABA6D2">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E9A6C211" sha1="A9C430CE38A078E19DE466AD2F2541680F0EB13E">
            <board type="KONAMI-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="E9A6F17D" sha1="1A17DF593C658F56D71B7026D2771396BFF95B36">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="8k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
            <device type="subormouse"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="E9A7FE9E" sha1="67CEF615772E3CED737B346BB552B4B6C311E2C9">
            <board type="UNL-EDU2000">
                <prg size="1024k"/>
                <vram size="8k"/>
                <wram size="32k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="E9C387EC" sha1="CA794E6A2B0ECF69B2BE1753D379CCE6434C49D7">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="E9D352EB" sha1="9D311C82B54C132EC63FDBAA933B593D75CCE310">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="E9F16673" sha1="39294394A0631708F58397371CE14075AE1FB7E6">
            <board mapper="148">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="E9F8EF15" sha1="BF0ED53F610E32F9D96E9079BF3DA4667D456DAA">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EA113128" sha1="08F7C1A9B2061E0C3D12EB960A48D022007C6252">
            <board type="COLORDREAMS-74*377" mapper="11">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EA19080A" sha1="6AFC82DBDB84B09286D09192BFFD641D9B3D003F">
            <board type="AVE-NINA-03" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EA27B477" sha1="DBF35D2F94D0F5F6B39621E8A29E864EEAEDE173">
            <board type="ACCLAIM-MC-ACC" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EA3E78DD" sha1="6A8B5768F50F9CFE21897D26F28E98D3EB6A0FB1">
            <board mapper="18">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EA4EB69E" sha1="DBA512B9EEE01549D3939297FD463681CFF92F11">
            <board type="NES-SFROM" mapper="1">
                <prg size="128k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="EA89963F" sha1="57F9DB2F47FCE34C5EA255BA3A9105279D41215F">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familytrainer"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="EA90F3E2" sha1="AA511B101CD5E32F27E20A901E40D90A270FD980">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EAB93CFB" sha1="9B8FFA06808FFA07BA1D5F05557860335CADBEBB">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EAC38105" sha1="252C80259DAE00076C667F1BAD9B54C2D32079B3">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="EAD40557" sha1="1BBA1E06B3F93CA523B4EB9CC04DAF3DA71F0CF5">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EAF7ED72" sha1="BE2F5DC8C5BA8EC1A344A71F9FB204750AF24FE7">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EB0BDA7E" sha1="66662F77437A69A9BA0470F877754E7946C157D7">
            <board type="TENGEN-800032" mapper="64">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EB15169E" sha1="3195B7813C7822A020C688CAD6587A22B3835CEB">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EB2D56C0" sha1="EEF617A022B8E45E0BDE088FED654C89AD4FAABF">
            <board mapper="198">
                <prg size="640k"/>
                <vram size="8k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="EB465156" sha1="2A554D8856FEA0F3701E512F375A4773B46DA319">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EB61133B" sha1="A38C6D29C96296B722B13F8B564D5027891650E8">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="EB6F80E8" sha1="95CD92B40D060C07484824D5BDA87ED2E90D5DC6">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="EB764567" sha1="F1C5073919A0D0D86E05C331E5DB6A94055EDDE6">
            <board type="NAMCOT-3305" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EB803610" sha1="CEB87A01049DBD6466696F70834B24997BBC6981">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EB84C54C" sha1="E62A1EEB5B88C4B812858C741907F6FE51765E56">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EB92B32A" sha1="08141D58D442237576EBD50979083263ECE91B47">
            <board type="KONAMI-VRC-4" mapper="25">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A0"/>
                    <pin number="4" function="PRG A1"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EB9960EE" sha1="CFB0DC557FDC913B995EE8B848C84F2661260E5F">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="suborkeyboard"/>
        </peripherals>
        <cartridge system="Dendy" dump="unknown" crc="EBB56E10" sha1="23F3AD340B258DCDA12FE14D6E22D106427C161D">
            <board mapper="7">
                <prg size="128k"/>
                <chr size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="EBCF8419" sha1="0EDA2AFDCD2FBD0714BC0F7A6DB2C19D8A0292BE">
            <board type="HVC-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EBCFE7C5" sha1="5AF88BE752FE06673874574A039AD03749C2BBA1">
            <board type="NES-SC1ROM" mapper="1">
                <prg size="64k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EC0FC2DE" sha1="92AE9BD552B0008EE513FCB63D93F008716472BE">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EC3B7B47" sha1="12B4E706D589AF6E20BBC7A204909B6113CCA855">
            <board mapper="64">
                <prg size="128k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EC40E71B" sha1="EA5D997C7B9F30C1BB3595AB4AAB6BC46E641F25">
            <board mapper="140">
                <prg size="128k"/>
                <chr size="128k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EC6D910E" sha1="816366EF0B1417BE7553957FA3D256493DD0BF85">
            <board mapper="156">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EC8A884F" sha1="AE9B29CA1A8FB67C6D43DD6841D1FEAB4E652DE5">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EC968C51" sha1="3BD76AF54A9A2760E5AF975BEEA877057F08E871">
            <board type="NES-DRROM" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <vram size="2k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ECBF33CE" sha1="A9F026EEDAC51D445358F8BC4FBCDA40E0CDFF7B">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="ECCD4089" sha1="7E9DC826B6E177FADC699473ABEADDB3405771BD">
            <board type="NES-SLROM" mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ECEC80B4" sha1="9CB093C4133999E3067F24B51E14998987334271">
            <board mapper="75">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ED0AA77B" sha1="ABF5C085833B9827130E6BF1C3A384D2C9B3C027">
            <board mapper="4">
                <prg size="64k"/>
                <chr size="64k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="ED2465BE" sha1="23C4DAFCC17FA75E8D682931702277659CD59735">
            <board type="NES-ELROM" mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="ED3FA60E" sha1="E98656C2DA2E93DF3CD5E3B29D4CA5CA9F41AD33">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="ED481B7C" sha1="A907E600CEDA175ECD115B406B28155397A4C1FA">
            <board mapper="199">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="8k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="ED77B453" sha1="7B0B8D19BD56AA255501852136828300EE2D2457">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="ED7F5555" sha1="6322960A969E008CC63BF14879D98412096BC795">
            <board type="NES-SNROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EDB662C5" sha1="5B949D7680DC240CEF984E24A1D196F856CA736A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="EDC3662B" sha1="D77D9B89347510B852BAA83EA1C3E1EF41A1288E">
            <board type="NES-SL1ROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EDCF1B71" sha1="DB8A165B40542394C6F13914F4722743CD5AB511">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EDDCC468" sha1="9E94EA7D2FA790A61C064A4D31C89603AA1C9E49">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="EE219A49" sha1="A60FFAADBD284D7AC9A1FCCB8C567838C8B53E80">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EE43153E" sha1="BF42FF80A4215FD74BA2DA18A77D30B983D8349E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EE6892EB" sha1="29CA7CC398B855472C9D94E7581BE8288468382B">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EE7614E8" sha1="3D8E92D5D9056109ACB3F4D0C2646F4790836C04">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EE810D55" sha1="CEFEBA536DB507DBDEF8A538F9C332D7A75BF613">
            <board mapper="192">
                <prg size="512k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EE921D8E" sha1="B239C2D48E84CA676DEE4461D4D6A1F77F34255D">
            <board type="KONAMI-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EE9548AD" sha1="78EC827CEE61E009F7716ADE03361369FFCE9D12">
            <board mapper="195">
                <prg size="256k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="Playchoice-10" dump="unknown" crc="EEB20F84" sha1="5A7ED3B5F273179F684930E2DC46482AA19F745B">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EEBEE0C8" sha1="B367506A7249865DEDB59AFF9B4CE593B3913F0C">
            <board mapper="195">
                <prg size="256k"/>
                <chr size="256k"/>
                <vram size="4k"/>
                <wram size="1k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="EEE0C7F8" sha1="A5BCAFA4FB5C9BED3F1BC5C0D946BE8FFC7E3C2A">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EEE6314E" sha1="1C05D3734EAAC1390638A9FDB22192F0A53FAFB9">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EEE9A682" sha1="46C443D0EB27AF7A566E744F096F981034A06E59">
            <board mapper="5">
                <prg size="256k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="EF4DB05E" sha1="DFFCC794FE448406B6977D066E2AEAFA7B5CB940">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="EF7996BF" sha1="B3515C7BF2DA2DE612FCFB58EB3B54F7EA4436CE">
            <board type="NAMCOT-163" mapper="19">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="163"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="EF7AF338" sha1="9F1943AADE4233285589CEA5BDC96B5380D49337">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="EF7BA485" sha1="861B1D21A75277C9168912E369F3499B247C0909">
            <board mapper="163">
                <prg size="2048k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EFB09075" sha1="6E700E8F72F767918B096F6A5F17F8CD1E2D0866">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="EFB2B7E8" sha1="F5FBB35CF460DE78F22A2A99ED21594D42BCF6E7">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerglove"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="EFCF375D" sha1="02D8D6A815FFFC12C19E183EEE11006C7D84109C">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="EFD26E37" sha1="355649D34AEFFAE0DD15C03A51B16EF49B668852">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F00584B6" sha1="DBF2D8477836E6A372CDD191EB26A365FE602AEF">
            <board type="NES-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F009DDD2" sha1="C5C2A7768710D9E13B28008C78846B0EBFB8C311">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F011E490" sha1="39F9094927FC87373F021244AABDC4DB1E1C8F37">
            <board type="NES-EWROM" mapper="5">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="32k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F053AC5F" sha1="14D0C6FDFEDC0347D809660A96DFB4B7069C4172">
            <board type="HVC-TKROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F05870D5" sha1="04E42EF95DE5C857C560B67743310F8777980745">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F08E8EF0" sha1="3F9D54EF6D7A92D5A0A70C2BFCA339486C90D95E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="F0C198FF" sha1="93E02D55CC783454A4CF44457B71F55B8EE996E9">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F0E89EFA" sha1="CB0EA57C6D01A81BE90D21FB1ED041147979897F">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F0E9971B" sha1="EDC4F9CC3BCED542E503A961E22D7B085ED17BCD">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F161A5D8" sha1="83F5EA60D6E6489EC0E5AF4B938D2D1C8FD24DD5">
            <board type="HVC-TGROM" mapper="4">
                <prg size="512k"/>
                <vram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F17486DF" sha1="52FD2FEA0BEA02C0B530B2AFE167724F6449C3C8">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F181C021" sha1="5FFE3CB3A79151E4DE8018F1CE8F3A375B3CE5C0">
            <board type="NES-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC3A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="F184EB2D" sha1="CA77F25BB4C5DDCDAA553A41CD52C3AE9C8F4B70">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F19A11AF" sha1="70925EF783A6716FAD9C6706BA9751D721250FCE">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F1C48D61" sha1="55A881F0A6B6CA3370414DFAD051AD4943780C4B">
            <board mapper="196">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F1C76AED" sha1="088F8F85FDD33EC2EF1EBB0374D33FFC634A397D">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F1E6B576" sha1="89C455E1793A1603BB977AD7215AB308B3586958">
            <board mapper="86">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F1FED9B8" sha1="79D3FD46C79F3AEF2877E51E2643915012F56125">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F283CF58" sha1="87ADEFE70600C499307BF39A9BD453B98D293A51">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F2CE3641" sha1="BCD6794579A743211CF96A306EB97E74A0C33EF6">
            <board mapper="68">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F2DC8923" sha1="89F0B8A1D8B3A166BF66F70D8761A623D65243D0">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F2FC8212" sha1="0B8A4BBB08D63D44AE4894D741CCC9F3779CB2BB">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F304F1B9" sha1="4BEFBEB81265AEF234B031AAF86695FD69FD41AC">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F31D36A3" sha1="00147962462C44354735861D0258D72314635458">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F31DCC15" sha1="0CB2B28BAD1629F08BE5DE38DC8DF8BB66C78B3A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F32748A1" sha1="AE812460AA7126B7436B7706B0923CEAFA0E1EFC">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F34190B4" sha1="8C703B4624EB880180398FB6988211FDB2BE4A55">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F3623561" sha1="3FEBF59EE063C808200F350051C1091E7E639CB5">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F37BEFD5" sha1="BB63D5681A96B529B8E1E43C89C21F4E67601F3D">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F3808245" sha1="1B32D273A0B8884E96F4814099DEC32FC925AC55">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F3841DCD" sha1="0EE24D0A864845449EF7434822C12FA0F063DE56">
            <board type="AVE-NINA-06" mapper="79">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F3F1269D" sha1="16A5C45C00862CD2F9C190117F91A8E4C142E8B5">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F41ADD60" sha1="6D982910A8D70A2705E87AF17C01AB6A676A9DE1">
            <board type="NAMCOT-3406" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F42B0DBD" sha1="091618154A2383926479D6CD0A0EF8F89C443C58">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F450DB3A" sha1="6E9889DE639EB6CF681546AD15FF3F643B0F4ECA">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F4615036" sha1="086AAF77F6B1C726FBC36E2611625F50E36BC673">
            <board type="NES-SL1ROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-PAL" dump="ok" crc="F46EF39A" sha1="2A46E463864E9EFA1F5F1BDEABE30D2A7C24A91D">
            <board type="PAL-ZZ" mapper="37">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="F471827D" sha1="4E717A133C5B0C7101D1E8D784263A2C9FAB294B">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="F4B70BFE" sha1="A261161BA810E1E5FC6857E3C574702F57036892">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F4DD5BA5" sha1="6EAE7638E08B790BBFDD29310CE6C77B3F1E6C83">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F4DFDB14" sha1="D548556C1803E102E7BA94ACB8D4E6297D8EC158">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F4E5DF0E" sha1="9693D51F52CA9C94FD6BD769FA377ACC571B6D5D">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F518DD58" sha1="92F0C3153D0DEC1F78D61425F88FC6573B0F9BE8">
            <board type="NES-AMROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F51A7F46" sha1="74218AAE93E4FEBFB2284BCF15811453418A2029">
            <board mapper="157">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F532F09A" sha1="3DD16BE6218CF608D1B03283227B14B4404E3652">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F540677B" sha1="44A5BC2B8156D50518EEBEEFA522A7642E0476DC">
            <board mapper="5">
                <prg size="512k"/>
                <chr size="256k"/>
                <wram size="32k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="F54B34BD" sha1="78D52BD2FE42D21DA0279D29B29F73A121AB9121">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F56135C0" sha1="7C5063439E6DEFB681CE115B950FFB66F6D65C2C">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F568A7A4" sha1="CA9257C01F6E190F7AE7998A3C1C681903EE0530">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F56D6D46" sha1="11419605C942FC9DCB4F93A329C13E3BD5D62403">
            <board mapper="243">
                <prg size="64k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="F59CFC3D" sha1="E22854DAF598B94C3F8620D42E959D4BF2C81BDD">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="F5A1B8FB" sha1="0C9F758585C9D552C4C7C83B888C941E7B0BAA0A">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="F5B2AFCA" sha1="8B6311003D26E3C90DC8A46F1A8F4B90E5078696">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F5CEEF8F" sha1="E6B11A16D435F8AF39E22D3FB73C92584C7FDE82">
            <board type="NAMCOT-3406" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F5F435B1" sha1="511A74517D20C6DEA4F95F8E30A3F93B757B54CF">
            <board type="HVC-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F5F5AA5D" sha1="C2A2D3C6EDF89D5F2FF7F924CDFA4EDAB1688176">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F6035030" sha1="979494E7869AC7AB4815FDBD1DC99F893F713FBF">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F6139EE9" sha1="E7D6AF180962EEF5121D6A319985ACD33142C946">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F613A8F9" sha1="5F2169E2C5C171CD350375FC403910A48A965591">
            <board type="NES-ANROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F6271A51" sha1="FDC5596523D3E322952388C9DAF2AECCE841B85E">
            <board type="KONAMI-VRC-4" mapper="25">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A0"/>
                    <pin number="4" function="PRG A1"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F635C594" sha1="578AF06C28A6630B5A2FB92CA86B7816AF39A0AD">
            <board type="SUNSOFT-1" mapper="184">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F64CB545" sha1="01C683A1E83220A9B976A541AAA9B4B5B8FEBCFD">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F651398D" sha1="5C972003B62D7B1503FC4604E8B547635359F64A">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F66EC512" sha1="29D8024529C5EC6F9F188D8F5448C84B5F32B9E7">
            <board type="HVC-TFROM" mapper="4">
                <prg size="128k"/>
                <chr size="64k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F6751D3D" sha1="590B5FB7456D4164CCC4D73EBA98DC3EF589DBAD">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F6898A59" sha1="A72746A57607B6AE6F5D613AE1218AB1C0DE9D54">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F699EE7E" sha1="56C3D55654D0E837082978505653F6E1E0D52D6F">
            <board type="TENGEN-800042" mapper="68">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F6B9799C" sha1="C881749BDED199785699F51C3925F940332EFAC1">
            <board type="NES-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="F6DE2AA2" sha1="726E10E484FCEFA32EDD531AFE4EEBB9F9F8C536">
            <board mapper="151">
                <prg size="64k"/>
                <chr size="64k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F6E2BD6E" sha1="BC9083697A0181BC597C0AC18C173FBC6BA6D1B4">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F6ECF6F7" sha1="34607618D5CB3F2FB0AE7E9F9223294942887FCD">
            <board mapper="170">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F714FAE3" sha1="C03A3E92A65C031A1A03036E965EF3048974CA73">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F71E7EDD" sha1="C4C46C1BE3EBF607E31010CC63258F22A5D98F84">
            <board type="HVC-SNROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F732C8FD" sha1="102BD0C46C5718C979EB1AC387DADE6F6EB70EE4">
            <board type="CAMERICA-ALGN" mapper="71">
                <prg size="256k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="F732C8FD" sha1="102BD0C46C5718C979EB1AC387DADE6F6EB70EE4">
            <board type="CAMERICA-ALGN" mapper="71">
                <prg size="256k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="F735D926" sha1="B0D1852782B4E9A9CCC2BA24CD40B170C38B940F">
            <board mapper="151">
                <prg size="64k"/>
                <chr size="32k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F74DFC91" sha1="F859A74ADE59A9687AC53C9048023CD7BA994E52">
            <board type="NES-SGROM" mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familykeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="F7606810" sha1="17720AE1AFC6A3750384D6B082391C0C2F8A0699">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <wram size="2k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F760F1CB" sha1="D545BCFFC46F5B6C577D189640C5C9C39E25CFF5">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F7762A20" sha1="7ABB6D254E6A2DC24868EFFCF1D710497D6E5256">
            <board mapper="206">
                <prg size="128k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F793E28A" sha1="099CC422A36211823D8BF838A31C48FA67C318A6">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F79A75D7" sha1="602F640B3FE0CA47CF47DE6688779419A75487AC">
            <board type="NES-TKROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F7B852E4" sha1="7AEAEAFB8C71F26F2E3DC2464BE431B80F1C4636">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F7D20181" sha1="879A0E3F8FF41C2FA656E52504101552C1B7D4C4">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="familykeyboard"/>
        </peripherals>
        <cartridge system="Famicom" dump="unknown" crc="F7DB8B5C" sha1="4E819C20F41E06059F4336E05B4CBAD52551423B">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <wram size="2k" battery="1"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F7E07B83" sha1="4026DA3BDAC8E539E2D90E86E3B5B13957B6F309">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="F808AF60" sha1="B933C1E9D5FF18D6BC18EBAA5525B8DA1B57A5FB">
            <board type="SUNSOFT-1" mapper="184">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F80BDC50" sha1="C7476483A506635CD0110D325D487F3A974DAA08">
            <board mapper="33">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F84E2912" sha1="C782134E7329027B6C12F735E246AA6897F4913C">
            <board mapper="225">
                <prg size="1024k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F85E264D" sha1="5E3E3B511AE25543BD991D255FABB67CB0E2D3FE">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F863D5BB" sha1="B134D199B7527A81F24DA54F7478BA17D1632251">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="bad" crc="F865EC8D" sha1="CC8B9B2CEBA1BB2F8E7E1D19B8F29ACCD640764F">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F880E010" sha1="F85B0368F42806643E66A981813590AD5FAE2E0B">
            <board type="KONAMI-VRC-4" mapper="25">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A0"/>
                    <pin number="4" function="PRG A1"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F885D931" sha1="CD61B3CAD9BE75A271D1BE164885CA0D8070A2C9">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F89300FB" sha1="23B6A40970E21F882B68348B01014DB29F5A6B3B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F8A713BE" sha1="E8EA2DEB2D65FC64F0DC038A2C95CA6CE8CA31B9">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F8C1A690" sha1="374446A798243FEC986673A670DCECA2FD229818">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F8D53171" sha1="033F2468BBA8A3FF796FF90E858C4958326F478E">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="F919795D" sha1="F98445C6B24AF3FB590FDD8689A3B44C18339B79">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F927FA43" sha1="CE4569326ACDFA03A580FA6B4C4CDE95FC8CDC9A">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F92BE3EC" sha1="5DC651CF48ED86DE4B45E9F7D1C8AC696F999F64">
            <board type="TENGEN-800032" mapper="64">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="F92BE7F2" sha1="4AD225EB6EA778E4C221268CB0FD7EAA3977D86D">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F9443A53" sha1="C296FA20343DC0C628BCBB6CE8B27B4C8582467F">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="16k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F96D07C8" sha1="85FC84B1E9031631A437A0BA47A0B1FA1256A808">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F989296C" sha1="60C90F38178381CF7C1B1934E9510494950C6A2B">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F99525B7" sha1="E375D8C20BD2EBF0965D210C39C76A8B9DBB6BAD">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="fourplayer"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="F99E37EB" sha1="46F2B1B666C252EEABE4381A56F85969C277B431">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="F9B0C04D" sha1="A4646B1D9D93EC27EBFFB4503545762250C72410">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="FA014BA1" sha1="250FD2FFE1C7565E1469055147B67C4D4C799E56">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FA2A8A8B" sha1="81E361D6CB0B74DC6ABCA976B23626577A115B30">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FA43146B" sha1="3774ABE51D449579E5D90D90A816FDB98D8E332E">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FA6D4281" sha1="EA4F12424B87A75E1C4CB75DA3EB0DFCE114BD37">
            <board type="HVC-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FA704C86" sha1="88919310A4B5433562AB5DF0E3F5FE8FE0A61403">
            <board type="HVC-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="FA73D3A2" sha1="672C7D33CF87A53F7846469DAA789C5EE9D33DDC">
            <board type="NES-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-A" dump="ok" crc="FA74F656" sha1="FB9D508379AEA8FBE0477501C322EFEF0147C397">
            <board type="NES-TLROM" mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FA7E02FA" sha1="E1A37FC82BD0BA7A20B4BC49C22EE82406F66F2F">
            <board mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <wram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FA7EE642" sha1="6590D556E68453BB368472871DFB8CD3A5FE1689">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="FAAD108A" sha1="A50E374A492BB4EF7CEEB17275C538B87E6858DF">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Dendy" dump="unknown" crc="FAF3582F" sha1="901F22C4530F3C0ECC5EE7D329B042AD81F3C067">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="FB0DDDE7" sha1="56FB1AAABA3B8C05452B2D5B8F232FAFB64AC70D">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FB1C0551" sha1="68F558CFF6D8AA33BF5584597BC7E79BBA0F09BD">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FB2F949F" sha1="B4B64E37A86EA5394F94567C6D88712C7F914549">
            <board mapper="112">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FB3439FC" sha1="993B06A960B8EE43A2D5B80AD33D384446FD6317">
            <board type="SACHEN-8259A" mapper="141">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FB69743A" sha1="35E34C7F7370A1CCB34014A62AD526BCC5F2B48B">
            <board type="HVC-SOROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FB8A9B80" sha1="CA429CF9091FCAA1BDACCE0633C4146B7D33A067">
            <board type="HVC-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1A"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FB98D46E" sha1="22D57AC6066529D199FCD299159D94820042C7D0">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="FB98D46E" sha1="22D57AC6066529D199FCD299159D94820042C7D0">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FBD48274" sha1="E8079FCA43A14A78D97EDF90DEFD4E822D4ECB8C">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FBF8A785" sha1="3BAE1F0AD46CAF12838E269665E690BB7DCA9758">
            <board type="NES-AOROM" mapper="7">
                <prg size="128k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FC201C46" sha1="6B9209D9E74F09F29987B85BBF59151B57C43132">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FC2DA286" sha1="E3251BA75A4C74847A90495BDABE23FA620F6206">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FC2F9B2D" sha1="9D5560DA31B39C3A14F5E671B1090489E31C5FF1">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FC3236D1" sha1="30670C049052CD9BB286C9F8C0C149FF7A241130">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FC3E5C86" sha1="4ABE6B51844F9A884BD5ECE64AB0D2B5DBE0E16B">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FC5026EE" sha1="979B2A67E0487D1120454DD69EC0B9E5FC379687">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FC5783A7" sha1="62298489FAF7A482AF33BE307631D7FF5D9003F6">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FC78ACAF" sha1="8971811A774983DE1AB45BF293BE9C50D5707D49">
            <board mapper="90">
                <prg size="128k"/>
                <chr size="512k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FC889532" sha1="BEED4D01527E2A25DC89F8274F82415938361F59">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FCB13110" sha1="0CBCDF7D48A71C44200F4EF9225597992CA1007C">
            <board mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FCB5CB1E" sha1="3DBD3B2C3A107D2FDD5085831ABE8C7EA5601A5A">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FCBF28B1" sha1="F08D61CF09B6794BA7E642AC501614493753BA0F">
            <board type="KONAMI-VRC-4" mapper="23">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="2k"/>
                <chip type="Konami VRC IV">
                    <pin number="3" function="PRG A3"/>
                    <pin number="4" function="PRG A2"/>
                </chip>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FCD772EB" sha1="94A054C4A4C8FAF300C8A9A8EC7AB190332D6DB4">
            <board type="NES-TSROM" mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <chip type="MMC3B"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FCDACA80" sha1="6AE9F6D628BBB23FEE068D1A9ED4DCA12693A229">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FCE408A4" sha1="164F251A952776A3500E84D99186120F44D6F100">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="powerpad"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="FCE71311" sha1="F671AFB307E14D08419E55512D82D38F7F1DA6A8">
            <board type="NES-CNROM" mapper="3">
                <prg size="32k"/>
                <chr size="32k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="FCEBCC5F" sha1="78F45E325E7F5E64E9A0C145F86B800B5BF8F947">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FCED9648" sha1="451C1C6A7910C8AFBCEB8DB73C30FAFA4870A547">
            <board mapper="117">
                <prg size="256k"/>
                <chr size="256k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="FD21F54D" sha1="7031D4124E914C66A831A770A0FBEC873149B250">
            <board type="NES-SGROM" mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FD45E9C1" sha1="7A06EF6867F116CB9217D66813CC6E94E3DA4A33">
            <board mapper="1">
                <prg size="128k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FD46C854" sha1="3EFB64D410367CBD60BCE96E55AC3E4F9ECF4353">
            <board mapper="189">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FD63E7AC" sha1="F771ACBA324678978BEC8A7200D1C19A37504D5C">
            <board type="TENGEN-800030" mapper="206">
                <prg size="128k"/>
                <chr size="64k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FD7E9A7E" sha1="B930D5A94A1E43005B3DB658CA738E724DDF9A48">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FD8D6C75" sha1="DD124B2B5F99408D13212D76728A4DA12EB2732E">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FDB8AA9A" sha1="274ACA5B5276D36ABBB0AB3BFA5BE0EB87689A55">
            <board type="HVC-TLROM" mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <chip type="MMC3C"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FDD89C45" sha1="D25327E0F0D8539AE761DF861254BDE3A60FDD96">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FDDF2135" sha1="36A89DA160D9760F78B891E332F7DCABB6E90E70">
            <board mapper="4">
                <prg size="256k"/>
                <chr size="256k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FDE14CCE" sha1="CC14D1CF59EF632CDB230601D029A5A9758EAB35">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FDE1C7ED" sha1="AD5D1B4330D2B746D758AF10F27362810EB8B103">
            <board type="NES-SLROM" mapper="1">
                <prg size="256k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="ok" crc="FDF4569B" sha1="BC9B2B877A87F8A8FB80513B18BFCF805C462CD2">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="32k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="FDFF80D5" sha1="66883B9EDDEC933E36B6BFF0479CEFD2434FFB40">
            <board type="NES-SEROM" mapper="1">
                <prg size="32k"/>
                <chr size="16k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FE07C1D5" sha1="B726B5C2D295F795DFD15405A9961F67E83DD26F">
            <board mapper="7">
                <prg size="256k"/>
                <vram size="8k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="ok" crc="FE08D602" sha1="397ADFCE82271784C96718F93BD28840C6059EDC">
            <board type="NES-SLROM" mapper="1">
                <prg size="128k"/>
                <chr size="128k"/>
                <chip type="MMC1B2"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FE18E6B6" sha1="8A5E699F33926E521B589025465FD536564902A3">
            <board type="HVC-NROM-256" mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FE3488D1" sha1="800AEFE756E85A0A78CCB4DAE68EBBA5DF24BF41">
            <board mapper="5">
                <prg size="512k"/>
                <chr size="128k"/>
                <wram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FE364BE5" sha1="46C7A91D77DA4362EFDEE1CE61FA1EB641988DD5">
            <board mapper="1">
                <prg size="256k"/>
                <vram size="8k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FE387FE5" sha1="8EAAE25DFB5FAB376C3F2F824DD727FEEA0E4A1D">
            <board type="IREM-G101" mapper="32">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FE4ED42B" sha1="7FEDEA67F9D052E55DA1E64212E70C8A88F7A3E4">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL-B" dump="ok" crc="FE907015" sha1="68B2D42CB1848517106B64D169307A167C58A802">
            <board type="NES-UNROM" mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FE99BBED" sha1="C2DD770D01AD44BB9943B82D367EBC50AA60A8AC">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FEA1CB5D" sha1="5CA47305A98057882E09A07D2BB054C3058CB454">
            <board mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FEBF5DC1" sha1="6EB33EFB0B6BF548C013E773B982803EE1A2BF64">
            <board mapper="0">
                <prg size="32k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <peripherals>
            <device type="zapper"/>
        </peripherals>
        <cartridge system="NES-NTSC" dump="ok" crc="FF24D794" sha1="C200D0BF8914B2116720BF8A29B5521C3CEFA36A">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
        <cartridge system="NES-PAL" dump="ok" crc="FF24D794" sha1="C200D0BF8914B2116720BF8A29B5521C3CEFA36A">
            <board type="NES-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-NTSC" dump="unknown" crc="FF53D73E" sha1="B8A7862C1612AD64B6ED48D6CF54D81DC467982C">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FF5BC685" sha1="C79EE0A0905F9E004FE8B26C13E8662B7427A765">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="128k"/>
            </board>
        </cartridge>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="FF84F552" sha1="7AF6CBA6BF62A7D1B5A5EB310738645064FF9945">
            <board mapper="99">
                <prg size="32k"/>
                <chr size="16k"/>
                <vram size="4k"/>
            </board>
        </arcade>
    </game>
    <game>
        <arcade system="VS-Unisystem" dump="unknown" crc="FFBEF374" sha1="9EB3B75E7B45DF51B8BCD29DF84689A7E8557F4F">
            <board mapper="2">
                <prg size="128k"/>
                <vram size="8k"/>
                <pad h="1" v="0"/>
            </board>
        </arcade>
    </game>
    <game>
        <cartridge system="Famicom" dump="ok" crc="FFD9DB04" sha1="3F6D6FC56EBB64984497916647A9AC41BCF8DB0E">
            <board type="SETA-NROM-128" mapper="0">
                <prg size="16k"/>
                <chr size="8k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="Famicom" dump="unknown" crc="FFE8507E" sha1="F561D6DA26CFED1EA1E583D39100552820D4B015">
            <board mapper="4">
                <prg size="128k"/>
                <chr size="256k"/>
                <wram size="8k" battery="1"/>
            </board>
        </cartridge>
    </game>
    <game>
        <cartridge system="NES-PAL" dump="unknown" crc="FFFDC310" sha1="C8983B705D6A413DEBFDEF1CE1567C11C39E212E">
            <board mapper="79">
                <prg size="32k"/>
                <chr size="64k"/>
                <pad h="0" v="1"/>
            </board>
        </cartridge>
    </game>
</database>
