Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46B45D93B
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789921940; cv=pass; b=URsEaL/K8VHozaBtqGWQKzdusXLrvMlA1uvGPqH35HA8XRoI9GjlDRWc43mLMzcQcmxpe0prVp7I6E9aJb3S+4GIj7Pyk5jSFkdvawIr11k+g0U9/olvY/d9ezKKNDCAt0a5i/hSOEr1OJBgj2WwBszT24nSSm6k6XjfkyTlrhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789921940; c=relaxed/simple;
	bh=+4YERuX/Tm4BEarMicY7oOWvS+xS/CmiXnLfQ+itnn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/Azl0pfymwso8O4Wx2JlKbaSFtoljI2r0dO9P4wLb4CR8p0BtFNO2JFAmQhBet9UX36CxkiK/F3dWh/5nWS3xupDnmJR774fgok9hNxse8iu2JvoE96ayNMH6vdt1qlv1KBft1wo90rSd5qfk3IBASDR2UPIN8OmyQlbaoFNNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NE+s2rF9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2Zrr29N; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NE+s2rF9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2Zrr29N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789921934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
	b=NE+s2rF9rmHr7RWbmayfgzY6aMLiVodPbc77lnIvK+GiQDyryLQ/wrygrOum698e6IUG9T
	2EI6PmA97MB99dMuHzzEWZigEUmMKzgDerBu+E2UTx2qyw4fdkfyygTZQ8kqJm/vgrcxpf
	5E/sehzlNwTqljoW1/imgtpQf8q9pEY=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-AjchMxU0OQGN08Yf1F25AQ-1; Sun, 20 Sep 2026 12:32:12 -0400
X-MC-Unique: AjchMxU0OQGN08Yf1F25AQ-1
X-Mimecast-MFC-AGG-ID: AjchMxU0OQGN08Yf1F25AQ_1789921932
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-66c70bf18a1so2372846d50.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 09:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789921932; cv=none;
        d=google.com; s=arc-20260327;
        b=DRYtwMF/mbG0EHM2ELAg/GLvfYbtigriU0wgYYOQrYV5k97dYx7dziQMtXDI1DA5rR
         rmwLgVLmnvi4DzgCWn3/k6kje4QKhoHwLwi3qYOtRgYZQcjcd1QyAidIaUjjcFIQq9U2
         oiUqhk5ZIzY217W+qUynqb10FFFIh9W71lrMCeSfSR2/blqVB7BoA0s6KjOZeyiE1Rjr
         2FXoBvewnyI9BzXho3HmDWovWVD4YkqfC+x+/jersvqZxy9xmpDv25NiwVzghqCwPXnB
         tIFH/+z76h6lf/T2rQ8ZcZeoQKCowqZO8XEUBEecKlLouDGYYNRlrDUf53MiuYhgS5dk
         xQVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
        fh=U+Lae9ZSg/6N9E/gyz6ek7mNUujOwHUP73gou3LuN/k=;
        b=cjCR8+zcgLiXb/lqCJNyhpmyJZSo2/0PTyg4/T9+JtNpH5eIboSGcxmWLCxgrj/VsH
         j2iZuvgD33mVYB6izZJjBuGJZF6ZJIPzSYmOhHu03/TppEHUqHeohBnAzDoG2oEREDK1
         LZa2Fl2ShjUXfUY/BrvDBKA6WfQlEN7V+B2Hmo/zi5FmB9SrBeLf9jYzocg60o6qg3SK
         6d/S0bfjXpLAG3g7GE5i3zDxV1ZPLuHfCU8dDFuD+G5Z2VCm9xR4B5nBRLY05x69i19i
         gUdDqsKpDl8dyZj26/FMrSeLptc5PtC8BW/e3CSl13bHoh7k6UVobgbGIloK+gW+H2UH
         frLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789921932; x=1790526732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
        b=O2Zrr29NPOW53WilSxjiGi5+GUNvcBVvdOoqH73SkdEdUiROaNcUr/Dadgv5HRQK5S
         5SohqF3YNLsUhWrHOtO3hDALjesXlygri5dK03KUhIieVN3sd/R9gCZqM285mVAkkhSO
         +eCemdvwbh99xjp00OjVgcow4v3enfWfjUWx3UPKM7+p9xcABOtqk9+quAtR6yiQevRE
         Pp9/kavNr2iMDdp8J2+ssCMO+kFuzKCkCXRvpHRP1Bb80K7ygFIvx1ywjX2h1ZZ6Kvd+
         K0KmEy87O5P2mJ9RdpedP4huuujk4F2y/CyHDRTDF5v8GBCOGDpjxyjqYIsYaBPnBFSH
         YbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789921932; x=1790526732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ElUqtRQzGRczK+6qtQzmlt/OBYAjwvyq42r0CytLLM=;
        b=DSKwtCBeBOZdrFuFVGXuj5XltP1W0qG1Yw5ruJ+Um4ga/nMq8zn9XsaC3lbOw0JrHJ
         Z+30hcqvtqXlwBMicKmVn0UaQ0jGiDi7Vafrr3TUBiG9kSYYjXPV9tC7IsjhvAmN7Sg7
         DeNbSlB5lYl2wXj12hF29QNTAGbO7C0p+kWn+Hty5+XZRQ6uBCqlAF0TXFAaywVsWz2A
         Pbgu/yT83A1AR7wKtmum0MzFX0L7OtG7qsTSFtgYPWPpsmMJONLiyb6sU62CP5vysRPS
         FYfF6udG8w3VFfkLq5suQbqFwEpGpZarZKzr4ry1TKkMIJJp/lE0rCxUZY9daRuIAmlF
         ppnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUFnzsmaOUq38jySkBc/ztvHO0jkCGBFB6PcAoMY8jvZuka8B60aVLspNJyioSbOfSvqWNpen1s5PQjKbt@vger.kernel.org
X-Gm-Message-State: AFuF++mpm/AryjeWnEjrNCMsQq6SGlWqeHjeJ4sY4YIIqEjMHAIX1Kt6
	l+Ve3izN6XgmGHJruO5WklquscEdZQ1an+j1XLrNPMLk3rtvMSeyRMZRV6LH1zY2uCm/FDE4yjY
	C4dfaGS4LFXZwmygK/TcJmTVa2/vxQgq6XKk4eTyTgGl3zu5Zc0LdoaBqjzh+N76FzCcmgKG+ou
	CqxPkH/JswdriTE4Vr11jytOY6VMYkUUC2CujxdTeW1g==
X-Gm-Gg: AYBFou2g5yTU8h/BNga/xc0A2UcUuUqRVCKQQGYYPb1JKX0OTj1likQd8mfymsV0pr4
	BDQisaznDsVmpGgZ3DFIxgF0+OYhtJ7SHeI+48EkA2QkJy4r6HNsCNH/bU5QmFzzmbL2gwOToDf
	Wg/ZKRmWX6LEnr8KpUnUsJGU3jD1J5VlTF8qp66PLtUUv50ChbMbsC7bTowYwD3dDMI2vHGA3V1
	uGBmap6J+j4WNpd9HkfvxLFbZAONDMBh4KL4/rDEJ5hag==
X-Received: by 2002:a05:690e:1348:b0:671:50b8:aee4 with SMTP id 956f58d0204a3-6717fdf7f42mr2684434d50.77.1789921931926;
        Sun, 20 Sep 2026 09:32:11 -0700 (PDT)
X-Received: by 2002:a05:690e:1348:b0:671:50b8:aee4 with SMTP id
 956f58d0204a3-6717fdf7f42mr2684413d50.77.1789921931459; Sun, 20 Sep 2026
 09:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919022441.3305170-1-neilb@ownmail.net> <20260919022441.3305170-4-neilb@ownmail.net>
 <CAHc6FU4M59nodfn+NCDsr81Wdmvd1Ubw712FF56ekVWfe1+Nuw@mail.gmail.com> <178985655280.37859.6894749467886035489@noble.neil.brown.name>
In-Reply-To: <178985655280.37859.6894749467886035489@noble.neil.brown.name>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Sun, 20 Sep 2026 18:31:59 +0200
X-Gm-Features: AcwNN1WDWK2kuJ9juQym02aIIB-Y-9YWAPGC_3VkH8hMthBmOzCWtJtaHEAolhI
Message-ID: <CAHc6FU4cD3fb13LE1-HOEnOoUNVdW1N3e892r7rFE9HJfztvhg@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] gfs2: simplify atomic_open handling.
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Mateusz Guzik <mjguzik@gmail.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, gfs2@lists.linux.dev, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 12:22=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrot=
e:
> On Sun, 20 Sep 2026, Andreas Gruenbacher wrote:
> > Neil,
> >
> > On Sat, Sep 19, 2026 at 4:31=E2=80=AFAM NeilBrown <neilb@ownmail.net> w=
rote:
> > > From: NeilBrown <neil@brown.name>
> > >
> > > gfs2 incorrectly returns -EFTYPE for any non-regular when __O_REGULAR=
 is
> > > in force.  A symlink might not be an error, and nfsd needs to know if=
 a
> > > directory was found.
> > >
> > > Neither this check, or the following check for a directory is needed.
> > > Both cases are handled correctly by instantiating the dentry and pass=
ing
> > > it to finish_no_open() - the caller will interpret the type.
> > >
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/gfs2/inode.c | 17 ++++-------------
> > >  1 file changed, 4 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> > > index f361876c5583..7aa92bb31cf4 100644
> > > --- a/fs/gfs2/inode.c
> > > +++ b/fs/gfs2/inode.c
> > > @@ -738,19 +738,10 @@ static int gfs2_create_inode(struct inode *dir,=
 struct dentry *dentry,
> > >         inode =3D gfs2_dir_search(dir, &dentry->d_name, !S_ISREG(mode=
) || excl);
> > >         error =3D PTR_ERR(inode);
> > >         if (!IS_ERR(inode)) {
> > > -               if (file && (file->f_flags & __O_REGULAR) &&
> > > -                   !S_ISREG(inode->i_mode)) {
> > > -                       iput(inode);
> > > -                       inode =3D NULL;
> > > -                       error =3D -EFTYPE;
> > > -                       goto fail_gunlock;
> > > -               }
> > > -               if (S_ISDIR(inode->i_mode)) {
> > > -                       iput(inode);
> > > -                       inode =3D NULL;
> > > -                       error =3D -EISDIR;
> > > -                       goto fail_gunlock;
> > > -               }
> >
> > as you note below, when the inode exists but it isn't a regular file,
> > we won't even get here (gfs2_dir_search() will have returned
> > ERR_PTR(-EEXIST)). So the above two if statements are dead code, which
> > contradicts the patch description. Could you please fix that?
>
> There are two different modes here: the "mode" that was requested and
> the "inode->i_mode" that was found.
> This branch will only be taken if "mode" is "S_IFREG", but the inode
> that is found could be anything.

Ah right, we could be looking for a regular inode non-exclusively and
get back any inode type.

> >
> > > +               /*
> > > +                * This can only happen if "S_ISREG(mode) && !excl" s=
o "file"
> > > +                * cannot be NULL.
> > > +                */
> >
> > Is that comment useful without removing the below NULL check for file?
>
> Fair point.  I'll remove the NULL check.
>
> I'd feel more comfortable if gfs2_symlink(), gfs2_mkdir(), and
> gfs2_mknod() all passed "1" (or "true") for the "excl" arg.
> Then it would be even more obvious that we don't need to test
> for NULL, as all callers that pass a NULL file, pass a true excl.
> (you could remove the "!S_ISREG(mode) ||" which would make the code
> look cleaner).
>
> But that is beyond the scope of this patch.

Yes, makes sense. I'll happily clean that up.

In fact, could just remove the two if statements in this patch queue?
We can then clean up the rest on gfs2 for-next without causing a merge
conflict.

Feel free to send a cleanup, or let me know if I should write that.

> hmm... you could even pass "!file || excl" to gfs2_dir_search() to make
> it impossible to use file if it were NULL :-)

Right.

Thanks,
Andreas

