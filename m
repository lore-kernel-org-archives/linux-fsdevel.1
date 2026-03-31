Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245E285C9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934613; cv=none; b=Q9uVBDx7i5QPqmAd6DEi702VZNg1iqTi2CXiKtv9Wclw63hjpY8fPbximZjbnHI1SAmREMp0jKIN2js+Yx5v+8ausYA+1xuRSbSBEOt52pLBsJSiGnQFVesgTcb6sqaLRxU2xO4Xjnd04MrICJd8C03OGRmoKqSlR6Ti8QHAJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934613; c=relaxed/simple;
	bh=wlvLz0WGqQy/cxT7OAS25PJ/Ukgw49BOZnMDwQcgY54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaLTLUZY/mv55PaKiwTlI1wkcEcL5mOiMbUqnG3OFKOxm60yY7sygKF44vx1ASgYYwBnSQ0GzQbb4S48DlxqV5k2OVNfjY8rKQkxQZH5uv1G4EF64/z4/HsDQ5fAXAhNwuL1+JjR6p5tj6lzFiyjGE8yq2HlHGv0B9wOVZYHsQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYnvox4A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYnvox4A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07D8C2BCB4
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774934612;
	bh=wlvLz0WGqQy/cxT7OAS25PJ/Ukgw49BOZnMDwQcgY54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XYnvox4A0EH/ZwWlesg3PWJ+Z3m1VDmWrzu0u1AwLHr/jhKj6M0W/wGJmYFXSDJ7K
	 z4KaKryCNhp5yj5UQ318ZTEjAZgNq9kGDoukVzCG7hSkpM0n955rdUBT+zs5mrSNId
	 Mkev9x+KxtcLo7gPt7OgrrGTOuam0xZa+SxRBBg/LVj4byluG/xz/phN3NZxZqXhSD
	 rEwVQKOaPfqfE1E72lt+K3UpAI86dLJQ+RkPlKTNdQedo358wTkkX9OEA3Tcq00qGF
	 LavzZymm9Masn0dyn2NuQBBZpx8CYl5MxXx6Xi9sD6jhUGHIk6urXwe5GCffUADIic
	 9pRAd4seCVxfQ==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66c304dbfd2so1176870a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 22:23:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPzNPLnmafxVHWqylBOFqULfJaSB63bJ9rbXPycgGol5ryli4s4tFDEvycAVaFCmjNOLnuJJRJism+ybrx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ZWYXXT0G/EM5X/2YvQiQf++nAGntJO1sfTOf6pKQ82au8u7N
	5Nd0VSTqwwm91D79+Z4peZEGQqQTdSBu7AWc5UI6hOfTKtFY8ZyDpS+TdL7gqEPYOPz6ghV8hkE
	MTpWfbtMmuJ/K4S0EyAvUlusqeoZ4hWw=
X-Received: by 2002:a05:6402:4552:b0:665:3cea:9864 with SMTP id
 4fb4d7f45d1cf-66c3383b8e5mr836736a12.12.1774934611366; Mon, 30 Mar 2026
 22:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-3-linkinjeon@kernel.org>
 <20260330063321.GB5897@lst.de>
In-Reply-To: <20260330063321.GB5897@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 31 Mar 2026 14:23:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9VVBQ2kqAsJBU29LxXJUStt+O+1tQvNcwbiPwROGJdKw@mail.gmail.com>
X-Gm-Features: AQROBzBfJ0YUThW1CvjNsrdZec4bN_D2PtBZO_W95qBDFZ6NHhxEmHluJGS9DoI
Message-ID: <CAKYAXd9VVBQ2kqAsJBU29LxXJUStt+O+1tQvNcwbiPwROGJdKw@mail.gmail.com>
Subject: Re: [PATCH 2/5] exfat: add iomap direct I/O support
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn, chizhiling@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:33=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Mar 26, 2026 at 08:50:42PM +0900, Namjae Jeon wrote:
> > +     if (iocb->ki_flags & IOCB_DIRECT) {
> > +             ret =3D iomap_dio_rw(iocb, iter, &exfat_write_iomap_ops,
> > +                             &exfat_write_dio_ops, 0, NULL, 0);
> > +             if (ret =3D=3D -ENOTBLK)
> > +                     ret =3D 0;
>
> This seems to miss a fallback to __generic_file_write_iter?
There is a follow-up patch in the series that adds the fallback to
buffered write. I'll reorganize the patches so that this change and
the fallback are combined together in a clearer way.
>
> > +     inode_lock_shared(inode);
> > +     if (iocb->ki_flags & IOCB_DIRECT) {
> > +             size_t count =3D iov_iter_count(iter);
> > +
> > +             if ((iocb->ki_pos | count) & (inode->i_sb->s_blocksize - =
1)) {
> > +                     ret =3D -EINVAL;
> > +                     goto inode_unlock;
> > +             }
>
> iomap_dio_bio_iter() should already take care of the alignment check.
Right, I will remove it.
>
> > -     .direct_IO      =3D exfat_direct_IO,
> > +     .direct_IO      =3D noop_direct_IO,
>
> This should not be needed, setting FMODE_CAN_ODIRECT in ->open should
> be all that is needed.
Okay. I will remove it.
Thanks!
>
