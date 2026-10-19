Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF673C4565
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383579; cv=none; b=ntHcka7AqubBAeYUEbFG4s1RHk5LARp+bCygTu3m8xz3/cHAYzjoSuIiTdMHz9LudnTp2VhaO9s1lWs1wGO9KPGLn5OpzHeitZV3/PIFq4M+NGNTkUih8YOW9Ao8p5syb42s5s0tCe5+Diw2pO/NfgewgYmd5bpNZqquoSsHjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383579; c=relaxed/simple;
	bh=rRVr7SqY4aYBU8eWtubbZiH7FbDsY/A2wV5s15LEf30=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pa0dM/pq7CcJB4m95zOA3dBzaBRrb5Ttb2aSO93WK7yveKOxI3mxLYesYk1JjXLZyalmnelibF3givMww7coHi0doVj2dluRU/7QKBk0HWzdCUDe0Ghdex7olIenoSLZG3W0O7D5b7UTR8GYuV8lA1syQckoHBqDO/Wui8M9iuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-70339873137so2041536eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 21:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383575; x=1792988375;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKlBBKRXtPxCd4xX1MhFyP3fgh/Oxz3wsitSIBI6Yw8=;
        b=FnU8BeY5aCVoABin8vfOtyd6D/WeuCHyCdTXTQUmHtYuxhwCavy+cx0Lmg0Ig5/qfE
         JNbkUJlssM/Djk9G3U0Kg5jDhjYmp0HBDYUroI2/o1KGWuZZIEHM5Vvz6qQWE0XclwVi
         waV8tMfi0LQucJgLaiSSafxVXb7QfZuHqwwPUpzJX9+87sj8/HlKDokZ93W2pDFGX2w7
         tadif7Bl+V5+5cDPeT45MgHszSq4bG1ORN6gR3KNQ1DUo2i2xEo7nyPYPaXuDd7TqOqk
         uZ3ciP/jTz/K4hWWTCSmshqF06EDfgChCMPDLe7Pagi+MaWIGI2GVY3t5KTuIqKtc5Si
         bmTQ==
X-Gm-Message-State: AFq9FYJqosCDsHrZn1cg7df0JsSVRBWUxIQOMOv3LbvXZ/UwV+/1XVSX
	GUtggKTK1f2Ih2fpg8mpuAlW633oSiepT7JRz4iGQsnV6OcU8yzbNn8jWPOyWzOQiBMYf06QsB4
	pCHcoVyA7Ghhtpfd6Wz4cE5oGWH52KD8hllgFpkYFwZmzUA6QRfQn79AqKh8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1517:b0:6d3:abd1:9b98 with SMTP id
 006d021491bc7-70117627040mr6008277eaf.62.1792383574902; Sun, 18 Oct 2026
 21:19:34 -0700 (PDT)
Date: Sun, 18 Oct 2026 21:19:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad59a56.6814cce4.34c49f.0150.GAE@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel paging request in read_seqbegin
From: syzbot <syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a19f0cc94ad Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16514121580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=26d6221a572842ac
dashboard link: https://syzkaller.appspot.com/bug?extid=975ace299d6ba2eb1cea
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16003da9580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address dfff800000000002
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[dfff800000000002] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 5047 Comm: syz-executor213 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/14/2026
pstate: 834000c5 (Nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : kasan_byte_accessible+0xc/0x1c mm/kasan/generic.c:210
lr : __kasan_check_byte+0x20/0x54 mm/kasan/common.c:584
sp : ffff80009b3a6c20
x29: ffff80009b3a6c20 x28: ffff80008979a000 x27: ffff0000d7079d80
x26: a4ec800080d875c8 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000002 x22: 0000000000000010 x21: 0000000000000010
x20: 0000000000000000 x19: ffff800080d875c8 x18: ffff80011b89c000
x17: ffff0001a4ff9e07 x16: ffff0000d7079d94 x15: ffff800080302e5c
x14: 0000000000494166 x13: 0000000000000009 x12: 0000000000000009
x11: ffff800080155740 x10: 0000000000000003 x9 : dfff800000000000
x8 : 0000000000000002 x7 : 0000000000000000 x6 : ffff800080d86228
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000002
x2 : 0000000000000000 x1 : ffff800080d875c8 x0 : 0000000000000010
Call trace:
 kasan_mem_to_shadow include/linux/kasan.h:65 [inline] (P)
 kasan_byte_accessible+0xc/0x1c mm/kasan/generic.c:210 (P)
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0xa4/0x320 kernel/locking/lockdep.c:5916
 seqcount_lockdep_reader_access include/linux/seqlock.h:73 [inline]
 read_seqbegin+0x6c/0x144 include/linux/seqlock.h:838
 get_fs_root_rcu fs/d_path.c:244 [inline]
 d_path+0x224/0x4dc fs/d_path.c:287
 audit_log_d_path+0xdc/0x19c kernel/audit.c:2221
 audit_log_lsm_data+0xe0/0x12d0 security/lsm_audit.c:199
 dump_common_audit_data security/lsm_audit.c:421 [inline]
 common_lsm_audit+0x1d0/0x290 security/lsm_audit.c:451
 smack_log+0x1f4/0x264 security/smack/smack_access.c:400
 smk_tskacc+0x210/0x2ac security/smack/smack_access.c:255
 smack_file_open+0x1d0/0x230 security/smack/smack_lsm.c:2078
 security_file_open+0xec/0x258 security/security.c:2739
 do_dentry_open+0x2a8/0xfbc fs/open.c:973
 vfs_open+0x44/0x2dc fs/open.c:1101
 dentry_open+0x74/0xc0 fs/open.c:1124
 ima_calc_file_hash+0x120/0x5cc security/integrity/ima/ima_crypto.c:269
 ima_collect_measurement+0x420/0x874 security/integrity/ima/ima_api.c:300
 ima_update_xattr+0x160/0x230 security/integrity/ima/ima_appraise.c:617
 ima_check_last_writer security/integrity/ima/ima_main.c:227 [inline]
 ima_file_free+0x40c/0x528 security/integrity/ima/ima_main.c:251
 security_file_release+0x84/0x148 security/security.c:2424
 __fput+0x2c4/0x74c fs/file_table.c:506
 ____fput+0x20/0x30 fs/file_table.c:541
 task_work_run+0x1cc/0x25c kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x58c/0x1a74 kernel/exit.c:986
 do_group_exit+0x198/0x238 kernel/exit.c:1129
 __do_sys_exit_group kernel/exit.c:1140 [inline]
 __se_sys_exit_group kernel/exit.c:1138 [inline]
 pid_child_should_wake+0x0/0x104 kernel/exit.c:1138
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x19c/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:796
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:815
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
Code: 17ffffec d343fc08 d2d00009 f2fbffe9 (38696908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	17ffffec 	b	0xffffffffffffffb0
   4:	d343fc08 	lsr	x8, x0, #3
   8:	d2d00009 	mov	x9, #0x800000000000        	// #140737488355328
   c:	f2fbffe9 	movk	x9, #0xdfff, lsl #48
* 10:	38696908 	ldrb	w8, [x8, x9] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
