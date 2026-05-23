Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E7F175A98
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 06:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779519010; cv=pass; b=TQKBddGwtfiwoz67UCs8jhNiYDFaiDWT+yMxMriBm6fIv+pAu/HN+vzuYWpahB8lZrI43p014C0Lk2spjThIMj8QKQfE3K/hlUMqQCrEDqnRf2s8fsk1CCLTcX6+epEEkQwvlCr9tE5dvkBvrVWijEuA1SmYi8QhCBg8RZcGE0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779519010; c=relaxed/simple;
	bh=BCi4hp799JEVlZniYfJtNX9BZy4TJbrCXE7U8Rd0mfM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Blp7nNkA2Rs+Txvhi3L0TTvzFUKaUn/jrdOp0slbmJUI+Tk2u/3gNUuQlqbahKVZM8yIqW4Fjh31rWrFvVdADaE2uMLoxE6SrnMJbwAz0GqzpqWg3Yq5FS+kHbQG7psqunv23Aklg1sgNwn5EBQRVyLA2SeS/edYh1we6Gb0CKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5dA6hUZ; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5dA6hUZ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b5de17382cso66480586d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 23:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779519007; cv=none;
        d=google.com; s=arc-20240605;
        b=Pa9ylOt6CQlBxCvM8HuHaIUDq3ATkYcDZkyBTVhzuye84Vlwtj5EkwM5reMpqlkBJS
         izicTHLzlgEzSKO9hURLnzT9ObM4E1fw7jBwuuXKOID6M9ibYuPM1Ne5LvAaOjwmTEEu
         htdosrbcPmwckA9g91xmB8G7N53qQ9MDqAWEhL9rEe4ltIs8w3eOw6Im0m19+JmXtNSK
         flB01itSU21PPLqW3AyTrEzdlBWUem+AMJCFrdP781H+T9tABt0n3jZbFIkYfClHVcLU
         p9gPiqSQjG14AT463GmOGdfaiw38U1RHEZQVELWIwosw4XhuwotTb4Mr8zjxWACF8q7T
         bulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=BCi4hp799JEVlZniYfJtNX9BZy4TJbrCXE7U8Rd0mfM=;
        fh=5S2S9Euf2bTgtjfC+XlkHgz6uJK00Pr6YKLaCbQAiMA=;
        b=B1nRaQE2YHRnfOadf4AM+KOveetdVcl+LRL1j+hgkZMwpa/RuVHWgVCwywjL/cnkFu
         VyLgnCQiA/8DlNQ1twbCX2H4dD0ba/2i275v3ZMnxLmeJUdrzWa2SEu2g2rt1SylEmv8
         fL+N+WXyIaRKun8eOukbsiv7n6VIr4+iATIUbshRtyCzcuhQdKiwC3ZK8hGYEIeoBwyO
         twWeGUrehroA82M46woqPRkp9h+leFC7UHpgiqMvXVDB/fRLguwW/9TKIeUH7IYu2zeZ
         Pmg50ffP/6ogpHIMQTQL4vlRJNu37RBC0+9Wh+QJrgyvJtbnU+o+xbRyN5yjXOZY8jx7
         t5Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779519007; x=1780123807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BCi4hp799JEVlZniYfJtNX9BZy4TJbrCXE7U8Rd0mfM=;
        b=H5dA6hUZzmwjUrxUtMaodUidoi0p3lX2tneylSq+w7mCrX8HTlESwt6XEd1p6/i7br
         5BorASG/MYFmXGQhM4EG8DsGNCWcXkGIDj2ig8Tda6Oh1QsZgu26StnTYrco/8eX8CUY
         I0+l2no8qiIk9emNsDbQyZHzW5Z5DaBulf7lz9sQSmmTJIL1mY6+gGDCBmEFCMC7q+/c
         s/3kfXSBPO1kDESsCICbmS9IIvZ6zQKrZ+AVVGTZWBHdxSONuG8n9leDxGnWVjxx+C5c
         T8/+5PHlIxQDIIdgmS+yOfr/qBPLdeJizwGYWVft0R9SBEpXLrjjGwVOHpsGC5iR5bQ7
         g5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779519007; x=1780123807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCi4hp799JEVlZniYfJtNX9BZy4TJbrCXE7U8Rd0mfM=;
        b=aELhQGcIorOVahrAR2BfqW2DIwPcfAreFhez4eoyeCeLv77IPK1dSBBUwnvUAYFYim
         OvrvC2NArWaK02MTn3z9DeWruxtPjXGer50x0G4QVnjC0Z7sXims+Cix6BKC/FFkIwNj
         Fm3YnRbvg7Hz8tn1lSFB0P3s3CIqlYRR5F6h7KudW0PSGekmv+F6rHl3ra8hwX5xul6r
         qjc3lKfBP0Hnqpzm6y1GPf1SFdtl+KxugzpS1Z6HZfOUi+PmkBzzRLNw9xQaMsc8U+tN
         n71SSDp45cVMx0twzuc1qBsBmJ5St5wvm9zz4C1W8Zc83LJnNAIbCJ8KQC7ap1ncAEnp
         bkDg==
X-Forwarded-Encrypted: i=1; AFNElJ9iKvYhpAMwQS0mkUMoR8mKd0nfwmEk1JbxObqgtN+CkaKt5/lagEOa+1TqlGhs5ZTcfsYaxHHa0RT57kpT@vger.kernel.org
X-Gm-Message-State: AOJu0YzWtwV8mGe1RfMi06rjdlHMj3C0EyJlscDz/iltUvFmCHGU0KTj
	1XqUhlO5cGqIOKguiuAsJ8vZ2/tm2QRkCbcL7cmoTXgwjaY04/5wECMlxYPvlF4gewTJuffDOc6
	VNWvPBeFptsUyrEte0WJ0oOuCwlOQi2M=
X-Gm-Gg: Acq92OH4/jcm+AXgnrkDzKcX8+R71gh3UxIXZYN8YPD3qktqzzcFwmUv2OK6gA0a9As
	/I1vmXO6C4EACYnwsFHj2lB72WU9p19P8VNac4jpgWj3h6J8y+nily0P8SjLzuIaqHl3r7mH8O7
	C7LNMxl8+gmydJxlJ8QpPp3YpG/BOLYuV+J6yZWv6DHKoi55oVCfbOmIYQQzUSByrNKKCy843Ot
	60G+0u48IIm+Tyn8nmGeyVoVOp/UD3BZ0G2ddK3tx2Sm9VC74ttVmwBtAeSaEsjBh9bA+LvNLZF
	nx+Yx9qJ
X-Received: by 2002:a05:6214:21ad:b0:8bd:4bc7:e19 with SMTP id
 6a1803df08f44-8cc7b5fe2c5mr108615176d6.47.1779519006722; Fri, 22 May 2026
 23:50:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Sun <samsun1006219@gmail.com>
Date: Sat, 23 May 2026 14:49:54 +0800
X-Gm-Features: AVHnY4I-Ob-NalArQ53G3c_sUJAqPnIjXeWWzMeFz3a5Wl_ikLFospVAV7udymI
Message-ID: <CAEkJfYMB47v1yOWHB8q2dc8kf=uj-rLO=+yMyudwPguJ8Kd3jA@mail.gmail.com>
Subject: [BUG] hfs: crafted image can deadlock in hfs_mdb_commit()
To: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear developers and maintainers,

We found a reproducible hung task in HFS with a crafted filesystem
image. The C reproducer and a small proposed patch are included below.
The crash report shows:

INFO: task kworker/1:0:24 blocked in I/O wait for more than 143 seconds.
Not tainted 7.1.0-rc3-00362-g6916d5703ddf-dirty #35
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0 state:D stack:26456 pid:24 tgid:24 ppid:2
task_flags:0x4208060 flags:0x00080000
Workqueue: events_long flush_mdb
Call Trace:
<TASK>
context_switch kernel/sched/core.c:5388 [inline]
__schedule+0x12ae/0x6560 kernel/sched/core.c:7189
__schedule_loop kernel/sched/core.c:7268 [inline]
schedule+0xe7/0x3a0 kernel/sched/core.c:7283
io_schedule+0xbf/0x130 kernel/sched/core.c:8110
bit_wait_io+0x15/0xf0 kernel/sched/wait_bit.c:250
__wait_on_bit_lock+0x12d/0x1c0 kernel/sched/wait_bit.c:93
out_of_line_wait_on_bit_lock+0xda/0x110 kernel/sched/wait_bit.c:120
wait_on_bit_lock_io include/linux/wait_bit.h:221 [inline]
__lock_buffer+0x66/0x70 fs/buffer.c:71
lock_buffer include/linux/buffer_head.h:432 [inline]
hfs_mdb_commit+0xf67/0x1320 fs/hfs/mdb.c:294
process_one_work+0xce3/0x2240 kernel/workqueue.c:3594
process_scheduled_works kernel/workqueue.c:3703 [inline]
worker_thread+0x693/0xeb0 kernel/workqueue.c:3784
kthread+0x38d/0x4a0 kernel/kthread.c:436
ret_from_fork+0xb09/0xdb0 arch/x86/kernel/process.c:158
ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
</TASK>
INFO: task syz-executor:9982 blocked in I/O wait for more than 143 seconds.
Not tainted 7.1.0-rc3-00362-g6916d5703ddf-dirty #35
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor state:D stack:23832 pid:9982 tgid:9982 ppid:1
task_flags:0x400140 flags:0x00080002
Call Trace:
<TASK>
context_switch kernel/sched/core.c:5388 [inline]
__schedule+0x12ae/0x6560 kernel/sched/core.c:7189
__schedule_loop kernel/sched/core.c:7268 [inline]
schedule+0xe7/0x3a0 kernel/sched/core.c:7283
io_schedule+0xbf/0x130 kernel/sched/core.c:8110
bit_wait_io+0x15/0xf0 kernel/sched/wait_bit.c:250
__wait_on_bit_lock+0x12d/0x1c0 kernel/sched/wait_bit.c:93
out_of_line_wait_on_bit_lock+0xda/0x110 kernel/sched/wait_bit.c:120
wait_on_bit_lock_io include/linux/wait_bit.h:221 [inline]
__lock_buffer+0x66/0x70 fs/buffer.c:71
lock_buffer include/linux/buffer_head.h:432 [inline]
hfs_mdb_commit+0x98b/0x1320 fs/hfs/mdb.c:351
hfs_sync_fs+0x1d/0x30 fs/hfs/super.c:38
sync_filesystem fs/sync.c:56 [inline]
sync_filesystem+0x110/0x2a0 fs/sync.c:30
generic_shutdown_super+0x7c/0x390 fs/super.c:625
kill_block_super+0x3b/0x90 fs/super.c:1725
hfs_kill_super+0x3c/0x50 fs/hfs/super.c:441
deactivate_locked_super+0xbf/0x1a0 fs/super.c:476
deactivate_super fs/super.c:509 [inline]
deactivate_super+0xb1/0xd0 fs/super.c:505
cleanup_mnt+0x2df/0x430 fs/namespace.c:1312
task_work_run+0x16b/0x260 kernel/task_work.c:233
resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
__exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
exit_to_user_mode_loop+0x121/0x570 kernel/entry/common.c:98
__exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inl=
ine]
syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
do_syscall_64+0x737/0xf80 arch/x86/entry/syscall_64.c:100
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2289fb703b
RSP: 002b:00007ffd6bc1e668 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f2289fb703b
RDX: 00007f2289e4fb80 RSI: 0000000000000009 RDI: 00007ffd6bc1e720
RBP: 00007ffd6bc1e720 R08: 0000000000000000 R09: 00007ffd6bc1e4f0
R10: 000055559311c673 R11: 0000000000000246 R12: 00007f228a0516f6
R13: 00007ffd6bc1f7f0 R14: 000055559311c600 R15: 00000000000224fb
</TASK>

We analyzed the root cause. The crafted HFS MDB has drVBMSt =3D=3D 2. This
is the same 512-byte block as HFS_MDB_BLK. hfs_mdb_get() accepts the
image and reads the volume bitmap from the same on-disk block as the
MDB. Later, after metadata changes dirty the bitmap, hfs_mdb_commit()
locks HFS_SB(sb)->mdb_bh and then enters the bitmap writeback path. It
reads the bitmap block with sb_bread(); since drVBMSt points to the
MDB block, this returns the same buffer_head. The code then calls
lock_buffer(bh) again while already holding that buffer lock, causing
a self-deadlock.

This appears related to an older syzbot report/discussion:
https://groups.google.com/g/syzkaller-bugs/c/oExrnL7RrHM
https://syzkaller.appspot.com/bug?extid=3D4fec87c399346da35903

That older report was marked fixed after commit 6f861765464f ("fs:
Block writes to mounted block devices"). However, that commit appears
to have blocked or masked that particular reproducer path rather than
validating the HFS MDB layout. The malformed HFS image issue is still
reachable here: the filesystem is accepted with drVBMSt pointing at
the MDB block, and hfs_mdb_commit() can still try to lock the same
buffer_head twice during bitmap writeback.

A possible fix is to reject malformed HFS images whose volume bitmap
range overlaps the MDB block, or more generally maps to the same
buffer_head as the MDB, and also validate that the bitmap range is
within the device/partition bounds and does not overlap the allocation
block area. I included a small proposed patch after the C reproducer
below.

If you have any questions, please let me know.

Best Regards,
Yue

C reproducer:
#define _GNU_SOURCE

#include <dirent.h>
#include <endian.h>
#include <errno.h>
#include <fcntl.h>
#include <setjmp.h>
#include <signal.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/prctl.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

#include <linux/loop.h>

#ifndef __NR_memfd_create
#define __NR_memfd_create 319
#endif

static unsigned long long procid;

static void sleep_ms(uint64_t ms)
{
usleep(ms * 1000);
}

static uint64_t current_time_ms(void)
{
struct timespec ts;
if (clock_gettime(CLOCK_MONOTONIC, &ts))
exit(1);
return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
}

static bool write_file(const char* file, const char* what, ...)
{
char buf[1024];
va_list args;
va_start(args, what);
vsnprintf(buf, sizeof(buf), what, args);
va_end(args);
buf[sizeof(buf) - 1] =3D 0;
int len =3D strlen(buf);
int fd =3D open(file, O_WRONLY | O_CLOEXEC);
if (fd =3D=3D -1)
return false;
if (write(fd, buf, len) !=3D len) {
int err =3D errno;
close(fd);
errno =3D err;
return false;
}
close(fd);
return true;
}

//% This code is derived from puff.{c,h}, found in the zlib development. Th=
e
//% original files come with the following copyright notice:

//% Copyright (C) 2002-2013 Mark Adler, all rights reserved
//% version 2.3, 21 Jan 2013
//% This software is provided 'as-is', without any express or implied
//% warranty. In no event will the author be held liable for any damages
//% arising from the use of this software.
//% Permission is granted to anyone to use this software for any purpose,
//% including commercial applications, and to alter it and redistribute it
//% freely, subject to the following restrictions:
//% 1. The origin of this software must not be misrepresented; you must not
//% claim that you wrote the original software. If you use this software
//% in a product, an acknowledgment in the product documentation would be
//% appreciated but is not required.
//% 2. Altered source versions must be plainly marked as such, and must not=
 be
//% misrepresented as being the original software.
//% 3. This notice may not be removed or altered from any source distributi=
on.
//% Mark Adler madler@alumni.caltech.edu

//% BEGIN CODE DERIVED FROM puff.{c,h}

#define MAXBITS 15
#define MAXLCODES 286
#define MAXDCODES 30
#define MAXCODES (MAXLCODES + MAXDCODES)
#define FIXLCODES 288

struct puff_state {
unsigned char* out;
unsigned long outlen;
unsigned long outcnt;
const unsigned char* in;
unsigned long inlen;
unsigned long incnt;
int bitbuf;
int bitcnt;
jmp_buf env;
};
static int puff_bits(struct puff_state* s, int need)
{
long val =3D s->bitbuf;
while (s->bitcnt < need) {
if (s->incnt =3D=3D s->inlen)
longjmp(s->env, 1);
val |=3D (long)(s->in[s->incnt++]) << s->bitcnt;
s->bitcnt +=3D 8;
}
s->bitbuf =3D (int)(val >> need);
s->bitcnt -=3D need;
return (int)(val & ((1L << need) - 1));
}
static int puff_stored(struct puff_state* s)
{
s->bitbuf =3D 0;
s->bitcnt =3D 0;
if (s->incnt + 4 > s->inlen)
return 2;
unsigned len =3D s->in[s->incnt++];
len |=3D s->in[s->incnt++] << 8;
if (s->in[s->incnt++] !=3D (~len & 0xff) ||
s->in[s->incnt++] !=3D ((~len >> 8) & 0xff))
return -2;
if (s->incnt + len > s->inlen)
return 2;
if (s->outcnt + len > s->outlen)
return 1;
for (; len--; s->outcnt++, s->incnt++) {
if (s->in[s->incnt])
s->out[s->outcnt] =3D s->in[s->incnt];
}
return 0;
}
struct puff_huffman {
short* count;
short* symbol;
};
static int puff_decode(struct puff_state* s, const struct puff_huffman* h)
{
int first =3D 0;
int index =3D 0;
int bitbuf =3D s->bitbuf;
int left =3D s->bitcnt;
int code =3D first =3D index =3D 0;
int len =3D 1;
short* next =3D h->count + 1;
while (1) {
while (left--) {
code |=3D bitbuf & 1;
bitbuf >>=3D 1;
int count =3D *next++;
if (code - count < first) {
s->bitbuf =3D bitbuf;
s->bitcnt =3D (s->bitcnt - len) & 7;
return h->symbol[index + (code - first)];
}
index +=3D count;
first +=3D count;
first <<=3D 1;
code <<=3D 1;
len++;
}
left =3D (MAXBITS + 1) - len;
if (left =3D=3D 0)
break;
if (s->incnt =3D=3D s->inlen)
longjmp(s->env, 1);
bitbuf =3D s->in[s->incnt++];
if (left > 8)
left =3D 8;
}
return -10;
}
static int puff_construct(struct puff_huffman* h, const short* length, int =
n)
{
int len;
for (len =3D 0; len <=3D MAXBITS; len++)
h->count[len] =3D 0;
int symbol;
for (symbol =3D 0; symbol < n; symbol++)
(h->count[length[symbol]])++;
if (h->count[0] =3D=3D n)
return 0;
int left =3D 1;
for (len =3D 1; len <=3D MAXBITS; len++) {
left <<=3D 1;
left -=3D h->count[len];
if (left < 0)
return left;
}
short offs[MAXBITS + 1];
offs[1] =3D 0;
for (len =3D 1; len < MAXBITS; len++)
offs[len + 1] =3D offs[len] + h->count[len];
for (symbol =3D 0; symbol < n; symbol++)
if (length[symbol] !=3D 0)
h->symbol[offs[length[symbol]]++] =3D symbol;
return left;
}
static int puff_codes(struct puff_state* s,
const struct puff_huffman* lencode,
const struct puff_huffman* distcode)
{
static const short lens[29] =3D {
3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31,
35, 43, 51, 59, 67, 83, 99, 115, 131, 163, 195, 227, 258};
static const short lext[29] =3D {
0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2,
3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 0};
static const short dists[30] =3D {
1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193,
257, 385, 513, 769, 1025, 1537, 2049, 3073, 4097, 6145,
8193, 12289, 16385, 24577};
static const short dext[30] =3D {
0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6,
7, 7, 8, 8, 9, 9, 10, 10, 11, 11,
12, 12, 13, 13};
int symbol;
do {
symbol =3D puff_decode(s, lencode);
if (symbol < 0)
return symbol;
if (symbol < 256) {
if (s->outcnt =3D=3D s->outlen)
return 1;
if (symbol)
s->out[s->outcnt] =3D symbol;
s->outcnt++;
} else if (symbol > 256) {
symbol -=3D 257;
if (symbol >=3D 29)
return -10;
int len =3D lens[symbol] + puff_bits(s, lext[symbol]);
symbol =3D puff_decode(s, distcode);
if (symbol < 0)
return symbol;
unsigned dist =3D dists[symbol] + puff_bits(s, dext[symbol]);
if (dist > s->outcnt)
return -11;
if (s->outcnt + len > s->outlen)
return 1;
while (len--) {
if (dist <=3D s->outcnt && s->out[s->outcnt - dist])
s->out[s->outcnt] =3D s->out[s->outcnt - dist];
s->outcnt++;
}
}
} while (symbol !=3D 256);
return 0;
}
static int puff_fixed(struct puff_state* s)
{
static int virgin =3D 1;
static short lencnt[MAXBITS + 1], lensym[FIXLCODES];
static short distcnt[MAXBITS + 1], distsym[MAXDCODES];
static struct puff_huffman lencode, distcode;
if (virgin) {
lencode.count =3D lencnt;
lencode.symbol =3D lensym;
distcode.count =3D distcnt;
distcode.symbol =3D distsym;
short lengths[FIXLCODES];
int symbol;
for (symbol =3D 0; symbol < 144; symbol++)
lengths[symbol] =3D 8;
for (; symbol < 256; symbol++)
lengths[symbol] =3D 9;
for (; symbol < 280; symbol++)
lengths[symbol] =3D 7;
for (; symbol < FIXLCODES; symbol++)
lengths[symbol] =3D 8;
puff_construct(&lencode, lengths, FIXLCODES);
for (symbol =3D 0; symbol < MAXDCODES; symbol++)
lengths[symbol] =3D 5;
puff_construct(&distcode, lengths, MAXDCODES);
virgin =3D 0;
}
return puff_codes(s, &lencode, &distcode);
}
static int puff_dynamic(struct puff_state* s)
{
static const short order[19] =3D
{16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15};
int nlen =3D puff_bits(s, 5) + 257;
int ndist =3D puff_bits(s, 5) + 1;
int ncode =3D puff_bits(s, 4) + 4;
if (nlen > MAXLCODES || ndist > MAXDCODES)
return -3;
short lengths[MAXCODES];
int index;
for (index =3D 0; index < ncode; index++)
lengths[order[index]] =3D puff_bits(s, 3);
for (; index < 19; index++)
lengths[order[index]] =3D 0;
short lencnt[MAXBITS + 1], lensym[MAXLCODES];
struct puff_huffman lencode =3D {lencnt, lensym};
int err =3D puff_construct(&lencode, lengths, 19);
if (err !=3D 0)
return -4;
index =3D 0;
while (index < nlen + ndist) {
int symbol;
int len;
symbol =3D puff_decode(s, &lencode);
if (symbol < 0)
return symbol;
if (symbol < 16)
lengths[index++] =3D symbol;
else {
len =3D 0;
if (symbol =3D=3D 16) {
if (index =3D=3D 0)
return -5;
len =3D lengths[index - 1];
symbol =3D 3 + puff_bits(s, 2);
} else if (symbol =3D=3D 17)
symbol =3D 3 + puff_bits(s, 3);
else
symbol =3D 11 + puff_bits(s, 7);
if (index + symbol > nlen + ndist)
return -6;
while (symbol--)
lengths[index++] =3D len;
}
}
if (lengths[256] =3D=3D 0)
return -9;
err =3D puff_construct(&lencode, lengths, nlen);
if (err && (err < 0 || nlen !=3D lencode.count[0] + lencode.count[1]))
return -7;
short distcnt[MAXBITS + 1], distsym[MAXDCODES];
struct puff_huffman distcode =3D {distcnt, distsym};
err =3D puff_construct(&distcode, lengths + nlen, ndist);
if (err && (err < 0 || ndist !=3D distcode.count[0] + distcode.count[1]))
return -8;
return puff_codes(s, &lencode, &distcode);
}
static int puff(
unsigned char* dest,
unsigned long* destlen,
const unsigned char* source,
unsigned long sourcelen)
{
struct puff_state s =3D {
.out =3D dest,
.outlen =3D *destlen,
.outcnt =3D 0,
.in =3D source,
.inlen =3D sourcelen,
.incnt =3D 0,
.bitbuf =3D 0,
.bitcnt =3D 0,
};
int err;
if (setjmp(s.env) !=3D 0)
err =3D 2;
else {
int last;
do {
last =3D puff_bits(&s, 1);
int type =3D puff_bits(&s, 2);
err =3D type =3D=3D 0 ? puff_stored(&s) : (type =3D=3D 1 ? puff_fixed(&s) :
(type =3D=3D 2 ? puff_dynamic(&s) : -1));
if (err !=3D 0)
break;
} while (!last);
}
*destlen =3D s.outcnt;
return err;
}

//% END CODE DERIVED FROM puff.{c,h}

#define ZLIB_HEADER_WIDTH 2

static int puff_zlib_to_file(const unsigned char* source, unsigned
long sourcelen, int dest_fd)
{
if (sourcelen < ZLIB_HEADER_WIDTH)
return 0;
source +=3D ZLIB_HEADER_WIDTH;
sourcelen -=3D ZLIB_HEADER_WIDTH;
const unsigned long max_destlen =3D 132 << 20;
void* ret =3D mmap(0, max_destlen, PROT_WRITE | PROT_READ, MAP_PRIVATE |
MAP_ANON, -1, 0);
if (ret =3D=3D MAP_FAILED)
return -1;
unsigned char* dest =3D (unsigned char*)ret;
unsigned long destlen =3D max_destlen;
int err =3D puff(dest, &destlen, source, sourcelen);
if (err) {
munmap(dest, max_destlen);
errno =3D -err;
return -1;
}
if (write(dest_fd, dest, destlen) !=3D (ssize_t)destlen) {
munmap(dest, max_destlen);
return -1;
}
return munmap(dest, max_destlen);
}

static int setup_loop_device(unsigned char* data, unsigned long size,
const char* loopname, int* loopfd_p)
{
int err =3D 0, loopfd =3D -1;
int memfd =3D syscall(__NR_memfd_create, "syzkaller", 0);
if (memfd =3D=3D -1) {
err =3D errno;
goto error;
}
if (puff_zlib_to_file(data, size, memfd)) {
err =3D errno;
goto error_close_memfd;
}
loopfd =3D open(loopname, O_RDWR);
if (loopfd =3D=3D -1) {
err =3D errno;
goto error_close_memfd;
}
if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
if (errno !=3D EBUSY) {
err =3D errno;
goto error_close_loop;
}
ioctl(loopfd, LOOP_CLR_FD, 0);
usleep(1000);
if (ioctl(loopfd, LOOP_SET_FD, memfd)) {
err =3D errno;
goto error_close_loop;
}
}
close(memfd);
*loopfd_p =3D loopfd;
return 0;

error_close_loop:
close(loopfd);
error_close_memfd:
close(memfd);
error:
errno =3D err;
return -1;
}

static void reset_loop_device(const char* loopname)
{
int loopfd =3D open(loopname, O_RDWR);
if (loopfd =3D=3D -1) {
return;
}
if (ioctl(loopfd, LOOP_CLR_FD, 0)) {
}
close(loopfd);
}

static long syz_mount_image(
volatile long fsarg,
volatile long dir,
volatile long flags,
volatile long optsarg,
volatile long change_dir,
volatile unsigned long size,
volatile long image)
{
unsigned char* data =3D (unsigned char*)image;
int res =3D -1, err =3D 0, need_loop_device =3D !!size;
char* mount_opts =3D (char*)optsarg;
char* target =3D (char*)dir;
char* fs =3D (char*)fsarg;
char* source =3D NULL;
char loopname[64];
if (need_loop_device) {
int loopfd;
memset(loopname, 0, sizeof(loopname));
snprintf(loopname, sizeof(loopname), "/dev/loop%llu", procid);
if (setup_loop_device(data, size, loopname, &loopfd) =3D=3D -1)
return -1;
close(loopfd);
source =3D loopname;
}
mkdir(target, 0777);
char opts[256];
memset(opts, 0, sizeof(opts));
if (strlen(mount_opts) > (sizeof(opts) - 32)) {
}
strncpy(opts, mount_opts, sizeof(opts) - 32);
if (strcmp(fs, "iso9660") =3D=3D 0) {
flags |=3D MS_RDONLY;
} else if (strncmp(fs, "ext", 3) =3D=3D 0) {
bool has_remount_ro =3D false;
char* remount_ro_start =3D strstr(opts, "errors=3Dremount-ro");
if (remount_ro_start !=3D NULL) {
char after =3D *(remount_ro_start + strlen("errors=3Dremount-ro"));
char before =3D remount_ro_start =3D=3D opts ? '\0' : *(remount_ro_start - =
1);
has_remount_ro =3D ((before =3D=3D '\0' || before =3D=3D ',') && (after =3D=
=3D '\0'
|| after =3D=3D ','));
}
if (strstr(opts, "errors=3Dpanic") || !has_remount_ro)
strcat(opts, ",errors=3Dcontinue");
} else if (strcmp(fs, "xfs") =3D=3D 0) {
strcat(opts, ",nouuid");
} else if (strncmp(fs, "gfs2", 4) =3D=3D 0 && (strstr(opts,
"errors=3Dpanic") || strstr(opts, "debug"))) {
strcat(opts, ",errors=3Dwithdraw");
}
res =3D mount(source, target, fs, flags, opts);
if (res =3D=3D -1) {
err =3D errno;
goto error_clear_loop;
}
res =3D open(target, O_RDONLY | O_DIRECTORY);
if (res =3D=3D -1) {
err =3D errno;
goto error_clear_loop;
}
if (change_dir) {
res =3D chdir(target);
if (res =3D=3D -1) {
err =3D errno;
}
}

error_clear_loop:
if (need_loop_device)
reset_loop_device(loopname);
errno =3D err;
return res;
}

static void kill_and_wait(int pid, int* status)
{
kill(-pid, SIGKILL);
kill(pid, SIGKILL);
for (int i =3D 0; i < 100; i++) {
if (waitpid(-1, status, WNOHANG | __WALL) =3D=3D pid)
return;
usleep(1000);
}
DIR* dir =3D opendir("/sys/fs/fuse/connections");
if (dir) {
for (;;) {
struct dirent* ent =3D readdir(dir);
if (!ent)
break;
if (strcmp(ent->d_name, ".") =3D=3D 0 || strcmp(ent->d_name, "..") =3D=3D 0=
)
continue;
char abort[300];
snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
ent->d_name);
int fd =3D open(abort, O_WRONLY);
if (fd =3D=3D -1) {
continue;
}
if (write(fd, abort, 1) < 0) {
}
close(fd);
}
closedir(dir);
} else {
}
while (waitpid(-1, status, __WALL) !=3D pid) {
}
}

static void reset_loop()
{
char buf[64];
snprintf(buf, sizeof(buf), "/dev/loop%llu", procid);
int loopfd =3D open(buf, O_RDWR);
if (loopfd !=3D -1) {
ioctl(loopfd, LOOP_CLR_FD, 0);
close(loopfd);
}
}

static void setup_test()
{
prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
setpgrp();
write_file("/proc/self/oom_score_adj", "1000");
}

static void execute_one(void);

#define WAIT_FLAGS __WALL

static void loop(void)
{
int iter =3D 0;
for (;; iter++) {
reset_loop();
int pid =3D fork();
if (pid < 0)
exit(1);
if (pid =3D=3D 0) {
setup_test();
execute_one();
exit(0);
}
int status =3D 0;
uint64_t start =3D current_time_ms();
for (;;) {
sleep_ms(10);
if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) =3D=3D pid)
break;
if (current_time_ms() - start < 5000)
continue;
kill_and_wait(pid, &status);
break;
}
}
}

void execute_one(void)
{
if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {}
// syz_mount_image$hfs arguments: [
// fs: ptr[in, buffer] {
// buffer: {68 66 73 00} (length 0x4)
// }
// dir: ptr[in, buffer] {
// buffer: {2e 2f 66 69 6c 65 30 00} (length 0x8)
// }
// flags: mount_flags =3D 0x0 (8 bytes)
// opts: ptr[inout, array[ANYUNION]] {
// array[ANYUNION] {
// union ANYUNION {
// ANYBLOB: buffer: {63 6f 64 65 70 61 67 65 3d 63 70 38 36 32 2c 67
69 64 3d} (length 0x13)
// }
// union ANYUNION {
// ANYRESHEX: ANYRES64 (resource)
// }
// union ANYUNION {
// ANYBLOB: buffer: {2c 69 6f 63 68 61 72 73 65 74 3d 63 70 39 35 30
2c 66 69 6c 65 5f 75 6d 61 73 6b 3d 30 30 30 30 30 30 30 30 30 30 30
30 30 30 30 30 30 30 30 30 37 37 37 2c 66 69 6c 65 5f 75 6d 61 73 6b
3d 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 30 31 30 30
30 2c 67 69 64 3d} (length 0x5b)
// }
// union ANYUNION {
// ANYRESHEX: ANYRES64 (resource)
// }
// union ANYUNION {
// ANYBLOB: buffer: {00 00} (length 0x2)
// }
// }
// }
// chdir: int8 =3D 0x1 (1 bytes)
// size: len =3D 0x2ce (8 bytes)
// img: ptr[in, buffer] {
// buffer: (compressed buffer with length 0x2ce)
// }
// ]
// returns fd_dir
memcpy((void*)0x200000000180, "hfs\000", 4);
memcpy((void*)0x200000000040, "./file0\000", 8);
memcpy((void*)0x200000000240, "codepage=3Dcp862,gid=3D", 19);
sprintf((char*)0x200000000253, "0x%016llx", (long long)0);
memcpy((void*)0x200000000265,
",iocharset=3Dcp950,file_umask=3D00000000000000000000777,file_umask=3D00000=
000000000000001000,gid=3D",
91);
sprintf((char*)0x2000000002c0, "0x%016llx", (long long)0);
memset((void*)0x2000000002d2, 0, 2);
memcpy((void*)0x200000000300,
"\x78\x9c\xec\xdd\xcd\x6e\xd3\x4a\x18\xc6\xf1\x67\x9c\xb4\x4d\x3f\xd4\xe3\x=
7e\x1c\x1d\xe9\x6c\x40\x85\x4a\xb0\x41\x14\x36\x88\x4d\x10\xca\x96\x3d\x2b\=
x04\x34\xa9\x54\x11\x15\x51\x8a\x04\x6c\xa8\x10\x4b\xc4\x05\xb0\xe7\x16\xb8=
\x08\x36\x20\x6e\x00\x56\xac\xb8\x80\xee\x8c\x66\x32\x89\x9d\x64\xe2\x24\xb=
4\x8d\x53\xf8\xff\xa4\x86\xf1\x78\xc6\xf3\x5a\xf6\xd8\xf3\x46\x42\x11\x80\x=
bf\xd6\xed\xda\xb7\x0f\xd7\x7f\xd8\x3f\x23\x95\x14\x49\xba\x29\xf7\x4f\x45\=
x2a\x4b\xfa\x57\xff\x55\x9e\xed\x1d\xec\x1e\x34\x1b\xf5\xbc\x03\x95\x5c\x0f=
\xfb\x67\xd4\xea\x69\xfa\xda\x6c\xef\x35\x42\x5d\x6d\x3f\xd7\xc3\x8b\xed\x5=
6\x59\x4b\xd9\xba\x8c\x70\x2d\x7e\x4b\x92\x24\xb7\xbe\x17\x1d\x04\x0a\xe7\x=
66\x7f\x40\x24\xcd\xf9\x19\xe7\xf6\x57\x26\x1c\xd7\x89\x39\xec\xdb\x3c\x57\=
x54\x28\xd3\xc0\x1c\xe9\x48\xcf\xb5\x5c\x74\x1c\x00\x80\x62\xf9\xf7\x7f\xe4=
\xdf\xf3\x4b\xae\xca\x28\x8a\xa4\x4d\xff\xda\x3f\xdb\xef\xff\x1e\x47\x45\x0=
7\x70\xea\x92\xdc\xbd\x99\xf7\xbf\x5b\xdd\x25\xc6\x5e\xdf\x7f\xdc\xae\x34\x=
df\x73\x29\x9c\xdd\x1f\xb5\xb3\xc4\x51\x46\x9e\xe9\xd9\x9e\x55\xeb\xce\xea\=
x5a\x60\x9a\x61\x59\xa5\x8b\x25\x9a\xdf\xd9\x2d\xeb\xca\xf6\xe3\x66\x3d\xd2=
\x6b\x55\xbd\x4c\xb3\x75\xf7\x59\x6f\xdd\xba\x6d\x43\xa2\xdd\x08\xe4\xa6\x3=
9\xf2\x8e\x76\x67\xa1\x75\x36\x7d\x0b\x4c\x29\x0d\x69\x67\xb7\xd9\x98\xb3\x=
85\x40\xfc\x6b\xe3\x8e\x78\x5c\xe6\x93\xf9\x62\xee\x99\x58\xef\x55\xef\xac\=
xff\xca\x89\xb1\x97\xc9\x5d\xa9\xb8\xe7\x4a\x45\x33\x36\xfe\xab\x81\x43\xf9=
\x87\xc1\xa2\xeb\x65\x5b\xc9\xa7\xfd\xd5\x6a\x35\xea\x6a\xb9\xe2\x06\xf9\xd=
f\x8f\xe0\x0d\x39\xcb\x4a\x38\x23\x51\xfb\x8e\x5a\x49\xbf\x0a\x38\xec\x44\x=
10\x8c\x33\xdb\x6b\xb5\xe7\x0b\x84\xd6\xd9\x6d\x85\xda\x9b\xb4\xd7\x5a\xa8\=
x57\xdc\xd9\x1a\x30\xd6\x7a\x57\xaf\x92\xbf\x13\xdc\xdd\x3c\x38\xca\xd3\x66=
\xde\x99\xbb\x66\x43\x3f\xf5\x51\xb5\xcc\xfa\x3f\xb2\xf1\x6d\x6a\x94\x99\x6=
9\xdb\xb8\x96\xfe\xce\x68\x9d\xcf\x6c\xb8\x65\xd9\xb5\x8c\xfb\xde\x1c\xe9\x=
74\x39\xdf\x89\xc0\x9b\x4b\x87\x19\x6f\xa2\x62\x74\x6f\xf5\x50\x37\xb4\xfc\=
xf4\xc5\xcb\x47\xa5\x66\xb3\xb1\x6f\x0b\x0f\x02\x85\x27\x4b\xfb\xc6\xd7\xcc=
\xbc\x91\x82\x6d\x0a\x2e\xe8\x30\xad\x49\xac\x57\x49\x32\x6a\xf7\xe4\x34\x0=
3\xbb\x7c\xa2\x07\xb4\xcf\x8f\x4e\x8d\x9d\x3e\xa1\xc6\x76\x96\x4d\xc5\x45\x=
19\xa3\xd0\x7e\x32\x4c\x4b\x3c\xc3\x0b\xb5\xcf\xd2\x14\x84\x71\xfc\x42\x92\=
x48\x03\x76\x15\xfc\x7c\xc2\x44\xa4\x17\xdd\x57\xcc\x17\x1c\x10\x26\xcd\xae=
\xbb\x4c\x2b\xff\x73\x2b\x79\xbf\xaa\x73\x2b\x2f\xfb\x11\xe7\xac\xd3\xf3\x9=
3\x4c\x75\x1d\x71\xab\x93\xc1\x75\x2f\x05\x57\xdd\xe7\xc2\x58\x19\xdc\xe2\x=
e0\x85\x61\x66\xc4\x6b\x03\x72\x46\x97\x73\x5d\xb8\x24\x5d\xcc\x54\x1a\xe5\=
x8e\x18\xfb\x38\xff\x10\xa6\xa6\xaf\xba\xcf\xf7\xff\x00\x00\x00\x00\x00\x00=
\x00\x00\x00\x00\x00\x00\x00\x00\x00\x67\xcd\x24\xfe\xa7\x41\xd1\xe7\x08\x0=
0\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xc0\x59\xd7\x=
f3\xfb\xbf\xa5\xe3\xfd\xfe\x6f\x3c\x89\xdf\xff\x05\x70\x42\x7e\x05\x00\x00\=
xff\xff\x04\x3c\x77\xd6",
718);
syz_mount_image(/*fs=3D*/0x200000000180, /*dir=3D*/0x200000000040,
/*flags=3D*/0, /*opts=3D*/0x200000000240, /*chdir=3D*/1, /*size=3D*/0x2ce,
/*img=3D*/0x200000000300);
// open arguments: [
// file: ptr[in, buffer] {
// buffer: {2e 2f 62 75 73 00} (length 0x6)
// }
// flags: open_flags =3D 0x60142 (8 bytes)
// mode: open_mode =3D 0x0 (8 bytes)
// ]
// returns fd
memcpy((void*)0x200000000000, "./bus\000", 6);
syscall(__NR_open, /*file=3D*/0x200000000000ul,
/*flags=3DO_NOFOLLOW|O_NOCTTY|O_NOATIME|O_CREAT|O_RDWR*/0x60142ul,
/*mode=3D*/0ul);

}
int main(void)
{
syscall(__NR_mmap, /*addr=3D*/0x1ffffffff000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
syscall(__NR_mmap, /*addr=3D*/0x200000000000ul, /*len=3D*/0x1000000ul,
/*prot=3DPROT_WRITE|PROT_READ|PROT_EXEC*/7ul,
/*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
syscall(__NR_mmap, /*addr=3D*/0x200001000000ul, /*len=3D*/0x1000ul,
/*prot=3D*/0ul, /*flags=3DMAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/0x32ul,
/*fd=3D*/(intptr_t)-1, /*offset=3D*/0ul);
const char* reason;
(void)reason;
loop();
return 0;
}

Proposed patch:

The patch below rejects invalid volume bitmap layouts during mount. In
particular, it rejects the drVBMSt =3D=3D 2 case from this reproducer and a=
lso
larger-blocksize cases where the bitmap start maps to the same buffer_head =
as
the MDB, preventing hfs_mdb_commit() from recursively locking mdb_bh.

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..59cacb2449f3 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -99,8 +99,10 @@ int hfs_mdb_get(struct super_block *sb)
char *ptr;
int off2, len, size, sect;
sector_t part_start, part_size;
+ sector_t mdb_block, vbm_block;
loff_t off;
__be16 attrib;
+ u32 vbm_start, alblk_start, bitmap_blocks;
/* set the device driver to 512-byte blocks */
size =3D sb_min_blocksize(sb, HFS_SECTOR_SIZE);
@@ -185,6 +187,30 @@ int hfs_mdb_get(struct super_block *sb)
sb->s_flags |=3D SB_RDONLY;
}
+ vbm_start =3D be16_to_cpu(mdb->drVBMSt);
+ alblk_start =3D be16_to_cpu(mdb->drAlBlSt);
+ bitmap_blocks =3D DIV_ROUND_UP(HFS_SB(sb)->fs_ablocks,
+ HFS_SECTOR_SIZE * BITS_PER_BYTE);
+ mdb_block =3D (part_start + HFS_MDB_BLK) >>
+ (sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS);
+ vbm_block =3D (part_start + vbm_start) >>
+ (sb->s_blocksize_bits - HFS_SECTOR_SIZE_BITS);
+ /*
+ * The bitmap is written while mdb_bh is locked. Reject layouts that
+ * would make the bitmap use the same buffer_head as the MDB.
+ */
+ if (!bitmap_blocks ||
+ vbm_start <=3D HFS_MDB_BLK ||
+ vbm_block =3D=3D mdb_block ||
+ alblk_start <=3D vbm_start ||
+ alblk_start >=3D part_size ||
+ bitmap_blocks > alblk_start - vbm_start ||
+ bitmap_blocks > part_size ||
+ vbm_start > part_size - bitmap_blocks) {
+ pr_err("bad volume bitmap location\n");
+ return -EIO;
+ }
+
/* TRY to get the alternate (backup) MDB. */
sect =3D part_start + part_size - 2;
bh =3D sb_bread512(sb, sect, mdb2);
