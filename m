Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BC306746
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194637; cv=none; b=V6JJFJ9/Bgd2prCP+LjAgxhT/0S910AIi6YIuhfRzU5Kjp94bQhDUSGv02iqSqTRIEGDAzqBX++Z6/1j40leG7hSs7Mukrt9LYVH15FultY1FYN1blxJ+zn7F/HmNljaL4Ubc+AsTUMb2Fs1AYTIL8f67LsgoiffbR3CNxxoJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194637; c=relaxed/simple;
	bh=m9j85QpQOxUgSY+OkJw80gRuEfHtGh8xi8ll2e9c6h4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q1y2h2TAZUyh1qiiRW2/JzgwexhPwF4F7MlFBqKzPY8OCwEyCpXSAo+nuFNEo40bo11OtUk8ggNT2i3bE8sjWATxjblkZaf3DpYlJc7vx9EzlUK3ejNscmSobDmRcTpSM2vcguENuYxT5BBl7GkeXeVqVp+3KZmgD86UPSOsowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=k/hT9ay+; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="k/hT9ay+"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3967725a77fso59254761fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 23:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782194633; x=1782799433; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mG0UtRgSOFKN8/2fe133iPfMXApj4VgAcN/ec2p5Rlg=;
        b=k/hT9ay+7mc8LoNWmAfnrL/rslxhhzxmLYTuFGGKvZ2vklswJWxfbPM9QW7NKEatuq
         JUmij/tqnDDuUZ8BsvxnmBy6vJ0vywYp5iMdOE/IWZP6i9zv6mAWRWxp4RonRh9uZ+Ji
         fx6iXsTM0Q3wYpXwfl6c7hax+IWE3sOllhlkne9lfFVj+b5WEcjb2ubCPVJCO8VsNLzC
         aBkLtiTafTyVZNtynhJsTIr6NYZUFFJnrQetQbNVPLD88otgOY1mF0OPI3x36W2yoQZd
         X5H2DA6WN9fmNBKXFWpZsIH3pr3sVBA/YcAUQhzAlHiFF+PoUFt1GXlTLnBfRHDNfsl/
         H4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782194633; x=1782799433;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mG0UtRgSOFKN8/2fe133iPfMXApj4VgAcN/ec2p5Rlg=;
        b=myRvDjlDYLoANJ5uecaMioM+5H1EAMDs1ip+5aCqy2h0vJbpcpNEYU1MHeDgUcQsiQ
         eaZCbwRItF46z1WcIPKOx/0Uo1Mt3zcMF3trDfVI1JE5U27lo/B/gJ/aw5EXO8J4hAS6
         RPFtfXLod8lZyE5UlV8rpS+4mh727+ytniJwW5WjhUIsM9YznVMM7EeZIitPTvVBG/YR
         2HPnQfaZ2yqD8Pivg2Qna6dapzIoRfMpcLpAx/gwEWMAjl7iKfeKOOL9z51mBvPa5lhr
         PuK+mSzuZogwpZyEbQthz7plEzQN0QFFgJMr8EnHPltnWP8MMEj1gcCBjo46Ncw/SvoZ
         yjXA==
X-Gm-Message-State: AOJu0YxD+WHFCrMqzLZBo5aJSk4q25ZBzaweo41Y1n5QVj0ANMEhL//R
	ceTzDlo/UAyvBBTzwP03pSHqekoOlV10fDX5Glk0JPY82NKQUgbKZuYBbP0gV2BPhnA=
X-Gm-Gg: AfdE7cnKxZDv+/+GLjnGXv+lmCZetm/tltHUxvYilcCvdWLuFUG68/V2yE/jwT8tsoB
	M1dCb4ONoeXXuF++TR6Btfy4BdjkBCZYK10tsTPFn2Nqg8/VovPEp93WRLr+2sxU3dKXHjN5PYg
	ABHnh7XugHXO4wK+mTbnum1HeqG4U9Bh6us0D6H0RCcjYEbT5T6oZI/+/NY96gf2e7AF9SrQtLK
	1XtNdNHP2mMbfDDPBJEskZ3v20ydGZ9XgeR3FEc9xkhxyHTt+xpFUdyteIZB85PE71sTd8nw0nS
	kPCVOFMqsBZ6eFQryQYX+x6fluLQ6QTR6Ml4c6GubX6m9Fm0N8uYmd0LbonOGDshsO/l5rSGK2w
	5o7W4ahvNcUFJAw/kSE/ntmLL/Gi1PEZkfT1RI2sF5QBwAv/oet4EUbntpx3sJHLiIq4Dh3SUWF
	D5WelXur6PwbAso4rxsZanBZgrhs9NfoyUzBesOIHXa/y8vcj8bB+vJUmweXzyemygab+QQ1YJg
	U874Qsk35vEOrKxEqnbSGuqrrGKtv6J7TqT
X-Received: by 2002:a05:6512:141b:b0:5aa:6115:e4b6 with SMTP id 2adb3069b0e04-5ad5be30be7mr3490864e87.21.1782194632526;
        Mon, 22 Jun 2026 23:03:52 -0700 (PDT)
Received: from [10.182.218.44] ([178.176.72.208])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957ff5csm479809e87.55.2026.06.22.23.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:03:50 -0700 (PDT)
Message-ID: <925f149459d5b8d78303efc3ab61e09ece9ae5eb.camel@dubeyko.com>
Subject: Re: [PATCH] hfs, hfsplus: remove WARN_ON when new bnode already
 hashed
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Aditya Srivastava <aditya.ansh182@gmail.com>, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com
Date: Mon, 22 Jun 2026 23:03:49 -0700
In-Reply-To: <20260622171715.1697-1-aditya.ansh182@gmail.com>
References: <20260622171715.1697-1-aditya.ansh182@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-22 at 17:17 +0000, Aditya Srivastava wrote:
> From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
>=20
> Syzbot reported a warning in hfsplus_bnode_create() when mounting and
> traversing a fuzzed/corrupted disk image.
>=20
> The warning is triggered because the node index is found to be
> already
> active and hashed in the btree hash table, which indicates on-disk
> metadata corruption.
>=20
> Filesystem corruption should be handled gracefully by returning an
> error
> and logging a message, rather than triggering kernel-level warnings
> (which can panic the system under panic_on_warn=3D1 configurations).
> The code already prints a critical message and returns -EEXIST (or
> the
> node in hfs), so the WARN_ON() is completely redundant and dangerous.
>=20
> Remove the WARN_ON(1) from both hfs_bnode_create() and
> hfsplus_bnode_create().
>=20
> Reported-by: syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D2bf21610eea63cb2ce93
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
> ---
> =C2=A0fs/hfs/bnode.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> =C2=A0fs/hfsplus/bnode.c | 1 -
> =C2=A02 files changed, 2 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 13d58c51fc46..335834961741 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -517,7 +517,6 @@ struct hfs_bnode *hfs_bnode_create(struct
> hfs_btree *tree, u32 num)
> =C2=A0	spin_unlock(&tree->hash_lock);
> =C2=A0	if (node) {
> =C2=A0		pr_crit("new node %u already hashed?\n", num);
> -		WARN_ON(1);
> =C2=A0		return node;
> =C2=A0	}
> =C2=A0	node =3D __hfs_bnode_create(tree, num);
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index f8b5a8ae58ff..bfc2a7f53edd 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -631,7 +631,6 @@ struct hfs_bnode *hfs_bnode_create(struct
> hfs_btree *tree, u32 num)
> =C2=A0	spin_unlock(&tree->hash_lock);
> =C2=A0	if (node) {
> =C2=A0		pr_crit("new node %u already hashed?\n", num);
> -		WARN_ON(1);
> =C2=A0		return ERR_PTR(-EEXIST);
> =C2=A0	}
> =C2=A0	node =3D __hfs_bnode_create(tree, num);

If we have corrupted HFS/HFS+ volume and we can detect it during the
mount operation, then we should not mount the corrupted volume or mount
in READ-ONLY mode. As I remember, we already have HFS+ logic that
detects b-tree's map corruption for the case of node 0. We haven't this
logic for HFS file system logic yet, if I remember correctly. So, you
are welcomed to port this logic for HFS case. Removing WARN_ON() simply
hides the potential issues. So, I don't think that we need to remove
it.

Thanks,
Slava.
