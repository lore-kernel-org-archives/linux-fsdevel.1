Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9BD3CBE97;
	Thu, 17 Sep 2026 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789630508; cv=none; b=VterXyJSv0WZUHvrlq5V0l4ToxSWbU8iDa5syLimgnv2hPN8xuvC0/lV9DcSoJCmIlX2OKRO0oSpLWNk+RIpMbAL93CD64ESzKFcztvAfpbnToYacamAZ+r7Y8kODciLUeQXlVlv3rzfBDmsEFBoAISdpEn/dcIdFCcNBaBWTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789630508; c=relaxed/simple;
	bh=hZB+bhZlEoRFgisaiEtIoRbMBvVkPK+8hI4I0MHmskE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eri7P4QYJ+7gX7i0MZcaeSCnaaHvancd7orFr6ByCs+q4z4dYdIFtXlYUJhUXCrKO0iOsqKYCgwURRBox7rfHtYnQspzJzT6LHzwbqESFziey8jKzaKgeFoOUYXhcR9zX/uk6RwgzrciTdoQMtjVQSusqVdZHjNYpVNkn+XKMnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z4jSRrUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z4jSRrUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5AD1F000FF;
	Thu, 17 Sep 2026 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789630505;
	bh=8Hwsxw3Y8tkuRMOTDZ90QHilSq8+uYpKRqXQGPabe7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=z4jSRrUKnA67i0ZwDUz8n/4fi1vMBPD76BxSX5ZwUfKN0cYBZsqSOag3JsamYDECu
	 Txryp17UIxmwWST17m4YMQ9kPARpr0JIr2CloOoO5mx46ZjW8DyymC12HkWwkQ62c4
	 0yDO8kXsDboxiszQuRwGB3dPiOPz51vEj8XBqU+k=
Date: Thu, 17 Sep 2026 08:33:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Chris Roy <iam@thechris.in>
Cc: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>,
	dakr@kernel.org, driver-core@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
Message-ID: <2026091753-broadness-bootie-b683@gregkh>
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
 <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
 <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>

On Thu, Sep 17, 2026 at 12:14:05PM +0530, Chris Roy wrote:
> On Wed, 9 Sep 2026 08:19:24 -0700, syzbot wrote:
> > syzbot found the following issue on:
> > ...
> > possible deadlock in ovl_create_object
> 
> Follow-up / v2.
> 
> v1 deferred the open with schedule_work() and an on-stack work_struct.
> That cleared the lockdep cycle, but syzbot reported an ODEBUG warning
> under CONFIG_DEBUG_OBJECTS_WORK.
> 
> v2 uses a dedicated ordered workqueue and heap-allocated work, keeps a
> module reference across the deferred open, flushes the queue before
> exit, and serializes setup on the worker under a local mutex.
> 
> Local testing with the C reproducer (LOCKDEP + DEBUG_OBJECTS_WORK):
> unpatched hits the circular locking warning; v2 is clean.
> 
> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> 
> Please consider the patch for linux-mtd.
> 
> On Thu, 17 Sept 2026 at 03:22, syzbot
> <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > WARNING: ODEBUG bug in lookup_object_or_alloc
> >
> > ODEBUG: object ffffc90007cdf850 is on stack ffffc90007cd8000, but NOT annotated.
> > ------------[ cut here ]------------
> > 1
> > WARNING: lib/debugobjects.c:672 at debug_object_is_on_stack lib/debugobjects.c:672 [inline], CPU#0: syz-executor162/6029
> > WARNING: lib/debugobjects.c:672 at lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705, CPU#0: syz-executor162/6029
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 6029 Comm: syz-executor162 Not tainted syzkaller #0 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:672 [inline]
> > RIP: 0010:lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705
> > Code: c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 c5 01 89 2d a0 1f 7d 1a 4c 89 e6 48 c7 c7 c0 39 62 8c e8 21 ae eb ff 90 <0f> 0b 90 e9 82 31 fe 03 83 c5 01 89 2d 7f 1f 7d 1a 49 39 c4 73 da
> > RSP: 0018:ffffc90007cdf6c0 EFLAGS: 00010082
> > RAX: 0000000000000050 RBX: ffff88802cb1d738 RCX: 0000000000000000
> > RDX: 0000000000000050 RSI: ffffffff81ea1339 RDI: fffff52000f9bec9
> > RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
> > R10: 8000000000000001 R11: 0000000000000001 R12: ffffc90007cdf850
> > R13: ffff888034204b00 R14: 0000000000000000 R15: 0000000000000000
> > FS:  00005555811b5400(0000) GS:ffff8880d5b57000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005555811b8778 CR3: 000000002bbd8000 CR4: 0000000000352ef0
> > Call Trace:
> >  <TASK>
> >  lookup_object_or_alloc lib/debugobjects.c:682 [inline]
> >  __debug_object_init+0x2a9/0x3d0 lib/debugobjects.c:798
> >  __init_work+0x51/0x60 kernel/workqueue.c:697
> >  block2mtd_setup_defer+0xd7/0x1d0 drivers/mtd/devices/block2mtd.c:504
> >  block2mtd_setup+0x9c/0x1e0 drivers/mtd/devices/block2mtd.c:529
> >  param_attr_store+0x199/0x300 kernel/params.c:591
> >  module_attr_store+0x58/0x80 kernel/params.c:906
> >  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
> >  kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
> >  iter_file_splice_write+0x830/0x10b0 fs/splice.c:736
> >  do_splice_from fs/splice.c:936 [inline]
> >  do_splice+0x109c/0x1fa0 fs/splice.c:1349
> >  __do_splice+0x33b/0x370 fs/splice.c:1431
> >  __do_sys_splice fs/splice.c:1634 [inline]
> >  __se_sys_splice fs/splice.c:1616 [inline]
> >  __x64_sys_splice+0x187/0x250 fs/splice.c:1616
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
> >  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fa1c31b3437
> > Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> > RSP: 002b:00007ffce5a2ac20 EFLAGS: 00000202 ORIG_RAX: 0000000000000113
> > RAX: ffffffffffffffda RBX: 00005555811b5400 RCX: 00007fa1c31b3437
> > RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
> > RBP: 00007fa1c31ec0fe R08: 0000000000000026 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000202 R12: 00005555811b7770
> > R13: 0000000000000026 R14: 00007ffce5a2aca0 R15: 0000000000000002
> >  </TASK>
> >
> >
> > Tested on:
> >
> > commit:         238650ef Merge tag 'powerpc-7.3-4' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=143de115580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
> > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ade115580000
> >

> From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> From: Chris Roy <iam@thechris.in>
> Date: Thu, 17 Sep 2026 00:00:00 +0000
> Subject: [PATCH v2] mtd: block2mtd: defer device open out of param/sysfs write
> 
> block2mtd_setup() opens the named block device (VFS path walk) while
> still under param_lock and kernfs_fop_write_iter. When that write
> arrives via splice, a pipe mutex is held as well. That nests under
> locks already ordered the other way with overlay sb_writers /
> ovl_i_mutex and triggers lockdep, for example:
> 
>   sb_writers -> pipe -> kernfs/param -> ovl_i_mutex -> sb_writers
> 
> Drop param_lock and run setup on a dedicated ordered workqueue so the
> open is not nested under that stack. Keep the call synchronous with
> wait_for_completion().
> 
> Changes since v1:
> - allocate work on the heap (v1 tripped DEBUG_OBJECTS_WORK)
> - use a dedicated ordered workqueue instead of system_wq
> - hold a module reference across the deferred open
> - flush and destroy the workqueue before exit teardown
> - serialize setup2 on the worker under block2mtd_mutex
> - keep early-boot paramline updates under that mutex
> 
> Reported-by: syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
> Signed-off-by: Chris Roy <iam@thechris.in>
> ---
>  drivers/mtd/devices/block2mtd.c | 121 ++++++++++++++++++++----
>  1 file changed, 103 insertions(+), 18 deletions(-)

Did you forget the Assisted-by: tag?

> 
> --- a/drivers/mtd/devices/block2mtd.c
> +++ b/drivers/mtd/devices/block2mtd.c
> @@ -27,6 +27,8 @@
>  #include <linux/init.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mutex.h>
> +#include <linux/workqueue.h>
> +#include <linux/completion.h>
>  #include <linux/mount.h>
>  #include <linux/slab.h>
>  #include <linux/major.h>
> @@ -45,6 +47,13 @@
>  
>  /* Static info about the MTD, used in cleanup_module */
>  static LIST_HEAD(blkmtd_device_list);
> +/*
> + * Serializes setup/teardown (including list updates). Never held by a
> + * task that also holds param_lock / kernfs / pipe locks across a VFS open:
> + * deferred setup runs on block2mtd_wq instead.

Make the comments make sense please.  That's the problem of using a LLM :(

thanks,

greg k-h
