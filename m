Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E73EDAC7
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881417; cv=pass; b=kk2iMbe7QvLpoWMd490F3InlyoBdpNJq0ItnjBKZOgkTsftbI6zfaAwZWM8EOPZ1bOm355cntHVsab0fRhH7dnfPme7LommjPPr5rQ2QgFCDklIcJUjr3dKTCJL98Ko6tY2IyeZDLz53PXFBtLk2oQxgfC+b4xy0FX1rx8BPSwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881417; c=relaxed/simple;
	bh=Q0CM9CcP2qsJx8ZTNz96giUIPG82DA4jHkT34z88mlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBpJ3ons54OdJYFL87Jqg3wG8eiSGltAQv64AAtbHuYKOWBRz1P8fOlk5t8nJdJPeu3q1umAsdO0Js7SzBcQ9aU5GdE+mjXw1k9XjlXSvIxTN5s5JMjOXeeGPqtA/7yR4iYcE8iDlVUmks87oPfx0aUiX45XaK0ZZmIyb3Ip5yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9UOMJSt; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9UOMJSt"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso555776a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 14:43:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778881415; cv=none;
        d=google.com; s=arc-20240605;
        b=W2WGVrcpc7dVDJR59iJl+C21rxkbrXeRFsWS4fne+TMWuCLzMSescZQ3+BdlBW0S/v
         ByHK6BsXqWTRihE+AmRzBLjhlX9X4Q2So1gM+dNusFq1FGS+GDFfEjVJLjIAA34le6Qv
         Z3EOMQDoiwl212zq49Z5RlJ7qOzaGT23+Ttj2vQK8WgiXHGXRIie14WIO1NT/QgCIAeg
         cyPpk2a7n1wKGh0Kcqr7CKY8zUY+FcJncGCGMR7IkdywzYER+oMhJx4JDiXVW2TbThfk
         QhfE+s9KrHOzxUmdzQzKI/eyj5rHy/J255EuPffbIw68PxjeY4353MvSoRwQAGJiLxtA
         UijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4K0dPW2QPPaLp7VmZFFIc9zXTxDqaqGxzNB77scsbfI=;
        fh=dwCKZK0N9CBO3X06pczRqP8K9YrQjHitQApn+VLPz7I=;
        b=fC9mqKks3s68YcsxMvAdikHMqCZEpdJJkiPKSh9bhovfFAiYjkIfF9qA6KOt/0dj7s
         TfZo9sTyajKYmxTxPmBH7F+VR4n6TqC8NdzvyE1kd6xJAaSyCKldBfqU7OZE+N6CZS58
         8CUto1OmpP05bhQ1rOPxZkb2EseOnTJeI3jDduMRAyGyXWSwckwnm0oBeEFUjGmGEMuv
         Dr3CRrGrTfsinQTBveu3vvKBKc3TSqQFl0Ldw2ax+RxS++MW9HRYUO00JvqYOh7UZSYq
         23/VkeXKRp7K5zkRQRIrHa7QywxI6uy/usrKO5wyMn58boEYq1Ybxkv73m7yUGYpJtD6
         XJLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778881415; x=1779486215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K0dPW2QPPaLp7VmZFFIc9zXTxDqaqGxzNB77scsbfI=;
        b=B9UOMJStw48xaQsRLgEXL0MVbp2PBt790iMDif8LQzhtBaQBbpTw5R8dppH1bTqyyN
         CegiyXgkFUtp9MgbS7OQ5jR81+dWIqhAfEqLzIll0PXfIlaCwgzdZ7foxdhsZ6vi75w2
         usZPESabjHvyh0w/O0i/hvoD+50jk3O0TEvhtoPE+L1vcgBf8qFH8ItA6AuoibJZVZth
         EvawmO2YTmVTsZ4oswUM0lYp1HX1zs+yXKKwjQKGXb/NXSrVrqbuKVcTAZDM8fa2Ne9I
         3bhb5qQxXGehJXa2jdGQmJv68DQ8IL6sx91kIFZ41zGgsRzr5xt1nNOzBHQ9S54LwoWX
         10hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778881415; x=1779486215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4K0dPW2QPPaLp7VmZFFIc9zXTxDqaqGxzNB77scsbfI=;
        b=PLdgi+T1Ia4OjP5JlMo0pKr4xQzfen2qyMsApV9wZf3IieHtY9uxDiIiF9isAc1V5k
         PlCqv1DUCgCHqyy5stbljkx1EgwBBu1T184Uj0lmVSrrKnSH8syIfZBmxfjW3B3HuJEV
         3thpLtB0ph1spsQ6gbBSyiny4kc0lEIVOzWrDgfAQFgtFML5oWQP09YfyQ3XN1Ljss8u
         VLBGA8eHNa/yFBHRrlZYSkaa2VXaTTqOIBGS9BWu+A/lcJJNVgRVtnO1ddFpJGT0MMVZ
         KH84yDxKJRP8eppEEXTMe0Q40Zwqw1k2olKX+Ek/9sJ3L5+5AyCSN3MI8Wqq49MkvI5d
         88lw==
X-Forwarded-Encrypted: i=1; AFNElJ/UDnvI97Clihz1OIgvpyuvyrD39Ei1hmLlZ69F8c9M2R8ZwFX8g4haqwIboxPPr0dDV0z2ev1WMKkVDiaJ@vger.kernel.org
X-Gm-Message-State: AOJu0YydfBezb3NDCuAd92wQq5WBCXsasVCUXil5ubPjW4Up+oC5Oozh
	3nwxU4PcMfc9s1nfn1zLTne4ECKJX7AfnywmOe44vYxOtXmYc47tu1ZGfdrKNdkaig6DIs0KpBN
	iE5gThwToGa+p9h9huZ0Tb/kTTv692QdNR0lo2qs=
X-Gm-Gg: Acq92OHi8KtjIPvXZAheGQ/8VLUh/drZQ1doYeFsTP9FCgnTSus/MszWtAW1UVBJru9
	0P9bGXlGgu2rvRjNkzubF75rxbO9byTrMfdu+xbfZSDAcdcEBnfuWnwaWYo0AZFJFotaW2thYFF
	zcirauA2JW95cBoLwsBUEX8POU3qJG5r/Q4xM8l+SibuaYJ3wVdkHTcn7WsLQZrS5JkS58XlRk1
	dCrciVie2wTlZu0H5esDsZA4nnMgmhiYPeGKpir3mhjE13QrX3sTfuwQZ6+H++xxpF+ADiftNUy
	ZkH5lR7rUNA2Ky/WBAkWiNw5HRKO6MO43sTURCpZDV/95QnMUmQw
X-Received: by 2002:a05:6402:3510:b0:67f:7e9b:afe8 with SMTP id
 4fb4d7f45d1cf-683bc5bdb08mr2947889a12.6.1778881414446; Fri, 15 May 2026
 14:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206617.4103309.9491664333731079107.stgit@frogsfrogsfrogs> <20260514221847.GL9544@frogsfrogsfrogs>
In-Reply-To: <20260514221847.GL9544@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 May 2026 23:43:23 +0200
X-Gm-Features: AVHnY4Lo33sQrExWGKxaR_cAZTJSjaGP-L92Ukdt5ubczf1SkIvoAriEDI8DfUw
Message-ID: <CAOQ4uxgU7Gsqd3H7v=izpm8Wbjrc7Qzv_BHzB8WQNpg=X4oMvQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] fuse: let the kernel handle KILL_SUID/KILL_SGID for
 iomap filesystems
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:18=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Apr 29, 2026 at 07:34:38AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Let the kernel handle killing the suid/sgid bits because the
> > write/falloc/truncate/chown code already does this, and we don't have t=
o
> > worry about external modifications that are only visible to the fuse
> > server (i.e. we're not a cluster fs).
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/dir.c |   11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> >
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 61015e83888ee4..e664a60200ee26 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -2477,6 +2477,7 @@ static int fuse_setattr(struct mnt_idmap *idmap, =
struct dentry *entry,
> >       struct inode *inode =3D d_inode(entry);
> >       struct fuse_conn *fc =3D get_fuse_conn(inode);
> >       struct file *file =3D (attr->ia_valid & ATTR_FILE) ? attr->ia_fil=
e : NULL;
> > +     const bool is_iomap =3D fuse_inode_has_iomap(inode);
> >       int ret;
> >
> >       if (fuse_is_bad(inode))
> > @@ -2485,15 +2486,19 @@ static int fuse_setattr(struct mnt_idmap *idmap=
, struct dentry *entry,
> >       if (!fuse_allow_current_process(get_fuse_conn(inode)))
> >               return -EACCES;
> >
> > -     if (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID)) {
> > +     if (!is_iomap &&
> > +         (attr->ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))) {
> >               attr->ia_valid &=3D ~(ATTR_KILL_SUID | ATTR_KILL_SGID |
> >                                   ATTR_MODE);
> >
> >               /*
> >                * The only sane way to reliably kill suid/sgid is to do =
it in
> > -              * the userspace filesystem
> > +              * the userspace filesystem if this isn't an iomap file. =
 For
> > +              * iomap filesystems we let the kernel kill the setuid/se=
tgid
> > +              * bits.
> >                *
> > -              * This should be done on write(), truncate() and chown()=
.
> > +              * This should be done on write(), truncate(), chown(), a=
nd
> > +              * fallocate().
>
> FWIW Codex noticed that in iomap mode we still send FATTR_KILL_SUIDGID
> even though we claim the kernel is supposedly handling the mode
> stripping for us.  Granted I've been starting to suspect that some of
> these file attribute related things ought to be gated on exclusive mode
> and not iomap mode.  Will have to do a comprehensive review when I get
> through the current round of bot complaints.

As I told Joanne in PASSTHROUGH_INO review
https://lore.kernel.org/fuse-devel/CAOQ4uxipQJt5zskb_THxueGi_MXpFdywFiGpd_n=
mWeY_sMHwzQ@mail.gmail.com/

Why do we need to deal with these special cases at all?

I understand that you want iomap to be per inode and that
both you and Miklos are in favor of allowing mixing iomap and passthrough
and other inode iomodes on the same filesystem, that's fine.

But we also made a note that the iomap patch set is very big and we would
all benefit if we could start with a slightly leaner patch set.

Mixing on the same filesystem, iomap inodes where kernel handles
killpriv and regular inodes where server handles killpriv seems like
too much freedom to me.

The moment that filesystem opts-in for IOMAP, can we say that
the rest of the inodes are at least "local-only" (no remote changes
of those other inodes)? so server should not be able to have both
iomap and handle_killpriv enabled.

If IOMAP is going to be merged via the FUSEX protocol, this is one
of the FUSEX requirements anyway.

Thanks,
Amir.
