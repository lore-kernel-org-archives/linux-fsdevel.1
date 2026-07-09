Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4473911AD
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 00:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558698; cv=pass; b=JrsrxQeCVViv4zzmzMI/YzlNuUyjr9y7Cz5UHziuG2bP8KodCj1a4omn1Ne0Bbb0zH7s/EDuE897FPxo6YZroaOo7fOa4wxTSF2lPG0O7DmKp9fvhdabX5ll9Uvua5aU21JqMgVf2id4IS5ukLZ02k9NuuIXtm692hPUhizJdnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558698; c=relaxed/simple;
	bh=gzs69sSjHMEP3VR6xSBLEy1DmDVYHWQ39gIU8GgNtZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ML/mgZhczCs7gBpQV2pJFXzX1JiIWlwQ7cO6461FsTD7dkpaZEU/l9ltwFXW2vIeTMgB5wowNOFDjufr8tJSleC6qZdVxFY3eFE+eedN8fdxwXoGHreTp6fHUAQ7UFdBiv8lGgcnxUA2TTBg1uyhddsBH7kP4bjLxvZrSgMorrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=SwtXo1v/; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="SwtXo1v/"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb6573bd52so243113a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 17:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783558695; cv=none;
        d=google.com; s=arc-20260327;
        b=ZitPr/dYA1nBg0SNwPebu0LWguiMvRDl/VxMwlNMyUHjCH6XEkzcs/fQf+lAVDlcoy
         uV1HcM0Z1AdKXsslzcQiOQ9iJs7oqbiVLrRzAVz8/pDXhqk6nQhMqq945vgi4hXJN9IP
         KieFbHsnYP565dCm403WE05JQy8HLXGAu6AcBbzLlZq7vlReNRahJ2CvMaJr0FMBPxfc
         +4sMooEvdJihtFKdEhwIP6mMopN92HsIrnI5qXsizKS5xneiaPuGYs/bQ1g4I1DEFzQx
         UPT5auVeqoMCZpfEy7VkUPJh3fFKW2Z/0dX63PmdfyV/TcvRFA7b8Js5OwurD0TGpyQG
         uYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5cuWU8STCXIzWMfhdmv1TQ8fQk64aTcb5TI9ARHydOs=;
        fh=Q3ovIGRIYBrgoQHubHbmbCgKWi0ihEFgHXUr+L4XNsA=;
        b=oexyzg5fa2KEzbHBz/b4qqNfzk900EXIjGKTv882ovouBfhl0oeAUFdeUfPAnggcax
         zjagrnmY68TdjJ5ygm97grspRdZwLKzedrWlcyXUkyIqq67f7wL+iZHVppDUoBy90VLy
         BSHAMFWCB2x4hpwv/qqOmJbtajPzJ+3+0l04fFPuwMhjmG0FLhd7/QL/sVqNvworvvoZ
         N+43Vhs1+x+LFlUZeVZvei2O0gt1/N6+3FTzRiY23xT6eBpk7UJm1mEw/lxl278yZe1H
         X2z1H3Nqw6EdviQmVXHKeyUW1FM+3ioNVNjuCrdmqCfwbt6l4bbfsQHUDEvMtFFDBuZt
         2QaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783558695; x=1784163495; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5cuWU8STCXIzWMfhdmv1TQ8fQk64aTcb5TI9ARHydOs=;
        b=SwtXo1v/9AJOCHDA7oo8bIxFdVvY4f1gAWXnkm1EmRUFwg9VSb8PR3pR56At+hC/8r
         i9zF8EgYKppW+Brtk4yDBNst62hOfeIHZD5FFsMFK0LH56m3yMivzCUGSc+CcGdHcS8J
         3VewtuNM3z+0dFLivYoTfM8dmriSgG5wqboN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783558695; x=1784163495;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5cuWU8STCXIzWMfhdmv1TQ8fQk64aTcb5TI9ARHydOs=;
        b=gdjszJBzSbpoXR/184S45oziJAumcVHpYcNN06Rrg8LKFNZdNyv0NZjs+Tvu2LjCTM
         HfQulqTAz1vEwYcpKULXY1beq+pGeLtkcJ6DntOHpeUdyikaCsJ73RQD/0AjSYwqQ3zU
         MEvP/uMSUwz9pgAdno7XM5RVkZ8YxR88rgADp30rI593btyZNKZJ6tgHLkxlyPiCiJZJ
         IaGwuSbFfVFwPZD+96TEtOZpa5OpmNSNHUYOwiVDHEZLuwjVvhPcmCeSOS0WCEyOdzAn
         BFgubpYolkCuAML6IAzP3uWWCRnEYhrOMWXxtMuU7dXt6XUTPuhPmBxDtp5s0SAJylMx
         TVpA==
X-Gm-Message-State: AOJu0YxKgS8tvLeDPl3TcS/kUxxkOfyLV4z+QKIpGfftPjPE6IDD6NJz
	x3bVP0sjMmZ5zCrPVVCLyMv0TMSapg/f0bcZRcxNfBan0UNfFXbXzwPEjKPd4sgI4vPoYUJwfNT
	565gDW1GcFIXmsGjrMCZfMae+mu0aJTDfgK6RibipChmOvUR5auU9WpFq0Q==
X-Gm-Gg: AfdE7clmqXsQwSPdPXPr0z4Rsvk6Rqokqjx/M2Xl4aKPx/41tKdQ/yfX1xYXdM9DprD
	epIoAlJDP8BjkzcfmlQcW7M2snWQheczMHK1edp9r4wRj1vvMLtb2Hr2BDQeo/rufLQioNc4+Jg
	YTuN6dZ4M2n2/Hay6RH1wkPVrBK5UNdvQ72jFPKJKQN0qttWzaP4q+9tE5tRZXJi6+sDDkjew7d
	3RpZEUw/m1koWJvddkFLdLqXJBvawlh6aK/Iusst+p2Wg4dLcmsogSsIKBC4yramKSuv7a53fhI
	/VccffycUYyEwL5bYDS6p67cmfBrFQVniELqcqxL0DyI
X-Received: by 2002:a05:6820:3084:b0:6a1:7fa0:114e with SMTP id
 006d021491bc7-6a36dac4d25mr3457598eaf.64.1783558695122; Wed, 08 Jul 2026
 17:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707234130.23524-1-kylebot@openai.com> <e1dc4acaa001ad4fdf589bac3ccd2a937edc8f0c.camel@dubeyko.com>
In-Reply-To: <e1dc4acaa001ad4fdf589bac3ccd2a937edc8f0c.camel@dubeyko.com>
From: Kyle Zeng <kylebot@openai.com>
Date: Wed, 8 Jul 2026 17:58:04 -0700
X-Gm-Features: AVVi8CfPMDWLJcjsUkHlqmht3jxvSLdBVMZA_P1rgUGuNedeZ668kxWBmDEm9Y4
Message-ID: <CAC7i468N9F4j3ZcP1cc7RBzd_Q-6YjerduRGaYRutJ_+xvdcOQ@mail.gmail.com>
Subject: Re: [PATCH v4] hfsplus: validate thread record before delete key rebuild
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Considering that we want to reuse the check in
`hfsplus_brec_read_cat`, we can just switch to using
`hfsplus_brec_read_cat`, avoid the changes in `hfsplus_brec_read_cat`
and avoid adding the `is_hfsplus_cat_thread_name_length_valid`
function?
will send a v5 in a bit.

Best,
Kyle

On Wed, Jul 8, 2026 at 11:14=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Tue, 2026-07-07 at 16:41 -0700, Kyle Zeng wrote:
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
> > length, or that nodeName.length fits in the fixed HFS+ catalog key
> > buffer.
> >
> > A corrupted image can therefore provide an oversized thread name
> > length
> > and make hfs_bnode_read() write past the catalog search-key
> > allocation.
> >
> > Read the CNID record through hfsplus_brec_read_cat(), which performs
> > the
> > hfs_brec_find() lookup via hfs_brec_read() before validating the
> > catalog
> > record. Reject non-thread records before building the delete key from
> > the validated thread name.
> >
> > Make hfsplus_brec_read_cat() validate that a thread nodeName length
> > both
> > fits HFSPLUS_MAX_STRLEN and exactly matches fd->entrylength, then
> > share
> > the HFS+ thread-record-type helper between hfsplus_find_cat() and
> > hfsplus_delete_cat().
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > ---
> >  fs/hfsplus/bfind.c      |  8 ++++++--
> >  fs/hfsplus/catalog.c    | 30 ++++++++++++------------------
> >  fs/hfsplus/hfsplus_fs.h | 12 ++++++++++++
> >  3 files changed, 30 insertions(+), 20 deletions(-)
> >
> > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > index 9a55fa6d5294..d5e41e1c70b3 100644
> > --- a/fs/hfsplus/bfind.c
> > +++ b/fs/hfsplus/bfind.c
> > @@ -322,8 +322,12 @@ int hfsplus_brec_read_cat(struct hfs_find_data
> > *fd, hfsplus_cat_entry *entry)
> >                       pr_err("thread record too short (got %u)\n",
> > fd->entrylength);
> >                       return -EIO;
> >               }
> > -             expected_size =3D hfsplus_cat_thread_size(&entry-
> > >thread);
> > -             break;
> > +             if (!is_hfsplus_cat_thread_name_length_valid(&entry-
> > >thread,
> > +                                                          fd-
> > >entrylength)) {
> > +                     pr_err("catalog thread name length
> > corrupted\n");
> > +                     return -EIO;
> > +             }
> > +             return 0;
>
> Do we really need to change this function at all? Because, current
> check already works pretty well. This check covers everything already:
>
>
>         if (fd->entrylength !=3D expected_size) {
>                 pr_err("catalog record size mismatch (type %d, got %u,
> expected %u)\n",
>                        be16_to_cpu(entry->type), fd->entrylength,
> expected_size);
>                 return -EIO;
>         }
>
> >       default:
> >               pr_err("unknown catalog record type %d\n",
> >                      be16_to_cpu(entry->type));
> > diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> > index 776ce36cf076..1a4b0beae135 100644
> > --- a/fs/hfsplus/catalog.c
> > +++ b/fs/hfsplus/catalog.c
> > @@ -204,16 +204,11 @@ int hfsplus_find_cat(struct super_block *sb,
> > u32 cnid,
> >               return err;
> >
> >       type =3D be16_to_cpu(tmp.type);
> > -     if (type !=3D HFSPLUS_FOLDER_THREAD && type !=3D
> > HFSPLUS_FILE_THREAD) {
> > +     if (!is_hfs_thread_record_type(type)) {
> >               pr_err("found bad thread record in catalog\n");
> >               return -EIO;
> >       }
> >
> > -     if (be16_to_cpu(tmp.thread.nodeName.length) > 255) {
> > -             pr_err("catalog name length corrupted\n");
> > -             return -EIO;
> > -     }
>
> If hfsplus_brec_read_cat() covers this check already, then, probably,
> we don't need in new function and we don't need this check. If we still
> need to keep this check, then we cannot simply remove it but we need to
> call the is_cat_thread_name_length_valid() here. So, do we really need
> to introduce the is_cat_thread_name_length_valid() finally?
>
> > -
> >       hfsplus_cat_build_key_uni(fd->search_key,
> >               be32_to_cpu(tmp.thread.parentID),
> >               &tmp.thread.nodeName);
> > @@ -350,23 +345,22 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> > *dir, const struct qstr *str)
> >               goto out;
> >
> >       if (!str) {
> > -             int len;
> > +             hfsplus_cat_entry entry =3D {0};
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
> > +             type =3D be16_to_cpu(entry.type);
> > +             if (!is_hfs_thread_record_type(type)) {
> > +                     pr_err("found bad thread record in
> > catalog\n");
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
> > diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> > index ec04b82ad927..01e5f1246ff6 100644
> > --- a/fs/hfsplus/hfsplus_fs.h
> > +++ b/fs/hfsplus/hfsplus_fs.h
> > @@ -521,6 +521,18 @@ static inline u32 hfsplus_cat_thread_size(const
> > struct hfsplus_cat_thread *threa
> >              be16_to_cpu(thread->nodeName.length) *
> > sizeof(hfsplus_unichr);
> >  }
> >
> > +static inline bool is_hfs_thread_record_type(u16 type)
> > +{
> > +     return type =3D=3D HFSPLUS_FOLDER_THREAD || type =3D=3D
> > HFSPLUS_FILE_THREAD;
> > +}
> > +
> > +static inline bool is_hfsplus_cat_thread_name_length_valid(
> > +             const struct hfsplus_cat_thread *thread, u32
> > entrylength)
>
> I don't like this style. :) Potentially, we can rework it:
>
> static inline
> bool is_cat_thread_name_length_valid(struct hfsplus_cat_thread *thread,
>                                      u32 entrylength);
>
> Technically speaking, it will be better to provide struct hfs_find_data
> *fd and hfsplus_cat_entry *entry here.
>
>
> > +{
> > +     return be16_to_cpu(thread->nodeName.length) <=3D
> > HFSPLUS_MAX_STRLEN
>
> Do we need to have this check now? I assume that the second check could
> cover everything. What do you think?
>
> Thanks,
> Slava.
>
> > &&
> > +            entrylength =3D=3D hfsplus_cat_thread_size(thread);
> > +}
> > +
> >  int hfsplus_brec_read_cat(struct hfs_find_data *fd,
> > hfsplus_cat_entry *entry);
> >
> >  /*
