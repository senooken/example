: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
: \file      cmdsh-ja.cmd
: \author    SENOO, KEN
: \copyright CC0
: \date      Created: 2021-01-02T16:37+09:00
: \sa        https://senooken.jp/post/2021/01/08/
: \brief     sh/cmd.exe�݊��X�N���v�g (���{��Ή�)�B
: 
: sh/cmd.exe���Ή��X�N���v�g�œ��{����g�p����ꍇ�C�ȉ��̓_�ɒ��ӂ���B
: 
: 1. ���s�R�[�h=CRLF
: 2. �����G���R�[�f�B���O=Shift_JIS or CP932 (Windows 932)
: 3. sh��CR (\r) �����s�Ƃ݂Ȃ���Ȃ����߁C�s����#�ŃR�����g�A�E�g
: ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
: ��s1
: <<-"EOC"
@echo off
echo cmd.exe ����ɂ��́B
exit /b
EOC
# ��s2
echo sh ����ɂ��́B #