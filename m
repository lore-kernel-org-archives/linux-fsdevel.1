Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360663F8235
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783337483; cv=none; b=gZ1+LPnHt4+M/1o8FeUinvDP/Bv2MKsyCk/XwjPltJt0yhOYqecU0a+HAkX17WP/xqRroRKvWDahq3jEUm0GzMnVvC12gVmw7J0TqebuM4OeCf2vidfjiPYth0iURL9TEldFBRY7sAB0O36t/jPtbN+JojbXYDZN3Ipva7UxjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783337483; c=relaxed/simple;
	bh=tcYS54rlsuveoQglG//no8aN9gcv9vZTT/MY7HcJPws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdLeqr86+1E8a+vwSiD699mi40oO1qhpuo+DcusEbo6ZjcxxGOhE7xvQfho4o+OxHRc+KrnJwHZU7Qy45PacROJsemvutMoKUE6smuUhIUKT3guPBOy4k/6a18xS7a56ifJvBWbh8vcNXeWAJcaalDNJJG/lp7cHR1CbXFoxZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKf0Q+1k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKf0Q+1k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5901F00A3E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783337482;
	bh=LN6BkhXP/Y62ngyS6joRDMaqj/ILkNtB6isj6Yz81R4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DKf0Q+1kVKj4NAaxUTXqvBX2GwYcshtK3Bdy52+2vWNn78Q1Y+Zp8qRIJqNW3jVop
	 J7Hz5jX+0dGbpRrVzDVMLcm2GMPEHQlchXEIegOPR3U095m6rFg9qf379D7+YZO2xZ
	 i1d4J0qIGs4z5M/4DoO1XILvP8mDKOdqonvHWwkPndD3uA6ZVhriNLGkph5M79mZAO
	 /uOYh/RAQb6EjbNGdzHdX8YTq+k18i5SnIzjYRTyF79EnO6TnqLWkOf6E2CgNqN299
	 oGPshTSuqkgH8tao7IdaYEBEjBYzAevKziyNjbWEWHfDtF6doICJThIX7AB4qFq3Ye
	 I3+QT7Ba9bbmg==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c125c082ee2so266639366b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 04:31:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RofOt1bPDngKc4CxA/3OBkk6LSh1nDV/TejKuvIGM/7fuLxjFVHrVf+mfvEVlbKlXx5h3KdHRGsKfslZU5P@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+0sCPO+oQFxgcPoz5jW1ygOlQU0nijTuE3ysK18rEGJG6f2b
	9yf5F9EAKvkLnDPWzOsGKkTtaCTSlBBTsrazwq5nnX9LIdoeGqDmOFDt8iadNsvYBzXrJ5+f0a5
	Njog6PetNhIFJPoxG9CzDI3kqysaDMxA=
X-Received: by 2002:a17:906:489a:b0:c12:6f98:d6a1 with SMTP id
 a640c23a62f3a-c15a6899fbfmr4785566b.62.1783337480614; Mon, 06 Jul 2026
 04:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704094007.426882-1-yashnikov.valeriy@gmail.com>
In-Reply-To: <20260704094007.426882-1-yashnikov.valeriy@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 6 Jul 2026 20:31:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9ngbove9i0Z2eiy33PBsfjESPCuq3jBrEmBsmnhUzN0Q@mail.gmail.com>
X-Gm-Features: AVVi8CcpfiwGR3vlteaaWUli1g9VO1PL080Y99ZOmTmIIpi96bPKYSBvgJuCU48
Message-ID: <CAKYAXd9ngbove9i0Z2eiy33PBsfjESPCuq3jBrEmBsmnhUzN0Q@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid calling post_write_mst_fixup() for invalid index_block
To: Valeriy Yashnikov <yashnikov.valeriy@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 6:39=E2=80=AFPM Valeriy Yashnikov
<yashnikov.valeriy@gmail.com> wrote:
>
> ntfs_icx_ib_sync_write() calls post_write_mst_fixup() when ntfs_ib_write(=
)
> returns an error, intending to restore the buffer after a failed write.
>
> However, ntfs_ib_write() returns an error immediately if
> pre_write_mst_fixup() validation fails. The caller,
> ntfs_icx_ib_sync_write(), interprets any error as a write failure
> requiring rollback. It does not differentiate between I/O errors and
> validation failures, and calls post_write_mst_fixup() anyway.
>
> Since post_write_mst_fixup() assumes that the index_block contents is
> correct, it doesn't perform the boundary checks, which results in
> out-of-bounds memory access.
>
> An attacker can craft a malicious NTFS image with:
>   - large index_block.usa_ofs offset, pointing outside the ntfs_record
>   - index_block.usa_count =3D 0, causing integer underflow
>   - or index_block.usa_count larger than actual number of sectors in the
>     ntfs_record, causing out-of-bounds access
>
> KASAN reports describing the memory corruption:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-out-of-bounds in post_write_mst_fixup+0x19c/0x1d0
>   Read of size 2 at addr ffff8881586c9018 by task p/9428
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x100/0x190
>    print_report+0x139/0x4ad
>    ? post_write_mst_fixup+0x19c/0x1d0
>    ? __virt_addr_valid+0x262/0x500
>    ? post_write_mst_fixup+0x19c/0x1d0
>    kasan_report+0xe4/0x1d0
>    ? post_write_mst_fixup+0x19c/0x1d0
>    post_write_mst_fixup+0x19c/0x1d0
>    ntfs_icx_ib_sync_write+0x179/0x220
>    ntfs_inode_sync_filename+0x83d/0x1080
>    __ntfs_write_inode+0x1049/0x1480
>    ntfs_file_fsync+0x131/0x9b0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: slab-out-of-bounds in post_write_mst_fixup+0x1aa/0x1d0
>   Write of size 2 at addr ffff8881586c91fe by task p/9428
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x100/0x190
>    print_report+0x139/0x4ad
>    ? post_write_mst_fixup+0x1aa/0x1d0
>    ? __virt_addr_valid+0x262/0x500
>    ? post_write_mst_fixup+0x1aa/0x1d0
>    kasan_report+0xe4/0x1d0
>    ? post_write_mst_fixup+0x1aa/0x1d0
>    post_write_mst_fixup+0x1aa/0x1d0
>    ntfs_icx_ib_sync_write+0x179/0x220
>    ntfs_inode_sync_filename+0x83d/0x1080
>    __ntfs_write_inode+0x1049/0x1480
>    ntfs_file_fsync+0x131/0x9b0
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Let's move the post_write_mst_fixup() call to ntfs_ib_write().
> The ntfs_ib_write() function calls pre_write_mst_fixup() at the beginning=
.
> If the index_block contents is invalid, pre_write_mst_fixup() fails and
> ntfs_ib_write() returns early without calling post_write_mst_fixup() on
> bad index_block.
>
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Valeriy Yashnikov <yashnikov.valeriy@gmail.com>
Applied it to #ntfs-next.
Thanks!
