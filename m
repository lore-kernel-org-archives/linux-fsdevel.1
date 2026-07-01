Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805CF41C2E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907345; cv=none; b=i4ICPEkC8d2orYMhDKWF8F9Sbz1H9LK6lhaaAwXWMNvOoTdZiY3AO6rDNHVUj3sFVC7S0wqfAPxX+KCSYQMe/6RunUjuYH3QEgPrb5OJ6r3O7oaS5tEiyx7SNASA5tEsMtIWWu59UjoN///adK5SYF2XQr+kOEI4UuFHK5B3Izo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907345; c=relaxed/simple;
	bh=I96FsRiOWv5GQ3iIfC6p39dklOUnYZjyNSQ3d9NuKc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRY1Qy2XoyiRfLfUve94oIzMp5NaPjCZkoUsCXRj615Obl7KYsKdAmgScFR3mUomH+eeUSzzHNcnUO8M1NxAQ+9HrYCozoRXC/X/8DmAFLtCnNOjt6RLfeTUwBebVZ41LM68rG2AVXnn2VeLUNtxkGE7wP3+5LzmR0VGWy7OX1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZGQVaPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZGQVaPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14DD1F00AC4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 12:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907343;
	bh=PEQ7MmRVr2YYcLoFCXLkIbaapHzulKLzbo5zmC2bjP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lZGQVaPlY0kyILIXo35amhl+ut43f3X6NnluQ1VOlOAdWtsxgGing4cCoS70fn95m
	 IQdiTFpH1ukpkv9ofijm3Vl48ae00MZ93i6gUBSbIU6OYeI+paa8eac/l75lV/PjXz
	 TH4hjWeEXeYAYvQpSajykoI8pPFxAB8aEg+D+IV+UJ67TSKcvkFRC27XoLMO5igq1X
	 JQOV9dGHka24K60irQSukD6/ZMQnqWjQg4ZEI9Quw+yfBlK9C+EdHTyLehB2IqpGzl
	 PYMWxJekhdcY9+Ifnd1QoqomXCVsgPrn20W5I6FHge049qnYCkAPSD4/IbFbJEkZ5k
	 IJjX9c32aIRdw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1276f8414bso74248666b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 05:02:23 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw18u9657mCB0e/g5BQcCOSLToXqhXHssDxVeApkJf6HQ8151sw
	s3SnN8Xyk3rxhgz/ysWnqLs7zTYhZkQ0mDy6kcMYYQEN8QEdYor4VeyOWf5T6XzyOrxlASamyYh
	jjIQhK38CYWQx1lRbeX909K/OSuPQ3XE=
X-Received: by 2002:a17:906:630b:b0:c12:330e:ea76 with SMTP id
 a640c23a62f3a-c12aa1fe58dmr64909266b.37.1782907342355; Wed, 01 Jul 2026
 05:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701005418.735715-1-chizhiling@163.com>
In-Reply-To: <20260701005418.735715-1-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Jul 2026 21:02:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9SxmntoutaKdCC0T4vDoKEJBgiQiJ=bcTnmgNaa+f-AQ@mail.gmail.com>
X-Gm-Features: AVVi8CfPQTMTUhdoPMDuS0d4VB3HyVHkksdG6wcybYQz-qSThFMXfeZuFFd9pW8
Message-ID: <CAKYAXd9SxmntoutaKdCC0T4vDoKEJBgiQiJ=bcTnmgNaa+f-AQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: validate cached iomaps during buffered writes and writeback
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
> index 7c8b4182f5de..71631bab182c 100644
> --- a/fs/exfat/cache.c
> +++ b/fs/exfat/cache.c
> @@ -228,9 +228,10 @@ static void __exfat_cache_inval_inode(struct inode *inode)
>                 exfat_cache_free(cache);
>         }
>         /* Update. The copy of caches before this id is discarded. */
> -       ei->cache_valid_id++;
> -       if (ei->cache_valid_id == EXFAT_CACHE_VALID)
> -               ei->cache_valid_id++;
> +       if (ei->cache_valid_id + 1 == EXFAT_CACHE_VALID)
> +               ei->cache_valid_id = EXFAT_CACHE_VALID + 1;
> +       else
> +               ei->cache_valid_id = ei->cache_valid_id + 1;
This looks equivalent to the original one. What does this rewrite change?

> @@ -133,7 +134,7 @@ static int __exfat_iomap_begin(struct inode *inode, loff_t offset, loff_t length
>                 }
>         }
>
> -       iomap->flags |= IOMAP_F_MERGED;
Is dropping the IOMAP_F_MERGED flag intentional? If yes, Why ?
> +       iomap->validity_cookie = ei->cache_valid_id;

Thanks.
