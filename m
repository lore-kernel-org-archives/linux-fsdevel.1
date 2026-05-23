Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488ED39C624
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 14:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779545493; cv=none; b=fSTpwY0uTsG8sxLoxY7pO5qZoeq9ojbSHTcSiITba9xnawY+XSD2RJmM8CVYwIE7sBI0HnrInbi7VHbTZTVb/yUfjjH0XhAnbUt+MqQcOaZVj0WJB4a1/e+n2ntfFo/6IUUFjxt7hXIGAEms+86a2i6vGZtA20LN41SxhlLwbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779545493; c=relaxed/simple;
	bh=MILBUonuQ/wsxj9ePj1tEHVhxrKe7ayxnkU1ahxewbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRub8NyttUSyXi0jimGlNycqsMLdyeUem6SC00Eq648YrzztPU+VwLEociZ/XB4EgMOUwWFd/wCalyS6RsGVOQ19s93UcbToKayENMIFkd3hJ1Yp1OoCzYQJEFxxl693wNCStQiC00VMR2icdFjlrF75pGJFvKhR0TaXb4vW0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARnv6+Qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARnv6+Qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF06F1F00A3A
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 14:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779545491;
	bh=5W2hPzRfv2zBY7wnLkq9rUxeFMucgyWPf3pFW26nkHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ARnv6+QpVlLtwBuHa15v29UtIb3zkJ3ru6cilmwuTDNMbR9Yeod/dm6Tuevpleks2
	 JdEUYl3dbUUf+mwClGuW/t3vPiF3mVzRU4MeFjtWt3OzZ7/RL33AT92JqT1WPl4O+4
	 52wjJKAlX2qDuSMlQa1HxA9fq5jVKBt4/VD1LtdMfTEg7IVnNfr7kSAM+3Uit9YkB4
	 b22HS3RqAvUrN1yyKWfwch3y8pKushX3v6ZF/ST4bIh+1MyU4Ld9CVTuxnU/n2nDf1
	 +8L2QLmLsAAAJbdfFu1aNg2m+i+253kOsu/Wt56jfkXOp+/ANY3Sx5ASePD5haJKgq
	 ehnNrBJb1CPgg==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67cac5ece75so15562310a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 07:11:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8OyE5exjtvz/NPWhVnDezGKIVLQJM79JnnmOheQm1+Yx+Q5tNROrPHHjSA4SDxq7890hSo/6O9QlGqzeE3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6wGeeGorlHfyCHJsIeS6oKWMLIQDD2rsNuGbJjnYO3TXLEvoN
	1LXgTvqyUKMqqda4D7x/V9PHTJM7Tgg4qy/SMa3p2WFoh7ljg3ds/88XpV3r5pAhhOqd6HLyZlP
	MaegZbDYEbzPsz/xIYYy2T2NPZ3smJ7g=
X-Received: by 2002:a17:907:3f04:b0:bde:2f9b:bea1 with SMTP id
 a640c23a62f3a-bde2f9bcda6mr265483866b.24.1779545490640; Sat, 23 May 2026
 07:11:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260521130017.713848-1-charsyam@gmail.com>
In-Reply-To: <20260521130017.713848-1-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 23 May 2026 23:11:17 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9OeV-TOVfwZqBqbHdx-e22k2CFzUNuX9929bHMYN5THA@mail.gmail.com>
X-Gm-Features: AVHnY4I5B2j_tMsCeKFbaBope1hz7h2OictU8Abe7ujwpPtq96gE6pbKw6eXhWQ
Message-ID: <CAKYAXd9OeV-TOVfwZqBqbHdx-e22k2CFzUNuX9929bHMYN5THA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] ntfs: fix mount failure cleanup and free-count setup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:00=E2=80=AFPM DaeMyung Kang <charsyam@gmail.com>=
 wrote:
>
> Hi Namjae,
>
> This v3 is based on current mainline at 8bc67e4db64a.  The patches
> modify fs/ntfs/super.c in the Linux kernel tree.
>
> The fixes cover mount failure cleanup, a free-cluster precalc allocation
> failure path that can otherwise leave waiters blocked forever, and the
> $UpCase default-table alias check.  Per review, the free-cluster patch
> now avoids the temporary file_ra_state heap allocation entirely by using
> a stack variable for the synchronous bitmap scan.
>
> Testing:
> - Built fs/ntfs/super.o and fs/ntfs/ntfs.ko with gcc 13.3.0.
> - For patch 1, I built a DEBUG_KMEMLEAK/DEBUG_FS kernel and injected an
>   ntfs_fill_super() failure immediately after load_system_files().  Befor=
e
>   the fix, kmemleak reported the leaked volume label allocated from
>   ntfs_ucstonls(); after the fix, the same failure path produced no
>   kmemleak report.
> - For patch 2, I used QEMU with a debug injection that forces the initial
>   precalc readahead-state allocation to fail.  Before the fix, statfs
>   remained blocked in D state in ntfs_statfs().  This version removes
>   that heap allocation and therefore removes the injected failure point.
>   I also mounted a fresh NTFS image with the stack-backed state and
>   verified statfs reported the same free count as ntfsinfo -m.
>
> Changes since v2:
> - Changed patch 2's on-stack file_ra_state initializer from the empty
>   initializer to { 0 } to avoid build failures with stricter compilers.
> - Re-tested patch 2 alone and patches 1-2 on a clean mainline tree.
>
> Changes since v1:
> - Rebased and regenerated the series for the Linux kernel tree
>   (fs/ntfs/super.c), instead of the Github out-of-tree layout.
> - Changed patch 2 to declare the temporary file_ra_state on the stack,
>   as suggested by Hyunchul Lee, instead of adding an OOM fallback path.
> - Zero-initialized patch 2's on-stack file_ra_state because
>   file_ra_state_init() only initializes ra_pages and prev_pos.
> - Reworded patch 3 to avoid overstating user-visible name comparison
>   effects, and used memcmp() for the exact $UpCase table comparison.
>
> DaeMyung Kang (3):
>   ntfs: free volume-wide resources on fill_super failure
>   ntfs: avoid heap allocation for free-cluster readahead state
>   ntfs: only alias volume $UpCase to default on exact match
Applied them to #ntfs-next.
Thanks!
