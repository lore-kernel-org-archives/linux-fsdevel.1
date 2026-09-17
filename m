Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AC43C05B
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 06:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627459; cv=pass; b=cVTFih7/ptRwcNhtO6ZoJE9D02Wrk5OUcgoaOcWTByjNPTc0OoKOi4Vl9jEJDRrHPuusytwMuC6IFt4Roo5gf/CgU36mbSCiN2njDoBXXmWqPpKu6QEKyAQbPGDJV9J4IFAPNaJUOp2HUyqLAvN2oeXn32lRK5uyAf14A1GPmi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627459; c=relaxed/simple;
	bh=OYoeypdEaeBPbLXudMcOvMuB6nW1x+Epkr9nWTAOK+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pToz+eZHnQy0UzyDeVjTwqNOEoN2oyPydLvby4kqCmgr0bF8tql2TIvJPZTYT9Hq4oA70tVEyGr0vKl8Dk+vDIuxg7dQ3DN9LUpZkmLe30RJv5bUYkYM4kPfrxp42Slqy8VXwXl4cW+dbWbrp8ccqz1X+09Cxo/XFBbt4D8D0xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in; spf=pass smtp.mailfrom=thechris.in; dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b=cA4Jfuhk; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thechris.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b="cA4Jfuhk"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdcaso2620717b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 23:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789627456; cv=none;
        d=google.com; s=arc-20260327;
        b=H5rLNiHGQzMeX24CusXx6PkJ18HUC3kcVuOwOZ0qjfU3L0/YXHb0Rqtk/Jk01QhZjY
         43Ky2T+wSe9MhTbWMISrkgTYwc8NrVxK4uuB0msdZFQ8AZzs4a2c0hlJQoLkyWI/H0Rj
         dktHOceHXwEXKvDqQq1JLt63LCpgTnx0yp+0mszQHewjvoTh6Nlpi6zOOkhXUKDpnp9E
         eS3HRua/PWEM30+OqgpVcHICmjlFREjKh8ZlM3lDUYM+ylLvvGMU+7TR4f4lOxpZDMyY
         ba4H9M9DL8CTnN86cYR/V49F4h2efzIYKqvqU0HXzBExbR+SbtcQhoT6tP2hCn7nCDIq
         BNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dM4zSalLHfI5dc2Rdq0rUbgr1XpQxX6X6hnZ+gfRnbM=;
        fh=4+fzanpbHsWAbP/X/3Xvue5MeUsf//y/uI1N/Ybs+lg=;
        b=JuRRbBsK7SwzhKHgRxyoAz2VsFp5wIEahn45t1NC49b4F12HtiD72hLOi4b3Oc7TS1
         hTeLYQf9Hi+Jk0DH5d/BeZrlbcxl4PaRqowx6C9YTwLIDSui53pgJJGcSNQ8VbCyKZVD
         qFj9Z1QXWA56/zJj2ce0lNgCQLFW33FFEE4ytiOublnewcZTdHGhqOGbZ165EefggZyh
         /cVKskFav49W8k+Jh3qixk6e40qpwHDDZd5GUDhHTZDrosBdT/gYmZ7N7iMuqRHebeE1
         Un7l74+kFP0La/NJ6PqYpTKqyJBThZk5MlwDF1CEQKv0yPNKhx0wS5iNhwbi2XIwk/RB
         Qfww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thechris.in; s=google; t=1789627456; x=1790232256; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dM4zSalLHfI5dc2Rdq0rUbgr1XpQxX6X6hnZ+gfRnbM=;
        b=cA4JfuhkmodvXR2d1OXbRlibgjZ92wycIPxcOsAC5KT5yO8NPbq3dosLyO/QQ5oBc0
         6tXvzrS9nB63fAvcBy/oqfAUu+4ykkFH+yY8DtSaxSeekf7MF7Zebpy4NyqF5fRKu3Lm
         jxZurX87o2EeurIGQMy3dKGBsPzLBk2IZkqOuCKk5FQ2TBqZ4mY/4p8IXWzJwZv5P22O
         PnCzibjiLV2rO5UVBC8dgsQFO83gVM1KzdcJRNVn92U9klgCIAUu/YsrfF6VgbEgdUtO
         BmpFGKVaUq0/k4+6F5qOO0nw7NFuMzJUt7i7aquvjX9+xJdHUsoJ1PMh/0WACKHqODju
         shqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627456; x=1790232256;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dM4zSalLHfI5dc2Rdq0rUbgr1XpQxX6X6hnZ+gfRnbM=;
        b=qQAzo8DVMDniFy536vSsuFj0kjGVO/o/XcnX7WbpBlX7n8mT8rlWbwJaojnhKYaWlf
         AMvL89DQe041KoNEn8tE2+BUV5R0LXz+nmzCPzPQxifSn7mHeHagjp3qK0Z/zyJ2dqRV
         ecMAts1jdclE16aPi9gevYZYXnwBiSHsFICxBXtEuBtsVUlmzXfUEarz9pbzHU/RMRRA
         tq4zf70/Fc9EfqELKC9/Xtq+vCC0OyAGPoVZ0hvd2MmVoD+xaiBaJFhf9sBi+o3f4jrR
         zx1uS2izxKXIIwRTBmFeRJip7EfYKC+xlweB+ZDtL09qWV5Rtu/xW/mjhVOOUs//31bI
         BTsA==
X-Forwarded-Encrypted: i=1; AKwUvByIh6VLckzNOy1z/7EBDd4zgou537DxcI72Hlq7lgzMTdqgFG1SUk9Oo/vW3izrF+KmKVjWR2MZTR/fOR65@vger.kernel.org
X-Gm-Message-State: AFuF++ky/t+30st7ijXhqPveLOHAuXx8tbDRNPONcR5OAliXgLs8ZXtE
	rUSIKTC/HedJRLMy1tHCIiEVUYRQtEF21QjCIrW5ZkzrYfIlWZNn+DaRlaWzouejidZ4krCjOho
	4xUvaJ+FRzr/DngVs8ykhF4DoymQTYqc4R/yqNLC4x5o=
X-Gm-Gg: AYBFou0wHAWL05s/bkRp6G0xGi7ODUhE3TKV7czkzxt996bL7XUWWZFH/c7wn41ldkL
	NgzBgdbTY/29G16ZpJtQNBz0LRRGUt7uviX+R74TH9meMPsAgKbGEod0i8AhWq4zMJ8p00W0PQN
	ZtdHZbge7tYJUIXhyxg/rf8PVfIhYIPS11n2+U0aR6cmpRTmlZp+wXZDF9PmrA0Goppu6PaelMQ
	d/3Q9L1Ioi33Ui01sjTzE/VbC65X+9/Hz6+dIF/81vhfO5/0jeZNKVrmOCI/xxUWqD/+HJxA1jd
	fdpT2JQltBOOOFMRJer5XvceIkpgPNUowOzBlWsyNUPRUwX+RWKnv9y0KinmBDbXdY9q5cl0wM9
	yG9jZjdoq4kXty0aAbud6eIcn1VzLjq12PLFCd/ITnoYxbfOM8gzQ3p0bLVGeVcuRGL/HrPRUHR
	nac5m/oRUyjUkUkmA=
X-Received: by 2002:a05:690c:e3eb:b0:882:1d1e:d763 with SMTP id
 00721157ae682-892216f4ba4mr21823597b3.9.1789627456418; Wed, 16 Sep 2026
 23:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
 <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
In-Reply-To: <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com>
From: Chris Roy <iam@thechris.in>
Date: Thu, 17 Sep 2026 12:14:05 +0530
X-Gm-Features: AcwNN1XTJuEp6MytV6y-s-Nr4st4GwH2XBWGKH7rAzgEfJoOFYiRyyv3Hkbtv80
Message-ID: <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
To: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>
Cc: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000d25a28065ba81c0a"

--000000000000d25a28065ba81c0a
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sep 2026 08:19:24 -0700, syzbot wrote:
> syzbot found the following issue on:
> ...
> possible deadlock in ovl_create_object

Follow-up / v2.

v1 deferred the open with schedule_work() and an on-stack work_struct.
That cleared the lockdep cycle, but syzbot reported an ODEBUG warning
under CONFIG_DEBUG_OBJECTS_WORK.

v2 uses a dedicated ordered workqueue and heap-allocated work, keeps a
module reference across the deferred open, flushes the queue before
exit, and serializes setup on the worker under a local mutex.

Local testing with the C reproducer (LOCKDEP + DEBUG_OBJECTS_WORK):
unpatched hits the circular locking warning; v2 is clean.

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

Please consider the patch for linux-mtd.

On Thu, 17 Sept 2026 at 03:22, syzbot
<syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING: ODEBUG bug in lookup_object_or_alloc
>
> ODEBUG: object ffffc90007cdf850 is on stack ffffc90007cd8000, but NOT annotated.
> ------------[ cut here ]------------
> 1
> WARNING: lib/debugobjects.c:672 at debug_object_is_on_stack lib/debugobjects.c:672 [inline], CPU#0: syz-executor162/6029
> WARNING: lib/debugobjects.c:672 at lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705, CPU#0: syz-executor162/6029
> Modules linked in:
> CPU: 0 UID: 0 PID: 6029 Comm: syz-executor162 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:debug_object_is_on_stack lib/debugobjects.c:672 [inline]
> RIP: 0010:lookup_object_or_alloc.part.0.cold+0x19/0x40 lib/debugobjects.c:705
> Code: c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 83 c5 01 89 2d a0 1f 7d 1a 4c 89 e6 48 c7 c7 c0 39 62 8c e8 21 ae eb ff 90 <0f> 0b 90 e9 82 31 fe 03 83 c5 01 89 2d 7f 1f 7d 1a 49 39 c4 73 da
> RSP: 0018:ffffc90007cdf6c0 EFLAGS: 00010082
> RAX: 0000000000000050 RBX: ffff88802cb1d738 RCX: 0000000000000000
> RDX: 0000000000000050 RSI: ffffffff81ea1339 RDI: fffff52000f9bec9
> RBP: 0000000000000001 R08: 0000000000000007 R09: 0000000000000000
> R10: 8000000000000001 R11: 0000000000000001 R12: ffffc90007cdf850
> R13: ffff888034204b00 R14: 0000000000000000 R15: 0000000000000000
> FS:  00005555811b5400(0000) GS:ffff8880d5b57000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555811b8778 CR3: 000000002bbd8000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  lookup_object_or_alloc lib/debugobjects.c:682 [inline]
>  __debug_object_init+0x2a9/0x3d0 lib/debugobjects.c:798
>  __init_work+0x51/0x60 kernel/workqueue.c:697
>  block2mtd_setup_defer+0xd7/0x1d0 drivers/mtd/devices/block2mtd.c:504
>  block2mtd_setup+0x9c/0x1e0 drivers/mtd/devices/block2mtd.c:529
>  param_attr_store+0x199/0x300 kernel/params.c:591
>  module_attr_store+0x58/0x80 kernel/params.c:906
>  sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
>  kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
>  iter_file_splice_write+0x830/0x10b0 fs/splice.c:736
>  do_splice_from fs/splice.c:936 [inline]
>  do_splice+0x109c/0x1fa0 fs/splice.c:1349
>  __do_splice+0x33b/0x370 fs/splice.c:1431
>  __do_sys_splice fs/splice.c:1634 [inline]
>  __se_sys_splice fs/splice.c:1616 [inline]
>  __x64_sys_splice+0x187/0x250 fs/splice.c:1616
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa1c31b3437
> Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
> RSP: 002b:00007ffce5a2ac20 EFLAGS: 00000202 ORIG_RAX: 0000000000000113
> RAX: ffffffffffffffda RBX: 00005555811b5400 RCX: 00007fa1c31b3437
> RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007fa1c31ec0fe R08: 0000000000000026 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 00005555811b7770
> R13: 0000000000000026 R14: 00007ffce5a2aca0 R15: 0000000000000002
>  </TASK>
>
>
> Tested on:
>
> commit:         238650ef Merge tag 'powerpc-7.3-4' of git://git.kernel..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=143de115580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
> dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ade115580000
>

--000000000000d25a28065ba81c0a
Content-Type: text/x-diff; charset="US-ASCII"; 
	name="0001-mtd-block2mtd-defer-device-open-out-of-param-sysfs-w.patch"
Content-Disposition: attachment; 
	filename="0001-mtd-block2mtd-defer-device-open-out-of-param-sysfs-w.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mu55hjeu0>
X-Attachment-Id: f_mu55hjeu0

RnJvbSAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpcyBSb3kgPGlhbUB0aGVjaHJpcy5pbj4KRGF0ZTogVGh1
LCAxNyBTZXAgMjAyNiAwMDowMDowMCArMDAwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIG10ZDogYmxv
Y2sybXRkOiBkZWZlciBkZXZpY2Ugb3BlbiBvdXQgb2YgcGFyYW0vc3lzZnMgd3JpdGUKCmJsb2Nr
Mm10ZF9zZXR1cCgpIG9wZW5zIHRoZSBuYW1lZCBibG9jayBkZXZpY2UgKFZGUyBwYXRoIHdhbGsp
IHdoaWxlCnN0aWxsIHVuZGVyIHBhcmFtX2xvY2sgYW5kIGtlcm5mc19mb3Bfd3JpdGVfaXRlci4g
V2hlbiB0aGF0IHdyaXRlCmFycml2ZXMgdmlhIHNwbGljZSwgYSBwaXBlIG11dGV4IGlzIGhlbGQg
YXMgd2VsbC4gVGhhdCBuZXN0cyB1bmRlcgpsb2NrcyBhbHJlYWR5IG9yZGVyZWQgdGhlIG90aGVy
IHdheSB3aXRoIG92ZXJsYXkgc2Jfd3JpdGVycyAvCm92bF9pX211dGV4IGFuZCB0cmlnZ2VycyBs
b2NrZGVwLCBmb3IgZXhhbXBsZToKCiAgc2Jfd3JpdGVycyAtPiBwaXBlIC0+IGtlcm5mcy9wYXJh
bSAtPiBvdmxfaV9tdXRleCAtPiBzYl93cml0ZXJzCgpEcm9wIHBhcmFtX2xvY2sgYW5kIHJ1biBz
ZXR1cCBvbiBhIGRlZGljYXRlZCBvcmRlcmVkIHdvcmtxdWV1ZSBzbyB0aGUKb3BlbiBpcyBub3Qg
bmVzdGVkIHVuZGVyIHRoYXQgc3RhY2suIEtlZXAgdGhlIGNhbGwgc3luY2hyb25vdXMgd2l0aAp3
YWl0X2Zvcl9jb21wbGV0aW9uKCkuCgpDaGFuZ2VzIHNpbmNlIHYxOgotIGFsbG9jYXRlIHdvcmsg
b24gdGhlIGhlYXAgKHYxIHRyaXBwZWQgREVCVUdfT0JKRUNUU19XT1JLKQotIHVzZSBhIGRlZGlj
YXRlZCBvcmRlcmVkIHdvcmtxdWV1ZSBpbnN0ZWFkIG9mIHN5c3RlbV93cQotIGhvbGQgYSBtb2R1
bGUgcmVmZXJlbmNlIGFjcm9zcyB0aGUgZGVmZXJyZWQgb3BlbgotIGZsdXNoIGFuZCBkZXN0cm95
IHRoZSB3b3JrcXVldWUgYmVmb3JlIGV4aXQgdGVhcmRvd24KLSBzZXJpYWxpemUgc2V0dXAyIG9u
IHRoZSB3b3JrZXIgdW5kZXIgYmxvY2sybXRkX211dGV4Ci0ga2VlcCBlYXJseS1ib290IHBhcmFt
bGluZSB1cGRhdGVzIHVuZGVyIHRoYXQgbXV0ZXgKClJlcG9ydGVkLWJ5OiBzeXpib3QrN2NhYjZh
MTk2MTlmMWI4ZWZjMDBAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD03Y2FiNmExOTYxOWYxYjhlZmMwMApTaWdu
ZWQtb2ZmLWJ5OiBDaHJpcyBSb3kgPGlhbUB0aGVjaHJpcy5pbj4KLS0tCiBkcml2ZXJzL210ZC9k
ZXZpY2VzL2Jsb2NrMm10ZC5jIHwgMTIxICsrKysrKysrKysrKysrKysrKysrLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDEwMyBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCi0tLSBhL2RyaXZl
cnMvbXRkL2RldmljZXMvYmxvY2sybXRkLmMKKysrIGIvZHJpdmVycy9tdGQvZGV2aWNlcy9ibG9j
azJtdGQuYwpAQCAtMjcsNiArMjcsOCBAQAogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4KICNpbmNs
dWRlIDxsaW51eC9tdGQvbXRkLmg+CiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4KKyNpbmNsdWRl
IDxsaW51eC93b3JrcXVldWUuaD4KKyNpbmNsdWRlIDxsaW51eC9jb21wbGV0aW9uLmg+CiAjaW5j
bHVkZSA8bGludXgvbW91bnQuaD4KICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8
bGludXgvbWFqb3IuaD4KQEAgLTQ1LDYgKzQ3LDEzIEBACiAKIC8qIFN0YXRpYyBpbmZvIGFib3V0
IHRoZSBNVEQsIHVzZWQgaW4gY2xlYW51cF9tb2R1bGUgKi8KIHN0YXRpYyBMSVNUX0hFQUQoYmxr
bXRkX2RldmljZV9saXN0KTsKKy8qCisgKiBTZXJpYWxpemVzIHNldHVwL3RlYXJkb3duIChpbmNs
dWRpbmcgbGlzdCB1cGRhdGVzKS4gTmV2ZXIgaGVsZCBieSBhCisgKiB0YXNrIHRoYXQgYWxzbyBo
b2xkcyBwYXJhbV9sb2NrIC8ga2VybmZzIC8gcGlwZSBsb2NrcyBhY3Jvc3MgYSBWRlMgb3BlbjoK
KyAqIGRlZmVycmVkIHNldHVwIHJ1bnMgb24gYmxvY2sybXRkX3dxIGluc3RlYWQuCisgKi8KK3N0
YXRpYyBERUZJTkVfTVVURVgoYmxvY2sybXRkX211dGV4KTsKK3N0YXRpYyBzdHJ1Y3Qgd29ya3F1
ZXVlX3N0cnVjdCAqYmxvY2sybXRkX3dxOwogCiAKIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqcGFnZV9y
ZWFkKHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90IGluZGV4KQpAQCAtNDYx
LDMxICs0NzAsMTAxIEBACiAJcmV0dXJuIDA7CiB9CiAKK3N0cnVjdCBibG9jazJtdGRfc2V0dXBf
d29yayB7CisJc3RydWN0IHdvcmtfc3RydWN0IHdvcms7CisJc3RydWN0IGNvbXBsZXRpb24gZG9u
ZTsKKwljaGFyICp2YWw7CisJaW50IHJldDsKK307CisKK3N0YXRpYyB2b2lkIGJsb2NrMm10ZF9z
ZXR1cF93b3JrZm4oc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQoreworCXN0cnVjdCBibG9jazJt
dGRfc2V0dXBfd29yayAqdyA9CisJCWNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgYmxvY2sybXRk
X3NldHVwX3dvcmssIHdvcmspOworCisJbXV0ZXhfbG9jaygmYmxvY2sybXRkX211dGV4KTsKKwl3
LT5yZXQgPSBibG9jazJtdGRfc2V0dXAyKHctPnZhbCk7CisJbXV0ZXhfdW5sb2NrKCZibG9jazJt
dGRfbXV0ZXgpOworCWNvbXBsZXRlKCZ3LT5kb25lKTsKK30KKworLyoKKyAqIFJ1biBkZXZpY2Ug
c2V0dXAgb24gYmxvY2sybXRkX3dxIHNvIHRoZSBWRlMgb3BlbiBpcyBub3QgbmVzdGVkIHVuZGVy
CisgKiBwYXJhbV9sb2NrLCB0aGUga2VybmZzIHdyaXRlIGlub2RlIG11dGV4LCBvciBhIHNwbGlj
ZSBwaXBlIGxvY2suCisgKiBXb3JrIGlzIGhlYXAtYWxsb2NhdGVkIChub3Qgb24tc3RhY2spIGZv
ciBDT05GSUdfREVCVUdfT0JKRUNUU19XT1JLLgorICogQ2FsbGVyIG11c3QgaG9sZCBhIG1vZHVs
ZSByZWZlcmVuY2UgdW50aWwgdGhpcyByZXR1cm5zLgorICovCitzdGF0aWMgaW50IGJsb2NrMm10
ZF9zZXR1cF9kZWZlcihjb25zdCBjaGFyICp2YWwpCit7CisJc3RydWN0IGJsb2NrMm10ZF9zZXR1
cF93b3JrICp3OworCWludCByZXQ7CisKKwlpZiAoIWJsb2NrMm10ZF93cSkKKwkJcmV0dXJuIC1F
Tk9ERVY7CisKKwl3ID0ga3phbGxvYyhzaXplb2YoKncpLCBHRlBfS0VSTkVMKTsKKwlpZiAoIXcp
CisJCXJldHVybiAtRU5PTUVNOworCisJdy0+dmFsID0ga3N0cmR1cCh2YWwsIEdGUF9LRVJORUwp
OworCWlmICghdy0+dmFsKSB7CisJCWtmcmVlKHcpOworCQlyZXR1cm4gLUVOT01FTTsKKwl9CisK
Kwlpbml0X2NvbXBsZXRpb24oJnctPmRvbmUpOworCUlOSVRfV09SSygmdy0+d29yaywgYmxvY2sy
bXRkX3NldHVwX3dvcmtmbik7CisJcXVldWVfd29yayhibG9jazJtdGRfd3EsICZ3LT53b3JrKTsK
Kwl3YWl0X2Zvcl9jb21wbGV0aW9uKCZ3LT5kb25lKTsKKworCXJldCA9IHctPnJldDsKKwlrZnJl
ZSh3LT52YWwpOworCWtmcmVlKHcpOworCXJldHVybiByZXQ7Cit9CiAKIHN0YXRpYyBpbnQgYmxv
Y2sybXRkX3NldHVwKGNvbnN0IGNoYXIgKnZhbCwgY29uc3Qgc3RydWN0IGtlcm5lbF9wYXJhbSAq
a3ApCiB7Ci0jaWZkZWYgTU9EVUxFCi0JcmV0dXJuIGJsb2NrMm10ZF9zZXR1cDIodmFsKTsKLSNl
bHNlCi0JLyogSWYgbW9yZSBwYXJhbWV0ZXJzIGFyZSBsYXRlciBwYXNzZWQgaW4gdmlhCi0JICAg
L3N5cy9tb2R1bGUvYmxvY2sybXRkL3BhcmFtZXRlcnMvYmxvY2sybXRkCi0JICAgYW5kIGJsb2Nr
Mm10ZF9pbml0KCkgaGFzIGFscmVhZHkgYmVlbiBjYWxsZWQsCi0JICAgd2UgY2FuIHBhcnNlIHRo
ZSBhcmd1bWVudCBub3cuICovCi0KLQlpZiAoYmxvY2sybXRkX2luaXRfY2FsbGVkKQotCQlyZXR1
cm4gYmxvY2sybXRkX3NldHVwMih2YWwpOwotCi0JLyogRHVyaW5nIGVhcmx5IGJvb3Qgc3RhZ2Us
IHdlIG9ubHkgc2F2ZSB0aGUgcGFyYW1ldGVycwotCSAgIGhlcmUuIFdlIG11c3QgcGFyc2UgdGhl
bSBsYXRlcjogaWYgdGhlIHBhcmFtIHBhc3NlZAotCSAgIGZyb20ga2VybmVsIGJvb3QgY29tbWFu
ZCBsaW5lLCBibG9jazJtdGRfc2V0dXAoKSBpcwotCSAgIGNhbGxlZCBzbyBlYXJseSB0aGF0IGl0
IGlzIG5vdCBwb3NzaWJsZSB0byByZXNvbHZlCi0JICAgdGhlIGRldmljZSAoZXZlbiBrbWFsbG9j
KCkgZmFpbHMpLiBEZXRlciB0aGF0IHdvcmsgdG8KLQkgICBibG9jazJtdGRfc2V0dXAyKCkuICov
CisJaW50IHJldCA9IDA7CiAKLQlzdHJzY3B5KGJsb2NrMm10ZF9wYXJhbWxpbmUsIHZhbCwgc2l6
ZW9mKGJsb2NrMm10ZF9wYXJhbWxpbmUpKTsKKwlpZiAoIXRyeV9tb2R1bGVfZ2V0KGtwLT5tb2Qp
KQorCQlyZXR1cm4gLUVOT0RFVjsKIAotCXJldHVybiAwOworCS8qCisJICogTGVhdmUgcGFyYW1f
bG9jayBiZWZvcmUgYW55IHBhdGggdGhhdCBtYXkgb3BlbiBhIGJsb2NrIGRldmljZS4KKwkgKiBT
eXNmcy9zcGxpY2UgbG9ja3MgYXJlIHN0aWxsIGhlbGQgaGVyZSwgc28gYWZ0ZXIgaW5pdCB3ZSBt
dXN0CisJICogYm91bmNlIHRvIGJsb2NrMm10ZF93cSByYXRoZXIgdGhhbiBjYWxsaW5nIHNldHVw
MiBpbi10YXNrLgorCSAqLworCWtlcm5lbF9wYXJhbV91bmxvY2soa3AtPm1vZCk7CisKKyNpZm5k
ZWYgTU9EVUxFCisJbXV0ZXhfbG9jaygmYmxvY2sybXRkX211dGV4KTsKKwlpZiAoIWJsb2NrMm10
ZF9pbml0X2NhbGxlZCkgeworCQkvKiBFYXJseSBib290OiBjYW5ub3QgcmVzb2x2ZSBibG9jayBk
ZXZpY2VzIHlldC4gKi8KKwkJc3Ryc2NweShibG9jazJtdGRfcGFyYW1saW5lLCB2YWwsIHNpemVv
ZihibG9jazJtdGRfcGFyYW1saW5lKSk7CisJCW11dGV4X3VubG9jaygmYmxvY2sybXRkX211dGV4
KTsKKwkJa2VybmVsX3BhcmFtX2xvY2soa3AtPm1vZCk7CisJCW1vZHVsZV9wdXQoa3AtPm1vZCk7
CisJCXJldHVybiAwOworCX0KKwltdXRleF91bmxvY2soJmJsb2NrMm10ZF9tdXRleCk7CiAjZW5k
aWYKKworCWlmIChibG9jazJtdGRfd3EpIHsKKwkJcmV0ID0gYmxvY2sybXRkX3NldHVwX2RlZmVy
KHZhbCk7CisJfSBlbHNlIHsKKwkJLyoKKwkJICogTW9kdWxlIHBhcmFtZXRlciBhcHBsaWVkIGJl
Zm9yZSBtb2R1bGVfaW5pdCAoaW5zbW9kCisJCSAqIGFyZ3MpOiBubyBzeXNmcy9zcGxpY2UgbmVz
dGluZyBvbiB0aGlzIHBhdGguCisJCSAqLworCQltdXRleF9sb2NrKCZibG9jazJtdGRfbXV0ZXgp
OworCQlyZXQgPSBibG9jazJtdGRfc2V0dXAyKHZhbCk7CisJCW11dGV4X3VubG9jaygmYmxvY2sy
bXRkX211dGV4KTsKKwl9CisKKwlrZXJuZWxfcGFyYW1fbG9jayhrcC0+bW9kKTsKKwltb2R1bGVf
cHV0KGtwLT5tb2QpOworCXJldHVybiByZXQ7CiB9CiAKIApAQCAtNDk2LDEwICs1NzUsMjAgQEAK
IHsKIAlpbnQgcmV0ID0gMDsKIAorCWJsb2NrMm10ZF93cSA9IGFsbG9jX29yZGVyZWRfd29ya3F1
ZXVlKCJibG9jazJtdGQiLCAwKTsKKwlpZiAoIWJsb2NrMm10ZF93cSkKKwkJcmV0dXJuIC1FTk9N
RU07CisKICNpZm5kZWYgTU9EVUxFCisJbXV0ZXhfbG9jaygmYmxvY2sybXRkX211dGV4KTsKIAlp
ZiAoc3RybGVuKGJsb2NrMm10ZF9wYXJhbWxpbmUpKQogCQlyZXQgPSBibG9jazJtdGRfc2V0dXAy
KGJsb2NrMm10ZF9wYXJhbWxpbmUpOworCS8qCisJICogUHVibGlzaCBhZnRlciBlYXJseSBwYXJh
bWxpbmUgaXMgY29uc3VtZWQgc28gYSBjb25jdXJyZW50CisJICogc3lzZnMgd3JpdGUgY2Fubm90
IHJhY2UgdGhlIGJ1ZmZlciB2cyBpbml0X2NhbGxlZC4KKwkgKi8KIAlibG9jazJtdGRfaW5pdF9j
YWxsZWQgPSAxOworCW11dGV4X3VubG9jaygmYmxvY2sybXRkX211dGV4KTsKICNlbmRpZgogCiAJ
cmV0dXJuIHJldDsKQEAgLTUxMCw5ICs1OTksMTYgQEAKIHsKIAlzdHJ1Y3QgbGlzdF9oZWFkICpw
b3MsICpuZXh0OwogCi0JLyogUmVtb3ZlIHRoZSBNVEQgZGV2aWNlcyAqLworCWlmIChibG9jazJt
dGRfd3EpIHsKKwkJZmx1c2hfd29ya3F1ZXVlKGJsb2NrMm10ZF93cSk7CisJCWRlc3Ryb3lfd29y
a3F1ZXVlKGJsb2NrMm10ZF93cSk7CisJCWJsb2NrMm10ZF93cSA9IE5VTEw7CisJfQorCisJbXV0
ZXhfbG9jaygmYmxvY2sybXRkX211dGV4KTsKIAlsaXN0X2Zvcl9lYWNoX3NhZmUocG9zLCBuZXh0
LCAmYmxrbXRkX2RldmljZV9saXN0KSB7CiAJCXN0cnVjdCBibG9jazJtdGRfZGV2ICpkZXYgPSBs
aXN0X2VudHJ5KHBvcywgdHlwZW9mKCpkZXYpLCBsaXN0KTsKKwogCQlibG9jazJtdGRfc3luYygm
ZGV2LT5tdGQpOwogCQltdGRfZGV2aWNlX3VucmVnaXN0ZXIoJmRldi0+bXRkKTsKIAkJbXV0ZXhf
ZGVzdHJveSgmZGV2LT53cml0ZV9tdXRleCk7CkBAIC01MjIsNiArNjE4LDcgQEAKIAkJbGlzdF9k
ZWwoJmRldi0+bGlzdCk7CiAJCWJsb2NrMm10ZF9mcmVlX2RldmljZShkZXYpOwogCX0KKwltdXRl
eF91bmxvY2soJmJsb2NrMm10ZF9tdXRleCk7CiB9CiAKIGxhdGVfaW5pdGNhbGwoYmxvY2sybXRk
X2luaXQpOwo=
--000000000000d25a28065ba81c0a--
