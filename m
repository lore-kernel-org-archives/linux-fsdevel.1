Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658435CBD7
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355548; cv=pass; b=nr6d/uyUKTq5APfRC3oTtRPqiNu8SwQlPG6yc9x6ufTMVeFKD6iUuKe7pG25u9bsMvOvMMKZwk1npgxvlzYavHYXNFmpw16Z174vNgt8g3U7yOLLS/q6KxaXv7PcS8sxqKQkj5J+N7B2U12UfLEU71olnfBvngQUfQgznc1RRAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355548; c=relaxed/simple;
	bh=js5SDLK+zkCRrpw2+cbIyuFJc9IaprQPZ/lIZpi0Edg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YINNRK9KEv1rp5w2DiCKNeXyKJNCPC4aEblB2NxQLT2a6S90pd6jfcIY897TrDcl4hlXSl7A79egcFAR8HFUvYCv9uggtK0OhKUFAv0KizB9JBXoeo5Ec3HGLGz7RAp8zyRpw0wAP163bksPsDm087aKyjvtePGvJrwUPUpG/G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGe50TOP; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGe50TOP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67e9b3037dcso11447148a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 02:25:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779355545; cv=none;
        d=google.com; s=arc-20240605;
        b=LMgJmZ7kYekYWYXoW20fF963+kkHXbq87UL5UGl2iurVwM67pFFoAj7h2aqAz1akiO
         QB43ix76oKGXfN4M7mVooJSqXZ+lSjNbyPUlQufcXhmSzy6R1tFvmbu2GFY1Fl3Likpm
         bo8olqavVDU/lcYfif4ox3deIabifIKuAhmIKmLOljdJWIxBYkXMIL8dpFcB1Sg1vaUs
         JU1rZp9py5jH+pnabJ0OA95IVvTovi3iamWQcEK0YHrjbKFyBlVno9Ba+TKRy7hELPFI
         YGOCpMT0eVUUDFuoRDyTRP2FPHLBoK1oPGX3wq8zgLo+S+CcV3x8dWvjsH9sVAZLRU6A
         WhZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Le9UrzUF2lq64cth3vk6I47k2qcnr5fpjM2SaIXhn1M=;
        fh=SBlxROeSE7fz9DN3+1FscfyWwVY8J8I85f9OM9I8FaU=;
        b=jAPI5iatWx5lOdjLwbgE9OqNDLGSHiNzmBYVAiAUivvih3NvtzWtIi6sDAqpTZoUiy
         q0K41Pj1a/6HCdeo5DPqXyGIJaA1mRQCSaW4QrpmznLGapeqMpg8JARY8ljfZlxUMXF7
         lPXRG2gOf631XJ72kVgVd0B5+CGmrEFybqr4Kt+lUw/666g4CnnAxqFZpQc1uFU3RnEt
         65TYPz36b5HWio6jW4anjVAlsIFcN5lH9A/fsrve1eCZNDkeiQxxZ/cw0ziUaS/RiKbS
         +nAu3Uafsz/WBfvecf4/VtT1Mn4P9SixPBG+1gwpKRAMsE61kAGNyxnIZXUzf0E457WC
         2p/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779355545; x=1779960345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le9UrzUF2lq64cth3vk6I47k2qcnr5fpjM2SaIXhn1M=;
        b=kGe50TOPy7NBVuNK5xjUymqaH8WTqVZSN26ho+io0NMgNAbAwK5LLmaVTLooJcZjXE
         3hn2ldoOmVaRKXSHdOaTvCccC92kDd4aTo3JNcCwGcYccxELorv5zz4FA22x5QY3Q1D2
         wYaTlqQ33mYktDEdhqru8irTq489xqNvzQoq+zOPEc0IEvrxNAiuPL9e1HxkJuhTFPim
         qGp5THbegOYZ5bg7I6G0hrBCkdStOz24zedo3Caa67M6dMW+EyX6yB9x5MY6fnNpeMzH
         4tuvrX5EhRIF3vC09Rl4LWWxKvfDmE+nb+0PztA2hT7ikpNjSKhcC6EeT5Ksly/UJMo9
         R04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355545; x=1779960345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Le9UrzUF2lq64cth3vk6I47k2qcnr5fpjM2SaIXhn1M=;
        b=XVFGr7h0vtX5A02iFUgaHocORzDrvTPAGfx41DKqLt6v0Oi641v8g9SQ3jolrTsDZo
         iGjCgc3UwRqp3N7nidOU7mlkpZi+yTpKY72qdevk4pj3jwkDl1ISlhQh/AhHfcsUWRnI
         pDu3uBmEhfh5ZQgFKB+TbyKBX8/MZ1UWOuv4ao5QZZeFwdxEWgxM43dKGStjYIG2HGMp
         pRzK2hmmmgTx0d7MB9hI7YSEy5D2TrGnu8ghbxEFIV34ubyx9cCLAnPpzq1u2U1xpBQo
         xqmfAfrZ0jXpSNmXbMKnnpDJKQm6sPX87XAdVRuJ6O06AgoK6axtEqMsFmNVE9+sSptw
         P6ZA==
X-Forwarded-Encrypted: i=1; AFNElJ+JfnKqW4YmuOTPahTjAQnLNgpvzOd9Le8QfEhyvnlb1dpVGPHXmHCBw34gra0DWiFzH8cf1EVgnaIFFnBk@vger.kernel.org
X-Gm-Message-State: AOJu0YzKT5X0SUqSKXEbiMe6Znwcp6wzs5bCkRtX2i+5clEQu5sM9kZs
	oUZGFfsMAcXFM1weQutGGnLJZqI2S6Z0q7IFrVTUiYuG/p1DverS5COCeO62uV7RZop5BcMd4Dn
	O6gojNpqv5C9SJxuKPTtZtYKaBP1uzXw=
X-Gm-Gg: Acq92OF+yTmt1QJ7eZJZ9U+v/H4OEEVJTKn1YJfw7kgln0m5WXyAARwLBXVHqS5VdkL
	ADys5rogPSR12CmH381b7iGwSXXLIRhKXq4o3Z390+0XaxZJUOvMSpJZvQEF0F/QN7N1fTevA5k
	0z3xyRMzcLk8lYV0vPL3jGE8PqkqjrXWF+cs8OJZOdU2DgBvsTdNJTwazo0DPq1nT8eZpifXthC
	w6hzZ1/zy712yDw38lTeydHXOxSCgjIFZ15hIXr9FdtOpRoT/JXPz8Jy+AB9tHghJZmlccO5yR7
	uyPGv5vg1GBJiWtxvKwUJFFsNnJ/ms6j0WHipqwpVOIH6tnHZw==
X-Received: by 2002:a17:907:86a2:b0:bd5:7c2:70c9 with SMTP id
 a640c23a62f3a-bdc15f2bc24mr113789266b.47.1779355544910; Thu, 21 May 2026
 02:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de> <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa> <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
In-Reply-To: <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 11:25:31 +0200
X-Gm-Features: AVHnY4KJNdKYQyfq9dcrIQyWHKYMB450aGPW4UBSN6VH-WfCBVPg7E2sdrdWSX8
Message-ID: <CAGudoHHaEFbft-SmPV+yTj6uMvNYWRQNYAWDP2x_sS=BcvesqA@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 11:21=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Am Donnerstag, dem 21.05.2026 um 11:09 +0200 schrieb Mateusz Guzik:
> > On Thu, May 21, 2026 at 10:53:03AM +0200, Mateusz Guzik wrote:
> > > Christian, can you fold this in please.
> > >
> > > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > > index 771fc31a69b8..8f17c0abbc95 100644
> > > --- a/fs/filesystems.c
> > > +++ b/fs/filesystems.c
> > > @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_stri=
ng(void)
> > >          * Did someone beat us to it?
> > >          */
> > >         if (old && old->gen =3D=3D file_systems_gen) {
> > > +               spin_unlock(&file_systems_lock);
> > >                 kfree(new);
> > >                 return 0;
> > >         }
> > > @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_stri=
ng(void)
> > >          * Did the list change in the meantime?
> > >          */
> > >         if (gen !=3D file_systems_gen) {
> > > +               spin_unlock(&file_systems_lock);
> > >                 kfree(new);
> > >                 goto retry;
> > >         }
> > >
> > >
> >
> > Even better, I got the above fixup + some polish listed below:
> > - removed an extra space in newlen calculation
> > - the WARN_ON_ONCE case needs to free 'new', not 'old'
> > - there is no READ_ONCE anymore in filesystems_proc_show()
> >
> > goes into the "fs: cache the string generated by reading /proc/filesyst=
ems"
> > commit.
> >
> > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > index 771fc31a69b8..712316a1e3e0 100644
> > --- a/fs/filesystems.c
> > +++ b/fs/filesystems.c
> > @@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string=
(void)
> >       hlist_for_each_entry_rcu(p, &file_systems, list) {
> >               if (!(p->fs_flags & FS_REQUIRES_DEV))
> >                       newlen +=3D strlen("nodev");
> > -             newlen +=3D strlen("\t") + strlen(p->name) +  strlen("\n"=
);
> > +             newlen +=3D strlen("\t") + strlen(p->name) + strlen("\n")=
;
> >       }
> >       spin_unlock(&file_systems_lock);
> >
> > @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string=
(void)
> >        * Did someone beat us to it?
> >        */
> >       if (old && old->gen =3D=3D file_systems_gen) {
> > +             spin_unlock(&file_systems_lock);
> >               kfree(new);
> >               return 0;
> >       }
> > @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string=
(void)
> >        * Did the list change in the meantime?
> >        */
> >       if (gen !=3D file_systems_gen) {
> > +             spin_unlock(&file_systems_lock);
> >               kfree(new);
> >               goto retry;
> >       }
> > @@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_stri=
ng(void)
> >                * generation above and messes it up.
> >                */
> >               spin_unlock(&file_systems_lock);
> > -             if (old)
> > -                     kfree_rcu(old, rcu);
> > +             kfree(new);
> >               return -EINVAL;
> >       }
> >
> >       /*
> > -      * Paired with consume fence in READ_ONCE() in filesystems_proc_s=
how()
> > +      * Paired with consume fence in rcu_dereference() in filesystems_=
proc_show()
> >        */
> >       smp_store_release(&file_systems_string, new);
> >       spin_unlock(&file_systems_lock);
> >
>
> So it was commit 36b3306779ea
> ("fs: cache the string generated by reading /proc/filesystems")
> which caused the problem. If I had finished the bisection properly instea=
d
> of cutting I probably would have noticed this...
>
> So I tested
>
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 771fc31a69b8..8f17c0abbc95 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(v=
oid)
>          * Did someone beat us to it?
>          */
>         if (old && old->gen =3D=3D file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
>                 kfree(new);
>                 return 0;
>         }
> @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(v=
oid)
>          * Did the list change in the meantime?
>          */
>         if (gen !=3D file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
>                 kfree(new);
>                 goto retry;
>         }
>
> with next-20260519 (no RT, no LOCKDEP) and got no crash so far (4 boots o=
nly though (next-20260619
> crashed in 2 out of 3 boots without RT)) but I get this warning on every =
boot:
>
> [    2.793416] [    T331] ------------[ cut here ]------------
> [    2.793433] [    T331] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> [    2.793434] [    T331] WARNING: kernel/locking/mutex.c:625 at __mutex_=
lock+0x586/0x10c0, CPU#17: (udev-worker)/331

Just so that we are on the same page: if you take the -next tag as is
and revert the "fs: cache the string generated by reading
/proc/filesystems" commit alone things work fine?
