Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522D02FDC30
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 01:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723256; cv=none; b=S7coArOfj17iQPOEjIL5ti+sAF9igCH3JY1UDVOYh9YFmRYGaRotFILMIDRBK7F/LVACRYrAXUN7IcWPK8xkC5IYHhJiPXEuraoJvONFfE6JZeTFPRXXFoO1gbQfRCvnBTsbEqJgsUCQqzh4c89P+BNr8WqGcoVm+6XCbxqyQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723256; c=relaxed/simple;
	bh=6GjOn+yVSqPQgjR7tD8rXnsM20DueX7fCF3o9OACxjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r7JU8b825uEtUJ+5jtaWglcqLgDLtzmZo8Wal6p2nd2XuEFOloiWDDupA47BfRuGoM0ZV4wtIYh+QNwvEGlzbfmEBKxPM3f2l2oFzhL/R0LOcqOYDHJci9M47X55ne8NTDH69fOdnvguDz7kSwGwEpd+m8DHoieuupDGKagYPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=na3E2gwU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="na3E2gwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334FFC19425
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 01:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723256;
	bh=6GjOn+yVSqPQgjR7tD8rXnsM20DueX7fCF3o9OACxjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=na3E2gwUIHbI2NX9N7bFPrD3RfNe+SHCSrlJL1eVOSwxUBAVdeW4RmNANUfim7UFL
	 9QvVJaE77B1c/RMA4jnByJnZEC/4s/O9nS1t8fwK+3CC1nWTytxchMl1cEynvz8tCQ
	 HM88xVA/GAciOX/Cs/M8IJHPmBuqUggq4I9V7Q78M7kU79MPblIizNuoCuZpx2kEv1
	 O8x1vVUty5rlNfkHr1Jfq0czcCl1QoKMZfJnYC0HI2W46V53r5Vu0NJU/8OywukLat
	 OymZvmgVar92olF1K+Mhowp8EXC2PBwuano1DCf0h52R3nJhl5m2puAqKoBS9j41pG
	 u/IPPggR2FobA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67c4aaf76ecso1100971a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 18:47:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9v1jtug76aXr/Y1UOuhbyH9nfjWU8JZrRKjIG9vHSbsIZEdKNrv/f5WAcfCleNi33bN3oyDRoGz1pl/3or@vger.kernel.org
X-Gm-Message-State: AOJu0YwlipzeF1cV7tFph812bL6VTm79/rkKZEq21AnRMRsjrk4txvbw
	6Hd0Zorj7HIUMyI5xGysQIZtaEmzJE306qFkfAsBA1PNnCiJaeaLw1k9ET+7y8ES0tqLwWpUeIt
	E+OfjHoyYYzqxT9ds/HReLd/X1xWq5rU=
X-Received: by 2002:a05:6402:518e:b0:674:5b2c:d42c with SMTP id
 4fb4d7f45d1cf-682a6e03765mr2760812a12.3.1778723254796; Wed, 13 May 2026
 18:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513112156.9122-1-linkinjeon@kernel.org> <20260513112156.9122-9-linkinjeon@kernel.org>
 <67ea38e7-ec7f-4ade-8962-074c60a45321@163.com>
In-Reply-To: <67ea38e7-ec7f-4ade-8962-074c60a45321@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 14 May 2026 10:47:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-R799_7CE90FsSfYnksrBkpfXgk=R5B+ObhwGJySFwEg@mail.gmail.com>
X-Gm-Features: AVHnY4LrBK83Z54JuNIrh5CKblw7Teq7orzd_sX7eetIOHmuvfysRL74XhJZ844
Message-ID: <CAKYAXd-R799_7CE90FsSfYnksrBkpfXgk=R5B+ObhwGJySFwEg@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] exfat: add iomap buffered I/O support
To: Chi Zhiling <chizhiling@163.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 10:39=E2=80=AFAM Chi Zhiling <chizhiling@163.com> w=
rote:
>
> On 5/13/26 19:21, Namjae Jeon wrote:
> > +static int __exfat_iomap_begin(struct inode *inode, loff_t offset, lof=
f_t length,
> > +             unsigned int flags, struct iomap *iomap, bool may_alloc)
> > +{
> > +     struct super_block *sb =3D inode->i_sb;
> > +     struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > +     struct exfat_inode_info *ei =3D EXFAT_I(inode);
> > +     unsigned int cluster, num_clusters;
> > +     loff_t cluster_offset, cluster_length;
> > +     int err;
> > +     bool balloc =3D false;
> > +
> > +     if (!may_alloc) {
> > +             /* Completely beyond EOF. Treat as hole */
> > +             if (i_size_read(inode) <=3D offset) {
> > +                     iomap->type =3D IOMAP_HOLE;
> > +                     iomap->addr =3D IOMAP_NULL_ADDR;
> > +                     iomap->offset =3D offset;
> > +                     iomap->length =3D length;
> > +                     return 0;
> > +             }
> > +
> > +             /* Clamp length if the requested range goes beyond i_size=
 */
> > +             if (offset + length > i_size_read(inode))
> > +                     length =3D round_up(i_size_read(inode),
> > +                                       i_blocksize(inode)) - offset;
> > +     }
> > +
> > +     num_clusters =3D exfat_bytes_to_cluster_round_up(sbi,
> > +                     offset + length) - exfat_bytes_to_cluster(sbi, of=
fset);
> > +
> > +     mutex_lock(&sbi->s_lock);
> > +     iomap->bdev =3D inode->i_sb->s_bdev;
> > +     iomap->offset =3D offset;
> > +
> > +     err =3D exfat_map_cluster(inode, exfat_bytes_to_cluster(sbi, offs=
et),
> > +                     &cluster, &num_clusters, may_alloc, &balloc);
> > +     if (err)
> > +             goto out;
> > +
> > +     cluster_offset =3D exfat_cluster_offset(sbi, offset);
> > +     cluster_length =3D exfat_cluster_to_bytes(sbi, num_clusters);
> > +
> > +     iomap->length =3D min_t(loff_t, length, cluster_length - cluster_=
offset);
> > +     iomap->addr =3D exfat_cluster_to_phys(sbi, cluster) + cluster_off=
set;
> > +     iomap->type =3D IOMAP_MAPPED;
> > +     if (may_alloc) {
> > +             if (balloc)
> > +                     iomap->flags =3D IOMAP_F_NEW;
> > +             else if (iomap->offset + iomap->length >=3D ei->valid_siz=
e) {
> > +                     /*
> > +                      * This is a write that starts at or extends beyo=
nd
> > +                      * the current valid_size. The region between the=
 old
> > +                      * valid_size and the end of this write needs to =
be
> > +                      * zeroed in the page cache to prevent stale data
> > +                      * exposure (see IOMAP_F_ZERO_TAIL handling in
> > +                      * __iomap_write_begin()).
> > +                      */
> > +                     iomap->flags =3D IOMAP_F_ZERO_TAIL;
> > +             }
> > +     } else {
> > +             if (offset >=3D ei->valid_size)
> > +                     iomap->type =3D IOMAP_UNWRITTEN;
> > +
> > +             if (iomap->type =3D=3D IOMAP_MAPPED &&
> > +                 iomap->offset < ei->valid_size &&
> > +                 iomap->offset + iomap->length > ei->valid_size) {
> > +                     iomap->length =3D round_up(ei->valid_size,
> > +                                              i_blocksize(inode)) -
> > +                                                     iomap->offset;
> > +             }
>
> Hi, you can write it like this:
>
> if (offset >=3D ei->valid_size) {
>         iomap->type =3D IOMAP_UNWRITTEN;
> } else if (offset + iomap->length > ei->valid_size) {
>         iomap->length =3D round_up(ei->valid_size,
>                                  i_blocksize(inode)) -
>                                         iomap->offset;
> }
Okay, Will update it.
Thanks!
