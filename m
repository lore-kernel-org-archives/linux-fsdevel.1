Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65012C326F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483701; cv=none; b=i3+eXWKD2vtd5S501RfHWmN/fA50Eybrtg5UXKWG6a1Sf+S1cdbcb2BnZf5udPrx0NtjJonc3IxliwxPsrbVLhSfw7Ed0IY9PU0mZ3MTmRywSdCJ0AgePfgUCIncpj/Y0F00unj7KczINNsA3BqidzVP8A/bMaPUGmN4cP7QMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483701; c=relaxed/simple;
	bh=qt0oSwVFqfthqG1FzpwH/lNVblPi2JZlJWH11WenQ/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4PiCumUWpagMVS79hpAo/u+O+CKUcunGRjyeXqRfeiu5iK71GaVfL9M08UslqFzSKoib1ny9sz+93vHShGDYLdoZ5cewE8Uolz5H7fReW0Zbw76MoZqOvPdmBhOuU82nfWvsRI4VV3eCaIe/qQakUhS94G5ahjMa3tOBuLb6Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUbvKtQ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUbvKtQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F27CC19423
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771483701;
	bh=qt0oSwVFqfthqG1FzpwH/lNVblPi2JZlJWH11WenQ/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qUbvKtQ/M/UeEJOFPg3k8FrvQno8BkmMZpXYTMLCMyJaVkXJ7HqmbxTDhGwFdy3cN
	 dCGs5n5yfC5K6s/GIUA+td4ewrWJQc2OrNqYuUT3dRbzWcOc0zOYSbu2tI6mJ7IKHb
	 iMAid8eQP918TLe0YeyBwKQ250WWt7QjfM0JyF99/ga6xkHiMECK7L6qmUPB8E8L2N
	 se4/aDf62aPmf5nfxJi6MIdSKvGRlOJ6CfNXFXAs/fZHnHJ9qLWqDyeiz3yi2WB0dk
	 zRPQ5YeiD7ydJzrPG53V5LKhVm+4TWSEaQPd3u8gAGKP4XUcc0JFp85elMladjSabw
	 71T3tuFrvU4Xg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-65a1970b912so2712126a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 22:48:21 -0800 (PST)
X-Gm-Message-State: AOJu0YxlZSjxeHs5/Hz8h6xU2Oonqm0E3J3NTC/KD8zVHRZu3lj++d8+
	ilDBAr2madPwJ9MdT5OKBYuDhrPG1n0iC1HsfMaWWczVn7uolQgxO+vKy6Pn+eMHE/z2s0rffZo
	YvvkiLkubGxDO9OE7YlB0nLCse24JhQs=
X-Received: by 2002:a17:906:d553:b0:b88:4224:815b with SMTP id
 a640c23a62f3a-b905491e346mr50094366b.3.1771483699988; Wed, 18 Feb 2026
 22:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0e5da23-90ed-4529-b919-11ae551611f3@dev.snart.me>
In-Reply-To: <d0e5da23-90ed-4529-b919-11ae551611f3@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Feb 2026 15:48:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-oj5Aa4rccp4iESFgoVUyPq2v+u=2m1AM8KQPpaZOOGg@mail.gmail.com>
X-Gm-Features: AaiRm50nLj_Qx2QFIfcdIEgThldIgtO4s9k_AZW8zQMVRKdRn4u8M54mbhqx-UI
Message-ID: <CAKYAXd-oj5Aa4rccp4iESFgoVUyPq2v+u=2m1AM8KQPpaZOOGg@mail.gmail.com>
Subject: Re: [PATCH] exfat: add fallocate support
To: David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>
Content-Type: text/plain; charset="UTF-8"

>  void exfat_evict_inode(struct inode *inode)
>  {
> +       int err = 0;
>         truncate_inode_pages(&inode->i_data, 0);
>
> -       if (!inode->i_nlink) {
> +       if (!inode->i_nlink)
>                 i_size_write(inode, 0);
> +       if (!inode->i_nlink || (exfat_ondisk_size(inode) >
> +                       round_up(i_size_read(inode),
> +                               EXFAT_SB(inode->i_sb)->cluster_size))) {
> +               /* Release unused blocks only when required.
> +                * The inode commit is handled in __exfat_truncate().
> +                */
Unlike before, I am no longer in favor of adding this logic to
evict_inode. One major concern is the potential for cluster leaks if a
device is unplugged while a file is still open. Instead, We can
sufficiently minimize fragmentation in applications like camera apps
by utilizing fallocate with mode 0. If there is any unused
pre-allocated space after the recording or write operation is
finished, the application can simply call ftruncate() to reclaim it.

>                 mutex_lock(&EXFAT_SB(inode->i_sb)->s_lock);
> -               __exfat_truncate(inode);
> +               err = __exfat_truncate(inode);
>                 mutex_unlock(&EXFAT_SB(inode->i_sb)->s_lock);
>         }
>
> +       if (err) {
> +               exfat_warn(inode->i_sb,
> +                       "IO error occurred whilst evicting an inode. Please run fsck");
> +       }
> +
>         invalidate_inode_buffers(inode);
>         clear_inode(inode);
>         exfat_cache_inval_inode(inode);
> --
> 2.53.0
>
