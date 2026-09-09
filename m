Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD84367F25
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977561; cv=pass; b=ANyEHzNrxiLo2MgKLs7YkXWY7p/XkA1SG/IfwPdIPkqoq5Skn9U1CDK8H/ujPoY5M4X/NE1m4J2yCfUgYtgLRWZpJgyqX/NVOymyYfBkJPGnUorclRweVTBHbI7gqfGtNMPwekTpFwfW2YPEcSz24Yt3bi/w/v17zOpaQ8cAUgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977561; c=relaxed/simple;
	bh=tNvGn7haK9J0L3LWimMU6l3mZKIYf+jC4wZcaZEiniQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ov7U6OZ3cDFQgsF9FyRZCSn2W4LbbrBIfAoHIO5t/2CQgE2u06+T7RLKyGV6sUfLZaOtdjV3quM2+OKSNc/quZg7KY0nLAOVFW3AKgaxukCJnVeokw0XGOB0M7zXN8JrElSDHTHnhmZjW5XiznnMnoh165+lhdnivSh5Sh4THsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=CNHLLx9t; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="CNHLLx9t"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5c675e64ffcso106236e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 11:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788977558; cv=none;
        d=google.com; s=arc-20260327;
        b=lh8tmX0cnCuHXezde3hh5oKXH2lW/EuhxXHkFjTQSq9gUIVYA4jo7taRlZu+WcgdAG
         JiALTQs+9/ikD0pjmLGOUdYrCCNEkxBxBBjyPFdwOB0fE1kXmPv3ZVx5aryHJN/iJRNg
         WNMycduAT+2oY/zCzgVZUrt7ueOjndc6ZgxhTMJLynTBlJfh+XM/RAungI1XLvWz5pNy
         gJ7+26C4IlDzZV1060VzncEXtIqgiXe1FD2gfulW4+uEpxaXpVU+xZiEOzgTQXSvimkA
         WoFFTF5FLtCHQruzJGvzDw0OiBbl2/cGul3m3weCmqOhhw41bTI6fsPHdyOT03DcaTIn
         +Vkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yL+XSVxjxz7cWBilTpUgwOesm0mEem6CcPc0U6hjdp4=;
        fh=M7gPHk0YyNPiBKpjpEFzGJF10GRxf6bC7zlMOL/vBD4=;
        b=PyHYsMm41p38gY4BrK6p3S8/5WSX8YTOBmZD6r1d3S4yOs87DdrEAnlaj29ylo/W+o
         /jHo8A4E7HyQQaIWgdMHMZ9Tsr9aL/GDUd8KzUAd165j/H2phGgOV30pdEZ0PKFqqLay
         pBlRJMMGg39yoJiNLZneKkcTs79W4pIPX+0O+lyI5KNdl8gZ35S/WAdG7K+UK3Y9dR1w
         VZh8hzZDtz3Renx72o14Zcg9W7KUJQWkcWKwhee+FC1Et/sir58dY1KHqTFRvSyUB0Sb
         db7iDeHObL+rrXPxkBqy79pA+o5OM6R4miFkL6TF1DDGfEJadk0J4Aa3WoJi0QfalVzq
         Ts9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1788977558; x=1789582358; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yL+XSVxjxz7cWBilTpUgwOesm0mEem6CcPc0U6hjdp4=;
        b=CNHLLx9tfIHld81Nv7h3F13WU7Oy4dnYy9B02uyP3RZ2nSe/7H1auz20OHFucSULFM
         iL1Srsz2imoI5y6KMtkuVsgw4GcoxH8hBlRTv/Vfc3uQv2A8vabNteHHNk1JdWTlNx+t
         TYk8wSaU8C9Y0ByqeiRE4u10P9IJlX1g2n3Ye13Bq9aAcy+VZgDAIPykNPmH1V4mjpjV
         fgVZKJjwdi7Pl559+HrcyC/r62fDKZj4ECUzEfpe/gVxbkJYQcAg2qFVn3/X8+5azthT
         uaZngVGeCUJu8RtraRw/SLYC3AthU8FrUn8PHH/+x4VIvlUTVz3ANpPeA5SEGPnSULlP
         YrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977558; x=1789582358;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yL+XSVxjxz7cWBilTpUgwOesm0mEem6CcPc0U6hjdp4=;
        b=O3OY/ScyPfhHLHnppZxVJYUroQgx3KFavO02hx774iPGCEB1VAfxSjgz4aiplB9RU8
         CGJZ8LfON+QvuKS/Vq791tG6YyPp+rqv6/NzNCbqTik2AO8NgT0ZhZCWInaDrvkDWcZv
         szdmDu5GZxo73jdJqhpPJnTHFbIlDy2GQGvjivrVjh+VNgrpleCY7Z/nzCd8yY9SQL1O
         SUVFxP5Nk10/FKRxOYmGoJWQwgXkL4hX8YCfrAh3XA3kqS2YI4DSYvMQOfj5hOFWLPGS
         LQbIpMJ+wd4mWwmZ0kN4wDboZoWCK5hokm4DOsZkxoU0aKvvrbIh7lod2NYpPKgq+Aq3
         /Hcg==
X-Forwarded-Encrypted: i=1; AKwUvByUP1AiUm7reWzmARiJeGAIWZXphDOnSuauA6JhfD9MLS3hDxCys5L/1qXc3qhSP5U2ukIVqcqyclwjGoYb@vger.kernel.org
X-Gm-Message-State: AFuF++moj3SBgSXsQIpaBfNGHVMEa3QkX7tBlBLZTiVPr1PN/6xbGMFz
	Rmyh8bdJ6CVaX1jLiPWQkDtB4vLBZxc/1Hc/7EuObxmW9MEjRrlPCPPIBRd6ZAA1rG7Mq16XN6j
	RTuug6BGba62ZJCF7Q+5JiSIjN1LtIhBECr6C2HLw
X-Gm-Gg: AYBFou3QcSEe7X2LPURWFQqNeWCddWVaQfb5sm+q+3lYuzvS7gLjfaLKgdBdiVTqQLY
	CAlYJl1USIltJ4APw47QkKIi5g4+hHaiS6Wl4FFMiAPQhRZGCxqt8EYAPeOl4HEl0eYZ9fWH8aV
	9SuIbvFG9Le5Fnv6S0brr4IwYRM9OGcqALY04BypDLJyfCIwRaqJrI5nNwbbMLziVKx+5dFKIY0
	ztpZiVqyyBcCT4m46WniVgc9Qm14J+K6W+1KANVMs1i6SXcNZUQPMzHr+NHkJfk5UzF8ZcKXjwc
	ELKuw944vdbte1dor/x3rNXkBHyTISIdwpatv3wcq9MN0oDhCOLRNULeLF17jC2yQ063ssa7Bk3
	hRmDGoi/avDqJvKKGTeThJCikK4HesiNFCWNQHi8Y
X-Received: by 2002:a05:6122:3301:b0:5c4:4ec2:971c with SMTP id
 71dfb90a1353d-5c837d72af3mr217440e0c.10.1788977556510; Wed, 09 Sep 2026
 11:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+0ovChcGF2nsf0iJNGXM79iGv2fKEqYi4DGQ55aygBcKg2NGQ@mail.gmail.com>
 <3266510.1788349255@warthog.procyon.org.uk>
In-Reply-To: <3266510.1788349255@warthog.procyon.org.uk>
From: Farhad Alemi <farhad.alemi@berkeley.edu>
Date: Wed, 9 Sep 2026 11:12:24 -0700
X-Gm-Features: AcwNN1WIPwk0QFyTFi9VEmgoQtVVkN3_8azm25ce1m8qQFTh0Qi3WYkXcmcgpLQ
Message-ID: <CA+0ovCiVkYwJJbXo3rnWke3MT4etn7QdpsWah13sw12q28myrw@mail.gmail.com>
Subject: Re: [BUG] afs: ERR_PTR dereference in afs_lookup_server() error path
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>, falemi@asu.edu, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c5f19c065b10cb46"

--000000000000c5f19c065b10cb46
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Tried it w 7.3.0-rc2-00006-g28924df2a08f:

[   43.872155][ T9500] BUG: unable to handle page fault for address:
ffffffffffffffb1
[   43.873156][ T9500] #PF: supervisor read access in kernel mode
[   43.873889][ T9500] #PF: error_code(0x0000) - not-present page
[   43.874619][ T9500] PGD e94b067 P4D e94b067 PUD e94d067 PMD 0
[   43.875371][ T9500] Oops: Oops: 0000 [#1] SMP KASAN NOPTI
[   43.876050][ T9500] CPU: 1 UID: 0 PID: 9500 Comm: repro Not tainted
7.3.0-rc2-00006-g28924df2a08f #1 PREEMPT(full)
[   43.877196][ T9500] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS 1.17.0-debian-1.17.0-1ubuntu1 04/01/2014
[   43.878156][ T9500] RIP: 0010:afs_put_addrlist+0x3c/0x110
[   43.878682][ T9500] Code: aa 39 17 fe 4d 85 f6 74 7d 49 8d 7e 18 48
89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 0f
85 af 00 00 00 <41> 8b 6e 18 4d 8d 66 10 4c 89 e7 be 04 00 00 00 e8 9f
35 87 fe 41
[   43.880425][ T9500] RSP: 0018:ffffc90007b67618 EFLAGS: 00010246
[   43.880980][ T9500] RAX: 0000000000000000 RBX: 0000000000000009
RCX: dffffc0000000000
[   43.881803][ T9500] RDX: 0000000000000000 RSI: 0000000000000009
RDI: ffffffffffffffb1
[   43.882537][ T9500] RBP: 0000000000000000 R08: ffff88810ea66a87
R09: 1ffff11021d4cd50
[   43.883253][ T9500] R10: dffffc0000000000 R11: ffffed1021d4cd51
R12: ffff88810d211000
[   43.883970][ T9500] R13: ffff88810ea66800 R14: ffffffffffffff99
R15: ffffffffffffff99
[   43.884688][ T9500] FS:  000000003957f400(0000)
GS:ffff8881da58b000(0000) knlGS:0000000000000000
[   43.885493][ T9500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.886088][ T9500] CR2: ffffffffffffffb1 CR3: 0000000113534000
CR4: 0000000000752ef0
[   43.886811][ T9500] PKRU: 55555554
[   43.887141][ T9500] Call Trace:
[   43.887456][ T9500]  <TASK>
[   43.887733][ T9500]  afs_lookup_server+0xe0a/0x1120
[   43.888196][ T9500]  ? afs_alloc_server_list+0x7da/0x1140
[   43.888704][ T9500]  afs_alloc_server_list+0x7da/0x1140
[   43.889196][ T9500]  ? __pfx_afs_alloc_server_list+0x10/0x10
[   43.889754][ T9500]  ? __raw_spin_lock_init+0x45/0x100
[   43.890262][ T9500]  ? afs_create_volume+0x96d/0x1130
[   43.890766][ T9500]  afs_create_volume+0x994/0x1130
[   43.891294][ T9500]  ? __pfx_afs_create_volume+0x10/0x10
[   43.891791][ T9500]  ? __asan_memset+0x22/0x50
[   43.892221][ T9500]  afs_cell_detect_alias+0x41d/0x1170
[   43.892719][ T9500]  ? __pfx_afs_cell_detect_alias+0x10/0x10
[   43.893249][ T9500]  ? afs_request_key+0x1c8/0x250
[   43.893708][ T9500]  ? __mutex_unlock_slowpath+0x731/0x900
[   43.894230][ T9500]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
[   43.894781][ T9500]  ? afs_request_key+0x13c/0x250
[   43.895235][ T9500]  afs_get_tree+0x24b/0x12b0
[   43.895665][ T9500]  vfs_get_tree+0x92/0x2a0
[   43.896077][ T9500]  do_new_mount+0x341/0xd30
[   43.896498][ T9500]  ? apparmor_capable+0x126/0x170
[   43.896960][ T9500]  ? __pfx_do_new_mount+0x10/0x10
[   43.897422][ T9500]  ? ns_capable+0x89/0xe0
[   43.897821][ T9500]  ? user_path_at+0xd4/0x160
[   43.898254][ T9500]  __se_sys_mount+0x31d/0x420
[   43.898689][ T9500]  ? __pfx___se_sys_mount+0x10/0x10
[   43.899164][ T9500]  ? __x64_sys_mount+0x20/0xc0
[   43.899606][ T9500]  do_syscall_64+0x155/0x510
[   43.900033][ T9500]  ? trace_irq_disable+0x3b/0x140
[   43.900499][ T9500]  ? entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.901051][ T9500]  ? clear_bhb_loop+0x30/0x80
[   43.901554][ T9500]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   43.902093][ T9500] RIP: 0033:0x426ffe
[   43.902464][ T9500] Code: 0a 00 01 00 00 00 eb 85 e8 0f 09 00 00 66
2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 f3 0f 1e fa 49 89 ca b8 a5
00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8
64 89 01 48
[   43.904183][ T9500] RSP: 002b:00007fff93751b68 EFLAGS: 00000207
ORIG_RAX: 00000000000000a5
[   43.904940][ T9500] RAX: ffffffffffffffda RBX: 0000000000000001
RCX: 0000000000426ffe
[   43.905655][ T9500] RDX: 00000000004a2103 RSI: 00000000004a20fa
RDI: 00000000004a2107
[   43.906369][ T9500] RBP: 00007fff93751b90 R08: 0000000000000000
R09: 0000000000000000
[   43.907082][ T9500] R10: 0000000000000000 R11: 0000000000000207
R12: 00007fff93751cb8
[   43.907837][ T9500] R13: 00007fff93751cc8 R14: 0000000000000002
R15: 00000000004cba40
[   43.908591][ T9500]  </TASK>
[   43.908893][ T9500] Modules linked in:
[   43.909258][ T9500] CR2: ffffffffffffffb1
[   43.909646][ T9500] ---[ end trace 0000000000000000 ]---
[   43.910172][ T9500] RIP: 0010:afs_put_addrlist+0x3c/0x110
[   43.910184][ T9500] Code: aa 39 17 fe 4d 85 f6 74 7d 49 8d 7e 18 48
89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 0f
85 af 00 00 00 <41> 8b 6e 18 4d 8d 66 10 4c 89 e7 be 04 00 00 00 e8 9f
35 87 fe 41
[   43.910190][ T9500] RSP: 0018:ffffc90007b67618 EFLAGS: 00010246
[   43.910196][ T9500] RAX: 0000000000000000 RBX: 0000000000000009
RCX: dffffc0000000000
[   43.910201][ T9500] RDX: 0000000000000000 RSI: 0000000000000009
RDI: ffffffffffffffb1
[   43.910205][ T9500] RBP: 0000000000000000 R08: ffff88810ea66a87
R09: 1ffff11021d4cd50
[   43.910210][ T9500] R10: dffffc0000000000 R11: ffffed1021d4cd51
R12: ffff88810d211000
[   43.910216][ T9500] R13: ffff88810ea66800 R14: ffffffffffffff99
R15: ffffffffffffff99
[   43.910221][ T9500] FS:  000000003957f400(0000)
GS:ffff8881da58b000(0000) knlGS:0000000000000000
[   43.910227][ T9500] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.910232][ T9500] CR2: ffffffffffffffb1 CR3: 0000000113534000
CR4: 0000000000752ef0
[   43.910238][ T9500] PKRU: 55555554
[   43.910244][ T9500] Kernel panic - not syncing: Fatal exception
[   43.919939][ T9500] Kernel Offset: disabled
[   43.920340][ T9500] Rebooting in 86400 seconds.

Reproducer attached; thanks!

On Wed, Sep 2, 2026 at 4:41=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Farhad,
>
> > While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU'=
s
> > SEFCOM lab, we hit the crash below. Crash reports can be found here:
>
> Have you tried it with 7.3-rc1?
>
> >   BUG: unable to handle page fault for address: ffffffffffffff9f
> >   RIP: 0010:afs_put_addrlist+0x43/0x250 fs/afs/addr_list.c:38
> >   afs_lookup_server+0xd3f/0x1020 fs/afs/server.c:243
> >   afs_alloc_server_list+0x800/0x11a0 fs/afs/server_list.c:82
> >   afs_create_volume+0x995/0x1290 fs/afs/volume.c:227
> >   afs_get_tree+0x955/0x10b0 fs/afs/super.c:555
>
> It looks like alist is 0xffffffffffffff9f, but it's not immediately obvio=
us
> how it could be anything other than a valid pointer at that point.
>
> > Our reproducer.c is available upon request.
>
> If I could have that, please?
>
> Thanks,
> David
>

--000000000000c5f19c065b10cb46
Content-Type: application/octet-stream; name="reproducer.c"
Content-Disposition: attachment; filename="reproducer.c"
Content-Transfer-Encoding: base64
Content-ID: <f_mtuf0wpl0>
X-Attachment-Id: f_mtuf0wpl0

LyoKICogUmVwcm9kdWNlciBmb3IgMTA0LWFmcy1lcnJfcHRyLWRlcmVmLWFmc19wdXRfYWRkcmxp
c3QKICovCiNkZWZpbmUgX0dOVV9TT1VSQ0UKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxz
dGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRl
IDxlcnJuby5oPgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHB0aHJlYWQuaD4KI2luY2x1
ZGUgPHN5cy9zb2NrZXQuaD4KI2luY2x1ZGUgPHN5cy90eXBlcy5oPgojaW5jbHVkZSA8c3lzL3N0
YXQuaD4KI2luY2x1ZGUgPHN5cy9tb3VudC5oPgojaW5jbHVkZSA8c3lzL2lvY3RsLmg+CiNpbmNs
dWRlIDxuZXRpbmV0L2luLmg+CiNpbmNsdWRlIDxhcnBhL2luZXQuaD4KI2luY2x1ZGUgPG5ldC9p
Zi5oPgoKI2lmbmRlZiBBRl9SWFJQQwojZGVmaW5lIEFGX1JYUlBDIDMzCiNlbmRpZgojaWZuZGVm
IFNPTF9SWFJQQwojZGVmaW5lIFNPTF9SWFJQQyAyNzIKI2VuZGlmCgojZGVmaW5lIFJYUlBDX1VT
RVJfQ0FMTF9JRAkxCiNkZWZpbmUgUlhSUENfQUJPUlQJCTIKI2RlZmluZSBSWFJQQ19BQ0sJCTMK
I2RlZmluZSBSWFJQQ19ORVRfRVJST1IJCTUKI2RlZmluZSBSWFJQQ19CVVNZCQk2CiNkZWZpbmUg
UlhSUENfTE9DQUxfRVJST1IJNwojZGVmaW5lIFJYUlBDX05FV19DQUxMCQk4CiNkZWZpbmUgUlhS
UENfQ0hBUkdFX0FDQ0VQVAkxNAoKc3RydWN0IHNvY2thZGRyX3J4cnBjIHsKCXNhX2ZhbWlseV90
CXNyeF9mYW1pbHk7Cgl1bnNpZ25lZCBzaG9ydAlzcnhfc2VydmljZTsKCXVuc2lnbmVkIHNob3J0
CXRyYW5zcG9ydF90eXBlOwoJdW5zaWduZWQgc2hvcnQJdHJhbnNwb3J0X2xlbjsKCXVuaW9uIHsK
CQlzYV9mYW1pbHlfdAkJZmFtaWx5OwoJCXN0cnVjdCBzb2NrYWRkcl9pbglzaW47CgkJc3RydWN0
IHNvY2thZGRyX2luNglzaW42OwoJfSB0cmFuc3BvcnQ7Cn07CgojZGVmaW5lIFZMX1NFUlZJQ0UJ
CTUyCiNkZWZpbmUgQUZTX1ZMX1BPUlQJCTcwMDMKCiNkZWZpbmUgVkxHRVRFTlRSWUJZTkFNRVUJ
NTI3CiNkZWZpbmUgVkxHRVRBRERSU1UJCTUzMwojZGVmaW5lIFZMR0VUQ0FQQUJJTElUSUVTCTY1
NTM3CgojZGVmaW5lIEFGU1ZMX0lPCQkzNjM1MjEJCS8qIC0+IC1FUkVNT1RFSU8gaW4gYWZzX3Nl
bGVjdF92bHNlcnZlcigpICovCiNkZWZpbmUgUlhHRU5fT1BDT0RFCQkoKHVuc2lnbmVkIGludCkt
NDU1KQoKI2RlZmluZSBBRlNfVkxTRl9SV1ZPTAkJMHgwMDA0CiNkZWZpbmUgQUZTX1ZMRl9SV0VY
SVNUUwkweDEwMDAKCiNkZWZpbmUgQ0VMTAkicmVwcm9jZWxsIgojZGVmaW5lIFZPTFVNRQkiYXZv
bCIKCnN0YXRpYyB2b2xhdGlsZSBpbnQgc3J2X3JlYWR5ID0gMDsKCi8qCiAqIEV2ZXJ5IG1lc3Nh
Z2Ugd2Ugc2VuZCBpcyBvbmUgc2VuZG1zZygpIGNhcnJ5aW5nIFJYUlBDX1VTRVJfQ0FMTF9JRCwg
cGx1cwogKiBvcHRpb25hbGx5IGEgc2Vjb25kIGNvbnRyb2wgbWVzc2FnZSAodGhlIGFib3J0IGNv
ZGUsIG9yIHRoZSBjaGFyZ2UtYWNjZXB0CiAqIG1hcmtlcikgYW5kIG9wdGlvbmFsbHkgYSBwYXls
b2FkLgogKi8Kc3RhdGljIGludCByeHJwY19zZW5kbXNnKGludCBmZCwgdW5zaWduZWQgbG9uZyBj
YWxsX2lkLAoJCQkgaW50IGNtc2dfdHlwZSwgY29uc3Qgdm9pZCAqY21zZ192YWwsIHNpemVfdCBj
bXNnX2xlbiwKCQkJIGNvbnN0IHZvaWQgKnBheWxvYWQsIHNpemVfdCBwYXlsb2FkX2xlbikKewoJ
Y2hhciBjb250cm9sWzI1Nl07CglzdHJ1Y3QgY21zZ2hkciAqY21zZzsKCXN0cnVjdCBtc2doZHIg
bXNnOwoJc3RydWN0IGlvdmVjIGlvdjsKCXNpemVfdCBsZW47CgoJbWVtc2V0KCZtc2csIDAsIHNp
emVvZihtc2cpKTsKCW1lbXNldChjb250cm9sLCAwLCBzaXplb2YoY29udHJvbCkpOwoJbXNnLm1z
Z19jb250cm9sID0gY29udHJvbDsKCW1zZy5tc2dfY29udHJvbGxlbiA9IHNpemVvZihjb250cm9s
KTsKCgljbXNnID0gQ01TR19GSVJTVEhEUigmbXNnKTsKCWNtc2ctPmNtc2dfbGV2ZWwgPSBTT0xf
UlhSUEM7CgljbXNnLT5jbXNnX3R5cGUgPSBSWFJQQ19VU0VSX0NBTExfSUQ7CgljbXNnLT5jbXNn
X2xlbiA9IENNU0dfTEVOKHNpemVvZihjYWxsX2lkKSk7CgltZW1jcHkoQ01TR19EQVRBKGNtc2cp
LCAmY2FsbF9pZCwgc2l6ZW9mKGNhbGxfaWQpKTsKCWxlbiA9IENNU0dfU1BBQ0Uoc2l6ZW9mKGNh
bGxfaWQpKTsKCglpZiAoY21zZ190eXBlKSB7CgkJY21zZyA9IChzdHJ1Y3QgY21zZ2hkciAqKShj
b250cm9sICsgbGVuKTsKCQljbXNnLT5jbXNnX2xldmVsID0gU09MX1JYUlBDOwoJCWNtc2ctPmNt
c2dfdHlwZSA9IGNtc2dfdHlwZTsKCQljbXNnLT5jbXNnX2xlbiA9IENNU0dfTEVOKGNtc2dfbGVu
KTsKCQlpZiAoY21zZ19sZW4pCgkJCW1lbWNweShDTVNHX0RBVEEoY21zZyksIGNtc2dfdmFsLCBj
bXNnX2xlbik7CgkJbGVuICs9IENNU0dfU1BBQ0UoY21zZ19sZW4pOwoJfQoJbXNnLm1zZ19jb250
cm9sbGVuID0gbGVuOwoKCWlmIChwYXlsb2FkKSB7CgkJaW92Lmlvdl9iYXNlID0gKHZvaWQgKilw
YXlsb2FkOwoJCWlvdi5pb3ZfbGVuID0gcGF5bG9hZF9sZW47CgkJbXNnLm1zZ19pb3YgPSAmaW92
OwoJCW1zZy5tc2dfaW92bGVuID0gMTsKCX0KCXJldHVybiBzZW5kbXNnKGZkLCAmbXNnLCAwKTsK
fQoKI2RlZmluZSBjaGFyZ2VfYWNjZXB0KGZkLCBpZCkJCXJ4cnBjX3NlbmRtc2coZmQsIGlkLCBS
WFJQQ19DSEFSR0VfQUNDRVBULCBOVUxMLCAwLCBOVUxMLCAwKQojZGVmaW5lIHNlbmRfcmVwbHko
ZmQsIGlkLCBkLCBuKQlyeHJwY19zZW5kbXNnKGZkLCBpZCwgMCwgTlVMTCwgMCwgZCwgbikKCnN0
YXRpYyBpbnQgc2VuZF9hYm9ydChpbnQgZmQsIHVuc2lnbmVkIGxvbmcgY2FsbF9pZCwgdW5zaWdu
ZWQgaW50IGFib3J0X2NvZGUpCnsKCXJldHVybiByeHJwY19zZW5kbXNnKGZkLCBjYWxsX2lkLCBS
WFJQQ19BQk9SVCwgJmFib3J0X2NvZGUsCgkJCSAgICAgc2l6ZW9mKGFib3J0X2NvZGUpLCBOVUxM
LCAwKTsKfQoKLyoKICogc3RydWN0IGFmc191dmxkYmVudHJ5X194ZHIsIDI2MiBiZTMyIHdvcmRz
IChmcy9hZnMvYWZzX3ZsLmgpOgogKiAgIG5hbWVbNjVdIG5TZXJ2ZXJzIHNlcnZlck51bWJlclsx
MyoxMV0gc2VydmVyVW5pcXVlWzEzXQogKiAgIHNlcnZlclBhcnRpdGlvblsxM10gc2VydmVyRmxh
Z3NbMTNdIHZvbHVtZUlkWzNdIGNsb25lSWQgZmxhZ3Mgc3BhcmVzWzldCiAqLwojZGVmaW5lIFZM
REJfRU5UUllfV09SRFMgMjYyCnN0YXRpYyB1bnNpZ25lZCBpbnQgdmxkYl9lbnRyeVtWTERCX0VO
VFJZX1dPUkRTXTsKCnN0YXRpYyB2b2lkIGJ1aWxkX3V2bGRiZW50cnkodm9pZCkKewoJY29uc3Qg
Y2hhciAqbiA9IFZPTFVNRTsKCWludCBpOwoKCW1lbXNldCh2bGRiX2VudHJ5LCAwLCBzaXplb2Yo
dmxkYl9lbnRyeSkpOwoJZm9yIChpID0gMDsgbltpXSAmJiBpIDwgNjQ7IGkrKykKCQl2bGRiX2Vu
dHJ5W2ldID0gaHRvbmwoKHVuc2lnbmVkIGNoYXIpbltpXSk7CgoJdmxkYl9lbnRyeVs2NV0gPSBo
dG9ubCgxKTsJCQkvKiBuU2VydmVycyAqLwoKCS8qIHNlcnZlck51bWJlclswXTogYWZzX3V1aWRf
X3hkciwgMTEgd29yZHMsIGFyYml0cmFyeSBidXQgbm9uemVybyAqLwoJdmxkYl9lbnRyeVs2NiAr
IDBdID0gaHRvbmwoMHgxMTIyMzM0NCk7CS8qIHRpbWVfbG93ICovCgl2bGRiX2VudHJ5WzY2ICsg
MV0gPSBodG9ubCgweDU1NjYpOwkJLyogdGltZV9taWQgKi8KCXZsZGJfZW50cnlbNjYgKyAyXSA9
IGh0b25sKDB4Nzc4OCk7CQkvKiB0aW1lX2hpX2FuZF92ZXJzaW9uICovCgl2bGRiX2VudHJ5WzY2
ICsgM10gPSBodG9ubCgweDk5KTsJCS8qIGNsb2NrX3NlcV9oaV9hbmRfcmVzZXJ2ZWQgKi8KCXZs
ZGJfZW50cnlbNjYgKyA0XSA9IGh0b25sKDB4YWEpOwkJLyogY2xvY2tfc2VxX2xvdyAqLwoJZm9y
IChpID0gMDsgaSA8IDY7IGkrKykKCQl2bGRiX2VudHJ5WzY2ICsgNSArIGldID0gaHRvbmwoMHhi
MCArIGkpOwkvKiBub2RlWzZdICovCgoJdmxkYl9lbnRyeVsyMDldID0gaHRvbmwoMSk7CQkJLyog
c2VydmVyVW5pcXVlWzBdICovCgl2bGRiX2VudHJ5WzIyMl0gPSBodG9ubCgwKTsJCQkvKiBzZXJ2
ZXJQYXJ0aXRpb25bMF0gKi8KCXZsZGJfZW50cnlbMjM1XSA9IGh0b25sKEFGU19WTFNGX1JXVk9M
KTsJLyogc2VydmVyRmxhZ3NbMF0gKi8KCXZsZGJfZW50cnlbMjQ4XSA9IGh0b25sKDB4MDIwMDAw
MDEpOwkJLyogdm9sdW1lSWRbUlddICovCgl2bGRiX2VudHJ5WzI1MV0gPSBodG9ubCgwKTsJCQkv
KiBjbG9uZUlkICovCgl2bGRiX2VudHJ5WzI1Ml0gPSBodG9ubChBRlNfVkxGX1JXRVhJU1RTKTsJ
LyogZmxhZ3MgKi8KfQoKc3RydWN0IGNhbGxyZWMgewoJdW5zaWduZWQgbG9uZwlpZDsKCXVuc2ln
bmVkIGludAlvcGNvZGU7CglpbnQJCWhhdmVfb3A7Cn07CiNkZWZpbmUgTkNBTExTIDY0CnN0YXRp
YyBzdHJ1Y3QgY2FsbHJlYyBjYWxsc1tOQ0FMTFNdOwoKc3RhdGljIHN0cnVjdCBjYWxscmVjICps
b29rdXBfY2FsbCh1bnNpZ25lZCBsb25nIGlkKQp7CglpbnQgaSwgZnJlZSA9IC0xOwoJZm9yIChp
ID0gMDsgaSA8IE5DQUxMUzsgaSsrKSB7CgkJaWYgKGNhbGxzW2ldLmlkID09IGlkICYmIGNhbGxz
W2ldLmhhdmVfb3AgPj0gMCAmJiBjYWxsc1tpXS5pZCkKCQkJcmV0dXJuICZjYWxsc1tpXTsKCQlp
ZiAoIWNhbGxzW2ldLmlkICYmIGZyZWUgPCAwKQoJCQlmcmVlID0gaTsKCX0KCWlmIChmcmVlIDwg
MCkKCQlmcmVlID0gMDsKCWNhbGxzW2ZyZWVdLmlkID0gaWQ7CgljYWxsc1tmcmVlXS5vcGNvZGUg
PSAwOwoJY2FsbHNbZnJlZV0uaGF2ZV9vcCA9IDA7CglyZXR1cm4gJmNhbGxzW2ZyZWVdOwp9Cgpz
dGF0aWMgdm9pZCBkcm9wX2NhbGwodW5zaWduZWQgbG9uZyBpZCkKewoJaW50IGk7Cglmb3IgKGkg
PSAwOyBpIDwgTkNBTExTOyBpKyspCgkJaWYgKGNhbGxzW2ldLmlkID09IGlkKQoJCQltZW1zZXQo
JmNhbGxzW2ldLCAwLCBzaXplb2YoY2FsbHNbaV0pKTsKfQoKc3RhdGljIHZvaWQgKnZsc2VydmVy
KHZvaWQgKnVudXNlZCkKewoJc3RydWN0IHNvY2thZGRyX3J4cnBjIHNyeDsKCXVuc2lnbmVkIGxv
bmcgbmV4dF9pZCA9IDEwMDA7CglpbnQgaSwgZmQ7CgoJZmQgPSBzb2NrZXQoQUZfUlhSUEMsIFNP
Q0tfREdSQU0sIFBGX0lORVQpOwoJaWYgKGZkIDwgMCkgewoJCWZwcmludGYoc3RkZXJyLCAic29j
a2V0KEFGX1JYUlBDKTogJW1cbiIpOwoJCXNydl9yZWFkeSA9IC0xOwoJCXJldHVybiBOVUxMOwoJ
fQoKCW1lbXNldCgmc3J4LCAwLCBzaXplb2Yoc3J4KSk7Cglzcnguc3J4X2ZhbWlseSA9IEFGX1JY
UlBDOwoJc3J4LnNyeF9zZXJ2aWNlID0gVkxfU0VSVklDRTsKCXNyeC50cmFuc3BvcnRfdHlwZSA9
IFNPQ0tfREdSQU07CglzcngudHJhbnNwb3J0X2xlbiA9IHNpemVvZihzdHJ1Y3Qgc29ja2FkZHJf
aW4pOwoJc3J4LnRyYW5zcG9ydC5zaW4uc2luX2ZhbWlseSA9IEFGX0lORVQ7CglzcngudHJhbnNw
b3J0LnNpbi5zaW5fcG9ydCA9IGh0b25zKEFGU19WTF9QT1JUKTsKCXNyeC50cmFuc3BvcnQuc2lu
LnNpbl9hZGRyLnNfYWRkciA9IGh0b25sKElOQUREUl9BTlkpOwoKCWlmIChiaW5kKGZkLCAoc3Ry
dWN0IHNvY2thZGRyICopJnNyeCwgc2l6ZW9mKHNyeCkpIDwgMCkgewoJCWZwcmludGYoc3RkZXJy
LCAiYmluZDogJW1cbiIpOwoJCXNydl9yZWFkeSA9IC0xOwoJCXJldHVybiBOVUxMOwoJfQoJaWYg
KGxpc3RlbihmZCwgMTApIDwgMCkgewoJCWZwcmludGYoc3RkZXJyLCAibGlzdGVuOiAlbVxuIik7
CgkJc3J2X3JlYWR5ID0gLTE7CgkJcmV0dXJuIE5VTEw7Cgl9Cglmb3IgKGkgPSAwOyBpIDwgODsg
aSsrKQoJCWNoYXJnZV9hY2NlcHQoZmQsIG5leHRfaWQrKyk7CgoJc3J2X3JlYWR5ID0gMTsKCglm
b3IgKDs7KSB7CgkJY2hhciBidWZbNDA5Nl0sIGN0bFs1MTJdOwoJCXN0cnVjdCBtc2doZHIgbXNn
OwoJCXN0cnVjdCBpb3ZlYyBpb3Y7CgkJc3RydWN0IGNtc2doZHIgKmNtOwoJCXVuc2lnbmVkIGxv
bmcgaWQgPSAwOwoJCWludCBnb3RfaWQgPSAwLCB0ZXJtaW5hbCA9IDA7CgkJc3NpemVfdCBuOwoJ
CXN0cnVjdCBjYWxscmVjICpjOwoKCQltZW1zZXQoJm1zZywgMCwgc2l6ZW9mKG1zZykpOwoJCWlv
di5pb3ZfYmFzZSA9IGJ1ZjsKCQlpb3YuaW92X2xlbiA9IHNpemVvZihidWYpOwoJCW1zZy5tc2df
aW92ID0gJmlvdjsKCQltc2cubXNnX2lvdmxlbiA9IDE7CgkJbXNnLm1zZ19jb250cm9sID0gY3Rs
OwoJCW1zZy5tc2dfY29udHJvbGxlbiA9IHNpemVvZihjdGwpOwoKCQluID0gcmVjdm1zZyhmZCwg
Jm1zZywgMCk7CgkJaWYgKG4gPCAwKSB7CgkJCWlmIChlcnJubyA9PSBFSU5UUiB8fCBlcnJubyA9
PSBFQUdBSU4pCgkJCQljb250aW51ZTsKCQkJZnByaW50ZihzdGRlcnIsICJyZWN2bXNnOiAlbVxu
Iik7CgkJCWJyZWFrOwoJCX0KCgkJZm9yIChjbSA9IENNU0dfRklSU1RIRFIoJm1zZyk7IGNtOyBj
bSA9IENNU0dfTlhUSERSKCZtc2csIGNtKSkgewoJCQlpZiAoY20tPmNtc2dfbGV2ZWwgIT0gU09M
X1JYUlBDKQoJCQkJY29udGludWU7CgkJCXN3aXRjaCAoY20tPmNtc2dfdHlwZSkgewoJCQljYXNl
IFJYUlBDX1VTRVJfQ0FMTF9JRDoKCQkJCW1lbWNweSgmaWQsIENNU0dfREFUQShjbSksIHNpemVv
ZihpZCkpOwoJCQkJZ290X2lkID0gMTsKCQkJCWJyZWFrOwoJCQljYXNlIFJYUlBDX0FCT1JUOgoJ
CQljYXNlIFJYUlBDX0FDSzoKCQkJY2FzZSBSWFJQQ19ORVRfRVJST1I6CgkJCWNhc2UgUlhSUENf
QlVTWToKCQkJY2FzZSBSWFJQQ19MT0NBTF9FUlJPUjogewoJCQkJdW5zaWduZWQgaW50IHYgPSAw
OwoJCQkJaWYgKGNtLT5jbXNnX2xlbiA+PSBDTVNHX0xFTig0KSkKCQkJCQltZW1jcHkoJnYsIENN
U0dfREFUQShjbSksIDQpOwoJCQkJdGVybWluYWwgPSAxOwoJCQl9CgkJCQlicmVhazsKCQkJZGVm
YXVsdDoKCQkJCWJyZWFrOwoJCQl9CgkJfQoKCQlpZiAoIWdvdF9pZCkKCQkJY29udGludWU7CgoJ
CWlmICh0ZXJtaW5hbCkgewoJCQlkcm9wX2NhbGwoaWQpOwoJCQljaGFyZ2VfYWNjZXB0KGZkLCBu
ZXh0X2lkKyspOwoJCQljb250aW51ZTsKCQl9CgoJCWMgPSBsb29rdXBfY2FsbChpZCk7CgkJaWYg
KCFjLT5oYXZlX29wICYmIG4gPj0gNCkgewoJCQl1bnNpZ25lZCBpbnQgb3A7CgkJCW1lbWNweSgm
b3AsIGJ1ZiwgNCk7CgkJCWMtPm9wY29kZSA9IG50b2hsKG9wKTsKCQkJYy0+aGF2ZV9vcCA9IDE7
CgkJfQoKCQlpZiAobXNnLm1zZ19mbGFncyAmIE1TR19NT1JFKQoJCQljb250aW51ZTsKCgkJc3dp
dGNoIChjLT5vcGNvZGUpIHsKCQljYXNlIFZMR0VUQ0FQQUJJTElUSUVTOiB7CgkJCXVuc2lnbmVk
IGludCByZXBseVsyXTsKCQkJcmVwbHlbMF0gPSBodG9ubCgxKTsJLyogbnIgY2FwYWJpbGl0eSB3
b3JkcyAqLwoJCQlyZXBseVsxXSA9IGh0b25sKDApOwoJCQlzZW5kX3JlcGx5KGZkLCBpZCwgcmVw
bHksIHNpemVvZihyZXBseSkpOwoJCQlicmVhazsKCQl9CgkJY2FzZSBWTEdFVEVOVFJZQllOQU1F
VToKCQkJc2VuZF9yZXBseShmZCwgaWQsIHZsZGJfZW50cnksIHNpemVvZih2bGRiX2VudHJ5KSk7
CgkJCWJyZWFrOwoJCWNhc2UgVkxHRVRBRERSU1U6CgkJCS8qIHRoZSB3aG9sZSBwb2ludDogbWFr
ZSBhZnNfdmxfbG9va3VwX2FkZHJzKCkgZmFpbCAqLwoJCQlzZW5kX2Fib3J0KGZkLCBpZCwgQUZT
VkxfSU8pOwoJCQlicmVhazsKCQlkZWZhdWx0OgoJCQlzZW5kX2Fib3J0KGZkLCBpZCwgUlhHRU5f
T1BDT0RFKTsKCQkJYnJlYWs7CgkJfQoJCWRyb3BfY2FsbChpZCk7CgkJY2hhcmdlX2FjY2VwdChm
ZCwgbmV4dF9pZCsrKTsKCX0KCXJldHVybiBOVUxMOwp9CgppbnQgbWFpbih2b2lkKQp7CglwdGhy
ZWFkX3QgdmxzZXJ2ZXJfdGhyZWFkOwoJaW50IGZkLCBpOwoJY29uc3QgY2hhciAqcm9vdCA9IENF
TEwgIjoxMjcuMC4wLjFcbiI7CgoJYnVpbGRfdXZsZGJlbnRyeSgpOwoKCWlmIChwdGhyZWFkX2Ny
ZWF0ZSgmdmxzZXJ2ZXJfdGhyZWFkLCBOVUxMLCB2bHNlcnZlciwgTlVMTCkpIHsKCQlmcHJpbnRm
KHN0ZGVyciwgInB0aHJlYWRfY3JlYXRlOiAlbVxuIik7CgkJcmV0dXJuIDE7Cgl9Cglmb3IgKGkg
PSAwOyBpIDwgNTAwICYmICFzcnZfcmVhZHk7IGkrKykKCQl1c2xlZXAoMTAwMDApOwoJaWYgKHNy
dl9yZWFkeSAhPSAxKSB7CgkJZnByaW50ZihzdGRlcnIsICJ2bHNlcnZlciBmYWlsZWQgdG8gc3Rh
cnRcbiIpOwoJCXJldHVybiAxOwoJfQoJLyogTWFrZSBvdXIgZmFrZSBjZWxsIHRoZSB3b3Jrc3Rh
dGlvbiBjZWxsLCB3aXRoIGEgbGl0ZXJhbCBWTCBhZGRyZXNzCgkgKiBzbyB0aGF0IG5vIEROUyBs
b29rdXAgaXMgYXR0ZW1wdGVkLiAqLwoJZmQgPSBvcGVuKCIvcHJvYy9mcy9hZnMvcm9vdGNlbGwi
LCBPX1dST05MWSk7CglpZiAoZmQgPCAwKSB7CgkJZnByaW50ZihzdGRlcnIsICJvcGVuIHJvb3Rj
ZWxsOiAlbSAoaXMga0FGUyBwcmVzZW50PylcbiIpOwoJCXJldHVybiAxOwoJfQoJaWYgKHdyaXRl
KGZkLCByb290LCBzdHJsZW4ocm9vdCkpIDwgMCkKCQlmcHJpbnRmKHN0ZGVyciwgIndyaXRlIHJv
b3RjZWxsOiAlbVxuIik7CgljbG9zZShmZCk7CgoJbWtkaXIoIi9tbnRfYWZzIiwgMDc1NSk7CgoJ
LyogVGhlIHNvdXJjZSBoYXMgbm8gY2VsbCBwYXJ0LCBzbyB0aGUgd29ya3N0YXRpb24gY2VsbCBz
ZXQgYWJvdmUgaXMKCSAqIHVzZWQgYW5kIGFmc19sb29rdXBfY2VsbCgpL0ROUyBpcyBuZXZlciBl
bnRlcmVkLiAgT3VyIFZMIHNlcnZlcgoJICogYWJvcnRzIFZMLkdldEFkZHJzVSwgc28gYWZzX3Zs
X2xvb2t1cF9hZGRycygpIHJldHVybnMKCSAqIEVSUl9QVFIoLUVSRU1PVEVJTykgYW5kIGFmc19s
b29rdXBfc2VydmVyKCkncyBjcmVhdGVfZmFpbGVkIC0+IG91dAoJICogcGF0aCBoYW5kcyB0aGF0
IEVSUl9QVFIgdG8gYWZzX3B1dF9hZGRybGlzdCgpLCB3aGljaCByZWplY3RzIG9ubHkKCSAqIE5V
TEwuICovCgltb3VudCgiJSIgVk9MVU1FLCAiL21udF9hZnMiLCAiYWZzIiwgMCwgTlVMTCk7CgoJ
cmV0dXJuIDA7Cn0K
--000000000000c5f19c065b10cb46--
