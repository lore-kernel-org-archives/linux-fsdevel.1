Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504931353B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 09:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775553507; cv=none; b=C2FHq0vfCEzM27pbgqEhgGXL3DWYG5oolOxeTh6eGZ7eWQv6pRdPKNhXkGhu9WWWqXjYbsKn5dWIrT52/UKsQF6X7auuZH83eOqSRI+/HLDguRSQ3wLSPhh0/IgvKfLRBAf2IyGD3lbwv13JTHH2mySCdC9B71QtF1ohdrU5Cc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775553507; c=relaxed/simple;
	bh=l4NivXEBu4XAPyzAuqyjGuA1t03KnXTa7jy9LR21weU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSWW1AnRy5Sb5c1H1zmsjOR4HACx5wEOMJrEY4H9koyIuj++xkjqxE1S25azXEeXEcU76sjtR5UNkhdsvYtsCqT1rcOVD192ARh6Fut7hR4qdgnrNwlGcTaL7jNspzkpyNjX8fCSD+b+YyYNSoApdqsRfE2gt/1scZrpqeo42PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv1FS9z9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv1FS9z9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2D0C2BCB1
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 09:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775553507;
	bh=l4NivXEBu4XAPyzAuqyjGuA1t03KnXTa7jy9LR21weU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cv1FS9z9Y2b7jAUWbXpsdPyXOUz9v3LcbSibEn5YMNTecKFvTQLDrVjlDZpdATvCc
	 aeQAHHyL7975umF2hzF7BbftylB7QNykpWjzhhTQsM3p25t8gvWX2kOtp0pb368r5c
	 Ks/Uf+JpQrAtx7WXAmDAqGq4S/ENzW3dkNXL82XE5ZDWRjV9dgf6oBLh7OSEHZewn/
	 J+nroMuJpbBCHYWfsp0mdB18XOObS8vzeETfFOGk5gRJO85Z/8XpDGqOpmQLKLu9Od
	 Wwf8ESfi6ahy07uS/brl0Ky+xmR9g3pn5C7HxG2zGC2lBPVCM/tKFvjQuMn9SKGc9/
	 RZ/BnA4VLMzYw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66e8cc747d8so3631323a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 02:18:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJ1NIV4gFR3I3xS8GgJeTzc0jCaJbFu4HbrI8C80DSPecOsN2O/xr4VZGAoA2E4eezDJ8ZXvOPc6X1EMN7@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5z1m2qLMmfyZTwmLCT11SGMVutpfqhxuPUBehFmpY+Lo9OhF
	FAzPmXu5bMDXStsXxzyX1WgdjSJuixFV8Lbq3Td5NjhX7y7u7G5PSZ13TKF0iQimb/nWmx390lM
	e7Hi2FRDIjjcEW5wL+T8i8444759JbW0=
X-Received: by 2002:aa7:c452:0:b0:66e:55cc:315d with SMTP id
 4fb4d7f45d1cf-66e55cc3257mr4107857a12.27.1775553505716; Tue, 07 Apr 2026
 02:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-4-linkinjeon@kernel.org>
 <149dabc5-5e88-4589-aec6-fd22925ce974@dev.snart.me> <20260407062849.GA6966@lst.de>
In-Reply-To: <20260407062849.GA6966@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 7 Apr 2026 18:18:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-NPV8Ep9+dhDoMPkJtmv+B3TO_82WHGwRqSFoUy-a45w@mail.gmail.com>
X-Gm-Features: AQROBzBli4D9lo8SBfPsTf1RBsJWCDuu6Tx8gI39JGNzdatFwyBi5b4bv9n4bQw
Message-ID: <CAKYAXd-NPV8Ep9+dhDoMPkJtmv+B3TO_82WHGwRqSFoUy-a45w@mail.gmail.com>
Subject: Re: [PATCH 3/5] exfat: add iomap buffered I/O support
To: Christoph Hellwig <hch@lst.de>
Cc: David Timber <dxdt@dev.snart.me>, sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, chizhiling@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 3:28=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> On Mon, Apr 06, 2026 at 10:09:42PM +0900, David Timber wrote:
> > > -#define EXFAT_CLU_TO_B(b, sbi)             ((b) << (sbi)->cluster_si=
ze_bits)
> > > +#define EXFAT_CLU_TO_B(b, sbi)             ((loff_t)(b) << (sbi)->cl=
uster_size_bits)
> >
> > I think type casting should be left to the users of the macro. These
> > helper macros are quite dangerous in case of (ex)FAT because integer
> > overflows are unchecked for shift op. The on-disk format is 32 bit but
> > the kernel has switched over to "all-64-bit".
> >
> > That particular macro is used in dirent update code and, in particular,
> > in exfat_map_cluster():
> >
> >     inode->i_blocks +=3D EXFAT_CLU_TO_B(num_to_be_allocated, sbi) >> 9;
> >
> > The type of i_blocks is blkcnt_t, which is unsigned. loff_t is signed.
> > exFAT got away with it because Linux write calls expand the size of
> > files no more than 0x7ffff000 bytes and the size of dir is limited to
> > 256MB. However, someone could come in and decide to use
> > exfat_map_cluster() to allocate more than this limit.
>
> But that will blow up in some many other ways.  The only sane thing
> to do here is to replace those macros with inline functions that
> include the proper casting.
Agreed. I'll replace them and include the changes in the v2 patch-set.
Thanks!
>
