Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177B38422D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223901; cv=none; b=l7UOGsaVEZGr31mPE9fUbfLE4ShOFDBnxfXkREaR7fCOY8bL07JpLPSHa0ggK+Yn4uJG0k4fKGzGWvwvNckEnkmaR5I7idbGwGsCCN2ZWdeCKDATGwib8rAEHLEojZ6qL8euHqc7jYEVCcT8UP0jYdnv62Xf+efTlcPpuNZenSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223901; c=relaxed/simple;
	bh=Bbo9dBS9bIsrtnZdwBXfOzf2LbFaaEW9ZJttJ0q3rCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aXdi3SjKTtrkeRr7PtqN9GrYUTMqyjLcOyF+tEsd4731b6WjAN3X+b8eJ6jWHg0+ZpxCKu2gHVQWee2aGxKcyAWYY2mNayxFdujgKo/v0948cAT9ZzArVe+K1rI1RBEw0EafgulTe/o/VnSVrFP+PfgLjqrvSaWU6CyylsE4usU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH1eFzdt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH1eFzdt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4079FC2BCB0
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 13:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223901;
	bh=Bbo9dBS9bIsrtnZdwBXfOzf2LbFaaEW9ZJttJ0q3rCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fH1eFzdtAsqq5ucQl58qisunbXm5RKbvZ1ltPc4Yg+xqdpaFO4TeLiAzXEnt9ougA
	 f+G9B+ROE3+WKkLIsVjSbyri8UsFjajAZ9zN8qoSQu5OeBIxFuS7bJsW9/1PugxfSx
	 VoLWCkxaa4fWhFNY2xNQ7nOLkdXjE4WMXAPxuUvFahrSr7AvAS2BegLiltiocKOsIv
	 NxXT1AfLztpbfOHzWWqPUPXZYrpi2mnRLs8PW5hHLX3zcTaR55E+/DgOtmTXZTSJXv
	 vOsQNT8oQ6CsTXfqPbGS3/qMxvk9zZEtG3HmbLgJ8wm9uk9oV3MBi6kILgTLsEv7Nd
	 hwOJ/VNG0glGQ==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66d65646c65so398733a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 06:45:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXB3FvwFpGLBNEuXFuWkhkrymEENkVYSDSZQKlyztrijcRPDC2/j4PNSoO+ysqQDox+GXHJg9qMEElRgcU/@vger.kernel.org
X-Gm-Message-State: AOJu0YxQU1qN/n01TN8PSBWNNb7AKBIDVOl7409GMV+k9l8VWAhDnelv
	XpN+lLedcpYMvnN6zMjPpO179Ze8XpsBsJMOKScVtDUmDezRARuu0Ax/LO5qQNLuPfJFTOyPEWX
	zRU4qyvcQdXcoeMCW9cmzHETT+XPeixs=
X-Received: by 2002:a05:6402:3253:b0:66e:886:d2f9 with SMTP id
 4fb4d7f45d1cf-66e3e0e645cmr1036609a12.1.1775223899760; Fri, 03 Apr 2026
 06:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403080538.361663-1-chizhiling@163.com>
In-Reply-To: <20260403080538.361663-1-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Apr 2026 22:44:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9csPB968z0L_K6yu88+OgEWTRk=G46H04VpNvRqFgZAQ@mail.gmail.com>
X-Gm-Features: AQROBzDadfRL41HxTOsVEPLveHulYbcc8RoDYv8gF2Pr2KAauDT5SoAHMamcZEg
Message-ID: <CAKYAXd9csPB968z0L_K6yu88+OgEWTRk=G46H04VpNvRqFgZAQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] exfat: unify FAT chain walking helpers
To: Chi Zhiling <chizhiling@163.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 5:06=E2=80=AFPM Chi Zhiling <chizhiling@163.com> wro=
te:
>
> From: Chi Zhiling <chizhiling@kylinos.cn>
>
> This series introduces and uses two new helpers to simplify FAT chain
> walking logic across the exfat driver:
>
> 1. exfat_fat_walk - walks FAT chain by a given step, handling both
>    ALLOC_NO_FAT_CHAIN and ALLOC_FAT_CHAIN modes
>
> 2. exfat_chain_advance - walks an exfat_chain structure by a given step,
>    updating both ->dir and ->size fields atomically with proper boundary
>    checking
>
> These helpers replace open-coded cluster walking logic in dir.c, namei.c
> and inode.c, improving code readability and ensuring consistent error
> handling for corrupted FAT chains.
>
> Also includes a fix for incorrect directory checksum when renaming a
> file to a shorter name.
>
> ---
>
> Changes in v3:
> - rework exfat_chain_advance
> - add error handling in exfat_find_location
> - misc tweaks
>
> v1:https://lore.kernel.org/linux-fsdevel/20260331091113.20882-1-chizhilin=
g@163.com/
> v2:https://lore.kernel.org/linux-fsdevel/20260401071138.114836-1-chizhili=
ng@163.com/
>
>
> Chi Zhiling (6):
>   exfat: fix incorrect directory checksum after rename to shorter name
>   exfat: introduce exfat_cluster_walk helper
>   exfat: use exfat_cluster_walk helper
>   exfat: remove NULL cache pointer case in exfat_ent_get
>   exfat: introduce exfat_chain_advance helper
>   exfat: use exfat_chain_advance helper
Applied them to #dev.
Thanks!
