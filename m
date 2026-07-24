Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E838BF67
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929205; cv=pass; b=SVH+TeDSAyIGGYkZyrXpc1DTgnXb0K5PVIAA2h/LRus6NqG1fmHbuZIrqNvaI4h1xLXnofbi8GA2QYIWrRhZPtwKzmHsWrQxnO+v0JsaqPk2sWzVLD1cREP2sFWA0tt9/dhqdvjnDFUOHk/a3uZIx37dECastgKngJMGdbLsliw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929205; c=relaxed/simple;
	bh=VjT8h0C0MEwc6Wql1bkZPcWk5J5Ghn5YmfhJSDEhSWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1mtmLmZLKa1U3du/N/tc1eHGOzDWL8xJSc2LlvysZOjja3VoxkjKgBFC4SgYHXiVIeAZ6bRIyzKu8hfRbQK3KSYUYXUugMWhhx/DK2IZK+MrKmzD6UX7LTX8rJ7cpwClr2UPHUxJfA0YVAqgjPVPWQXX4BnCD9gjz+G8ahpa4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpXg/nwp; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpXg/nwp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-476a130c138so926567f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:40:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784929202; cv=none;
        d=google.com; s=arc-20260327;
        b=LXNQrowHFUPOisVxbwANOleKJM2ftTGOBs2M09Yixi6DPCelsvEwDGCJeQ2fjrpPzv
         YE4GaDQa5LS7JzaX3GTd40FTNaO6mPjzTYr17q0ePkgo/GiWZB9RsDTLq1GJ4ZU2L+89
         H/YwHehXPSX2kTPaHHOruWh6Ho10DIkp3axuLfwGaCmoS8G3dmN/AOa3tN8lLFU6sqe/
         4aUSlbAeWCdAN5+WvfLcMQGsm2EyRVSg7KhRsFSpSdyjlvJx0dzaXRPDrDp5mUD6AQkN
         AKgMmROF8yLEc4Kw9RWgInHdzOL+AY111jd/CYZMFZONQ0t1GXM+2xmrl8FDLnEj3Js3
         nRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RAB/Z210MZmDSDWCyj7qmtTg5HLMGjGEKXw1Q9kkiO8=;
        fh=erpfsLjwGfG5lfvyYJ2pZ1hIUJJ8L079++UQCCX2F6k=;
        b=I8cIhx5zURHMZ2oE2bjx1vchgeS1/I6H+wnTjy0e3EpEBC0AqEkwRavXkthJKhweIp
         2TaUTMLOz6E2h5U0ITJ8/0CDfDmGurQcwaqJoV/1dMAo5pMK3m/SKznAU4RPXhSfoa4X
         7UWFtGC4EAHvaHScITgPqmkkhU8axoVCRWDj5Uth1jKWaYEN5w5LZV1QJR7xoJDoI1Co
         IQA3il7kAzMt4Y9DkbW5pRz9NuyX/Y0ZNaSaE0nI+2d/ySOcRqXqR3h8Weu4lApOIXS/
         41o8FJMb8t6GsxIVYvIAo/7Vfsl850jSl/JmUPZOUUn7sTEub0CYOv4DT1Ki6kKIKJCd
         Akbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784929202; x=1785534002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RAB/Z210MZmDSDWCyj7qmtTg5HLMGjGEKXw1Q9kkiO8=;
        b=FpXg/nwpsEcnbDYbNgtN7hYZ6HKC4pBocBkVRX4UzMBx5Xw/cMmkNmElLYus4cYjYa
         MHXhm3XlJWlhuaTY2rxo+qcJ8u4K8LzLZtp2NFLA0hLTA3HjHQwoWmIYi5NYVir8Q2g3
         fw2aTZuEG2YRBN+wVKCIsfd2R4spseU9bbLRvEb67YkWmqP33NZjQ+VkUfbTJ1YgkLfL
         NOGGbwo5ibKfVgYQW/yiGUieTeBFXCODdKuin1ShfXKaIl4ScBxvjhLGZZTznW06QIEB
         PjQculeb3KJm0VN3x2P36zezi/PQZiSzyhuklQrENOaHL+MdtBUfvKxIxPlPevPsGyRe
         XHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929202; x=1785534002;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RAB/Z210MZmDSDWCyj7qmtTg5HLMGjGEKXw1Q9kkiO8=;
        b=cb1ZKxKqUvh0ePCP8XTucY2klS3Hym534r2jLfWJ8PfoUbPQ9lY7orN4bOcGydx9nn
         67mM0KgoZ+L3Bcl6bUhzfUPa3Gkc+sZnCJ93tVjxgx0oOmTrD6kB1NTwwKgH1GIsNGK7
         JWtJARrNK9gGEY1Y4Nqh3D6qTPLOqjP+qeJ2WtRO1aIIg46rGWVR3UK69qqhemm8mGH6
         QJ2zKg0VG2LibJCBwtan8owLO7P9a8kH/wbCxGKqPpQ+6dnmMIqWdeNRgIugGJTFYh0+
         hVgp1rm/mziqqJ1d0d2bVEnsEmVARwmSKDjPpzQJYpz55ccM4FcIdwhYpAOaIQGv9RRi
         ONAQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPn2Lc3909mcanWQGRqaStUJE1Obm3iCzwkCgNDAHDasZESEXsk+iVeeAeF32ztKD0nQ5TPzKrsGY+JDIB@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0ajmCuJtI80dnceaJVJiwE7F2bV0pRlBwDwIAt0is6yaPeFxy
	9aVDZwGoZ121LJYrvpaC6N8itevHj6TTB7zRM8Tv3V97Q6rM3T9H8l7C/IjhpwOAOck9jF7hA9d
	ZwQwc8eMuE1d1PQIdsPmr+g9j0tVbqcQ=
X-Gm-Gg: AR+sD117wQwzCdXdLVKpH7pAZVM0vjwWNN9+MXV+p6yHtc/8ulxbBOgu4A/t6ZTVxBn
	EHFctTMw2ZgcCOCsehpZC6J6QsH+2IK42ygYrPib2tTLCXKyPMf2TzNWvOqAcIf82o0qLEpE6st
	9lZLAHO/8r87QJWTCikwj5lEGkmci15n/2eKhpep/JeqlvtZXT2sN1Kc2dBHxzdowNxVKk87NBw
	EdLTb1xlOef/R2QL2TAjuWfEAOmV1Us5Xw+lkXNA/JX+SHl66tjqjWuwju2zy2Tgz4Q6fAWoh6K
	vtvhxlrUM0KsfPl1sckCgBfciOL1tUEb9rAbl3/Oqw==
X-Received: by 2002:a05:6000:27ce:b0:47f:928e:21f7 with SMTP id
 ffacd0b85a97d-47f928e23f7mr6329327f8f.55.1784929202068; Fri, 24 Jul 2026
 14:40:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050201.3381045-1-hch@lst.de> <20260723050201.3381045-3-hch@lst.de>
 <20260723164722.GF7380@frogsfrogsfrogs>
In-Reply-To: <20260723164722.GF7380@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Jul 2026 14:39:49 -0700
X-Gm-Features: AUfX_mynOUqF9g7tlIXhMduTjnHTQ0m_VqSSHi-dOSMHoEm_AgBHSxiCdTlP2Is
Message-ID: <CAJnrk1Z9wxXf+=d-+5VMcCiDiy4Q7UsBGvzwaPQtAok6avjKPw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iomap: decouple simple direct I/O reads from iomap_dio_rw
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, changfengnan@bytedance.com, 
	Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 9:47=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Thu, Jul 23, 2026 at 07:01:40AM +0200, Christoph Hellwig wrote:
> > The pending iomap_iter_next conversion creates performance issues for t=
he
> > new simple direct I/O read fast path, because it assumes a model where
> > the iterator must be advanced at the end, which the direct I/O read fas=
t
> > path tries to avoid.
> >
> > Side step this by splitting the simple path from iomap_dio_rw, and
> > require the file systems to call into it explicitly, and pass only a
> > ->begin callback.  This allows to drop various checks for incompatible
> > features while creating a requirement for the file system to only call
> > the simple path for cases that it can handle.
> >
> > As a side-benefit we can now inline the initial part of the simple
> > direct I/O read fast path and let the compiler convert the indirect cal=
l
> > to ->begin into a direct call.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/ext4/ext4.h        |   3 +
> >  fs/ext4/file.c        |   4 +-
> >  fs/ext4/inode.c       |   2 +-
> >  fs/iomap/direct-io.c  | 208 ++++++++++--------------------------------
> >  fs/xfs/xfs_file.c     |  14 +--
> >  fs/xfs/xfs_iomap.c    |   2 +-
> >  fs/xfs/xfs_iomap.h    |   4 +
> >  include/linux/iomap.h |  66 ++++++++++++++
> >  8 files changed, 136 insertions(+), 167 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index b37c136ea3ab..e134c0193e2b 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -4007,6 +4007,9 @@ static inline void ext4_clear_io_unwritten_flag(e=
xt4_io_end_t *io_end)
> >  extern const struct iomap_ops ext4_iomap_ops;
> >  extern const struct iomap_ops ext4_iomap_report_ops;
> >
> > +int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length=
,
> > +             unsigned flags, struct iomap *iomap, struct iomap *srcmap=
);
> > +
> >  static inline int ext4_buffer_uptodate(struct buffer_head *bh)
> >  {
> >       /*
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index eb1a323962b1..f20d92255546 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -91,7 +91,9 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb,=
 struct iov_iter *to)
> >               return generic_file_read_iter(iocb, to);
> >       }
> >
> > -     ret =3D iomap_dio_rw(iocb, to, &ext4_iomap_ops, NULL, 0, NULL, 0)=
;
> > +     ret =3D iomap_dio_read_simple(iocb, to, ext4_iomap_begin);
>
> I was kinda wondering if you can pass ext4_iomap_ops.iomap_begin here
> to avoid the declaration in ext4.h?

I think it ends up being a bit cleaner to do it here, otherwise the
subsequent ext4 patch that replaces .iomap_begin()/.iomap_end() with
.iomap_next() will have to do it.

Thanks,
Joanne
