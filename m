Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795044957;
	b=lKgnJ3aRaT6c++ZD1eIIruE9Pg9HaSK8x4SJLeXfvA8q3pQNgOpTSSLcRYEPiGmkWIRA
	 OuknKpQbDOWEkQcmk3bxe7+btf6OHnO8nmNcUJd7i3y+e/pyJuluk/RJ3eTJWgw5CoUEo
	 gCrMM9lc0O6bmBOeL2vKRdUpdixzPsVvvatjLEHBrEZA7ANTgjzvaIj94WYRacv/8gf/Y
	 A7Q2uLH/mWVjDm5ZOffn4WmhIdrX1pcI0DIlFutURkHGJqXfZuZCgSIdgk4SkB67c+XT0
	 iCoO/VErN3Fe+0GGJibDAQkIsBz1uQkV4ROHWEnygL85QPO9YEMnP/N6i4sSfPmDouw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044957;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
	b=42+1KaShe/CX0+myR7afknn2oGLk1Sr0j3+u/yfYtvzQmIoLaAWIZ5ZibvSaK7Lda6Gy
	 MTU3V6f0lLPZIvy34EW8SgOOoziNHVkqLPm2sbSBnB/QRANWraqOQwgSJAPEeoveZG6q2
	 vgn5CI7w9P0iZaRT4N0zaF4E4PIrCNz1DLO72vS4wjm5dXGOxMQMZKJQ2rUmuiVqkpq2J
	 QL63VcNV7TxwEpUugGNdJQj++nldYIovTgr6XW+3XuXotBKc9PSnp0Hqe4i3TaIVaWP9R
	 Xtqh4LofZypGJd4SbdzwqlJvkIU/uICt4EBh/ly004eWbFagVkMtaeD2sCGl/CDuvuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OeZtfPG5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VV4lacCc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BF606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 23:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD7BF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OeZtfPG5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VV4lacCc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795044955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
	b=OeZtfPG50Fjqj40s6Sj+6Did4ufEl3tVHRxceE+mdWNbGwx7fNYk44K7y6G04p78xFCD/R
	1kv1BumxCx310EyVnA8d4SqhUasQR7TMJCm7IYNKBrDLFc8ygMd69JH4NPy4EA0UV5oaOI
	oaiqNL+fbnuAUb7jfi3vcX/vMHMt/3w=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-hyZoWM4sMh6kIEG32PhpMg-1; Wed, 18 Nov 2026 18:35:54 -0500
X-MC-Unique: hyZoWM4sMh6kIEG32PhpMg-1
X-Mimecast-MFC-AGG-ID: hyZoWM4sMh6kIEG32PhpMg_1795044954
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-8b3030bd581so26856117b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 15:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795044954; cv=none;
        d=google.com; s=arc-20260327;
        b=daM65pt8/P0QtPY0TKKSnTisb2L1gBL9mXxlUdPfAOToQuZW2uBOclqpVDEwM3gO9b
         gTf2+OjLnAu3yMkaBiV+1yLDQ2HwOLJJYTod7IwwP9AvRI4CMXCVavbjlvqiM8CQpJCj
         Gbcj7ABcat/K8Se9HPkK7IqW07cpkAO+wplQz10kPJtas57rTI4/vWuplODf5EouE1OG
         N0TepStapydHxGH8Cicq4PzGEUslyRy7UwpxZDTDLVmKLEkc8QFTwdpSeRjT0OQrEs2S
         z9AlgeUElDfAhRok0i37TK6YE8P70KDtLTR7JFQLxP7HTvFzYRpEka94JI3trmHQP2bj
         Lolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
        fh=GrJ8iuL9NKeMorsTqmvUxfTdB2SphwNaikJ5KLdnF3M=;
        b=F8ei+z5+KcIYjd+YBLvue36DkEQi4hHGDAS2kVIXGzmUbs+vOlnGjSzlYgeNvxK3w1
         zP5WyHZnNwG62h+TRqrItELYDdZDEnuO+15fr8ilvhibSPGXxf9ZXstNSPxLjcWb4rre
         OPJDm4RQHX0U0rfDmL3zAspt6RdgZTclsPd7H13xbgCxv5r6spgRPLWNB7JL+uKC+9tu
         JyYMwrROjpuvEXGxCe6oUuaAOgCxqRmHlNP3IrL+BivJfsQNx9aJLRWaeBO9O4Ln2O/+
         aMivtzs2mgr7KF/LGinu2patY38X7mKnrhTfD0On+hPDzmAXhG2fLmS2wMfIAC4iMLtZ
         Jsvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795044954; x=1795649754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
        b=VV4lacCcYXl3jx6oU1yk7ocsmoMzxU9SP0AoOrXpBHytOyD+5/iloPPuTFDwHot85c
         i1CuguwIDMKYkYwOifW2jU2ON3pcwrl2ze+1M1zXcGvzpEjssC/9u8BP5GrnFxyulUg4
         m3kl+sBRcRdHC6cSbeJi+MrV0kK8R6nXJ+1+w101Ltg7NsQzens8JvDyW07HuceLJ6GS
         rA+E2+jV1u9T1OR/mFRBlrYQhI5+p4bfkvpqrJOCTWbtpDO3YyPi5JSYd2/v8scOcjke
         d/uPzbLWNdLsBIgq0z3OZKLiCCq8cx+Fg79vmPk4t0z6mQMU/UeaNF5w+hvK8lTtE+Iw
         eTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795044954; x=1795649754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
        b=1vc3m6zED8tJ0H5RosExFW+WSc6+Yp65WGEy8zLsxQACfX3Ftau1ZghEM8ApgVS5oR
         TgyMQrgf1GXJJS/IRicGJ9hXSdL6ofE5opAQpkvZ45xLWfGY+HhC8TuxsNqFdHe9U+uJ
         e/XZazprcudrdufqWDS8y9MV8sLPCyqXyn3R+e+p8Qls5+Sr9YGOPPVna2jmFsLpZuKB
         N8+bkKaCnghprvIZ6k25hBD3nI1u7un4Am/Xh6NCQif/OQS+/4aq3i+VmbyjbppaOFsd
         7BbuIqer2VgM+2mOkFvCV+ogZEzihbZsY+BvsjtdgLw0rK3nUbsEamm35j0+srhx/Cvw
         042w==
X-Forwarded-Encrypted: i=1; AL+hErERSiFj8WFoedFO5DY9/Axhfrm/9WOHy6SLKljRS6XS822aAjG6eswfJSPty6NTnwyt6SZaxxb8qmmuAMif@vger.kernel.org
X-Gm-Message-State: APuU4Z9J/gaga1kV1I9XvYtehaLnpfyJjNgWsaSa1UY0Q9dAGfaQkM9t
	GQvvgsb26I9RKh20qLlmWpbRlWwZNNsF2+9zIdC0O3GpOdmmdOrG8UendZqcaMhshi39Um3mXT8
	8MlhsiVqyVWNPd3w/UFt9KKHeB1TXvJ+UqvF+BY2ZJxBevNC5/ng02bk/so3qAxDYQz6A+WSY0D
	ba4swFJauDkYtFHZO2J0bxowehew5pqzq4G3EC0QDUjg==
X-Gm-Gg: AZFdTZeNWLkgq2u4mRNAveyt314xZFvZBA5m0bclSJFS5hO6ksyYRd6NvadsCSv2O2X
	pL/oEPeVwtYh3p7Kq9/ES6gh7/fEkf+uiIBuvBGxVyggMjtFJ30rxU01No5pNCs3yrMnlNyVbLS
	oviGtHv4nh614bpykkYgS9jnwLHlMw50c7hgksqXpOZ2ROzxUcoRoon4lhHaqZuMzrAewU0RvHh
	b/BkSvseqr44T15e0mpm6HOkDaHBCSRs6qe80BCihsoAA==
X-Received: by 2002:a05:690e:128a:b0:679:2a90:d3ad with SMTP id 956f58d0204a3-67dd403bf8cmr1618029d50.102.1795044953733;
        Wed, 18 Nov 2026 15:35:53 -0800 (PST)
X-Received: by 2002:a05:690e:128a:b0:679:2a90:d3ad with SMTP id
 956f58d0204a3-67dd403bf8cmr1618023d50.102.1795044953295; Wed, 18 Nov 2026
 15:35:53 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-19-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-19-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 00:35:42 +0100
X-Gm-Features: AclHuK9zTsUN7zuq72-DSL1ny4jnrrzy1tFjBUU4DEu6A9maK7lyiUQZqwV6vuE
Message-ID: <CAHc6FU7NoZua98SGP9Kuga58gAcco6X__u=kOPfsUqbefAKLFQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] gfs2: Avoid racy dirtiness check in gfs2_fsync()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, 
	fuse-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Check for I_DIRTY_PAGES state in gfs2_fsync() is racy because
> __writeback_single_inode() unconditionally clears the flag and
> reinstates it only later based on PAGECACHE_TAG_DIRTY tag. If
> gfs2_fsync() unlocked read of i_state hits in between, it will not see
> I_DIRTY_PAGES although there may be dirty folios in the mapping. Check
> for PAGECACHE_TAG_DIRTY instead and use inode_is_dirty() helper for
> inode metadata dirtiness check.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/file.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 1efd0679badd..f5532f72ab99 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -749,7 +749,7 @@ static int gfs2_fsync(struct file *file, loff_t start=
, loff_t end,
>  {
>         struct address_space *mapping =3D file->f_mapping;
>         struct inode *inode =3D mapping->host;
> -       int sync_state =3D inode_state_read_once(inode) & I_DIRTY;
> +       bool dirty_data =3D mapping_tagged(inode->i_mapping, PAGECACHE_TA=
G_DIRTY);
>         struct gfs2_glock *gl =3D gfs2_inode_glock(inode);
>         struct gfs2_inode *ip =3D GFS2_I(inode);
>         int ret =3D 0, ret1 =3D 0;
> @@ -760,12 +760,8 @@ static int gfs2_fsync(struct file *file, loff_t star=
t, loff_t end,
>                         return ret1;
>         }
>
> -       if (!gfs2_is_jdata(ip))
> -               sync_state &=3D ~I_DIRTY_PAGES;
> -       if (datasync)
> -               sync_state &=3D ~I_DIRTY_SYNC;
> -
> -       if (sync_state) {
> +       if (inode_is_dirty(inode, datasync) ||
> +           (gfs2_is_jdata(ip) && dirty_data)) {

this adds back the I_DIRTY_TIME check explicitly removed in commit:

3aac630b5ce1 ("gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()")

Could you please clarify what's going on?

>                 ret =3D sync_inode_metadata(inode, 1);
>                 if (ret)
>                         return ret;
> --
> 2.53.0
>

Thanks,
Andreas

