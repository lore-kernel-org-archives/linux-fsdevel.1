Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF9C1F94F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037837; cv=pass; b=Mxy1jYJJRKiAZ2IHz+wED9r7Tc8m6Oo5J3Dbsat1AxwoxVSUTgxsiZjpOTGsaj9cc13kyGlkbri7PHUCXB4U+w7PAQqycJdqfF7ZB1R2S9h1VlDRIjH2ADajFgM4ME2rBWprR4aO5kBuuoxgfP2Mli3AsdR2VRSgmw5XrSparvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037837; c=relaxed/simple;
	bh=kRH5ME6cl2uOZNTf4Hz7cjp4HebVSYInnLBFWd3k8/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJpzDru+K6V2Ty2UduxCS4icX/94CQE7PSfQPcuqlaMd4QPCF796LNLYrBcLA8ekovTJJ4pmK4myqhKMUns9dLu2rcC5uqBxvzQqDz0l/R1E85uWe8g6g92DXXa1fWZ00160DB8H6EMZi2LCjvYFx/mL1ChJZNEB9UIZ2dGCAlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a253fLdl; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a253fLdl"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-473ba028d46so28132f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 17:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783037834; cv=none;
        d=google.com; s=arc-20260327;
        b=nFLdwj2B7k3P1ue2FKGJKRtH/Mdio1xi5kutq9FENyKS/2hNaqTb6rq3MyeRSanF/M
         Rb1TrCsslSuEq/RRgP9MzFsv6hDZpewOjAJHQZEYL8pcmBFIMWGyv9H7t60W0jkVgzAK
         5b/k9ogchyGIToq6zUgnUqTIq9XwZGxsMwO6xTIK/s7/o4WQtVDGEPtRYg5B1S501zLS
         P3YbRpPYSZNvUzFDVe1h0zA5LHZHH7cv+rBvo4+34LYMglpsLKaQEesGZdgRAFiIpXmC
         4l8C8wa5UZwCCnXCirz35jjZw4kOsq5500N9/WHp5OUussEqF5cQp/VRZaF/S2yIwSE5
         Pjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vU7OEUrLlyve1bXZ6P0sGV5EAt2DQDqFHvcpp7wTUdg=;
        fh=fuA0yEll0gKLz3BbbFuI8jV5GQLKdoriNuOtAju7oBM=;
        b=oU5TQLtoc3qVtQSYob+oL9KKx3AEACaVrVFftC4Q4EFTBE05jsmh55mXaKOax8Caxq
         Nz4G4sN8t0fhJuZAm61/0tlzIrEaglJ5tuTbUJJtlj9zSnFLAQ3FEpoQw2fy9TxZQiq0
         IZg6gZrxN4aZXhOtN8W8r8Cdid3dhrvzhLawV74E6MOt1V7wH4KorG6yee4ARVFqfnMO
         Q/zwQl18UnTU8MChr/N+mA/oLmSo+e/aj9rrbZfs1JqYn4CyVO0PPQcKEI17ih6TQfbh
         ti0QYL6qt+NPG+CI/As2Ehtj59YDux/DFepfHf2jB9mk0s8vavZmP30fKDdlWFN6NA/g
         UDhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783037834; x=1783642634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU7OEUrLlyve1bXZ6P0sGV5EAt2DQDqFHvcpp7wTUdg=;
        b=a253fLdlbH8sjLvBQuxc18I7crzBttsxvYqvDQKjdsDqmfby4HxHTiwKBeYtfQQ1p2
         fh/NNNkiEW9X42YMwUy5BL6qjFZsgG79TS93wnUMg1ENd7lC9bWuRUojmsAlFGZlG7oR
         SPjr+K7XCDpAgW3mCbvg+3BmePEaE825ByxEhVgqByT1XDwEnrKuSX5d/yF2BLyer5mS
         ChzX45p2lDAQtLYtKI3ytM7J+SsLMMfkvDL4l5QHFiLAakQhDJWvXcVQTV0RU+xHFX02
         oIR4u6PTI4Aj/4YErRx6q+umHvbfjb03WNF1DboheuhkNRvK6jK32I/h0fQL9HRfAZcY
         tvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783037834; x=1783642634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vU7OEUrLlyve1bXZ6P0sGV5EAt2DQDqFHvcpp7wTUdg=;
        b=VvBDkmCoe8OpwmHDGdKCzhtMWr+3OWMMvH1tOButf0oxv7oR9e2OoWUlKAgPTj2itd
         Tphw14yXXCrIsO2hURYBrGwaM/2BdKKatQNhzUqtsOcI1jlD3S7OJaOvFfJreArOD/Qu
         8cZUR7k7oMLSng3zf9JyqqgLuTV168t0Wu+0+Z/Ac3pwbe1yhZLbrFhI8MF1PdrkHiw6
         f3CP+OIaceBogscx1pKKLKKOK50TfbLRBF9kFTT4m6zac8VXXsLNlgdzPLPCbY7tJkyv
         763BBBt8/Ludr3s22ANiaAFO/vPZKgolSTTUkpISzxYowNsd0DwNcqAa4Ox1BR/BL5FS
         jBkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8o6CPVaf0XQKsEegIfDXGhaC4XqJ1UA+08/XHv1/hGJvbxkEwjlKkD+2tenC+I4P9lUwJbb1/zOtLX5ExF@vger.kernel.org
X-Gm-Message-State: AOJu0YzoFN7jgSXjE6Ta8JfFXYBHHmowP7qz/kuG0Abx+uUQAkT7lrw8
	smKqLsyBqLdUbMkpRcjQaFCqJITc86CZMjN5O9Izn9o5zq7NfeptJniVp/FUwfmhoVqlzGE2IPi
	CcLpQFCBEuenydpFj2dSkbmqs6Vu5b2w=
X-Gm-Gg: AfdE7cnGBjg8rSSIRwUha19JvHFgMJfiiBsqp7lR7eaajwhgzf2TMv04EX3ug2bjM8H
	idl7Sy7VqfaSFsuPPB1Yr71S3nGQsTIt1/Sm/HrLMbJjVhY48989N8JFyJheEWyqbYnXz70L1Pc
	rfjSiljAsiFU/nhvIXaKOPYxR3mVKxAk/zvGbyytYukomzH2wCIe4gOsIej1IAWNqjea+CEegbK
	Q9/X2mDGGuphHNMDbsf7TgDovTBPTImm9uExoE1vaqSSor7w9YZWHw0ULa0JM+c61+NIlZy9lv4
	cw0YOwqtx+R8tsi11Ii4lzlzu/QrxSOLSyykiaYpg3foKy8kS1B6Y10/7jY/tVM=
X-Received: by 2002:a05:600c:46d0:b0:493:bc4a:c6b6 with SMTP id
 5b1f17b1804b1-493c2ba1d3emr113298325e9.38.1783037834179; Thu, 02 Jul 2026
 17:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-18-joannelkoong@gmail.com> <20260702165841.GM9392@frogsfrogsfrogs>
In-Reply-To: <20260702165841.GM9392@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 2 Jul 2026 17:17:02 -0700
X-Gm-Features: AVVi8CcxJan3XgaMiYmE7l9m1K7rjamtB3vH8NBAZsWn7x4K1BrIcNnVAJIzZPo
Message-ID: <CAJnrk1YW0gKRVvHRC+WeKoV2vrquzaC6UkipZkQ34Z0RAQDjtg@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] iomap: pass iomap_next_fn directly instead of
 struct iomap_ops
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Dan Williams <djbw@kernel.org>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Chunhai Guo <guochunhai@vivo.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, "open list:BLOCK LAYER" <linux-block@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>, 
	"open list:FILESYSTEM DIRECT ACCESS (DAX)" <nvdimm@lists.linux.dev>, 
	"open list:EROFS FILE SYSTEM" <linux-erofs@lists.ozlabs.org>, 
	"open list:EXT2 FILE SYSTEM" <linux-ext4@vger.kernel.org>, 
	"open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>, 
	"open list:FUSE FILESYSTEM [CORE]" <fuse-devel@lists.linux.dev>, 
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, "open list:NTFS3 FILESYSTEM" <ntfs3@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 9:58=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 3f0932e46fd6..0aa8abc438c1 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -626,7 +626,7 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
> >       return 0;
> >  }
> >
> > -void iomap_read_folio(const struct iomap_ops *ops,
> > +void iomap_read_folio(iomap_next_fn iomap_next,
>
> If you took my earlier suggestion to rename the typedef to
> iomap_iter_fn, then this parameter ought to be named iter_fn.

Hmm... maybe at that point, it's self-explanatory enough that the arg
could just be called "iter" instead of "iter_fn"?

>
> >               struct iomap_read_folio_ctx *ctx, void *private)
> >  {
> >       struct folio *folio =3D ctx->cur_folio;
> > @@ -650,7 +650,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
> >               fsverity_readahead(ctx->vi, folio->index,
> >                                  folio_nr_pages(folio));
> >
> > -     while ((ret =3D iomap_iter(&iter, ops)) > 0) {
> > +     while ((ret =3D iomap_iter(&iter, iomap_next)) > 0) {
> >               iter.status =3D iomap_read_folio_iter(&iter, ctx,
> >                               &bytes_submitted);
> >               iomap_read_submit(&iter, ctx);
> > @@ -688,22 +688,22 @@ static int iomap_readahead_iter(struct iomap_iter=
 *iter,
> >
> >  /**
> >   * iomap_readahead - Attempt to read pages from a file.
> > - * @ops: The operations vector for the filesystem.
> > + * @iomap_next: The iomap_next callback for the filesystem.
>
> "The iomap iteration function for the filesystem" ?
>
> Using the term "iomap_next" in the definition for iomap_next isn't that
> helpful.

Agreed, I'll replace this with your suggestion.

>
> >       return ret;
> > @@ -824,16 +824,16 @@ xfs_file_dio_write_atomic(
> >       unsigned int            iolock =3D XFS_IOLOCK_SHARED;
> >       ssize_t                 ret, ocount =3D iov_iter_count(from);
> >       unsigned int            dio_flags =3D 0;
> > -     const struct iomap_ops  *dops;
> > +     iomap_next_fn           dops;
> >
> >       /*
> >        * HW offload should be faster, so try that first if it is alread=
y
> >        * known that the write length is not too large.
> >        */
> >       if (ocount > xfs_inode_buftarg(ip)->bt_awu_max)
> > -             dops =3D &xfs_atomic_write_cow_iomap_ops;
> > +             dops =3D xfs_atomic_write_cow_iomap_next;
> >       else
> > -             dops =3D &xfs_direct_write_iomap_ops;
> > +             dops =3D xfs_direct_write_iomap_next;
>
> Probably ought to be called iter_fn, or at least something that isn't
> "dops".

Nice spotting, I'll rename this in the next version.

Thanks,
Joanne
