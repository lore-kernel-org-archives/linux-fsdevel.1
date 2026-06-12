Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F62FD68B
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781305733; cv=pass; b=QRznx61TONGJP1SEeltuv+B0dRAOm4Hc8sEBAUMuaoDZfSOX0I9eq8lY0cGDVXCKwubTe+g/ASsOCIDHolrvn4EOQj5KJzOoLrtQYCStnMUuQDsLIechMKIqhIlZyHmlY8qENPRT36rBw/mYIzc7DM6KpLUxFuvIIEsg7jzwq9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781305733; c=relaxed/simple;
	bh=pzBBZ55dsYrBbwRWGmJdboVIwpMiztH4NEgUEHaL1TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ufc3Sd76sEYml9AXVeM28hWPQvolhpjdMgjUu0bpeWQndiWfyvI8CoonYJl7lOd9X/sswX2vojChSNKshMsw7LWPVe7KlXTZ0FlQIC2G0r6KJuCQPSa49qe+iL3fINguQbjycw71u0YsYTIgohibbe9VoSgOgAge5kSvY2Uvjrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ElmM9eY6; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ElmM9eY6"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69e7dfcea4dso1500549eaf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 16:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781305731; cv=none;
        d=google.com; s=arc-20240605;
        b=VBB7p/41vWAhWdyfrsUXKfjT2I0RnCfcLWi/KetjJBowGLeFlmzFH6Zksykb9NnuLV
         tA5JFA2JuQawPp7ZHo44gBwLzacNRku9ogSFZIzPfRKl7OMhSIRr9m2qSbKWwnMr7lco
         JgMG5ROTcLSa9TRabr5oafhuvxwOp6koxCzDrQMGzuKUbwX9j9KKcGp1dEpQOOSZE10P
         kHHBCQIbY5xzCeVuIvw0Z8EOlctj0uNcH3dTn4dupOgqNHp8c6P4m1BtsmIIey7bprLh
         WvDStV+9NwDaOFmzP8p8aI+yTDepck0Ok4yVjcDlnJeK2nX5WmPWOx7BtNW+2BAcE7GP
         JsyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UNh4awcJcxT3SpE9ki1qDnwXi++xN/OXIzywrn4IJ34=;
        fh=sF8SN7CNJYgg9Xv9JpjQo+MiCuXP2zUVmKS53vjVIXc=;
        b=IfvTIjbeCn32lBYLgeaUqbMZ+wW4JQjmczwRYMagFLYjlelvqyzAjQ2CFyfwB6OALh
         okjdaYTW1SDIXS8y5ekDbcSTebGuVeVb1650kIIVhBwJk3ISWH/71LjSlo/U+gkphUET
         g0cCwuvsD3zpOeFPDbt79RoHZvIiE7JeSKHyH4utj9V9GLbmSdA9dp11RRoKBOy7xnIo
         bJEU5zAnzbXeLMG+M3wwksHB+5W4+JRPH/IAzg9Y4L8mjO4df1a8jPmF7aGHgHoWgpU3
         dlT0A8H1+HHKuCwNvZSKVBiFQj3RFr8hR8AGG305oMCD4pjEktwPLWlAVbVvTZGO6T5S
         2cBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781305731; x=1781910531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNh4awcJcxT3SpE9ki1qDnwXi++xN/OXIzywrn4IJ34=;
        b=ElmM9eY6jdrb5QmqZwy3XNNr2uxMnp/x5kTnU7cdVVBvfiZa137A0oqmf2GquqjB4t
         kz632vUFjE2nYGWmLqRJrqYBbQSM19eq/6oStWDdLQHRDw6juiJPpe4t84pDVD/CJasd
         W2hsrvBMQ60yivVBjrQGdw600M2PUr6JnlDcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781305731; x=1781910531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UNh4awcJcxT3SpE9ki1qDnwXi++xN/OXIzywrn4IJ34=;
        b=J1NUYSNWUPZz/JfqXc6hcoiltSWeoxsK56RR45v0xrq1NLLMj5aZhz5ZXzJwiHNa5o
         cnC8zgyNPZGIJFJfp0wOiep346PGPJmHQySvSOCR1/9tweRF55i/Z06MTBcvqfiVI9bn
         LLNjr586OtQ36vPjcNaGrAdT/N483Bq2zUOQOpoj8JKUJgMd07rdRP/R2SWndHxHE7jl
         lV6nkNBvC2ayJ45+lcVFmJvUUOR3g6NxYKqWlvmE375PXUA1HH4kAQU6/hSzPu73+yqX
         TGac/hYeAxQH59nFBQpL8yTPPW2bSjO/jtmhIjSrG2QVyReLMvgKn1Xo0i1swDJ/wOAU
         3zaw==
X-Gm-Message-State: AOJu0YxzQW8bQ52XK+ak0SBQ61sYwdp0A8ziwkHINtehf7paLBgGnECG
	y5aR4vp2yVv0K1Ir2s1NWk2NajqTSbPa7IgKW3ETa/TcWXplS4u4W8f4M+8mlP3oleYXNgBYTYp
	jw7/fXPGY/xCIaRklynMrYRKKM+fBAxu7Ui3A+r0+Iip2QKUfFDhMxvw=
X-Gm-Gg: Acq92OGnLlLXaGC5MU2jmAYQGsQEFPvaiGsQ8U70SFE9a4Q+cXL8JlQt6RtDvylc7fu
	bWW1RwUXKHcjT+Zff1KYpwaZk2B9iQSq/rbrxQ9nVffbygkZ3m6jHtXaiOcFaHd9daUJMc8Ld1D
	KU0xTkOSIqSgN6x+/8ZWi3gqspPQ92tCS8Ersf0/MnPsmL8RQ1RFNuHiZI8Z5ChG++aENgJ7+eU
	APVbIa7SjoBRuY+e+UBCgMqd4sOQjmhv8Vxjb1ndPt4TYFWu5mTPTpV4fUdAzLE5uQLc67l+rth
	17M5rltaRY6z/7X5bldEjuQDN7JtldPuU1baaNDAEibGyBBqS8havQ8=
X-Received: by 2002:a05:6820:1f10:b0:69e:87de:1fbe with SMTP id
 006d021491bc7-69edaad5a2amr2747828eaf.25.1781305731274; Fri, 12 Jun 2026
 16:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611212633.5058-1-kylebot@openai.com> <04c1bff937f903a43820ae4c916b6ea919944869.camel@dubeyko.com>
In-Reply-To: <04c1bff937f903a43820ae4c916b6ea919944869.camel@dubeyko.com>
From: Kyle Zeng <kylebot@openai.com>
Date: Fri, 12 Jun 2026 16:08:38 -0700
X-Gm-Features: AVVi8CcVK0IxRSq2tBIHKc7lsScGn3VYvIKTXjwI8TDRcK4RJgJVzXiDPmn-0wQ
Message-ID: <CAC7i46-j-5QgBcv2Bm64NUz+T5nkTBhiRmh=a7i0_hd2x099Tg@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: validate thread record before delete key rebuild
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org, Yangtao Li <frank.li@vivo.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, outbounddisclosures@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viacheslav,

I prepared a xfstests environment and tried to test the patches.
But unfortunately, due to my lab environment constraints, I could not
fully finish the tests: some tests errored out even without the
patches due to environment constraints.
I think you will still be the best person to perform the test. I'll
ping you around end of June.

Thanks,
Kyle

On Thu, Jun 11, 2026 at 9:11=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Thu, 2026-06-11 at 14:26 -0700, Kyle Zeng wrote:
> > hfsplus_delete_cat() is called with str =3D=3D NULL when the last open
> > reference to an unlinked HFS+ hardlink backing inode is closed. In
> > that
> > case, the function finds the catalog thread by CNID and rebuilds the
> > catalog key from thread.nodeName.
> >
> > That reconstruction path reads thread.nodeName.length directly from
> > the
> > catalog B-tree into fd.search_key and then copies length * 2 bytes
> > into
> > fd.search_key->cat.name.unicode. It does not first check that the
> > found
> > record is a thread record, that the record size matches the thread
> > name
> > length, or that the name length fits in the fixed HFS+ catalog key
> > buffer.
> >
> > A corrupted image can therefore provide an oversized thread name
> > length
> > and make hfs_bnode_read() write past the catalog search-key
> > allocation.
> >
> > Read the CNID record through hfsplus_brec_read_cat(), reject non-
> > thread
> > records, and explicitly bound nodeName.length before building the
> > delete
> > key from the validated thread name.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > ---
> >  fs/hfsplus/catalog.c | 32 ++++++++++++++++++++------------
> >  1 file changed, 20 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> > index 3f0cc1b1bb58..000000000000 100644
> > --- a/fs/hfsplus/catalog.c
> > +++ b/fs/hfsplus/catalog.c
> > @@ -351,23 +351,31 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> > *dir, const struct qstr *str)
> >               goto out;
> >
> >       if (!str) {
> > -             int len;
> > +             hfsplus_cat_entry entry =3D {0};
> > +             u16 thread_type;
> >
> >               hfsplus_cat_build_key_with_cnid(sb, fd.search_key,
> > cnid);
> > -             err =3D hfs_brec_find(&fd, hfs_find_rec_by_key);
> > +             err =3D hfsplus_brec_read_cat(&fd, &entry);
> >               if (err)
> >                       goto out;
> >
> > -             off =3D fd.entryoffset +
> > -                     offsetof(struct hfsplus_cat_thread,
> > nodeName);
> > -             fd.search_key->cat.parent =3D cpu_to_be32(dir->i_ino);
> > -             hfs_bnode_read(fd.bnode,
> > -                     &fd.search_key->cat.name.length, off, 2);
> > -             len =3D be16_to_cpu(fd.search_key->cat.name.length) *
> > 2;
> > -             hfs_bnode_read(fd.bnode,
> > -                     &fd.search_key->cat.name.unicode,
> > -                     off + 2, len);
> > -             fd.search_key->key_len =3D cpu_to_be16(6 + len);
> > +             thread_type =3D be16_to_cpu(entry.type);
> > +             if (thread_type !=3D HFSPLUS_FOLDER_THREAD &&
> > +                 thread_type !=3D HFSPLUS_FILE_THREAD) {
> > +                     pr_err("found bad thread record in
> > catalog\n");
> > +                     err =3D -EIO;
> > +                     goto out;
> > +             }
> > +
> > +             if (be16_to_cpu(entry.thread.nodeName.length) >
> > +                 HFSPLUS_MAX_STRLEN) {
> > +                     pr_err("catalog name length corrupted\n");
> > +                     err =3D -EIO;
> > +                     goto out;
> > +             }
> > +
> > +             hfsplus_cat_build_key_uni(fd.search_key, dir->i_ino,
> > +                                       &entry.thread.nodeName);
> >       } else {
> >               err =3D hfsplus_cat_build_key(sb, fd.search_key, dir-
> > >i_ino, str);
> >               if (unlikely(err))
>
> Have you run xfstests for this patch? Sorry, I am in personal trip
> right now and I cannot test your patch until the end of June. Please,
> ping me around that time.
>
> Thanks,
> Slava.
