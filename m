Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC643E8C78
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935714; cv=pass; b=HFwRJLx49+MWEl2n6Jd45/0XoFcAMt87bcgYpTiHqQGbi1LZrzXld5+wSOmXHl+BNhJSjWR5x0hgxdUg7FSIBZNTVWL9BQZ4jSAXj2hL0xUUFI/ULb9tGeDi3ZcUzgQ/X5IUon8dlTpaBUIYmcl1AczoBSsrojq7LGyNoBVeYtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935714; c=relaxed/simple;
	bh=x5i4G6OtbOoqMZckC8IG6y1IC1mTcG4nPuYjxaeMyYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxWeEZ4XQwPEhWHyk4wUHB3k1Hnyqx2smDgmMOpTOJ4Kivok3krLA21whuJSxG96c9IZEdp++O/VlxmUB4289i67L0xUkjcUxlQxt/e6cTVZN1kNavi5gauaVF/wm7Rc59kZS3dCobZUyLukLSqEfHhoWsAgFaTGUHawZ7FeSic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XfiVnkpG; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XfiVnkpG"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35a1f3f07ebso593980a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 08:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773935711; cv=none;
        d=google.com; s=arc-20240605;
        b=aMr832q/EJYjQrAkMQKksy8PzKE6AQ8Bpw8zvMXBx1U95hHhCI0LJR5gcexgumEeyX
         5Fd8ErA9vhjtPFjHGjdAe5OozF6c4vYLIKudsvKo2zR95JL0Ni9xNsc+o4mgL4G/hhrf
         11L4W5D5o9+I+fK8SSshPR3VIQhQqZxecGXTJ4y1W3F1Ejn+va+ob+iaOlyoceLTPAa2
         aQ6HukaoiNa0p+EpO5kxBxbQPeSQzU1+AQL6ZshQFcFyfhSWgu4Rdxz4TrhO4uAfwov1
         Rdxc18Fa1jry4dM2N8rXunA0TGAeVCAImjIxBnbt4wrQG1Qzd01qiXELyuORuUPtPqfU
         6zoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dUObDXy8tyO/dqZjJVHNnud7OeR2yjgyzlwu5eskHg=;
        fh=TWK0j2EU1wfgDK2WvvNUX9z4Z566ipDMZMDyNhmDh4Y=;
        b=BxPphOm6sseCq/u972OLBcvnu/wtBEIWJFW6b7sMh/Zwhc16ROM3RKCfN5OW/sRpWq
         gGpP3ebX+uFuVBqt/8vuLM0AmjHaQsfX3YEGndmrancwcF2AF8n8JEg1QFzRjOOXUetd
         4tc1NW9raw+6UjSFKEujIV2z2ArI1QWpGXfnuMzScFCyCBEJfMLKISXuEe7yCB9DDjSz
         oU/zlELt2zTkLzEDE84/A2Ft79dkM8hODipp/HrhcytwkvdmOXwcTu8ZDzLqVgTn9SBj
         10sdCvgIiRvTobKvAyl+G8Jf8qKOMco1d7mje2L65WTyDSP2XJ2JFK6I4RjFZJvkBU0+
         kycw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773935711; x=1774540511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dUObDXy8tyO/dqZjJVHNnud7OeR2yjgyzlwu5eskHg=;
        b=XfiVnkpGB0S7KTHXXVWMJAMAqTm8a3K0t7y95yso7tdAXPhSLG6fVdljC3xxC077p5
         UcID72OJ44Zzx2swySirmq1XxTT3m2MyaV+9eR+GoJrEFfMiksX6cX/eAyCOJgkwniWa
         Tb8NW+8fWggkKB3qiH5B2amCgUPVFcHvt6Ha2ONwmKncHHTCUCzJ/NrRS4d3syxUwj7C
         8JZdDqRDjXn8S1kYz375bqy5ieYoUuU/K9v5jN3lSfVMyEMh41lqpB2pGlgnfAduDn8q
         Zk4IcbG8raL7pUuvdTDBOS7Pn9lKK0V94u5JXpKWzXOa3hva+BJSDvJ3HGJMHm64wpv0
         klag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935711; x=1774540511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dUObDXy8tyO/dqZjJVHNnud7OeR2yjgyzlwu5eskHg=;
        b=Aego4aF5Z/xPAxmjTfgK8+DP6oVZ4PQrKrKLfVsQEC3y+0Nnd7oB/ErXRpkz0vC+Ep
         5tZq54azWPHW4nZxp1WxxQh0sPNGbZstr5qoJLqSSBzDsCSb2CCC3d6u2GgRvIHxMDPc
         Nnw6ekISRDN0JdNyQng3DIsIIeTw6lkB/InaYvS5eMKWP0A8xVSf4gpQD6qD0MW+Aqcy
         8OkTD9waAG7n83kzCqv4s7nxBhUF1USOHl1pmVU+ucxPCizBtbtqhMz2N+5ozg63rFrF
         KvHW2mK72AVp5nll1XNgTTCk+G8AjPRcdcJuzZCgkXE7eh/fWJvRcYXYe2jyv8wqrxjD
         L6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVv7QXUb5SWm3Bz8O4/1VeN5c6xV7n7jCqwFaXdLcpowmo7G+RC6HBKeqFx2gPTUb03ftD1uEF2/Zxw/NYT@vger.kernel.org
X-Gm-Message-State: AOJu0YxpxqSBsoYE222Pnh2u6ycZOQj0eLsPf1I5+f7RXvsVycnb/ffe
	N9YTSabUx4u/VlZJc7wHoaIcZp4RgkMigW3DRYR98F4v6FC/MXSfeI0J3kzCRLzTSyleGCu4FZx
	VRk+UQ1IJSllUDAq0z+Rvc8POCoIf6CqCgZlrWQsd
X-Gm-Gg: ATEYQzxwx3BU6ndG2QVV2dPcsTmlNx3aDu9GDXzWHXNS7mLSBkFgwGkNrwapS8NatcJ
	8H64e/evE3YAwy8PqBlHh4LODlaUsJ/XB5ciql3AXDSjZr+akDqwiAVklArRXl3jmwVJA3nSpF9
	jjkB/noJm+w/PLq8Ej3avMR1MbM2rIntD0cQFo4XBby+qz5tth+ffhfcxYLqbk+eAN8yBqNtXWx
	JTDoBzNrQCDEbQ/iXX+R7M0ZiDuIMtllpKm5TNGUT7SZb4IkRRR3qWKOaubLPg54QcqdGGnAocI
	a93hF5/I4hrbnOpDcQ==
X-Received: by 2002:a17:90a:dfcb:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-35bb9efae55mr5927149a91.22.1773935711512; Thu, 19 Mar 2026
 08:55:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319124616.1544415-1-amir73il@gmail.com> <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
 <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Mar 2026 11:54:58 -0400
X-Gm-Features: AaiRm51qlPregfqoGDRQQu1uLckOXRqh7QNN-0XQFNPe0ZKCktL-8XDfXZ3JIYA
Message-ID: <CAHC9VhQDXHh_=X-OKD9oN8fapVXBwLakNp4rEHLUL0cQ1RSteA@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 10:50=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
> On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> > On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH fi=
le.
> > > Skip setting them for O_PATH file, so that the O_PATH file could be
> > > opened with a negative dentry.
> > >
> > > This is not something that a user should be able to do, but vfs code,
> > > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> > > before instantiating the dentry.
> > >
> > > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Christian,
> > >
> > > This patch fixes the syzbot report [1] that the
> > > backing_file_user_path_file() patch [2] introduces.
> > >
> > > This is not the only possible fix, but it is the cleanest one IMO.
> > > There is a small risk in introducing a state of an O_PATH file with
> > > NULL f_inode, but I (and the bots that I asked) did not find any
> > > obvious risk in this state.
> > >
> > > Note that specifically, the user path inode is accessed via d_inode()
> > > and not via file_inode(), which makes this safe for file_user_inode()
> > > callers.
> > >
> > > BTW, I missed this regression with the original patch because I
> > > only ran the quick overlayfs sanity test.
> > >
> > > Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> > > test case is covered and that the bug is detected.
> > >
> > > WDYT?
> > >
> > > Thanks,
> > > Amir.
> > >
> > > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> > > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-am=
ir73il@gmail.com/
> > >
> > >  fs/open.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 91f1139591abe..2004a8c0d9c97 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> > >
> > >       path_get(&f->f_path);
> > >       f->f_inode =3D inode;
> > > -     f->f_mapping =3D inode->i_mapping;
> > > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > -     f->f_sb_err =3D file_sample_sb_err(f);
> > >
> > >       if (unlikely(f->f_flags & O_PATH)) {
> > >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> > >               return 0;
> > >       }
> > >
> > > +     f->f_mapping =3D inode->i_mapping;
> > > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > +     f->f_sb_err =3D file_sample_sb_err(f);
> > > +
> > >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ)=
 {
> > >               i_readcount_inc(inode);
> > >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mo=
de)) {
> >
> > I think this is really ugly and I'm really unhappy that we should adjus=
t
> > initialization of generic vfs code for this. My preference is to push
> > the pain into the backing file stuff. And my ultimate preference is for
> > this backing file stuff to be removed again for a simple struct path.
> > We're working around some more fundamental cleanup here imho.
>
> Fair enough, we can rip the entire thing from vfs if you don't like it.
> The user path file can be opened and stored internally by selinux
> without adding all the associated risks in vfs.
>
> Paul,
>
> Please see compile tested code at:
> https://github.com/amir73il/linux/commits/user_path_file/

No.  Definitely no.  Ignoring the fact that there is no reason we
should pushing this into the LSM, doing it in this way means it is
very likely that each LSM wanting to provide mmap/mprotect controls on
overlayfs will have to create a new O_PATH file.  No.

... and let me preemptively comment that this doesn't belong in the
LSM framework either.

As Christian already mentioned, this really needs to be addressed in
the backing file code, please do it there.

--=20
paul-moore.com
