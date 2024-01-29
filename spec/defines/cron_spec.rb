require 'spec_helper'
describe 'types::cron' do
  context 'cron with bare minimum specified' do
    let(:title) { 'cronjob-1' }
    let(:params) { { command: '/usr/local/bin/script.sh' } }
    let(:facts) { { osfamily: 'RedHat' } }

    it do
      is_expected.to contain_cron('cronjob-1').with(
        {
          'ensure'  => 'present',
          'command' => '/usr/local/bin/script.sh',
        },
      )
    end
  end

  context 'cron with all options specified' do
    let(:title) { 'cronjob-1' }
    let(:params) do
      {
        command:     '/usr/local/bin/script.sh',
        ensure:      'absent',
        environment: '/bin:/usr/bin',
        hour:        '1',
        minute:      '10',
        month:       'Jan',
        monthday:    '1',
        provider:    'crontab',
        special:     'absent',
        target:      'root',
        user:        'root',
        weekday:     '6',
      }
    end
    let(:facts) { { osfamily: 'RedHat' } }

    it do
      is_expected.to contain_cron('cronjob-1').only_with(
        {
          'ensure'      => 'absent',
          'command'     => '/usr/local/bin/script.sh',
          'environment' => '/bin:/usr/bin',
          'hour'        => '1',
          'minute'      => '10',
          'month'       => 'Jan',
          'monthday'    => '1',
          'provider'    => 'crontab',
          'special'     => 'absent',
          'target'      => 'root',
          'user'        => 'root',
          'weekday'     => '6',
        },
      )
    end
  end

  context 'with periodic attributs specified as valid array containing integers' do
    let(:title) { 'array_with_integers' }
    let(:params) do
      {
        command:  '/usr/local/bin/array_with_integers.sh',
        hour:     [6, 9],
        minute:   [2, 42],
        month:    [2, 3],
        monthday: [3, 6],
        weekday:  [0, 3],
        special:  [1, 42],
      }
    end

    it do
      is_expected.to contain_cron('array_with_integers').with(
        {
          'ensure'   => 'present',
          'command'  => '/usr/local/bin/array_with_integers.sh',
          'hour'     => [6, 9],
          'minute'   => [2, 42],
          'month'    => [2, 3],
          'monthday' => [3, 6],
          'weekday'  => [0, 3],
          'special'  => [1, 42],
        },
      )
    end
  end

  context 'with periodic attributs specified as valid array containing strings' do
    let(:title) { 'array_with_integers' }
    let(:params) do
      {
        command:  '/usr/local/bin/array_with_strings.sh',
        hour:     ['6, 9'],
        minute:   ['*/2', '*/42'],
        month:    ['*/2'],
        monthday: ['3', '6'],
        weekday:  ['0'],
        special:  ['1', '42'],
      }
    end

    it do
      is_expected.to contain_cron('array_with_integers').with(
        {
          'ensure'   => 'present',
          'command'  => '/usr/local/bin/array_with_strings.sh',
          'hour'     => ['6, 9'],
          'minute'   => ['*/2', '*/42'],
          'month'    => ['*/2'],
          'monthday' => ['3', '6'],
          'weekday'  => ['0'],
          'special'  => ['1', '42'],
        },
      )
    end
  end

  context 'with periodic attributs specified as valid strings' do
    let(:title) { 'strings' }
    let(:params) do
      {
        command:  '/usr/local/bin/strings.sh',
        hour:     '3',
        minute:   '*/42',
        month:    '*/2',
        monthday: '3',
        weekday:  '0',
        special:  '1',
      }
    end

    it do
      is_expected.to contain_cron('strings').with(
        {
          'ensure'   => 'present',
          'command'  => '/usr/local/bin/strings.sh',
          'hour'     => '3',
          'minute'   => '*/42',
          'month'    => '*/2',
          'monthday' => '3',
          'weekday'  => '0',
          'special'  => '1',
        },
      )
    end
  end

  context 'with periodic attributs specified as valid integers' do
    let(:title) { 'integers' }
    let(:params) do
      {
        command: '/usr/local/bin/integers.sh',
        hour:     3,
        minute:   42,
        month:    2,
        monthday: 3,
        weekday:  0,
        special:  1,
      }
    end

    it do
      is_expected.to contain_cron('integers').with(
        {
          'ensure'   => 'present',
          'command'  => '/usr/local/bin/integers.sh',
          'hour'     => 3,
          'minute'   => 42,
          'month'    => 2,
          'monthday' => 3,
          'weekday'  => 0,
          'special'  => 1,
        },
      )
    end
  end

  context 'cron with invalid ensure' do
    let(:title) { 'invalid' }
    let(:params) do
      {
        command: '/usr/local/bin/script',
        hour: '2',
        minute: '0',
        ensure: '!invalid',
      }
    end

    it 'fails' do
      expect {
        is_expected.to contain_class('types')
      }.to raise_error(Puppet::Error, %r{expects a match for Enum})
    end
  end
end
