Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795804930;
	b=pxpZlPuIhASZo/upc8jYjTkiu2nl2DaGT1dWtkOIbVli1MO9hIgXqqjG86D7w2W03n73
	 j7OIDDAXPOVzOdiVCdUjYsLwMBBQe7kNmmEoU7jPD6qy8C3cgYr+M06FK6EKoyWt1lQD1
	 xEnkCu/NkIdeXwBZCHva5It6jPsDkWbUFCiZFe5p8yU9uMM2QbXo912+zQT5YV+rH8aFQ
	 3Mms/EUuYS4URsSqnK5G7kF6T5m2QhaqHzuMQ+TDIbco9K1B/57AuCp34va5wBOZTJGn3
	 OKYvK9epqaFDjNG/jPOMjve9nBofCSQj2aXT2sM4felT0kXJPEQC6Dv7qzv6wsTyZLw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TUljqXlhZxTlbThpwiTid+WCRjyQRpD6xEshdFq1HmY=;
	b=yUAKWJw6rP1t4E/kd7HYh1MCU+kyVaW8RoZykfBDBRf1QOhsDIZkrfQ/GcyFpGCp9xOO
	 n5d3EuACskMSEJb94tCeYdNZDe4JLbXc4HDy1v3RnbtQoRDz/FsAlNY2LbsgMeiWFycxd
	 h1lmjW5y+WdK5OXYljonI34sZcAui9mkWhYljcjKkm3fJjBTJKEB15UbVg7c75SDWJ6FZ
	 FFUHL2v4Gr9kQVCHEpTcRLdQTQTCdhqDZvcusWUP4q6gCmgrXBKg8QU1qQoJ/tibm8wVG
	 BNzZB/4HSn8oLZPQu/LtBlgVddbhYKqu9RKw2YRBZUpQTAOgundq3ny2rksy8SP7MKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pj9n7rNc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3B606A323
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 18:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C3B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pj9n7rNc
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b86fcbd647so12857511a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 10:42:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795804928; cv=none;
        d=google.com; s=arc-20260327;
        b=RhDwvdYP+s8fyZIerbnjpcmcknDwieK7kHl0QwrbgN3Mxhm3CrdOrnmrjTYkDw3A65
         AqEFAcUWM6dqp2Hdp7WUqoi8fsKnxEJuiojmYSadaNc9dAHqyHMd69d8BM+y34QWQ19c
         adgslwPQ0CPL/I2xQSmYeNpMR62p2qn1sdxDbU2NEUxJvmP8dhZ5jN07vZqmEZXDGWdJ
         muAudiP0oLVWJjsmjIyahFB4ZmzJAlo6m8VNfqAQRE5ej8Z4JVZJ0nBE+vWn200NDUjW
         g9vAxNwDFvW2maHUeJtm8I0JaB1UncL+2xre0BQ7NNpFAFvai9aMv5GG7DbfVgsM/Tjd
         PIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TUljqXlhZxTlbThpwiTid+WCRjyQRpD6xEshdFq1HmY=;
        fh=zxyhICiQ2OwjWpcvhvGPwbJq14P8KII9075lUNHWmK4=;
        b=IuEiP/5L/4TUluG093Bli/V4yweFSKaZ1CEwGjmWTdi5WDvVf2xPJzTfpaWT81w4IK
         zlVwemDIlJ8v6hiDJPKOl/NE859bNAK+kKMtIbp3BK5tOBiN7fcps4aTEaj5AUAD7a9R
         kz+o6Z/oA38IJLAKYmabaZatZ8QjK8minhzwhmFReGYrjlgzpEWaWsHzBPmTiOPQ1sxr
         WmuznyxCbn8p9oMaQ5emJnWosqnIZCqcVwuAKfa8nOhE/sCA3RCG5WF2WFZJ4l7JyoO7
         6mRVNhyJspJDK2j8snkpZ212g5bBLkG7PifqNT+yiPX7KGLU/AxXn8J07AzsxLdEbEzm
         hILg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804928; x=1796409728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TUljqXlhZxTlbThpwiTid+WCRjyQRpD6xEshdFq1HmY=;
        b=Pj9n7rNcgOoQYx/mE0cI/8NzQ1M0EFEAssinKhBTe/23ul6kD07ftPVdeovh+IBH2I
         vkf7BIVYGPsdvWUel9+WBjdyG+/uSyBAxg1okjizA7O0JzPi/LyqtbHo9lwjnFt/1eoc
         FNUUJ8lqFseiz6rsXjXiZdbJORBjcaTDRh1rpAhKWJvHYZa++6VMPmqGwFDLFLV60yhV
         1YqL5DI2+JfBTOOD54TVGvcglbQCLIxEwpZhfVDXdDAdZyN3UN+Mn+qpEBDMon7kr9BV
         fKF5YIWZ2oqxgDuG1h4bvEtpGWEdLJKZMzVqrxuXvD8659Ko9I3yPA8Z2IGzfXWeTvVA
         6wJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804928; x=1796409728;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUljqXlhZxTlbThpwiTid+WCRjyQRpD6xEshdFq1HmY=;
        b=w0ykhj2RXqQpG5YtADA9kQrBI0dEWH13uHttdMGFCSRZ1ewTRaOATqjMo2HK9RAKqy
         NLFg+Wbu8d4+4H51q7qH+fTxYkDT4k2rQkz1pLxI6m0PuHJ6ukidqv+mRKlugLUm7pK+
         eSTCDiwdcPY1U6wZpmskVZIr1GlYRP/GeOgXiIis74yF73/BcnL8uvfNzPSoZ1z0E50N
         UjSpQ5O5iiBAvPB1sQNWsBvlpEorpfdSNRyngDMG/INne+axd97kSTFSOJdGNiwy5jG8
         qAF4C3mjr/LrA7FAdUC2xlUqliAitu1f6rBNlWeF6ipCtixo/1DSC2qopOkcgjUANMS7
         vqFw==
X-Forwarded-Encrypted: i=1; AL+hErFJumoOXhX/YHrT2Q0DRWri6YqEk/upTN+1jFdg09hcu//1Lru3sT/yae+1tMdo3ZngCXhcMpFCjVSrDshP@vger.kernel.org
X-Gm-Message-State: APuU4Z/r1iFjokkABjY0YEY2PwFjuWWwBGSvZlrFQ6xSPLYC7ogOHfsa
	RK689yJGGwtXzNV3FnVq/V7QDJ4uRG0Fu9m83wKqQqOJ8WVnjfAKVZ6Up4yfUmhofT6MwkYU6m6
	mxdMmiBA9VJ4Wl6RqmF9kda1AJm3NeQs=
X-Gm-Gg: AZFdTZfZRSg2eT+gE1t3LNNwt2gBwHcq0zxbHxMSwblIb9XnkuJ3Z0OMFocdjmNgKTL
	djna4Tn+HOuzphwTK7BcEm8rl4tfrtBtsM5OzIOu+iQq7uVnBJamtZbGMM+pUCD0W6Z+ZX2k8AO
	1//JpFkvfoQ2+/YjrQO/8OLEqAxMpCD69AL0IDV3uirg6aXhihvLjzPh9rKpNcCdGaBAn36SuJ+
	yizmvgNxtMz1hS3M/+NxbBdpa2ESbND+rOLakM0lV7fQIZys2jB79iSnbsFuUqmRv8sY6iDl0bO
	5BSFHbjnX4CZE30qXhzz8lwscRLUJkrSPYEWgBWHFCIOiKGo5SzcX8V9PZ+KQPqFp1J6qP4+tz3
	TtO4ogOoXumPLiIl/ZUboZR8hG0lZia3jIj+0Ny+T1lZAhBPStLKmdBmMHxIn64c5hk7/hQ==
X-Received: by 2002:aa7:d698:0:b0:6b4:7b32:eb48 with SMTP id
 4fb4d7f45d1cf-6ba1fafc91cmr14967401a12.7.1795804927801; Fri, 27 Nov 2026
 10:42:07 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126163114.403846-1-koray.fra@gmail.com> <20261126163114.403846-4-koray.fra@gmail.com>
 <CAOQ4uxhA+93bo5WseLxe7cAvJHJ8eQodoQHLwh=iToyEVkeXEA@mail.gmail.com> <DN66YKVRVRU7.1062V6NCL4LUW@gmail.com>
In-Reply-To: <DN66YKVRVRU7.1062V6NCL4LUW@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 27 Nov 2026 19:41:56 +0100
X-Gm-Features: Aa3M54od_6b5916mtsitDoA0D91NC5HrbGWcFpxN2v8YyDqaZJZ4Zdj0mvMUcHk
Message-ID: <CAOQ4uxi6oyFj_A9nPbgGeSufGo11L2N=QxLi2DW=ZKy25YQ5Tw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vfs: add xflags mask to fileattr API
To: koraynilay <koray.fra@gmail.com>, Christian Brauner <brauner@kernel.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y . Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <cel@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Aring <alex.aring@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Andrey Albershteyn <aalbersh@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lauri Gates <lauri.gates@gmail.com>, Christoph Hellwig <hch@infradead.org>, Dave Chinner <dgc@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-nfs@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 7:06=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> On Fri Nov 27, 2026 at 6:48 PM CET, Amir Goldstein wrote:
> > On Thu, Nov 26, 2026 at 5:31=E2=80=AFPM koraynilay <koray.fra@gmail.com=
> wrote:
> >>
> >> Add fa_xflags_rw_mask and fa_xflags_ro_mask to struct file_attr, both
> >> __u64 to match fa_xflags' size, and bump FILE_ATTR_SIZE_LATEST to
> >> FILE_ATTR_SIZE_VER1, which is now 40 bytes.
> >>
> >> Add equivalent masks and a has_masks selector to struct file_kattr, so
> >> we can know when a user of this API (userspace or filesystem) supports
> >> them.
> >>
> >> This lets filesystems advertise their support for specific xflags, lik=
e
> >> statx.stx_attributes_mask does, and userspace can specify only which
> >> xflags it wants to change without needing a RMW cycle.
> >>
> >> These masks have the following semantics:
> >> - fsx_xflags_rw_mask:
> >>   * for filesystems: advertise which xflags they support changing
> >>   * for userspace:   specify which xflags it wants to modify
> >> - fsx_xflags_ro_mask:
> >>   * for filesystems: advertise which xflags they support only reading
> >>   * for userspace:   ignored
> >>
> >> And they should be filled according to the following:
> >> - GET:
> >>   each filesystem that wants to implement this new API fills the masks
> >>   according to its supported read-write and read-only xflags,
> >>   then:
> >>   * for boolean xflags: it fills fsx_xflags with the current on-disk v=
alue;
> >>   * for value xflags: it sets the xflag bit to 1 in fsx_xflags and the
> >>     xflag value in the struct field;
> >> - SET:
> >>   userspace fills the rw_mask with the bits of the xflags it wants to
> >>   change, then:
> >>   * for boolean xflags: it provides the xflag value as a bit in fa_xfl=
ags;
> >>   * for value xflags: it sets the xflag bit to 1 in fa_xflags and then
> >>     provides the value in the struct field; if the xflag bit is set to=
 0
> >>     instead, this informs the kernel to unset/clear that value.
> >>
> >> Add AT_FILE_ATTR_MASKS at_flags option that userspace needs to pass
> >> (with usize >=3D FILE_ATTR_SIZE_VER1) in order to be able to use masks=
,
> >> otherwise legacy RMW semantics are used.
> >>
> >> If AT_FILE_ATTR_MASKS is not specified:
> >> - on GET, zero fa_xflags_rw_mask and fa_xflags_ro_mask and strip new
> >>   xflags added in or after VER1, so older programs doing RMW don't pas=
s
> >>   them back;
> >> - on SET, reject non-zero fa_xflags_{rw,ro}_mask with -EINVAL.
> >>
> >> If AT_FILE_ATTR_MASKS is specified on SET with fa_xflags_rw_mask =3D 0=
,
> >> return early as a no-op after permission and support checks.
> >>
> >> To make both legacy and new programs interact correctly with both lega=
cy
> >> and new/upgraded filesystems, add:
> >> - xflags_to_flags() / flags_to_xflags(): use fileattr_fill_*() to
> >>   convert xflags to their flags counterpart and vice-versa;
> >> - fileattr_set_mask_to_legacy() / fileattr_set_legacy_to_mask(): conve=
rt
> >>   between legacy read-modify-write API and modern rw_mask/ro_mask API.
> >>
> >> Also add the missing FS_XFLAG_PROJID xflag, to allow userspace to set
> >> the projid using file_[gs]etattr() by leveraging the new masks.
> >> In order to prevent the legacy FS_IOC_FSSETXATTR from accepting
> >> FS_XFLAG_PROJID, add a FS_FILE_ATTR_XFLAGS_MASK to support new xflags
> >> and use it to validate/clamp both the _xflags fields and the masks.
> >>
> >> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.11
> >> Signed-off-by: koraynilay <koray.fra@gmail.com>
> >> ---
> >>  fs/file_attr.c             | 332 +++++++++++++++++++++++++++++++++---=
-
> >>  include/linux/fileattr.h   |   7 +
> >>  include/uapi/linux/fcntl.h |   6 +
> >>  include/uapi/linux/fs.h    |   7 +-
> >>  4 files changed, 320 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/fs/file_attr.c b/fs/file_attr.c
> > ...
> >
> >> +/*
> >> + * Convert legacy RMW input format without masks, coming from userspa=
ce, to new
> >> + * input format with masks, for filesystems that already support mask=
s.
> >> + */
> >
> > The term "legacy" is always a bit ambiguous so best to avoid if possibl=
e
> >
> > So maybe something more explicit like v0_to_v1
> > ...
>
> Ah ok.
>
> >> @@ -283,20 +485,62 @@ int vfs_fileattr_set(const struct mnt_idmap *idm=
ap, struct dentry *dentry,
> >>         if (!inode_owner_or_capable(idmap, inode))
> >>                 return -EPERM;
> >>
> >> +       if (fa->has_masks && !fa->fsx_xflags_rw_mask)
> >> +               return 0;
> >> +
> >>         inode_lock(inode);
> >>         err =3D vfs_fileattr_get(dentry, &old_ma);
> >>         if (err)
> >>                 goto out;
> >>
> >> -       /* initialize missing bits from old_ma */
> >> +       if (old_ma.has_masks) {
> >> +               old_ma.fsx_xflags_rw_mask &=3D FS_FILE_ATTR_XFLAGS_MAS=
K;
> >> +               old_ma.fsx_xflags_ro_mask &=3D FS_FILE_ATTR_XFLAGS_MAS=
K;
> >> +       }
> >> +       old_ma.fsx_xflags &=3D FS_FILE_ATTR_XFLAGS_MASK;
> >> +
> >> +       /* Convert between formats and initialize missing bits from ol=
d_ma */
> >>         if (fa->flags_valid) {
> >> -               fa->fsx_xflags |=3D old_ma.fsx_xflags & ~FS_XFLAG_COMM=
ON;
> >> -               fa->fsx_extsize =3D old_ma.fsx_extsize;
> >> -               fa->fsx_nextents =3D old_ma.fsx_nextents;
> >> -               fa->fsx_projid =3D old_ma.fsx_projid;
> >> -               fa->fsx_cowextsize =3D old_ma.fsx_cowextsize;
> >> +               if (!old_ma.has_masks) {
> >> +                       /* FS_IOC_SETFLAGS */
> >> +                       fa->fsx_xflags_rw_mask =3D 0;
> >> +                       fa->fsx_xflags |=3D old_ma.fsx_xflags & ~FS_XF=
LAG_COMMON;
> >> +                       fa->fsx_extsize =3D old_ma.fsx_extsize;
> >> +                       fa->fsx_nextents =3D old_ma.fsx_nextents;
> >> +                       fa->fsx_projid =3D old_ma.fsx_projid;
> >> +                       fa->fsx_cowextsize =3D old_ma.fsx_cowextsize;
> >> +               } else {
> >> +                       err =3D fileattr_set_legacy_to_mask(fa, &old_m=
a);
> >> +                       if (err)
> >> +                               goto out;
> >> +               }
> >> +       } else if (!fa->has_masks) {
> >> +               if (!old_ma.has_masks) {
> >> +                       /* FS_IOC_FSSETXATTR / file_attr VER0 */
> >> +                       fa->flags |=3D old_ma.flags & ~FS_COMMON_FL;
> >> +               } else {
> >> +                       err =3D fileattr_set_legacy_to_mask(fa, &old_m=
a);
> >> +                       if (err)
> >> +                               goto out;
> >> +               }
> >>         } else {
> >> -               fa->flags |=3D old_ma.flags & ~FS_COMMON_FL;
> >> +               /* file_attr VER1 */
> >> +               if (old_ma.has_masks) {
> >> +                       /*
> >> +                        * Don't preserve non-common flags since files=
ystems
> >> +                        * with masks only use xflags
> >> +                        */
> >> +               } else {
> >> +                       /*
> >> +                        * Filesystem doesn't support _mask API yet, s=
witch to
> >> +                        * old rmw format.
> >> +                        * PROJID is supported like the legacy masks, =
but will
> >> +                        * be stripped during conversion.
> >> +                        */
> >> +                       err =3D fileattr_set_mask_to_legacy(fa, &old_m=
a);
> >> +                       if (err)
> >> +                               goto out;
> >> +               }
> >
> > I stand behind my earlier comment - this is too much for open coding
> > here. I won't suggest a better factoring I am sure you will figure out
> > one by yourself. focus on readability and reviewability please.
>
> Hmm, ok, I'll try.
> Can I keep the comments though? (changing them a little maybe)
> I think it's important to have them since we're dealing with bitwise
> operations and a not so easy to understand logic.
>

I have no problem with the comments.

> >> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> >> index a13c7b32a1bd..63d88ebe3420 100644
> >> --- a/include/uapi/linux/fs.h
> >> +++ b/include/uapi/linux/fs.h
> >> @@ -238,10 +238,13 @@ struct file_attr {
> >>         __u32 fa_nextents;      /* nextents field value (get)   */
> >>         __u32 fa_projid;        /* project identifier (get/set) */
> >>         __u32 fa_cowextsize;    /* CoW extsize field value (get/set) *=
/
> >> +       __u64 fa_xflags_rw_mask;/* supported writeable xflags (get) / =
flags to set (set) */
> >> +       __u64 fa_xflags_ro_mask;/* supported read-only xflags (get) */
> >>  };
> >>
> >>  #define FILE_ATTR_SIZE_VER0 24
> >> -#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
> >> +#define FILE_ATTR_SIZE_VER1 40
> >> +#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
> >>
> >
> > Man... we really need a bot to review all UAPI changes
> > Please someone tell the bot to check
> > NO LATEST/LAST/ALL constants in UAPI headers!!!
> >
> > Your patch does not introduce this constant in UAPI but if we change
> > it we risk spreading different versions in installed headers.
>
> You mean someone having different versions of the header, each with a
> different FILE_ATTR_SIZE_LATEST?
>

Yes, I think this is bad practice.

> > Honestly I see no reason for FILE_ATTR_SIZE_VER* to be in UAPI
> > either. For other UAPIs those constants are not in the UAPI header:
> >
> > ~/src/linux$ git grep SIZE_LATEST include/linux/
> > include/linux/fcntl.h:#define OPEN_HOW_SIZE_LATEST      OPEN_HOW_SIZE_V=
ER0
> > include/linux/seccomp.h:#define SECCOMP_NOTIFY_ADDFD_SIZE_LATEST
> > SECCOMP_NOTIFY_ADDFD_SIZE_VER0
> > include/linux/xattr.h:#define XATTR_ARGS_SIZE_LATEST    XATTR_ARGS_SIZE=
_VER0
> >
> > So please move those contacts before adding/changing them
> > (can be in the same patch IMO).
>
> Should I move them to fs/linux/fileattr.h?

Yes please.

> If so, all of them or only VER1/LATEST? (since they're maybe used by
> some userspace program already (?))

All of them.
I doubt that someone is using them and it's easy to
return them if needed.

Btw, nsfs.h also has this pattern:

$ git grep SIZE_LATEST include/uapi/
include/uapi/linux/fs.h:#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
include/uapi/linux/nsfs.h:#define NSFS_FILE_HANDLE_SIZE_LATEST
sizeof(struct nsfs_file_handle) /* sizeof latest published struct */

This is not as bad as defining it to a constant (40) IMO, but
I also don't really see the point of defining this constant in uapi,
when programs can just do the sizeof() instead.

Thanks,
Amir.
