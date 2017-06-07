#!/usr/bin/python3
import json
import os
import subprocess
import pexpect
from pexpect import pxssh

def clean_resources(targetinfo):
    ssh = pxssh.pxssh()
    ssh.login(targetinfo['target_ip'],targetinfo['target_user'],targetinfo['target_passwd'])
    rm_string = 'rm ' + targetinfo['target_path'] + targetinfo['program']
    ssh.sendline(rm_string)
    print('removed old resources')

def upload_program(targetinfo):
    upload_string = 'scp ' + targetinfo['program'] + ' ' \
    + targetinfo['target_user'] + '@' + targetinfo['target_ip'] \
    + ':' + targetinfo['target_path'] + targetinfo['program']
    child_process = pexpect.spawn(upload_string)
    if targetinfo['target_passwd'] is not '':
        child_process.expect(' password:')
        child_process.sendline(targetinfo['target_passwd'])
        child_process.expect(pexpect.EOF)
    print('uploaded file')
    input('halt')


def start_gdb_server(targetinfo):
    ssh = pxssh.pxssh()
    log = ssh.login(targetinfo['target_ip'],targetinfo['target_user'],targetinfo['target_passwd'])
    if log is not True:
        print('gdbserver: Error opening ssh tunnel to target')
    gdb_string = 'gdbserver ' + targetinfo['target_ip'] + ':' +\
    targetinfo['target_port'] + ' ' + targetinfo['target_path'] + targetinfo['program'] +\
    ' > /dev/ttyO0' #redirect program output do shell O0
    s = ssh.sendline(gdb_string)
    print('gdbserver: ',ssh.before.decode('ascii'))
    return ssh

def start_gdb_client(targetinfo):
    #make sure there is a .gdbinit file else create one
    try:
        f = open('./.gdbinit','r')
    except FileNotFoundError:
        f = open('./.gdbinit','w+')
        gdb_string = 'target remote ' + targetinfo['target_ip'] + ':' +\
        targetinfo['target_port']
        f.write(gdb_string)
        f.close()
        f = open('./.gdbinit','r')
    f.close()
    command_string = '--command=gdb-multiarch ' + targetinfo['program']
    subprocess.Popen(['gnome-terminal',command_string])
    print('gdbclient started')


if __name__ == '__main__':
    targetfile = open("./targetinfo","r")
    targetraw = targetfile.read()
    #echo file content to user
    #print(targetraw)
    targetinfo = json.loads(targetraw)
    
    clean_resources(targetinfo)
    upload_program(targetinfo)
    server_ssh = start_gdb_server(targetinfo)
    start_gdb_client(targetinfo)
    r = input('press enter key to quit')


