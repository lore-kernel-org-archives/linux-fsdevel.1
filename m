Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92437CD35;
	Thu, 21 May 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357499; cv=none; b=u4tfIw6b3aGSz4/zmH8mP9944k3USJPPGJu5J4a4U5xDAJUdOB68Yc4wlCe+vvV/a6jsQSENZPsU0o2pZrOpMMMqmLaTobJDdirCj435iDZiMrka+F1XhBOcuQaaHJ3A0zy4VIsuXi0kOl1Xug3IS8npIPVKQr9RWldfzpSA8x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357499; c=relaxed/simple;
	bh=9CGj3c69Q7vTc/lRXlusXfHnoY9CArNY43ltyYpZkoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miFAl8s6EQKyvmK+ehM9xUAhllgshE8cCULxGIlmBT9ZlJ1UwGJcv8EyoPqtMXtF5QhXwVi6hiKTSH9FYNRN/oLgeDGf9aAkjPdQ1HTv1eB4sv7O1SJwFIII7ZTzp63t263sI032qTtpaK7u22Vjyn4ZH9ayNuBPi0QcCKKKwfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=WxZuX5RA; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="WxZuX5RA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1779357456; x=1779962256; i=spasswolf@web.de;
	bh=6Z/Kl70jluO78qo5ym0kG5LN03GlMTuZ9u+ZbPV20KQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WxZuX5RAqpkvg/CjCbSuZ4S0ShtjdUz4V00tf4BDrKiF4fzaB2fXC+i223LmKrM7
	 YjMbXjAtSIQUjk2aM8651QjiA+ztdwJAXuYij+tFKzGG810Vd4LaWgnD3v/N0+bjX
	 TLuCgSxb+6QgNcVoHZwFqwRqKRHRnSHmscmNWNKxOSM9PaLzbjPLgR2t25oVhrznA
	 9T7NpqPQo2iFjxK4Lj8hLc/Vgn7ZxM5OGvtez/luxONZe9FX0GLioo+hAr81/KNFL
	 7AKkNZvSw8S9l2Lz7kZMOGQBjZQ4BdLd9mRLMvWyNbD2InlT6npLpx+YCazp42X5q
	 CCedXbfv3GYelgkxAw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MI3t5-1wbprj0hZH-005gyu; Thu, 21
 May 2026 11:57:36 +0200
Message-ID: <120781e5109918916422a7ad6602d4be29f8fbdc.camel@web.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 	spasswolf@web.de, Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 21 May 2026 11:57:35 +0200
In-Reply-To: <CAGudoHHaEFbft-SmPV+yTj6uMvNYWRQNYAWDP2x_sS=BcvesqA@mail.gmail.com>
References: <20260520225245.2962-1-spasswolf@web.de>
	 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
	 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
	 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de>
	 <CAGudoHHaEFbft-SmPV+yTj6uMvNYWRQNYAWDP2x_sS=BcvesqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:urWEud4rAPogNt8k7G4J9Zbe8f02kSZrY+GTHdoPQbvl/0/kdIw
 mMvpB5GjGBLq95pA8X0H2z9TNHMYgSdmGIzRBdrx2bNSex9tOdh8vmBWGheFLP2wvFCJchQ
 mAwXzx68A/PIP0u9xMa4g08P4p97wlR+wi+PP5OaBvLCEz7l8eacQx0O2Kj4wxCLTjYrUN6
 H60hel/7UVyQiMuic6zHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1CyY5a8sjFM=;1m7OLE9p6Nb7t2TWiSMMnw07tia
 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

Am Donnerstag, dem 21.05.2026 um 11:25 +0200 schrieb Mateusz Guzik:
> On Thu, May 21, 2026 at 11:21=E2=80=AFAM Bert Karwatzki <spasswolf@web.d=
e> wrote:
> >=20
> > Am Donnerstag, dem 21.05.2026 um 11:09 +0200 schrieb Mateusz Guzik:
> > > On Thu, May 21, 2026 at 10:53:03AM +0200, Mateusz Guzik wrote:
> > > > Christian, can you fold this in please.
> > > >=20
> > > > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > > > index 771fc31a69b8..8f17c0abbc95 100644
> > > > --- a/fs/filesystems.c
> > > > +++ b/fs/filesystems.c
> > > > @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_s=
tring(void)
> > > >          * Did someone beat us to it?
> > > >          */
> > > >         if (old && old->gen =3D=3D file_systems_gen) {
> > > > +               spin_unlock(&file_systems_lock);
> > > >                 kfree(new);
> > > >                 return 0;
> > > >         }
> > > > @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_s=
tring(void)
> > > >          * Did the list change in the meantime?
> > > >          */
> > > >         if (gen !=3D file_systems_gen) {
> > > > +               spin_unlock(&file_systems_lock);
> > > >                 kfree(new);
> > > >                 goto retry;
> > > >         }
> > > >=20
> > > >=20
> > >=20
> > > Even better, I got the above fixup + some polish listed below:
> > > - removed an extra space in newlen calculation
> > > - the WARN_ON_ONCE case needs to free 'new', not 'old'
> > > - there is no READ_ONCE anymore in filesystems_proc_show()
> > >=20
> > > goes into the "fs: cache the string generated by reading /proc/files=
ystems"
> > > commit.
> > >=20
> > > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > > index 771fc31a69b8..712316a1e3e0 100644
> > > --- a/fs/filesystems.c
> > > +++ b/fs/filesystems.c
> > > @@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_str=
ing(void)
> > >       hlist_for_each_entry_rcu(p, &file_systems, list) {
> > >               if (!(p->fs_flags & FS_REQUIRES_DEV))
> > >                       newlen +=3D strlen("nodev");
> > > -             newlen +=3D strlen("\t") + strlen(p->name) +  strlen("=
\n");
> > > +             newlen +=3D strlen("\t") + strlen(p->name) + strlen("\=
n");
> > >       }
> > >       spin_unlock(&file_systems_lock);
> > >=20
> > > @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_str=
ing(void)
> > >        * Did someone beat us to it?
> > >        */
> > >       if (old && old->gen =3D=3D file_systems_gen) {
> > > +             spin_unlock(&file_systems_lock);
> > >               kfree(new);
> > >               return 0;
> > >       }
> > > @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_str=
ing(void)
> > >        * Did the list change in the meantime?
> > >        */
> > >       if (gen !=3D file_systems_gen) {
> > > +             spin_unlock(&file_systems_lock);
> > >               kfree(new);
> > >               goto retry;
> > >       }
> > > @@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_s=
tring(void)
> > >                * generation above and messes it up.
> > >                */
> > >               spin_unlock(&file_systems_lock);
> > > -             if (old)
> > > -                     kfree_rcu(old, rcu);
> > > +             kfree(new);
> > >               return -EINVAL;
> > >       }
> > >=20
> > >       /*
> > > -      * Paired with consume fence in READ_ONCE() in filesystems_pro=
c_show()
> > > +      * Paired with consume fence in rcu_dereference() in filesyste=
ms_proc_show()
> > >        */
> > >       smp_store_release(&file_systems_string, new);
> > >       spin_unlock(&file_systems_lock);
> > >=20
> >=20
> > So it was commit 36b3306779ea
> > ("fs: cache the string generated by reading /proc/filesystems")
> > which caused the problem. If I had finished the bisection properly ins=
tead
> > of cutting I probably would have noticed this...
> >=20
> > So I tested
> >=20
> > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > index 771fc31a69b8..8f17c0abbc95 100644
> > --- a/fs/filesystems.c
> > +++ b/fs/filesystems.c
> > @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_strin=
g(void)
> >          * Did someone beat us to it?
> >          */
> >         if (old && old->gen =3D=3D file_systems_gen) {
> > +               spin_unlock(&file_systems_lock);
> >                 kfree(new);
> >                 return 0;
> >         }
> > @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_strin=
g(void)
> >          * Did the list change in the meantime?
> >          */
> >         if (gen !=3D file_systems_gen) {
> > +               spin_unlock(&file_systems_lock);
> >                 kfree(new);
> >                 goto retry;
> >         }
> >=20
> > with next-20260519 (no RT, no LOCKDEP) and got no crash so far (4 boot=
s only though (next-20260619
> > crashed in 2 out of 3 boots without RT)) but I get this warning on eve=
ry boot:
> >=20
> > [    2.793416] [    T331] ------------[ cut here ]------------
> > [    2.793433] [    T331] DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock)
> > [    2.793434] [    T331] WARNING: kernel/locking/mutex.c:625 at __mut=
ex_lock+0x586/0x10c0, CPU#17: (udev-worker)/331
>=20
> Just so that we are on the same page: if you take the -next tag as is
> and revert the "fs: cache the string generated by reading
> /proc/filesystems" commit alone things work fine?

Yes this works fine:
16ff8d6e7c28 (HEAD) Revert "fs: cache the string generated by reading /pro=
c/filesystems"
6a50ba100ace (tag: next-20260519, origin/master, origin/HEAD, master) Add =
linux-next specific files for 20260519

(tested only without RT as the bug seems to be easier to trigger ...)

Bert Karwatzki
