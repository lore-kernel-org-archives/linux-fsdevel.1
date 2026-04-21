Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594930E0D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 22:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776811778; cv=pass; b=B3kalztqM+C6sIoDVZFs4TwXDW13vlhUAPlhGJQnSU3Qc7qkXwk2K3bgkpmTFeqVucLxTG15cGN61g9z//7HelZYOZmhoueVU38V0FnuVaiDcfmZqjs71pks8sUZ0OvnLcuSHR1aeypx8X3zUM6FBdjsIb7fYdYO9lJBvC0Wu+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776811778; c=relaxed/simple;
	bh=bosIUsk4/qLLMuQSvGeth5PhpnHTAu/Wh6xeZLbghWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr5HYTlKOgEMxdQKxW3DR9blG1TKiplP7XijPEmGUEZNhpCulWa1G5cPMgjngy+QUvjCNn25C6WOnz9nb4vyJalQTgMkka6Y3sl4IIkULq2g0l1SZaRAvROV+oLFppAZsJuK7bHm1r215IZ1Aenmavb+BIo0IVZqqQhiZtKPfKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mY+jx3x0; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mY+jx3x0"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48374014a77so62487595e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 15:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811775; cv=none;
        d=google.com; s=arc-20240605;
        b=R34RkoQplrEkZfvEnALichinhDRWsqFHKY4eqPlC0JkInxvX4m5VyNDffoG59jKWcN
         BqkVphpCpIbV+yDbseuqPQHJ+yy0Nd0lQUIzMJRAtItssdoL1fjAlxjWfsafTus6eCQh
         qNRFbJJyvFV+QTi0vIKqO7l0HPoc1wq+uZIlAtoBWixvAklBju6xsU7Sd8Av3afrZ4hz
         FcqWM8yElm5yDEbRmR0767ce2sZdW0JXpLqaX7YfmUHfCnQsj23I6CzvGkXqlQQqKol3
         9D+yzcXBkcCdOhr6vAA+3nU7b5lGMEg4FfN4LyM/mDoRS4vj1qXaTkI45aY+xVHg318r
         Pyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6VaONjG69h7tMMHTMSL+ukU0IZkEXzpPtrrj0vKzrV8=;
        fh=e22Wdt5MODgTfxRTyAkps647gxhH4CNeV9+3mjf88Qs=;
        b=DWB41roJcTilb9nIf1T2EgFMbvlDKqIUBn1yW62IHElCcTwv5Hbz0S8p0TBaQn7TVA
         Bu+q0+IuChSeSTftWwPJKmwHWnFYpCQJWt7dVJ3Rws36upZW2sPpke8NnW2jL/SsI9JD
         cbMGTpDYMY/rUX6VJJAZBjHJi0+YFZwG/hy/5HwG9T+WnJ6TGi8rISFAxJmpQLd5aAUr
         1izR6wyw9Yc2oSY58WZVh8FOmH/WV+dbzC5EDwEPbInqHnr/Cz4PzFKMa94WHa8c21Qm
         ITRbXPZaifA06upseyyMuYA2sSiCaHQTyr9CgUjKe/h+uPk8Rjx4SGcJZT7cxMwHLfMq
         ZXDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776811775; x=1777416575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VaONjG69h7tMMHTMSL+ukU0IZkEXzpPtrrj0vKzrV8=;
        b=mY+jx3x0vVeVDt837PqUUpwuO9SuG9vBVa2ygBZADa2pUp/7AelhxZY4R5P5bGo7XI
         CzGR5/diHCXWKfZmYCdeZ7/4d87TEZwfVe2AFhzxgNU1eKR4BOnUTVSklpbF1ROZIhui
         3fRzsX0ztzsnjdetMkRZCb0iN6vtKp3ZxuDhBxao+xZdjtGgduYiLy9R6RXD/YrUfD5N
         YwZT/Vhpn8SSwb5lebJzH39OQtLR9xAZHamGu3C0kMSakEI3x4uGzjv5TOK2k3ZHD4b0
         jCWl4F4Ya+PB3jP2eatvN0GLjItOTryw8jhwkvvi0i56SY3/lEZRSAmyhWheuuwz47bn
         4MFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776811775; x=1777416575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6VaONjG69h7tMMHTMSL+ukU0IZkEXzpPtrrj0vKzrV8=;
        b=Zzread8I/vlZp34sSv/coQK/K0W2edCT6Zc8HQ45Kxa97UiKNw2avBxAruTPn8MWC+
         UpXO11zZRz891CgoSFq6K+tZE32o7RgXDghz9LLj2OGHBwsBufGZR0ALeiDIbMZr9rYh
         aPVYnh/d/Ezvlp+OO7QJUmKHNnpGAcWccmRbxF0d7tLO/F/mfhsxmCz0o+hVUZ8SM/t6
         97QAZ0Jeclvz2cOos14PjkAgxXOQ6HbPIdKIYeWGCl78h7BHHWU4GBJ7ZmU9+SdX73Qz
         u1l3eJ83cvNNb1TcPTFJsaXn3dIpFmocHAkep0Kx0VyIJbFPuzNI9DMCZgE40mrH3PJq
         c3jA==
X-Forwarded-Encrypted: i=1; AFNElJ9I5iJzyQ0+GYnnpAyHmkmwbiC6x0l5lm6V1sV/YDgmR0VJbXdWhdRDb7ZhHeVbNSkAojz0Cnt20ALMLimY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy44pFjIv8DiMU2sKswE5phgTZ0EulLe5zUQaoZt5ycjg//3pob
	fMrK7pbeQJYTpmFJhtkUj8disExbrzo1ToxmsKpU+Y4f34qT5nEpX18h5bHuUL70G+rkvo96zPv
	9Eoi50gQnfKnQQ0xT1OyGRfKRb1g8Aa0=
X-Gm-Gg: AeBDievXcXq0qCNzB6hviClYdmVUot+1H8g38A07Ak1qNEtBqNuNAhml97gGG3TR4O2
	dla3N6zTTBO+0NoXjLIq2c02y1yczA8QVe4WHhznlEQPz+qrEypg8t8PbW4A24EQyAXA2N7znab
	mHIUEGfCz/UaOh36U7iTQdYm3KXcca78qkfyNEqsizkWBUfmCHLKjhdPbrLmFBsSx3OynjsC8gS
	4omG52l0guwjQ3oN3/Cs8MN4v15UcNIhtHuAU3pAvI/4VZkakR6TFOiLHmBpMVz/gk5GeVT94y2
	CJgnCFDOiu1DfRXP
X-Received: by 2002:a05:600c:4714:b0:48a:5574:3a5b with SMTP id
 5b1f17b1804b1-48a55743d05mr67189915e9.27.1776811775165; Tue, 21 Apr 2026
 15:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-2-mszeredi@redhat.com>
 <3c9f8396-41f4-4c88-b883-34bede72b427@sirena.org.uk> <e3ad44f0-0a3e-4ef5-ab6e-c346814c0104@sirena.org.uk>
In-Reply-To: <e3ad44f0-0a3e-4ef5-ab6e-c346814c0104@sirena.org.uk>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 21 Apr 2026 15:49:23 -0700
X-Gm-Features: AQROBzB34cTj5BDxh_a3XW8NVm84BziFH85OZmdnlTZ-ivrSJW-qo8iKMKU28rU
Message-ID: <CAJnrk1Y1JzKJ=RCLBt592EZ+0=hPzaLWuHve_umxtUMOSH76dQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead of mount
To: Mark Brown <broonie@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, torvalds@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, Aishwarya.TCV@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 8:30=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Mar 19, 2026 at 11:36:10PM +0000, Mark Brown wrote:
> > On Thu, Mar 12, 2026 at 08:39:59PM +0100, Miklos Szeredi wrote:
> > > Allocate struct fuse_dev when opening the device.  This means that un=
like
> > > before, ->private_data is always set to a valid pointer.
> > >
> > > The use of USE_DEV_SYNC_INIT magic pointer for the private_data is no=
w
> > > replaced with a simple bool sync_init member.
> >
> > Since Monday we've been seeing problems with the read_all_dev LTP
> > testcase running -next on a range of arm64 platforms, these bisect to
> > this commit.  The test reports:
>
> This issue is now present in mainline.

Hi Mark,

Would you be able to test if this patch fixes the issue you're seeing?:

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..d48c10db62e3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1562,9 +1562,15 @@ struct fuse_dev *fuse_get_dev(struct file *file)
        struct fuse_dev *fud =3D fuse_file_to_fud(file);
        int err;

-       err =3D wait_event_interruptible(fuse_dev_waitq,
fuse_dev_fc_get(fud) !=3D NULL);
-       if (err)
-               return ERR_PTR(err);
+       if (!fuse_dev_fc_get(fud)) {
+               /* only block waiting for mount if sync init was requested =
*/
+               if (!fud->sync_init)
+                       return ERR_PTR(-EPERM);
+
+               err =3D wait_event_interruptible(fuse_dev_waitq,
fuse_dev_fc_get(fud) !=3D NULL);
+               if (err)
+                       return ERR_PTR(err);
+       }

        return fud;
 }

>
> > 11468 01:06:07.273320  tst_test.c:2021: TINFO: LTP version: 20250930
> > 11469 01:06:07.284741  tst_test.c:2024: TINFO: Tested kernel: 7.0.0-rc4=
-next-20260316 #1 SMP PREEMPT Mon Mar 16 20:19:24 UTC 2026 aarch64
> > 11470 01:06:07.285022  tst_kconfig.c:88: TINFO: Parsing kernel config '=
/proc/config.gz'
> > 11471 01:06:07.296067  tst_test.c:1842: TINFO: Overall timeout per run =
is 0h 02m 10s
> > 11472 01:06:07.296580  read_all.c:601: TINFO: Worker timeout set to 10%=
 of runtime: 1000ms
> > 11473 01:06:07.296818  Test timeouted, sending SIGKILL!
> > 11474 01:06:07.307439  tst_test.c:1905: TINFO: Killed the leftover desc=
endant processes
> > 11475 01:06:07.318985  tst_test.c:1914: TINFO: If you are running on sl=
ow machine, try exporting LTP_TIMEOUT_MUL > 1
> > 11476 01:06:07.319263  tst_test.c:1916: TBROK: Test killed! (timeout?)
> > 11477 01:06:07.319486
> > 11478 01:06:07.319690  Summary:
> > 11479 01:06:07.319887  passed   0
> > 11480 01:06:07.320076  failed   0
> > 11481 01:06:07.320262  broken   1
> >
> > The test does a read of every file under /dev, the actual binary is
> > read_all and the command is:
> >
> >    read_all -d /dev -p -q -r 3
> >
> > so the connection with a change to a change in behaviour when opening

If I'm understanding it correctly, I think the change in behavior is
from the fuse_get_dev() function now waiting indefinitely in
wait_event_interruptible() for the no connection non-sync_init case,
whereas prior to the commit,there was a check for the non-sync_init
case in the wait_event_interrupitble(... READ_ONCE(file->private_data)
!=3D FUSE_DEV_SYNC_INIT) which would exit the wait and return -EPERM.

Thanks,
Joanne

> > /dev/fuse seems plausible though I didn't investigate further than that
> > and checking that the bisect looks smooth.
> >
> > bisect log:
> >
> > git bisect start
> > # status: waiting for both good and bad commits
> > # bad: [8e42d2514a7e8eb8d740d0ba82339dd6c0b6463f] Add linux-next specif=
ic files for 20260318
> > git bisect bad 8e42d2514a7e8eb8d740d0ba82339dd6c0b6463f
> > # status: waiting for good commit(s), bad commit known
> > # good: [2430154a93764c58b8ee9b6f7e5b3563ff452baa] Merge branch 'for-li=
nux-next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
> > git bisect good 2430154a93764c58b8ee9b6f7e5b3563ff452baa
> > # bad: [1ec9b3fbfc367f64a29f3335ae9879202993b7bc] Merge branch 'nand/ne=
xt' of https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
> > git bisect bad 1ec9b3fbfc367f64a29f3335ae9879202993b7bc
> > # bad: [91392dfbff751ca86443a6f3ce7c46143fecdecd] Merge branch 'fs-next=
' of linux-next
> > git bisect bad 91392dfbff751ca86443a6f3ce7c46143fecdecd
> > # good: [41512607505955aaf57cc6899aa548ae75ab81e6] Merge branch 'for-ne=
xt' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
> > git bisect good 41512607505955aaf57cc6899aa548ae75ab81e6
> > # bad: [515b2513dabbdec4536c8c1b8de56271efe800f6] Merge branch 'for-nex=
t' of https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> > git bisect bad 515b2513dabbdec4536c8c1b8de56271efe800f6
> > # bad: [2115fbae3f0b9ad858373ed31ee9af0b25a63d6d] Merge branch 'jfs-nex=
t' of https://github.com/kleikamp/linux-shaggy.git
> > git bisect bad 2115fbae3f0b9ad858373ed31ee9af0b25a63d6d
> > # good: [41019679bc4f7ed6b072a83ba264908bc88752dd] Merge branch 'for-ne=
xt-next-v7.0-20260316' into for-next-20260316
> > git bisect good 41019679bc4f7ed6b072a83ba264908bc88752dd
> > # good: [a0597d24fd296252e40643e95ca22c752f246158] Merge branch 'for_ne=
xt' of https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
> > git bisect good a0597d24fd296252e40643e95ca22c752f246158
> > # bad: [6dcceeb728567a61fbad781c13828b638b32bc16] fuse: support FSCONFI=
G_SET_FD for "fd" option
> > git bisect bad 6dcceeb728567a61fbad781c13828b638b32bc16
> > # good: [25307ca50b815c14a21f82fc5b10e8a621af32ad] fuse: simplify logic=
 in fuse_notify_store() and fuse_retrieve()
> > git bisect good 25307ca50b815c14a21f82fc5b10e8a621af32ad
> > # bad: [3379620923d3e59b6767605a0f11d13b37d72a0c] fuse: create fuse_dev=
 on /dev/fuse open instead of mount
> > git bisect bad 3379620923d3e59b6767605a0f11d13b37d72a0c
> > # good: [8d306cbffc2ee0f3251c81d574aa3451ef21cd5a] fuse: use offset_in_=
page() for page offset calculations
> > git bisect good 8d306cbffc2ee0f3251c81d574aa3451ef21cd5a
> > # good: [5a6baf204610589f8a5b5a1cd69d1fe661d9d3cd] fuse: fix uninit-val=
ue in fuse_dentry_revalidate()
> > git bisect good 5a6baf204610589f8a5b5a1cd69d1fe661d9d3cd
> > # first bad commit: [3379620923d3e59b6767605a0f11d13b37d72a0c] fuse: cr=
eate fuse_dev on /dev/fuse open instead of mount
>
>
