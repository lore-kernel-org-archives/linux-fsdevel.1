Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795597731;
	b=JjAxygMCBhBaFSyzuSmp4HwisLQr7GPoXdaX6TIJqK03shS1qvGvPIc4xOCXgDUZzznI
	 R5sRsxNxoCU8BdTHiA7/++ltKiFVbMWA03gd4CJpJ162m+hxnn0Yy0cihSFKvg5qHkZib
	 PouG6Y48jyWW4HNZ+OszKrtRXGmbkQto8NqeHiWEnLTsgNrPPSnP+PZ8bOYdbPlI/pQW6
	 srL5jgSgVrZbfJ9iCRrp2S3MUOM27iTjV4ydfnYZfRDS9Io3qS8+zpjMb9kloDYACYfzx
	 ORPC82hP+WOuucaxO8lch93C/jAaopv1OmkXoKP7wxQgQWa4QGOJAaCd1H1zDoo6g2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795597731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KuvoUDCaIBt8E6V4M3XTLtfXIPJakzIdb85mkQY3hms=;
	b=AdMJRVD7Oa0Mhto4TFE2hFF/HFiBcq1lMsBt/R4tmQWFmWu+DP06wtej1piM7YZy7QXU
	 qCDCz8+l9s68UJMej2dmQwac1BNMcHLYzMC7iPPE1w1JW9yk48B4n4Rc11U/Djv+8ystx
	 kLisdkZoYKnIfzLKM0xSnFxIYzuVsy5dNB03QEqwKjpE/QtcFtfdpa+p0/I8O662uxvuz
	 JmXONorSgNrtE8kVscCaJVugn3a0VfCkPkdxbJbAe1lIAfPWXd74xPFMarg1KS8RMiOgf
	 FlmFoLfsOfLoVWXzaQ97k/FoPsgYZniHvgHcm0KO6f6ChB3Wg+0N3KXT8cE/eJKyCSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A64RA4rh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.50
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C753606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 09:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C753606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=A64RA4rh
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7cc53938a8fso3705773137.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 01:08:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795597729; cv=none;
        d=google.com; s=arc-20260327;
        b=dtNlCZpmeJKyB2MvhEG/o6RUh8JlJzdxNErdXTpkfd39JI2b+tB7tkcquUOwDzpka1
         /PScMEFXQiqZbvk5fC7iXp26/R03/212IowsL3aitpfuecKVoFe20kGi02afd28zR4/V
         M1Ni7MXIR/ILfqd+vejvhO/rV/VKHiNmBVqd7lhWCJJrLEew5vJRlINgLFCLTnVycrZz
         tHYNIc1iEcdVQqB3gE1tBucjehBOPYd8yiaS5kcTQPL+YWDViO1PzvlWGg4suqFmxjG0
         Mqr4HURRqd4lL/j3kelnQLACBROAfP2rfp3Ds+Rt1/Sjx6tFzZP96QdbMNBWkJWVUfm1
         sU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KuvoUDCaIBt8E6V4M3XTLtfXIPJakzIdb85mkQY3hms=;
        fh=3frn9U9klQIKhP0Q139wXf/iz+3Ki8fv54OCp7oKezM=;
        b=YKxgSgjRMbew0YZTw10GNJbDDgKKs/XHX2qlWrZ/0S7t7D0Uod0pMIT/cUxunY+1Xz
         2++HwR+mA4OCBstmwXQVVWHUulftumssynaKWBybq/F6jjiuPSkTbVkHwksvaPYtti5z
         egmy2FxmUxhjINjBwLZxHGPpQauwBCCOAbpYLIOYpb6Vv6AWmf0jPNAyf2F3HJifeIkU
         W8/i+4P9wD+0o7pgoXZTqww5RDu7h+SK4ykRr90BH9QSs2zHesm75fZIJBDcTcqGc+Nl
         k8nbVde5iEqGyzesPNo4bzae59Kaf9N9klXRLSZIPH6wIHoqixazALVCt8wzX6wjqIqj
         IvGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795597729; x=1796202529; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KuvoUDCaIBt8E6V4M3XTLtfXIPJakzIdb85mkQY3hms=;
        b=A64RA4rhLVkaxeL3AK+w6kVNF/j9XejWTJMtEpSG2w8mpUSVnjYKhSIfopUYUPTfUN
         E8up/uiczsdf6+6hVtsWA95M+TfZ1apFye3OZzf+QXC0lM+kCfIA2m1zrgSAsBHzi9nd
         jFo9Tt6X1+8l8yNih+SUNKm6tpJEmA0IqXoM/Vt1PLWUBGNNZ9boleBccA2Akij4eifb
         aStof6OoIoL7Sq5ZRulZ2ibzQ0YSJxEDq79gSDwPuq/uuopDpkGTpWJJvDxOVDe6Comt
         kCc+UOGOHdCrTLpG3kgGZHEM5NZvdEiglSpAwfW3OdwxNyrNUrX2NODB6vkewGK6C2wB
         faFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795597729; x=1796202529;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KuvoUDCaIBt8E6V4M3XTLtfXIPJakzIdb85mkQY3hms=;
        b=0vBLjF5yznCMMuC14IlslCOO6E6+1YpGmiop5M2tFibjz2x1pss8EXzcBfEoiIUypA
         w92yxNNHHaYzqmNaiDH82WXWkezjK4/zdWjYbhfnm5eQd+leyOzJMLH1MEYhQRB+xAbW
         hE1VcfkwTwh39X9+Rb6iY5LxCx79MbUjQraovYOWjtM9x4QraMXDBJXLik0i60JF/VE6
         e81GV9WR+gpyvb8HRtEQU5CufEkZOHponM5dc2wvbajtZjTTUTs8rGoSnyybzkLfxQ4/
         MLBky9VSXB8iZHBVXN3LaC8LvtgGuu/zKFcKtTiAY2cQ4PKuzgo0tYCJB0vcb5Nv5nA3
         qeXw==
X-Forwarded-Encrypted: i=1; AL+hErG0j24Y34I1FLv3lsZBVtKJwbbSLsQ9H3WbohQfdC0wCRbYNYEJ7tZA92tYI6/Y67jZ+ZOdMwSuB3W7UP6Z@vger.kernel.org
X-Gm-Message-State: APuU4Z9Lb2sgwl2mSxjkS21AblcdyREgl6i61pUY8Rvtm1o6PFy2cPOL
	BB+a01MDnpRDuw0NkX0X2KWyIl2NHDGL+Ce4HsXzBkvWK+MgzTSigYQwf4K3BoA2pXkTMfsT5nm
	rKol5+BTs2wQveDgx8cfKu9aXkk/ghNPe0n9hsbg/HOQ=
X-Gm-Gg: AZFdTZf1TprUNk2uFmLcGHJGW8PJF8XPw7SA617icRopVX1ZV8AyMfdCrAMdztc87tm
	Yd95pEm0ezF1+AOKUROBO9tgLusQSMl5FmYbX6NyvanjKbFTEe00M/XHv8MeNYutVTZIgXgOERN
	zllhrX6JQIUZYReZmc6ozwbojOPZxDJ5S0PZGFAn1a0b/ocKEG2HtQ+kz0K6oLa64RMMJmrMLno
	lpwTF5lqMY9GfYFjUZdLL7ZMQjkqA8MiB4TIwFcv0R/n0sCzr70sTHeNBWfIAdSp1m+1sX/5GHO
	FIpB1ykqxPDcmkupLRvlFN4lwL2WGIcMdUjPLs5wfnBQ3XXgf+P+RKLXBaR2WAdDOdgh29V2ssB
	bxD8um480PF8vqEmagmzaAsIAw3+a/enNGUtYHeomCRiQP/EYEzFGS6CpT2Bcsi8Fzes=
X-Received: by 2002:a67:e115:0:b0:7cc:115:ddf4 with SMTP id
 ada2fe7eead31-7d73961ffdfmr7565233137.25.1795597729498; Wed, 25 Nov 2026
 01:08:49 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124195430.105522-1-alex@amutable.com> <ykuz2hhjgnfhwnh7srst3ev4yqetv5jrs3vn5idwr5jfynszax@zrbrypi5phon>
In-Reply-To: <ykuz2hhjgnfhwnh7srst3ev4yqetv5jrs3vn5idwr5jfynszax@zrbrypi5phon>
From: Alexander Mikhalitsyn <alex@amutable.com>
Date: Wed, 25 Nov 2026 10:08:36 +0100
X-Gm-Features: Aa3M54qn6h9ODGjV2IafKC2EXuw5MUKOakyqBrbUxm2h5WabcIWL6MsV22rl6GI
Message-ID: <CAL65ydQaiFfQtEcFhDUA2HbrUnAUe86m9uGVoWneh7wpLZUZ0w@mail.gmail.com>
Subject: Re: [PATCH] ecryptfs: release inode on error path in ecryptfs_lookup_interpose
To: Jan Kara <jack@suse.cz>
Cc: code@tyhicks.com, brauner@kernel.org, ecryptfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 10:02=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 24-11-26 20:54:29, Alexander Mikhalitsyn wrote:
> > Currently, when ecryptfs_i_size_read() fails we only do make_bad_inode(=
)
> > which only removes the inode from a hash. So it's not getting released
> > and on umount we get "VFS: Busy inodes after unmount of ecryptfs" (see =
below).
> >
> > Let's fix it by using iget_failed() when inode is I_NEW and iput() when=
 it's not.
> >
> > This was accidentally found while working on SB_I_PSEUDO fix.
> >
> > ------------[ cut here ]------------
> > VFS: Busy inodes after unmount of ecryptfs (ecryptfs)
> > WARNING: fs/super.c:731 at generic_shutdown_super+0x117/0x1a0, CPU#11: =
umount/402
> > Modules linked in:
> > CPU: 11 UID: 0 PID: 402 Comm: umount Not tainted 7.4.0-rc1-virtme #9 PR=
EEMPT(lazy)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debi=
an-1.16.3-2 04/01/2014
> > RIP: 0010:generic_shutdown_super+0x125/0x1a0
> > Code: 5d 5d c3 cc cc cc cc e8 19 d0 f3 ff 48 8b bb 18 01 00 00 eb d7 48=
 8d 3d a9 93 d1 01 48 8b 43 50 48 8d b3 d8 03 00 00 48 8b 10 <67> 48 0f b9 =
3a 4c 8d ab 40 05 00 00 4c 89 ef e8 17 6c b0 00 48 8b
> > RSP: 0018:ffffccc0406bbcf8 EFLAGS: 00010283
> > RAX: ffffffff87d54a20 RBX: ffff8a7bc2358800 RCX: 00000000000000b5
> > RDX: ffffffff873e7853 RSI: ffff8a7bc2358bd8 RDI: ffffffff87e52550
> > RBP: ffffccc0406bbd10 R08: ffff8a7bc235d408 R09: fffff12a00000000
> > R10: ffffccc0406bbcf0 R11: ffffffff87d209d8 R12: ffff8a7bc2358d48
> > R13: ffff8a7bc2388824 R14: 0000000000000000 R15: 0000000000000000
> > FS:  00007fd846e02840(0000) GS:ffff8a7c76af9000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fd84716e8e0 CR3: 00000000037d8000 CR4: 0000000000350eb0
> > Call Trace:
> >  <TASK>
> >  kill_anon_super+0x1c/0x80
> >  ecryptfs_kill_block_super+0x1a/0x50
> >  deactivate_locked_super+0x39/0xc0
> >  deactivate_super+0x47/0x60
> >  cleanup_mnt+0x3b/0x80
> >  __cleanup_mnt+0x16/0x20
> >  task_work_run+0x64/0x90
> >  exit_to_user_mode_loop+0x177/0x570
> >  do_syscall_64+0x352/0x410
> >  ? up_read+0x1f/0xe0
> >  ? schedule+0x27/0xb0
> >  ? schedule+0x27/0xb0
> >  ? schedule+0x27/0xb0
> >  ? trace_preempt_on+0x28/0x80
> >  ? schedule+0x38/0xb0
> >  ? preempt_count_sub+0x4d/0x70
> >  ? irqentry_exit+0x2e1/0x700
> >  ? exc_page_fault+0x8d/0x170
> >  ? do_syscall_64+0x33/0x410
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7fd84705c1d7
> > Code: 0d 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 31 f6 e9=
 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 =
ff ff 77 01 c3 48 8b 15 09 3c 0d 00 f7 d8 64 89 02 b8
> > RSP: 002b:00007ffd3839fae8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> > RAX: 0000000000000000 RBX: 000055b7f819dbf8 RCX: 00007fd84705c1d7
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055b7f819df30
> > RBP: 0000000000000000 R08: 00007ffd3839e8d0 R09: 00000000ffffffff
> > R10: 0000000000000103 R11: 0000000000000246 R12: 00007fd8471ba26c
> > R13: 000055b7f819df30 R14: 0000000000000000 R15: 000055b7f819daf0
> >  </TASK>
> > ---[ end trace 0000000000000000 ]---
> >
> > Fixes: 3b06b3ebf441 ("eCryptfs: Fix new inode race condition")
> > Signed-off-by: Alexander Mikhalitsyn <alex@amutable.com>

Dear Jan,

>
> I can see this fix already in vfs.git as b793b0bfa631 ("ecryptfs: don't
> leak the inode when a lookup can't open the lower file").

Ugh, my bad. I've checked a next branch for ecryptfs and quickly
looked on the mailing list and didn't find it.

Sorry for the noise.

Kind regards,
Alex

>
>                                                                 Honza
>
> > ---
> >  fs/ecryptfs/inode.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> > index 48e520960d66..3a966348a578 100644
> > --- a/fs/ecryptfs/inode.c
> > +++ b/fs/ecryptfs/inode.c
> > @@ -362,7 +362,10 @@ static struct dentry *ecryptfs_lookup_interpose(st=
ruct dentry *dentry,
> >       if (S_ISREG(inode->i_mode)) {
> >               rc =3D ecryptfs_i_size_read(dentry, inode);
> >               if (rc) {
> > -                     make_bad_inode(inode);
> > +                     if (inode_state_read_once(inode) & I_NEW)
> > +                             iget_failed(inode);
> > +                     else
> > +                             iput(inode);
> >                       return ERR_PTR(rc);
> >               }
> >       }
> > --
> > 2.47.3
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
