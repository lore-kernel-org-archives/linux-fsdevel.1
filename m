Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451FD1A9F9F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 00:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778200092; cv=none; b=afQDQwrRG4eYacr+qxK7pw2pk7cFEAgDROKZV8ZHFHnqK0sPKAjlpQDh/vNP/Azif/De4T7oPxOjAB6p+Uu7IkJ7a7CAuxdcH2L0kkbo4OEPwXUrL5Yqn54E9qMctio9QW+p0jaupk4Qro0kW/IPpI++6BTtlbprC1Vj8croEaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778200092; c=relaxed/simple;
	bh=ZhIirmXPJibjwua8ptV6kvCpwwbFmFz4gdoai4DGfmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKG91FDKLj+4M2UB14AIAT13irSqu38iR7iGpPF7ZKv1/Qt0CWCuAOCv4NLy1EKgJN0/wM0s1AQ3oA7Z1WFj3szOJtGnLpy6a6n5hGzOUVG7H3ffFNTFZjoOK8opdSVPbH5kb0HW8M4KkaosHx7rQTJmmgm1AF77KYn2HYkjMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsK9kb42; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsK9kb42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1BFC2BCFA
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 00:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778200092;
	bh=ZhIirmXPJibjwua8ptV6kvCpwwbFmFz4gdoai4DGfmw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lsK9kb42iXws6RUmTA/93o1ZynJgYisAuvObrTxXB7HXcCoGQBcDWX4Xu39wh2PVd
	 06LUg/bni71IHdgfimXhIKQ5tTL9MQqPF2zWCFnp7X1HBaLjpsGKW/WmLUv/XzduU8
	 Ccm59ntQ9rDmem18s0CqQW0Qzd91F7p1H+H9B6zbsxJN1B+/B1ry6FOb8QmetIR8mu
	 50yaOSqm/hN/nrEko0vGGRF1zylVWIDZrZhM8uo4LVLa30hCYGsLxouLxwnN1nsyln
	 1Vj70p/0Nu+msKKXgCkP42z7l/9azWwKJbwrihn4z38wcDDX0iZn7r0W1X5Vw1JbcJ
	 /Xjr301xfy1XA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso2237141a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 17:28:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/w0Zw2/2jfURgHK6+luDPRO55tdmXvaOJM76XbElWtvlLSy3n2boP3oAPYbFLw9O3EdF9lPKQr9SrPMjmj@vger.kernel.org
X-Gm-Message-State: AOJu0YwYIavwSFWMEhFWnqOxzP2EviePIY+iDUhLlKhg4AktSvh50y+C
	DRteZ5P3PNxSHqrogV2efOJVL/pxMIa5ByHZz20TE6RlJkKAGm//yOpzodXCq99DaUpxAiCFkKM
	a9ewRPVUm1dN3HpE/Y5Nq4QcRCZG6TIc=
X-Received: by 2002:a05:6402:3059:b0:670:9ca8:1eb4 with SMTP id
 4fb4d7f45d1cf-67d642b0377mr4089397a12.12.1778200090496; Thu, 07 May 2026
 17:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-5-linkinjeon@kernel.org>
 <CAMrLSE6tGG0b+zHExAFzdPJOL7Agv25ggg6nvUd6ik5rEN-DUA@mail.gmail.com>
In-Reply-To: <CAMrLSE6tGG0b+zHExAFzdPJOL7Agv25ggg6nvUd6ik5rEN-DUA@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 8 May 2026 09:27:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ne7geSQsNpboDv=b_tpeYD0K+CJzJ2N44MfkmsUo01g@mail.gmail.com>
X-Gm-Features: AVHnY4KMJpYNaBeVPnLlMbpkWRjWbIr4SW5UG9uQmbvjRGnn4CSy5f22nmejgas
Message-ID: <CAKYAXd-ne7geSQsNpboDv=b_tpeYD0K+CJzJ2N44MfkmsUo01g@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] exfat: add support for multi-cluster allocation
To: CharSyam <charsyam@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 11:09=E2=80=AFPM CharSyam <charsyam@gmail.com> wrote=
:
>
> hi, Namjae.
>
> The critical issue is that this hunk drops the hole-care walk in
>   exfat_map_cluster():
>
>                   *clu =3D new_clu.dir;
>   +               *count =3D new_clu.size;
>
>   -               inode->i_blocks +=3D
>   -                       exfat_cluster_to_sectors(sbi,
> num_to_be_allocated) >> 9;
>   -
>   -               /*
>   -                * Move *clu pointer along FAT chains (hole care) becau=
se the
>   -                * caller of this function expect *clu to be the last c=
luster.
>   -                * This only works when num_to_be_allocated >=3D 2,
>   -                * *clu =3D (the first cluster of the allocated chain) =
=3D>
>   -                * (the last cluster of ...)
>   -                */
>   -               if (exfat_cluster_walk(sb, clu, num_to_be_allocated
> - 1, ei->flags))
>   -                       return -EIO;
>   -               *count =3D 1;
>   +               inode->i_blocks +=3D exfat_cluster_to_sectors(sbi,
> new_clu.size);
>
>   The removed comment is explicit: the caller expects *clu to be the
>   cluster at the requested clu_offset, not necessarily the first cluster
>   of the newly allocated chain. The old code walked
>   num_to_be_allocated - 1 steps so that *clu ended up at clu_offset.
>
>   With this change, *clu is left as new_clu.dir (the first newly
>   allocated cluster) and *count is set to new_clu.size. That is only
>   correct for the sequential-extension case where
>   clu_offset =3D=3D num_clusters. For clu_offset > num_clusters, the call=
er
>   will compute the physical sector from the wrong cluster:
>
>         phys =3D exfat_cluster_to_sector(sbi, cluster) + sec_offset;
>
>   This also interacts badly with the new contig=3Dtrue allocation mode.
>   If exfat_alloc_cluster() stops early at a non-contiguous boundary,
>   new_clu.size can be smaller than num_to_be_allocated, so the allocated
>   run may not even reach clu_offset while exfat_map_cluster() still
>   returns success.
>
>   Could you keep the old hole-care behavior and extend it to the
>   multi-cluster case? After allocation, the code should advance from
>   new_clu.dir to the cluster corresponding to clu_offset, set *count to
>   the remaining number of clusters from that point, and handle partial
>   contiguous allocation by either continuing allocation or unwinding it
>   before returning an error.
exfat_map_cluster() returns a contiguous cluster range to the caller :
a starting cluster number (*clu) and the number of contiguous
clusters(*count) from that point. num_to_be_allocated is only the
maximum number of clusters the caller would like to allocate. If
exfat_alloc_cluster() returns fewer clusters than requested, that is
not an error.

Thanks.
