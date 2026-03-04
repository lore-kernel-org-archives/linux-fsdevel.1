Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22263A2572
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772620232; cv=none; b=p0/aZJai3aZGzT+b+F+Qai0kFaBz3UZhRKuDXgfMfMtloMmY7NlRVJhPH15bpzQBEzodFM+GkpXfuwSPOkC3QKpeD7LB7RkXDGZ2qAKfnJL0JhhSpLKd4+v2RwE60cSH+PDCmjv31rY5URtq+INAn0aHDoZw9sXqjhEidEA5cCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772620232; c=relaxed/simple;
	bh=exF157vowtWwLaJaWRqadNcdOT2dbQYF14L6yU5wOBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aV8idmOekrBrERJ6tZ8rf9FIFkXb3orNziy3pmo3GP8889FYKTKXy9JSBziZvZhe4WMmqcNo9JXtCsK5p0y+SXPd2HfH1UBmlhXINObrWi8VskMNndqrYnONu5oB9oLAWa5m8/lXzAiIKoXAGXwZqRALztTT9brH2p6my/WZMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKdR8IIe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKdR8IIe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EA3C2BC87
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 10:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772620232;
	bh=exF157vowtWwLaJaWRqadNcdOT2dbQYF14L6yU5wOBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eKdR8IIeOjl85w1Vwg9LIEAd4fdDIj/cPV13FEtawmasNsEMz/k0wrfEJQtqxtaa3
	 KSewXzLZLUZV1cSMdIVWgs6AgnPou0viFdQJmUoW4olmoQj0VsdcM9M6IMUAKRgQ3l
	 9b111ii4+S/movpZkbfzplFur7KWo1Bh6zoE9SPqR+ZSVXqfszb29W0hZ5r/EuMyUZ
	 98vtks9m4yQYvJaqRFkxVpajY+Z+eEvZFtkJhFjaissksMsuupYW+nIU1pMdW/YJjA
	 22OqJMyhadlGnCPAt2z8fi98P9ZiIbvIAx1GIWv6GubU6J/RohPmVEhO3yq1nQ5YCU
	 bfJPmmNZCWFsA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-660ea8bcb96so785244a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 02:30:32 -0800 (PST)
X-Gm-Message-State: AOJu0Yy858zUTV/S15C/YT+98vD7t6L2osw7ODmbL7jxxRSMeEcmwOA4
	HvrDSz1evK0RXqIbghPt1aDWmLA7nHiW6HMvG+FnbYRQm1nccaI7WinCBpTMgjuSZxpu5Loi6RF
	bgT6gPjGRDRmoagI2bjtHNyuvWmrIxO0=
X-Received: by 2002:a17:906:ef04:b0:b88:4e52:bfb6 with SMTP id
 a640c23a62f3a-b93f1593b6bmr102542966b.56.1772620231013; Wed, 04 Mar 2026
 02:30:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228084542.485615-1-dxdt@dev.snart.me> <20260228084542.485615-2-dxdt@dev.snart.me>
In-Reply-To: <20260228084542.485615-2-dxdt@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 4 Mar 2026 19:30:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-LOF5zaV=g+myuF60q+57DCZ_4iAG_CaiMUoaUygvdgg@mail.gmail.com>
X-Gm-Features: AaiRm51xi0uohwjN8rY1l9Z1-VpSglPeWSEHST7xRVmuv0Xs9cKEUR5EsSDAe28
Message-ID: <CAKYAXd-LOF5zaV=g+myuF60q+57DCZ_4iAG_CaiMUoaUygvdgg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] exfat: add fallocate mode 0 support
To: David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 5:46=E2=80=AFPM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> Currently, the Linux (ex)FAT drivers do not employ any cluster
> allocation strategy to keep fragmentation at bay. As a result, when
> multiple processes are competing for new clusters to expand files in
> exfat filesystem on Linux simultaneously, the files end up heavily
> fragmented. HDDs are most impacted, but this could also have some
> negative impact on various forms of flash memory depending on the
> type of underlying technology.
>
> For instance, modern digital cameras produce multiple media files for a
> single video stream. If the application does not take the fragmentation
> issue into account or the system is under memory pressure, the kernel
> end up allocating clusters in said files in a interleaved manner.
>
> Demo script:
>
>         for (( i =3D 0; i < 4; i +=3D 1 ));
>         do
>             dd if=3D/dev/urandom iflag=3Dfullblock bs=3D1M count=3D64 of=
=3Dfrag-$i &
>         done
>         for (( i =3D 0; i < 4; i +=3D 1 ));
>         do
>             wait
>         done
>
>         filefrag frag-*
>
> Result - Linux kernel native exfat, async mount:
>         780 extents found
>         740 extents found
>         809 extents found
>         712 extents found
>
> Result - Linux kernel native exfat, sync mount:
>         1852 extents found
>         1836 extents found
>         1846 extents found
>         1881 extents found
>
> Result - Windows XP:
>         3 extents found
>         3 extents found
>         3 extents found
>         2 extents found
>
> Windows kernel, on the other hand, regardless of the underlying storage
> interface or the medium, seems to space out clusters for each file.
> Similar strategy has to be employed by Linux fat filesystems for
> efficient utilisation of storage backend.
>
> In the meantime, userspace applications like rsync may
> use fallocate to to combat this issue.
>
> This patch may introduce a regression-like behaviour to some niche
> filesystem-agnostic applications that use fallocate and proceed to
> non-sequentially write to the file. Examples:
>
>  - libtorrent's use of posix_fallocate() and the first fragment from a
>    peer is near the end of the file
>  - "Download accelerators" that do partial content requests(HTTP 206)
>    in multiple threads writing to the same file
>
> The delay incurred in such use cases is documented in WinAPI. Patches
> that add the ioctl equivalents to the WinAPI function
> SetFileValidData() and `fsutil file queryvaliddata ...` will follow.
>
> Signed-off-by: David Timber <dxdt@dev.snart.me>
I have directly changed mode 0 to FALLOC_FL_ALLOCATE_RANGE and applied
it to #dev.
Thanks!
