Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE69A2E1EFC
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784854686; cv=none; b=jtZJ8EEnsC5GQb+DIlsPyjqGwyzm34oQdqRSfZQg9Ca09IeLAP9X0aZcpwQkXuhgpYrwG7Gn6OTCYREBu3WO7WYsClm1uyH3v4fI9RstV6ccwvtpvxHMn/swWxUuktjxdtP7xl6rCMdgFmh3yrcRcmybp1cR2KWSwXTymPt+Yhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784854686; c=relaxed/simple;
	bh=smQ1Hlq4sZkwTbuY6sciG7w7xa0ATqjafTshS5++xgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccVVHcRdFZKlNzZnE8Pzav/BMr3wJf/DLKcnQLxcSfbKAEnE5A4z9IwLDaKp9c/FE3LzJDbrNHeY8gTKaYaKcay87+u9DOYQU8c+6ioOrenatD62w6U8bt18bmTFHRWfpByf+5ZGVbQjJ6Bh17G2ZSy3xvLip04mxSBAKZTO3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1wCAWrr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1wCAWrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8841E1F00A3A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 00:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784854684;
	bh=zqPw5fUO+01D4h/EOhOp3SO0FFgcARUmaMXnaD4beJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U1wCAWrr7nD1BMrdYIUq6mSMbH3hqNbfgigfoptao+FZqRRIBd6UyquDq1llSJWHo
	 sh54SDe6pYg9TKOkqEK0tIS07bPhOMMbg30kEEDno1ikJhvhpNHUhVMF9+YauoDNiM
	 hKCHOcVEF3us9s24YZ98iHEljcu+09x5M/hZHw0KE7Nz2vChLnrRRAF+yX4MMLdQNk
	 mzm9eqgvddY93Zl40l9+8rJjL/5zZi31xyvBbaMkjWlcKYofl12C6zUD0ihLOStO5d
	 //0Ns4LB9ya4BBJwToXbwQGGS3IqSxYihG3qvYwOjgixLTswWjlkod6b7o01pkSmub
	 tKQsH0VE3aEpg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15f020a223so168940666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 17:58:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoImhrU64va1m7c8a16fG34sJw1IGMRK0A6W/IHIfyYrRYAPRL9YbT8F0GPrt5ebDVXE9hSTbyZOilI567K@vger.kernel.org
X-Gm-Message-State: AOJu0YykudL8KfHwglEbXchnLSsDlUhd2xwiLp8Q42EZy3hBY89WTbSE
	uYiUFLkDbs1qcOwrxuDdv8gbLctCURs2gL/ny3gDKQDrHuXs9g5s7zsboX7ebjV1F1rP8x0NrLQ
	5OWZijdgxYSg6HtU7bXuGQPcssOMVaCI=
X-Received: by 2002:a17:907:6088:b0:c16:1655:309d with SMTP id
 a640c23a62f3a-c1c50d82182mr228504966b.56.1784854683217; Thu, 23 Jul 2026
 17:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260723191936.2419799-1-harshit.m.mogalapalli@oracle.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 24 Jul 2026 09:57:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd--N_2nY5XPr3vNyb7Ai+xYbuR3EE4ivecVf6Eur-vC_w@mail.gmail.com>
X-Gm-Features: AUfX_mzRUdgWrQsO3cVnG2RaABVXCep_ZxbBBKuGoeNDo7KwoV4l75T2jsZL4m0
Message-ID: <CAKYAXd--N_2nY5XPr3vNyb7Ai+xYbuR3EE4ivecVf6Eur-vC_w@mail.gmail.com>
Subject: Re: [PATCH] exfat: preserve allocated extents for swap activation
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:19=E2=80=AFAM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> exFAT reports allocated ranges beyond valid_size as IOMAP_HOLE whenever
> IOMAP_REPORT is set. iomap_swapfile_activate() also uses IOMAP_REPORT
> while collecting a swapfile's physical extents, so it treats the
> preallocated tail as unallocated and rejects the file with -EINVAL.
>
> Allocated space beyond valid_size is not a hole. Keep it as
> IOMAP_UNWRITTEN so iomap consumers that need physical extent identity,
> such as swap activation, can still use it. The iomap seek helpers
> already handle unwritten extents appropriately for SEEK_HOLE and
> SEEK_DATA.
>
> Fixes: b4b7fe2c7cbf ("exfat: add support for SEEK_HOLE and SEEK_DATA in l=
lseek")
> Assisted-by: Codex:GPT-5.6
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> LTP swapon/swapoff tests failed on exFAT, with this patch the tests
> pass.
> ---
>  fs/exfat/iomap.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
> index 190fc6471f84..24d93288a432 100644
> --- a/fs/exfat/iomap.c
> +++ b/fs/exfat/iomap.c
> @@ -105,18 +105,14 @@ static int __exfat_iomap_begin(struct inode *inode,=
 loff_t offset, loff_t length
>                  * marks the exact boundary between valid data and
>                  * holes (or unwritten space).
>                  *
> -                * When IOMAP_REPORT is set (used by lseek(SEEK_HOLE)
> -                * and SEEK_DATA), we return IOMAP_HOLE. This allows
> -                * iomap_seek_hole_iter() to directly return the
> -                * precise byte position.
> -                *
> -                * For normal I/O paths (without IOMAP_REPORT) we
> -                * return IOMAP_UNWRITTEN so the write path can
> -                * distinguish it from a real hole.
> +                * Allocated space beyond valid_size is not a hole. Repor=
t it
> +                * as IOMAP_UNWRITTEN so iomap consumers that need physic=
al
> +                * extent identity, such as swap activation, can still us=
e it.
> +                * The iomap seek helpers already handle unwritten extent=
s
> +                * appropriately for SEEK_HOLE and SEEK_DATA.
>                  */
>                 if (offset >=3D ei->valid_size) {
> -                       iomap->type =3D flags & IOMAP_REPORT ?
> -                               IOMAP_HOLE : IOMAP_UNWRITTEN;
> +                       iomap->type =3D IOMAP_UNWRITTEN;
Returning IOMAP_UNWRITTEN with IOMAP_REPORT can make SEEK_HOLE rely on
page-cache/block-granularity handling, which can lose the
byte-accurate valid_size boundary. Before activating the swapfile,
extending ->valid_size to i_size through exfat_extend_valid_size()
safely zeroes the preallocated range and makes it valid for swap use.

Thanks.
