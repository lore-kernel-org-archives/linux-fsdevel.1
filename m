Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916341760
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 16:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876866; cv=pass; b=eE9y64N9xjCaldzDMQsBBrRq/R42pnZnbHzeD5s+e5I5Qo/kSQdsusoNhAYd+JVD8nxSNpt/TJVZ95zuBrcESs0YKS9OUzUtr7OXWKI6cdUeLprJLH8mLcgOH/RAiKUd2yyeM33vjDASJbo4F/YgargSt/ktokp77mUT1tXV144=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876866; c=relaxed/simple;
	bh=yNiozV/uIjirTmrzM0L/RBnHmhWLY0x6gNoOUuefcZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ55smd6YU/l9FDEGWzK6Cq7aojQleLlkCG7zz2Cj7q03cExSZOmuPrTMZz/az106SO7d+wrJBUsGQlGffGPrIttOe/uckgmjb8p2OthXtxK7lszDc/pp+aXlofXSZ9708A/thTCXbpBLBUK0M7xhopngimYl1Q2qwZafipihvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5FwVGET; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5FwVGET"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so74437065e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776876863; cv=none;
        d=google.com; s=arc-20240605;
        b=ZTpB2vs5p8q8fuLVB8vGh/60r6kD69NsJvRYCkPRrae3OE4jAHEgQ65mRi0fYMbfVb
         +FSZ4/HPQUsDY/bWIm9FWx34WEpUPWELccDtXlnEy5FIzdH0U/A41lgmFUT2/2pqbtbb
         9cZeeHSRnj57rMlhwElANE2oI9ts27wd5AuMO58MK9u/gKMj+aglwXUHRCrT0k/P/0xb
         10BiT+JPPs5uCogTPTS9K0ke4bjVNBzbKNasyIqgHYAgsiT436l4FkvEK8XDgY8+ok73
         8QzOYgWTF9tRJ6mr7pZakezU9KnimM6pwDv4lKnHzqCiSBxM5WyHvSoHDuSFdtWpN7Xt
         wB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+oiFs1l26/V/qS2zOH1FqnpYb/RHhrJDmUKUEt6eOsA=;
        fh=DHwYp9YACplFa6F7suxk3SLs0Rp20kiFKXCaUkAanVg=;
        b=L1rhL1CqDewypcw8VlSeOAJ2bTeUh15cQ3bd19Mnln6z2Fi5mN0WoQonH4S8DBU9je
         Z7NkJdGbMWCZZwJNoGi6IFM/WjqbQJED/nCRo5X3Z01vjwTMR16MH3bv7S6djT8kPZcL
         FkXF2aZzWfQQeYlJiC+n2ZQJMhkbL13CAGapHWV7Vn++u3qsE0rV52+teVSG/6Eo5Gto
         J+iNHfnz7BooEEwrUYyAntVB6yHii6ok3s2h/bu1n4ppMtfecYcH6T9NuFxFDzdgtX1o
         IM1FD4HxZ1B8VPUo+u1xGXs/E4FAqgvyDV4AuJ0xD0xz0c9yZyrN3nYPqAMq1LLS5Cni
         pWYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776876863; x=1777481663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oiFs1l26/V/qS2zOH1FqnpYb/RHhrJDmUKUEt6eOsA=;
        b=m5FwVGETRJK9FculNYnoikryaDg4ltjNl70X7C3ZKmfjUBEi18cKdbDwMb9mBneDF3
         rTbPvdkRC+lWRH+feV690W0cYBPcJVHYms1RXIz1szzoHNymoBSQy9UMy4Oe98T/6Daq
         amiSMGISZJET2iLiAtMpKK4M8xGlgYLZ2+rwRU6VUPc7AoLufNNa8/WLbpmssAcn2gsF
         0m8NT/8QVXsDh3BAjg+vKsH3EyOD6MsKRe/vap9FTBUH5JocMCLg9BGvL044tkQhIG1b
         fSNcwmkJZ7Ml9uGhuv3+8vADpQEZT+BwdSJZMWTs1vwoTYhaaXquTBWUag50FWSd0Gmh
         /iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876863; x=1777481663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+oiFs1l26/V/qS2zOH1FqnpYb/RHhrJDmUKUEt6eOsA=;
        b=LKhTQsBWN1G5MWwB8Us/fvyH5x6tLnk+BOiE0JMWAs0+g+oXFUgT9Z5vhIlXiaHSBU
         kp6YxeQzvJSdGUZTKfX5+t58BjhzwcXZNsoEDyTB/Cw2M4BLdD647uH11I7q74cTPI0O
         fx68d3xOeakDZ65fE5478qQKTA7WwwssDxdWYyPevfMSZq+5rSn8ng93jnGs0BBAWYTs
         Nk82O0P0fP5JYGbxQjbXMJrIpkZce1J5k1hB1JzpkJg2Hmgo+idWoOoQvh6SGH83xlLC
         NYba3nETo652aWezKtdxWxtYHuCiIPsdeV4xv7yQYAVqNUDhcir4hUCFUobgv7kpZGKw
         ysag==
X-Forwarded-Encrypted: i=1; AFNElJ9ueV97CXPuCrWHt5RyuqPiLiWdj4jEwY0Fr79KM2NzqrDTW2CmJCDiLFR/WblFNAOP8rwMOvrWPwbHK9cJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1YKIshTrWE8f2LKRaDJUyCKQpmShn1LSPoA4eg/hOEZVqs4by
	pDHivCOw6IJ6pQO1Wh2lb+2U1kqXgGBJceI93QftMn7nC2Ep7lvHTzhAVOz/AFs4R+xCeXEfVMz
	871lzihd2zE+7VO1UevpeVJIFR7oqnng=
X-Gm-Gg: AeBDiett9Gel2Jjizi5afBV6GgiGthLY19ugFw3v495B9yUQ5RiIxaWOS9KF+7j82zR
	sfarx92oS5MkKgyFEtdL8ypg44ftQEQvD/Sk6Jb5GPuMs5zK8LZ3HO5VfOBEjODzPgkC/YrgCw+
	RU8cmujxP9hY1LURW2+j+r4HTr5j/zlQz8O9Arw4exbwpbOK4fWHHd0dk8rpg7DmKhWyCX5sL2l
	OcFoWyhHkPAqS+tYNaI5jnMSWVaJeORuitJEIrVu+ypVKV65K4aKw2iYT7iy7NTIBfRsU63mpAL
	gDvV7kXjglGcnPzf
X-Received: by 2002:a05:6000:2f83:b0:43c:fd7e:72eb with SMTP id
 ffacd0b85a97d-43fe3e144b5mr37616868f8f.41.1776876863179; Wed, 22 Apr 2026
 09:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-2-mszeredi@redhat.com>
 <3c9f8396-41f4-4c88-b883-34bede72b427@sirena.org.uk> <e3ad44f0-0a3e-4ef5-ab6e-c346814c0104@sirena.org.uk>
 <CAJnrk1Y1JzKJ=RCLBt592EZ+0=hPzaLWuHve_umxtUMOSH76dQ@mail.gmail.com> <CAOssrKfVKvJeriSm7zeRd8xd6mMgRqc3YkpY6rehBtGSy=JVbA@mail.gmail.com>
In-Reply-To: <CAOssrKfVKvJeriSm7zeRd8xd6mMgRqc3YkpY6rehBtGSy=JVbA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Apr 2026 09:54:10 -0700
X-Gm-Features: AQROBzDfDwkABEqH8NAutEtKTfO9vVvZXZbbipKn38d3E87t1vkhJeiUDdEXOQc
Message-ID: <CAJnrk1aC7za1COhMOKe6abhjCPhV-OsNN5v_-dY=qs8ROsG6tA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead of mount
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Mark Brown <broonie@kernel.org>, torvalds@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, Aishwarya.TCV@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 2:04=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> On Wed, Apr 22, 2026 at 12:49=E2=80=AFAM Joanne Koong <joannelkoong@gmail=
.com> wrote:
>
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 5dda7080f4a9..d48c10db62e3 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -1562,9 +1562,15 @@ struct fuse_dev *fuse_get_dev(struct file *file)
> >         struct fuse_dev *fud =3D fuse_file_to_fud(file);
> >         int err;
> >
> > -       err =3D wait_event_interruptible(fuse_dev_waitq,
> > fuse_dev_fc_get(fud) !=3D NULL);
> > -       if (err)
> > -               return ERR_PTR(err);
> > +       if (!fuse_dev_fc_get(fud)) {
> > +               /* only block waiting for mount if sync init was reques=
ted */
> > +               if (!fud->sync_init)
> > +                       return ERR_PTR(-EPERM);
> > +
> > +               err =3D wait_event_interruptible(fuse_dev_waitq,
> > fuse_dev_fc_get(fud) !=3D NULL);
> > +               if (err)
> > +                       return ERR_PTR(err);
> > +       }
> >
> >         return fud;
> >  }
>
> Ack.   Do you want to send a proper patch?  Or I can just add a header
> and your SoB.

From e434521edf44596239a07838a1a8b37c5f0464cb Mon Sep 17 00:00:00 2001
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Apr 2026 09:31:23 -0700
Subject: [PATCH] fuse: don't block in fuse_get_dev() for non-sync_init case

Commit a8dd5f1b73bc ("fuse: create fuse_dev on /dev/fuse open instead of
mount") changed behavior so that fuse_get_dev() now unconditionally
blocks waiting for a connection, even in the case where sync_init was
not set. Previously, non-sync_init opens returned -EPERM immediately.

Restore the previous behavior of returning -EPERM.

Fixes: a8dd5f1b73bc ("fuse: create fuse_dev on /dev/fuse open instead of mo=
unt")
Reported-by: Mark Brown <broonie@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

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
--
2.52.0


Thanks,
Joanne

>
> Thanks,
> Miklos
>
