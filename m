Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793204284;
	b=iXOvfkVsZJsvsQ53WopwaYXLDP1WFB7MQK5dxTofYcOQVP7d/hl0r3rqJ/4fH87x8bZF
	 mG1Jq5/esViyuFhZFG03babZ8KkFDCUvZOXKrrqTwN/tQ149UKInEoV0CIoluDkVW1jTK
	 mc7DFXOOjnJ2c4TnYQw9KrVS6zApzg9dMFc+RZCFc6qR5ebC0bJvQgQJXf5qLqTd+/Y7t
	 U9KS0t47VGWGjTetRfIhwUWiTvw50umJSPzxN9J8BcYseXhJHL/ZfE935fGrqmcZKX/+T
	 3fbVE3W67zyG/w4ypkIgpLd039vUjetRtj+Foc29kWqZZ0Om8k4fX+ZvXFi+8qtcp+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LR+4Nh8FYTRY8kZRrhgD+RKAvmlbTqJy80aNBobHu6k=;
	b=miVhk4VrGPVxhYzN9SeEqbKGMWzc6fKh8N/AdJas/orBqktjZeE/hjoJXzETXuFUB1zz
	 5Q9UPmP/+l4gsUbRY0m8d+BUmBKn2J8StczGNvBeVRj+PFOzYJKAWrqUUp0HN9UE8zHQa
	 SkgXZ+Ms8PsiMSX2MYoVqtG+o39Ur2luddBfgaoTYiEVfQHvRtGk2uyhXnSx0cymumvzK
	 2qoAqj+aMKo9IBL60vGemY7ou8LEta1IpH37/s14uJmHC7/Og/2ELQAVAcahKRLUpmrfT
	 34wVfNxvSX/DL02xzw7tCXnoyXRNL26008uyiAzzxYzgeLzLHYXWVl1lYJDb/30APBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aE0UVEPl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE2606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3BE2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aE0UVEPl
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-89ff475a152so575110b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 09:18:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793204283; cv=none;
        d=google.com; s=arc-20260327;
        b=NyLUU+z7qcC13o62PYNMLmCNiD61eJS0xfQMzLDe4YMku8FfaTw4WLvQmTT9DB9iYu
         fUdD+Kr9oLjmXMh+p94qDBjJYvJuJ7u5ARDphiWcl0QlZcFEEegDcHuQTTw4dEd5aRaV
         iu73Cg0EdDCs1hWVZyzh8HBXM7lTNF3AE0IGYgH5ztgGlOgBLyWvNL3DLweqTnKVKa8/
         1ze3gxjRIQlC8/+EiQYqRbnAjGyYWSrd8efhB0x9X3e79gK0bgQZwpXAw6OnqmiEGam1
         90P7VoJ2t6ZCrRn3xExXwD5tRmfCia+pqNTjo5emWlwt1+EhfPmMaVqn3TAjME8VpYxO
         t6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LR+4Nh8FYTRY8kZRrhgD+RKAvmlbTqJy80aNBobHu6k=;
        fh=K12LUZQJVi92jjIXoUpj2Yjb7mbpcO+8/ZQjCW7lT/c=;
        b=IimKcGKwM6A2uRUNI7Y041QY9iXwEVM8KTs2sb0C7VNp8vcQjYcjhLWpDaetPOMerG
         81E16k6kNKe3zFLcQN02l4oaWNQz2maU1pwisQhb58GxE+QKKr1az4xQ9nsWWAEN4iCI
         4Kt8t0Hd+asdsnSKA6qe/gu7KDqqX5mhLWJ+bgCGkxy50hIk2UEJteBVQ8XsrUAEw9oK
         UkX08t7vbBU9waM+IELLDFlrg3J79ATXODnbx+Px+QiZp8CowP3g+IHTUtOA2X4lLLRF
         hJHUAcuJgqkT7EexihXGbkUeSoAGKiLwSZ9ry9yhjmxyc1NH5RaVnSl8oDB+Uu1vTckE
         iCDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793204283; x=1793809083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LR+4Nh8FYTRY8kZRrhgD+RKAvmlbTqJy80aNBobHu6k=;
        b=aE0UVEPlAf/V7Y31izbriey87faIFsoS80MZfhPz+nDPK2fFTvb3pIODF+rYWahhAL
         IE/GRtPxJFWJY401Rp92EZ6jNjNQiz4DcR1KQKNa6Wrp8DP5JXEhIV3bawUSZ6OBMF3Z
         Fag/CZu8p4S0vDV+pKLBKXG5EdyK4ORV7TOV/oJxfGOY2FaA54ToDtf6HylO7ckImk9L
         EZJGWpNqqI1H/cea5knc2AQwEuMaFuJBcGtCUYmE2I6v4kVZDruIbLWQjeqrsqwYkeKv
         brBqy/vSgeArKD9ZAiQYA43dPDFIFx74Cu6p0i9jVLMzAd7CHb1//RgOJp9+fhNk+tAC
         6PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793204283; x=1793809083;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LR+4Nh8FYTRY8kZRrhgD+RKAvmlbTqJy80aNBobHu6k=;
        b=Lc0JMntuGrfUC+4WwriapgtpaHk+/Dk0k8J7xSA/SeLVT/p9/Z/huEs+vwA24LAxND
         6nihS02KJdj6sH1cM+qEHDDGZfSSZkIw3g/VuEShvchgmVdbiqHQZctxv6wGYWQcB4Xa
         ixppkBqrHnvRdgZPrDNSuLxENbd5FfICNmKrm7sxr9SmI6kuifRLaXJEZujS2WU3ZpjJ
         zTpgqnajIgNuusUpIWVmruphvdvCEiNUAaZYM8z9r+2bJDoeV1LtYClunei3TgM2UPzL
         anznhd54KXvSYwA5QA2xRkmd4YIQ8OsD+cdkT6OdE45RbfQWr8W6jOE0Z+rilS4mES4/
         xMVw==
X-Forwarded-Encrypted: i=1; AKwUvBylxEFtztG4zA45IWKtjJmgKtJ+hs7AyyXVRM0NzGJJslE72egSM5plZqieIYUVY/8Rywh6WsuEB/ByBZTc@vger.kernel.org
X-Gm-Message-State: AFq9FYKe7FyQUjy29zJV+ZRC+oGTS+OaJHN9MomFQmTkv2t6GYCJsDDN
	7zVM/Jy2eEf6JUs9dHzhJsjJTwyBLNOj3+GlRhU5cu5yJsShTYCcdKAlqrCqTuGXEGFKg5lu8u3
	/nksH6PYsLcnd7INJkvJSsjyi1d+bBNI=
X-Gm-Gg: AYBFou3BRedrpSW7/wbQoIWMjVy8u31xo6demmj0udN0eqy1ho+jtFv6evMnh5QitON
	d9NFdDGoZ7hOvpQVAHDwqrdq25nSrOWXxzfHOKM/wXKtUPXHSug1bbNexO0S17EdU9EN6BLuOKm
	h1S+vTX6maJXwcgdJSAcnbeVJPBoDT20Z8CFUIzTnMQg5YVrks6h4wTVfBcf9feBu4X9U+c7SQg
	+zsNoqIi5WjRc3fIlyiS50XyFm+bk5gow9yqXJ8Wg26qKN4d54gIDVNdE5zwJPRGtBMJh8PYqEZ
	3CktADXJ+rsu7XKRpZ5Yaofbiz7pKlztb82Bf40X2SCkvKaGZgzwMP0M+WgKmAknXVqHmg4pvcv
	Hdmzj8Q/cRLBAAzCpAnYftBs0rn2xLbo+S5fcog==
X-Received: by 2002:a05:6a00:391f:b0:89e:9560:fc7a with SMTP id
 d2e1a72fcca58-8a6e6efa7a7mr2168656b3a.29.1793204283163; Wed, 28 Oct 2026
 09:18:03 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027215326.2693300-1-joannelkoong@gmail.com> <20261027215326.2693300-2-joannelkoong@gmail.com>
In-Reply-To: <20261027215326.2693300-2-joannelkoong@gmail.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 29 Oct 2026 01:17:43 +0900
X-Gm-Features: AclHuK91pZpqmliH2N1ROYQZJFORz_xx3uP0uM_hYUkPFZ1oO9AzV0q2NKIx0ms
Message-ID: <CAKFNMo=Kqs0T=a578WN+=PZ2gse2APWZ_jnJ64XyrerFK41sXw@mail.gmail.com>
Subject: Re: [PATCH 1/5] nilfs2: convert iomap ops to ->iomap_next()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, "Darrick J . Wong" <djwong@kernel.org>, changfengnan@bytedance.com, 
	kbusch@kernel.org, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, libaokun@linux.alibaba.com, bfoster@redhat.com, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	Viacheslav Dubeyko <slava@dubeyko.com>, linux-nilfs@vger.kernel.org, fuse-devel@lists.linux.dev, 
	Zhang Yi <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 6:58=E2=80=AFAM Joanne Koong wrote:
>
> Convert nilfs2 iomap_ops to the new ->iomap_next() callback. The callback
> is generated with the DEFINE_IOMAP_ITER_NEXT() macro, which wraps the
> iomap_iter_next() helper to finish the previous mapping if needed and
> produce the next one. No functional changes are intended.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

Hi Joanne,

Thanks for picking up the newly merged NILFS2 iomap code and handling
the additional conversion to complete this series.

While this patch is an intermediate step, the changes look good to me,
including the finalizing conversion in patch 4/5.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

>  fs/nilfs2/iomap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/iomap.c b/fs/nilfs2/iomap.c
> index e130ed63abd9..359786c97f2b 100644
> --- a/fs/nilfs2/iomap.c
> +++ b/fs/nilfs2/iomap.c
> @@ -67,6 +67,8 @@ static int nilfs_iomap_begin(struct inode *inode, loff_=
t offset,
>         return 0;
>  }
>
> +static DEFINE_IOMAP_ITER_NEXT(nilfs_iomap_next, nilfs_iomap_begin);
> +
>  const struct iomap_ops nilfs_iomap_ops =3D {
> -       .iomap_begin =3D nilfs_iomap_begin,
> +       .iomap_next =3D nilfs_iomap_next,
>  };
> --
> 2.52.0
>
