Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3F1990C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934591; cv=none; b=umK4UpL6yvz5d522xckiViCbiosCWhmdQ45+fJIn7sDiT0aSKePwicPBLR9ydANCnXMZKnFwp5jjgCvBJCLOssyFxhBGm6h8i8n92Q8UqL0MZYgfqPVM3XDRwP9soTZkrV0OdGhypvFVms9ROROXJOBx+mf34GlD+UwtmYJZANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934591; c=relaxed/simple;
	bh=CEdZW/c55IqH4VqMnX9sw+sxGvIfqAxpZ1JxZtGBA5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvPdNBMsyRn8SJVaPxnH+uhX06iKoaFht7ZpC67BbbiNO4oi1KSe51ARX05+BWNKj3jcaF+w3AUGqTMxXyklw6fvFsb91u6OeRItVPu1IvRdIHBpaD+mnjGdybEaCSZho28anf0ZgNek/+POjQZeo4FOISrZBWRMcDJZYTWIxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioq9sS99; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioq9sS99"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E851BC2BCB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774934590;
	bh=CEdZW/c55IqH4VqMnX9sw+sxGvIfqAxpZ1JxZtGBA5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ioq9sS996MfcFJcKl0PVGAeDyF2SC4ERdXCfbGdMeqIgIFnInzHfnMheMFx32KK4B
	 8/V/RhaDw/4cL8oobxakkX8+atpnZmUDeRVQRlTD4f9+IWJHKl+ouLga8Ut4opOqR7
	 +nCtjV38T5utCjo4/brzj+gKtwmttFyxJ3p4ra6PnmsHKAioMpRcAqnLriLqtnoJOT
	 lfw8CHAoylhPdsek6PsJDA71DLFdBhUwCAifoR1+UvVuH9kF48wnFF53X8hkdsL/xG
	 6HAt2n461gzfu7PVzQxFLSvHOBb4/UvqVl47eKoPzRtSydw23ggmniBExowCqU0NL3
	 xKcnO2s1z8z8A==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8f9568e074so744174166b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 22:23:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPYE3ZdaXyIq47ORySoB63f1TE8OrD5/xv4LQOD6/wWLgt+37ttENntBU/Odhmgv4zIMfScEQXoNwmgqaX@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb8nk0qJ3cik5ACBJgjWB3g8xkSK8LuE6erWyxZGdahhlaXuZh
	rzjLq4dzWtlG7DLJ7GdHW5802suzrBPnQANhZjyXBWGdOrmuP5AQeVGrMd7vTcd66WqzLZYx6p9
	DqaCGDhywf+uyvMS0dfPlDLEP8qraZI0=
X-Received: by 2002:a17:907:3d52:b0:b97:a0d6:f6b2 with SMTP id
 a640c23a62f3a-b9b503015f2mr917412466b.4.1774934589482; Mon, 30 Mar 2026
 22:23:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-4-linkinjeon@kernel.org>
 <20260330063821.GC5897@lst.de>
In-Reply-To: <20260330063821.GC5897@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 31 Mar 2026 14:22:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9pZx1g=53wtCh0xTVYgQCLNz1sEL-2-fHbkSHQ=qTiTg@mail.gmail.com>
X-Gm-Features: AQROBzDzWpTKvvd3rWaWKjePoJF7nmxsnvgN5Mx94scfVAl-GVOvP_mhLrgpTnY
Message-ID: <CAKYAXd9pZx1g=53wtCh0xTVYgQCLNz1sEL-2-fHbkSHQ=qTiTg@mail.gmail.com>
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn, chizhiling@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:38=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > -#define EXFAT_CLU_TO_B(b, sbi)               ((b) << (sbi)->cluster_si=
ze_bits)
> > +#define EXFAT_CLU_TO_B(b, sbi)               ((loff_t)(b) << (sbi)->cl=
uster_size_bits)
>
> This should be a prep patch.
Okay.
>
> >       if ((attr->ia_valid & ATTR_SIZE) &&
> >           attr->ia_size > i_size_read(inode)) {
> > +             loff_t old_size =3D i_size_read(inode);
> > +
> >               error =3D exfat_cont_expand(inode, attr->ia_size);
> > +             if (!error && attr->ia_size > old_size &&
> > +                 old_size % PAGE_SIZE !=3D 0) {
> > +                     loff_t len =3D min_t(loff_t,
> > +                                     round_up(old_size, PAGE_SIZE) - o=
ld_size,
> > +                                     attr->ia_size - old_size);
> > +                     error =3D iomap_zero_range(inode, old_size, len,
> > +                                     NULL, &exfat_read_iomap_ops,
> > +                                     &exfat_iomap_folio_ops, NULL);
> > +             }
>
> Why is this needed for iomap?  Shouldn't explicit zeroing on size change
> be a prep patch?
Okay, I will change it to a prep patch.
>
> >       if (unlikely(exfat_forced_shutdown(inode->i_sb)))
> >               return -EIO;
> >
> > -     err =3D __generic_file_fsync(filp, start, end, datasync);
> > +     err =3D file_write_and_wait_range(filp, start, end);
> >       if (err)
> >               return err;
> >
> > +     if (!datasync)
> > +             err =3D __exfat_write_inode(inode, 1);
> > +     write_inode_now(inode, !datasync);
>
> This seems to have lost the i_state check to see if a sync
> is needed before __exfat_write_inode.  Also doing write_inode_now
> plus the explicit inode sync seems duplicate.  Last but not least
> I don't understand how this is related to iomap?
There is a deadlock issue when using iomap_dio_rw(). In
exfat_write_iter(), the inode lock is held while calling iomap_dio_rw.
generic_write_sync()->__generic_file_fsync() in iomap_dio_complete()
can be triggered, which attempts to acquire the inode lock again.
I will fix i_state check and introduced duplicate inode syncing problem.
> > +     ssize_t ret;
> > +
> > +     ret =3D iomap_dio_rw(iocb, from, &exfat_write_iomap_ops,
> > +                     &exfat_write_dio_ops, 0, NULL, 0);
> > +     if (ret =3D=3D -ENOTBLK)
> > +             ret =3D 0;
> > +     else if (ret < 0)
> > +             goto out;
> > +
> > +     if (iov_iter_count(from)) {
> > +             loff_t offset, end;
> > +             ssize_t written;
> > +             int ret2;
> > +
> > +             offset =3D iocb->ki_pos;
> > +             iocb->ki_flags &=3D ~IOCB_DIRECT;
> > +             written =3D iomap_file_buffered_write(iocb, from,
> > +                             &exfat_write_iomap_ops, &exfat_iomap_foli=
o_ops,
> > +                             NULL);
> > +             if (written < 0) {
> > +                     ret =3D written;
> > +                     goto out;
> > +             }
> > +
> > +             ret +=3D written;
> > +             end =3D iocb->ki_pos + written - 1;
> > +             ret2 =3D filemap_write_and_wait_range(iocb->ki_filp->f_ma=
pping,
> > +                             offset, end);
> > +             if (ret2) {
> > +                     ret =3D -EIO;
> > +                     goto out;
> > +             }
> > +             if (!ret2)
> > +                     invalidate_mapping_pages(iocb->ki_filp->f_mapping=
,
> > +                                     offset >> PAGE_SHIFT,
> > +                                     end >> PAGE_SHIFT);
> > +     }
>
> Eventually we should factor this code int oa common helper.  Not needed
> for this submission, though.
Okay.
>
> >  {
> > -     int err;
> >       struct inode *inode =3D file_inode(vmf->vma->vm_file);
> > -     struct exfat_inode_info *ei =3D EXFAT_I(inode);
> > -     loff_t new_valid_size;
> > +     vm_fault_t ret;
> >
> >       if (!inode_trylock(inode))
> >               return VM_FAULT_RETRY;
> >
> > -     new_valid_size =3D ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;
> > -     new_valid_size =3D min(new_valid_size, i_size_read(inode));
> > -
> > -     if (ei->valid_size < new_valid_size) {
> > -             err =3D exfat_extend_valid_size(inode, new_valid_size, fa=
lse);
>
> Why is this moving out?  I think the zeroing changes in this patch
> are really something that should be split out and explained in the
> commit log for better understanding and bisectability.
Okay, I will split it out and add detailed commit log.
>
> > +static int exfat_file_open(struct inode *inode, struct file *filp)
> > +{
> > +     int err;
> > +
> > +     if (unlikely(exfat_forced_shutdown(inode->i_sb)))
> > +             return -EIO;
>
> This doesn't look iomap-related.
Okay. I will split it out also.
>
> > +
> > +     err =3D generic_file_open(inode, filp);
> > +     if (err)
> > +             return err;
> > +
> > +     filp->f_mode |=3D FMODE_CAN_ODIRECT;
>
> This should go into the previous patch.
Right. I will fix it.
Thanks!
>
