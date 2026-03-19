Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0723DC4C0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931864; cv=pass; b=ar/JWfKlR4xccPFAIX3g1hjcqkoMjZoS22iWYVw01h5XHKWME6gwwc6esgUHfDH4SYnkvOT/a6lDoHQO11relDK8mbtjj3i2UmAMKq+GNmbaU1jVEqA/7lkDlEgni+gBb8JjZeN09ISCcmqAMgpHEdSmBEYkhG+CrpII1IChGF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931864; c=relaxed/simple;
	bh=H6hSfyl/3hQMznCb6ljYtpusInK9NAqhtfiVbDB/PnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlScf+E3mIlrlj5DZvUwN8DaO2oDhGbcsbypJG/zy5QxTp2h/Hn8+rDn9VTSMD9W+bni+BpznmkAEqmRqJ0cXhBZhhyMsdwZ8i1q1UFagOwvO1waZJe0VJhRoQnIbA570D9RzLD8lzTLQ7FJroJ25CkZdbbsdwG50nj5Ciis2HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg5Te2FI; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg5Te2FI"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b96d784828bso142722666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 07:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773931856; cv=none;
        d=google.com; s=arc-20240605;
        b=JX+hkZ/PSPGIzvtjbhqoFYITnFLWJugYCE6iu+Ao5JgL3bSGCeKpSa4VCu8wgkaB5V
         JfSJdcJ/o3qPqjvIxGoip22irvBwzGMafd0JP3DU/VE29gdJDFinNhO+AQg9gafUklCB
         uJBbzlp5uR2X1H7vF/+SkS8ccoBQc3cKvrEIZZm0Yb/Vxcs42dGaC7x+U07nlAs4oPf1
         gKgLu+NzDrjX/juD8RZz+0QuYPZEvlZkTvNcgFwAMHioY4fYqWejxqmXSQzjGDpb6k/u
         ii+/oIIwWMgBXlWSZg0WXtTRlb5SiHUZwPXKpTA4RiAKiFDQYkQVX2Whu4XoaCVoV7OZ
         XTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        fh=f3IcMw4rbnJUX5nW2Kla8IVZIaiBYXart6ALL64g1UA=;
        b=LQ1ofFvMuBni2F5hVSA3Vj5Uy0jGZBhTAomtdpPXtNVgq8Tu30kJPHasjhE9c/qDBr
         vuAYA1WjD/+Cvn4zqhFljsiqNFpwu6hC1T5BUQfAt5scnSBJlIOUBA9Y/Ak82IAjXbkx
         y+BDD6txCcjjDS9gyV5Sy3uc1pF9lgWGhVRv3Rxey36xDrfYdbPjQRhG7hxU4qQhhxmA
         CZz/NzFUE+ZKN6/e9De8PYuBSFm/4cKeQ1NeiX8/AitJ274sdGm89iIjNtNKLRNveypq
         Wg63A5ZVkoeo1jAZd5mZoS0U5oM4NC/ebyMdLkXRMfJKRaKEEFzNTjUCHRMOFByOvYN8
         hExQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773931856; x=1774536656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        b=Wg5Te2FIL+Zl2jNxs/ZAhXPzndGtbGUHGjqvngec5teIxWvdWKMQyQf6nJ0fgvvMh6
         tIqApBZdWMl288cehQz+j9P9XRMyhKag1+3x/WkGdOy0aQE8/s2QB7SMPW5r0qb6cvPf
         pJyu0JNh9Ho6ylPDJiXLaZvtSnf/7QEuE745zQbrNYJMuvCcNR/IJ6VCBWFvjgPuvQq1
         ggu5XDiJV4zwF8Q4wFM2CiZBySHQXmd/IUEIVBZNHI4hFRIJAN3hZHBD6UQqY89IDmH5
         pp5Ph/clzdpsMOX9bcYFKgQojKLwmRYAlKevMF5+b0evAxOQXjKzovWVWIo+UCJudabz
         kfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931856; x=1774536656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PNv+R9h7HIF0XPTxmdIQBKpHP0M3+R/vRZNH6LP2zQ=;
        b=kFGBHv2miAq6qoVm/Su9W7ephCmKcomtNbda1vwa+6wcyXc6vfcDjBg8WYY39tlGpS
         0mzu7mhGrf5t3aPCfQMGU9seTy0Wt/6xhcNLrzBgX86j7k3IpiVMHamxm8ExweTvGq3t
         lQg/yehC4qpJPeEe85Y1slb2yq23mF4vnwaTsCRY44LW0sYjrERaD0Hf/DSBEreOHl0Q
         oeTw+DZoYaJE+HbWifiEVtbpxpOuwynpTuThCiXZsotFSa3BKjPoNX5Y7kt3e9YjHgck
         y9rADaVEvxE3dW/Hp3VyCbJmUKzo3X41QDz4J2ixsoxNz8z30hfL+NgYAHYpzcabKIc1
         K80w==
X-Forwarded-Encrypted: i=1; AJvYcCXhP2kii7sA1dDxXEwu2MiubJ6IAyrH6KE2Qn92fAPoAR/Fw3K3sbaFAT5u1kkKLm+0JIzOYg0xRMGljeL1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/oQCPlXRWU0kphrSoYCGPPBQR5PjyCwAtaH+FRkrrnbcIBVID
	bYq4VZfqyEM67WM8cKt0yObz5veFHfuzTA9eyLf+vcXLnln8GKBeb+lELvH/geJxsxe5waqc1wa
	Djoe3S8XKVFG6oXwmlHQN47GApaxr93U=
X-Gm-Gg: ATEYQzyOE/hDp+AQRTD/lFmS6QJZrpjvqOuWVDNbzy7bNX+G54Dc+2TDW5ykCN1k3Cm
	Qo1i323NXjZ+uTyU/dyvsQ8I+aI8hRDo2pQxVcQBmuTKIVj9iwmAGwgZqR7Mjt/kFVENusY7eQG
	iZrH0luwtBHxWDs9Fbxw4KYTEsDYan+My4pUWPYEFsCRG22eKK/Yg3RqNiRvKZ6r3cxuIR0qerd
	nunKHG/2FYyviFHyfaupHL6FR4N1mbZztuVgpp1S1gSHWpJYXNkDT3IR2Ek4sDaGBcxXoqHcq1b
	ntcSMeWZd0fRy2MeHS33rzhBit44y78gwmeGGYC7MioPVaS/++Dj
X-Received: by 2002:a17:907:1b06:b0:b97:aea3:86dc with SMTP id
 a640c23a62f3a-b97f48e0c86mr555307866b.15.1773931856096; Thu, 19 Mar 2026
 07:50:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319124616.1544415-1-amir73il@gmail.com> <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
In-Reply-To: <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 15:50:44 +0100
X-Gm-Features: AaiRm50Tod8HscrjlQUl55658cqI4Ii7lNI4-xMEI5BRod0xGVsfCDlxh5_S6TI
Message-ID: <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Gao Xiang <xiang@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH file=
.
> > Skip setting them for O_PATH file, so that the O_PATH file could be
> > opened with a negative dentry.
> >
> > This is not something that a user should be able to do, but vfs code,
> > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> > before instantiating the dentry.
> >
> > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >
> > Christian,
> >
> > This patch fixes the syzbot report [1] that the
> > backing_file_user_path_file() patch [2] introduces.
> >
> > This is not the only possible fix, but it is the cleanest one IMO.
> > There is a small risk in introducing a state of an O_PATH file with
> > NULL f_inode, but I (and the bots that I asked) did not find any
> > obvious risk in this state.
> >
> > Note that specifically, the user path inode is accessed via d_inode()
> > and not via file_inode(), which makes this safe for file_user_inode()
> > callers.
> >
> > BTW, I missed this regression with the original patch because I
> > only ran the quick overlayfs sanity test.
> >
> > Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> > test case is covered and that the bug is detected.
> >
> > WDYT?
> >
> > Thanks,
> > Amir.
> >
> > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-amir=
73il@gmail.com/
> >
> >  fs/open.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/open.c b/fs/open.c
> > index 91f1139591abe..2004a8c0d9c97 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> >
> >       path_get(&f->f_path);
> >       f->f_inode =3D inode;
> > -     f->f_mapping =3D inode->i_mapping;
> > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > -     f->f_sb_err =3D file_sample_sb_err(f);
> >
> >       if (unlikely(f->f_flags & O_PATH)) {
> >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> >               return 0;
> >       }
> >
> > +     f->f_mapping =3D inode->i_mapping;
> > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > +     f->f_sb_err =3D file_sample_sb_err(f);
> > +
> >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ) {
> >               i_readcount_inc(inode);
> >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mode=
)) {
>
> I think this is really ugly and I'm really unhappy that we should adjust
> initialization of generic vfs code for this. My preference is to push
> the pain into the backing file stuff. And my ultimate preference is for
> this backing file stuff to be removed again for a simple struct path.
> We're working around some more fundamental cleanup here imho.

Fair enough, we can rip the entire thing from vfs if you don't like it.
The user path file can be opened and stored internally by selinux
without adding all the associated risks in vfs.

Paul,

Please see compile tested code at:
https://github.com/amir73il/linux/commits/user_path_file/

Feel free to use my patch as is or reorder/squash/rebase as you see fit.
Feel free to attribute my contribution any way you see fit, just pls cc me =
for
review when you post v2.

Thanks,
Amir.
