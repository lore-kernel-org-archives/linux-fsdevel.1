Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFB436D4E1
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934830; cv=none; b=dclxGr+RZ0dntyPKX2PuDGZmrSVA3CHSvm0+PpnjZMs55pZkUZXdptuZy/dKHAIB4PY/uNOeBvFObv2aMTISe5BoBHuZSKLmjiNyTFI+bSwzVvULVFGZDsmoGroDJ4ecKWd5k8tU0djyZIA8RniN0lrcetiTx3E0Ppj6qWyWclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934830; c=relaxed/simple;
	bh=nlZSyl2RXZKPY5q/mHssfmiL37g+oAdCzNJA6ryp43g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WG1ecox182iQFCEJC6TgtwnlEIsBYqIh6YoO35tyXd2m+GqgP0/Ze5dfuifnJbks1ItfU/DEvZVOIFZC14QvtpTtaCKBBPbJ+b1w1aFxamJvSTHOP1Qn47tS99Uq/upIAzZUBkdWqjeNJwGv1dh5u3/Ckqvcr6b+cJma7FI1JcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt611njy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt611njy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C21C2BCB3
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774934829;
	bh=nlZSyl2RXZKPY5q/mHssfmiL37g+oAdCzNJA6ryp43g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Vt611njygzJVY4shXDGgsrUObx0RdwaV8BjfIsccB0r6Gb76LOnziba+1Mdy10hGN
	 GZXCviSO5o9P/CsM5PlDg5/8PzMWnKkzVB+BBQB8AK5leJGVVeHfdoq8Hgvq9Y0aim
	 tZYiDXqee9Tvpdk5lAMLAtSdBkmrUDpByWMwDDOticm9+8NXW9BmeRlR6h8DScU6Tx
	 QVMDgP67TalT67u9lIhEReZoh+1Aa0cJU6v7+4fn6+YW3owMe5yKcnyMlClRWNN6Uf
	 9ne9B0NDSwmm4gXuw7HdJdm1b0aeuh6WWoI8uEy93UKfID29iWxznF7VDU9/9CxE0P
	 LEzUwvUIQUtYw==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-661b16ac011so9840285a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 22:27:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjPp8GZ3ZH3cLChKy+Grh5WkRrVKfPxeYw0b6fMRiMKF4JTCcGL8Zwj8plNtlLUHXI9LLaUYxjo6764QJq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6HzMvEIYXrkWhhUDTCZAI9pC0PSkkQ6YGihLc7Ea4Ma5gcFMa
	0CVUeAg6vhAWXgKb/es3vQU9h7NOSfJ/c5qWZhacq/E5F1eA9CxochsLZ4ZRf8rOYYCFSXwbQ7K
	0d5Ispoasc/wxCX7jaJCSZhSyuy3Fafk=
X-Received: by 2002:a05:6402:1471:b0:66b:f0b3:42a7 with SMTP id
 4fb4d7f45d1cf-66bf0b34608mr3552581a12.24.1774934828325; Mon, 30 Mar 2026
 22:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-2-linkinjeon@kernel.org>
 <20260330063059.GA5897@lst.de>
In-Reply-To: <20260330063059.GA5897@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 31 Mar 2026 14:26:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_uzuyfz6BBNPxDDiN9GRSoqOWPe__kKx=UbZNxVG70QQ@mail.gmail.com>
X-Gm-Features: AQROBzAU0OzdDj5Ng8hd2N3dSwwvcEPba3EyJkX8k2XZCNGxQ6bYqDvBOIE6IXo
Message-ID: <CAKYAXd_uzuyfz6BBNPxDDiN9GRSoqOWPe__kKx=UbZNxVG70QQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] exfat: add iomap support
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn, chizhiling@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:31=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> >
> > -static int exfat_extend_valid_size(struct inode *inode, loff_t new_val=
id_size)
> > +int exfat_extend_valid_size(struct inode *inode, loff_t off, bool bsyn=
c)
>
> This looks like at least partially unrelated refactoring.  Can you
> split this out into a separate well-documented patch, or maybe even
> two where one has the bulk reformatting changes, and one adds the
> new bsync option?  Also it might help to document the bsync option.
> Often it might be more readable to add a flags parameter with a named
> flag to make things easier to follow.
Okay. I'll split it out into a separate patch and add a flags
parameter with documentation.
>
> > -static int exfat_map_cluster(struct inode *inode, unsigned int clu_off=
set,
> > -             unsigned int *clu, unsigned int *count, int create)
> > +int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
> > +             unsigned int *clu, unsigned int *count, int create,
> > +             bool *balloc)
>
> Similarly, this would be a good prep patch.
Okay.
>
> > diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> > new file mode 100644
> > index 000000000000..e4135a13454f
> > --- /dev/null
> > +++ b/fs/exfat/iomap.c
> > @@ -0,0 +1,305 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * iomap callack functions
> > + *
> > + * Copyright (C) 2026 Namjae Jeon <linkinjeon@kernel.org>
> > + */
>
> Also normally new infrastructure would get added with the users.
> I.e. the bits you're using in the first iomap conversion would go
> with that and so on.  But that's not a strict rule.
I'll try to split the introduction of the iomap infrastructure so that
only the parts actually used in each conversion step are added
together with the users.
>
> > +/*
> > + * exfat_iomap_put_folio - Put folio after iomap operation
> > + *
> > + * Called when iomap is finished with a folio zero-fills portions of
> > + * the folio beyond ->valid_size to prevent exposing uninitialized dat=
a.
> > + */
> > +static void exfat_iomap_put_folio(struct inode *inode, loff_t pos,
> > +             unsigned int len, struct folio *folio)
>
> Can you explain the logic here?  Shouldn't the iomap buffered I/O
> code do all the needed zeroing for you based on the map type?  If not
> how could we enhance the core iomap code so that we don't need this
> in the file system, which feels like a bit of break of abstraction
> barriers?
The reason we have exfat_iomap_put_folio() is because of exFAT's
VDL(->valid_size). When we map a range beyond ->valid_size, if we set
the map type to IOMAP_UNWRITTEN, iomap_zero_range() does not perform
zeroing.
However, if we set it to IOMAP_MAPPED, then iomap_zero_range() treats
the area beyond ->valid_size as valid data and could expose
uninitialized garbage data from disk. So it explicitly zero out the
portion beyond ->valid_size in exfat_iomap_put_folio().
I agree that it would be better if core iomap could handle this case by its=
elf.
I'll check whether we can improve the core iomap layer to avoid
filesystem-specific put_folio handling for ->valid_size.
>
> > +/*
> > + * exfat_file_write_dio_end_io - Direct I/O write completion handler
> > + *
> > + * Updates i_size if the write extended the file. Called from the dio =
layer
> > + * after I/O completion.
> > + */
> > +static int exfat_file_write_dio_end_io(struct kiocb *iocb, ssize_t siz=
e,
> > +             int error, unsigned int flags)
> > +{
> > +     struct inode *inode =3D file_inode(iocb->ki_filp);
> > +
> > +     if (error)
> > +             return error;
> > +
> > +     if (size && i_size_read(inode) < iocb->ki_pos + size) {
> > +             i_size_write(inode, iocb->ki_pos + size);
> > +             mark_inode_dirty(inode);
> > +     }
> > +
> > +     return 0;
> > +}
>
> I think in the long run we should just do this as the default in
> the core iomap dio code when no end_io routine is provided for
> writes.  But I can refactor this later to not hold you up.
Okay, Thanks!
>
> > +static int exfat_read_iomap_begin(struct inode *inode, loff_t offset, =
loff_t length,
> > +             unsigned int flags, struct iomap *iomap, struct iomap *sr=
cmap)
> > +{
>
> The read and write routines look very similar, and chance we could
> extra most of the logic into a common helper?  Also the rounding of
> the length using the start in the write version looks like it would
> be the right thing for the read side anyway.
Okay. I'll factor out the common logic into a helper.
>
> > +static int exfat_mkwrite_iomap_begin(struct inode *inode, loff_t offse=
t,
> > +             loff_t length, unsigned int flags, struct iomap *iomap,
> > +             struct iomap *srcmap)
> > +{
> > +     return __exfat_write_iomap_begin(inode, offset, length, iomap);
> > +}
>
> The special mkwrite handling looks a bit odd to me.  I'll return to
> that later in the series, but this is a good example where keeping
> all the related code together would help the reviewer.
Okay. I will fix it.
>
> > +     if (offset < wpc->iomap.offset ||
> > +         offset >=3D wpc->iomap.offset + wpc->iomap.length) {
> > +             int error;
> > +
> > +             error =3D exfat_read_iomap_begin(wpc->inode, offset, len,
> > +                             0, &wpc->iomap, NULL);
>
> The read confused me a bit here, but I guess by the time we do writeback
> everything is allocated in exfat.  This would be another good candidate
> to directly call the low-level helper suggested above.
Agreed. As you suggested, I'll change it to directly call the
low-level common helper.
>
> > diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> > index 83396fd265cd..b69c4b0a926b 100644
> > --- a/fs/exfat/super.c
> > +++ b/fs/exfat/super.c
> > @@ -499,6 +499,7 @@ static int exfat_read_boot_sector(struct super_bloc=
k *sb)
> >       if (p_boot->num_fats =3D=3D 2)
> >               sbi->FAT2_start_sector +=3D sbi->num_FAT_sectors;
> >       sbi->data_start_sector =3D le32_to_cpu(p_boot->clu_offset);
> > +     sbi->data_start_bytes =3D sbi->data_start_sector << p_boot->sect_=
size_bits;
>
> Is this related to iomap?
Yes, I'll split it out into a separate prep patch together with the
other related changes, so it will be clearer.
Thanks for your review!
>
