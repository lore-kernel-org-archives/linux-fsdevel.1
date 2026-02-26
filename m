Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D8313273
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098549; cv=none; b=gGp/CBO7W3EnV5kqgGphR0XPfBLmrYpAgyTEwQBSnHJ2p9QGYgOVXJkHhujG+SyN80Vyal3ldgmMexoCYxDlRQzSRv6tx11khW368HxHdLFRYBOPUfGvMSN9yx0+gG0ytLLYwMA+a8r7Jb1Fzyh3OYx0RsiBnp7ScuLQV0ZHVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098549; c=relaxed/simple;
	bh=VSqlac2UbN9e1maY58rnEtgfE2kGJsgwzJH3mRr3c+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQhq8KeMgP9TjPvbltY7Vb2zkYwfn1PHsOudDwanUdcCNKRyMpq/qeLOuRaMWuQgfIG0R9ubHJ9wMek/ELVLGlDfuF1G+Gh4SObsjj1wbZ9I5yrNwLjJ8x2aUyf1Vzu2OI6RZSIcjsYG7BZ3ud6hdN6xU3kFBxDq0KgizeiUKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKorbFH/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKorbFH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A416C19423
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772098549;
	bh=VSqlac2UbN9e1maY58rnEtgfE2kGJsgwzJH3mRr3c+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NKorbFH/lBXajGvrq8mkEkT4D+xaAtkNAbrqr6h4brZabhVHYfivxRWdjiAGQZPX0
	 KgTWJizLgtqRnlRVvwglE5Iv3TxidL5viO7e8hvzx37l++D+6JFwEV6uSu1QfVhGbz
	 gvrBYdRoUWr6nSOoB8yErOOTBTO6VVoys2Tol9lGgu/OyoAIV3+ar8KAFJx0VGYGtf
	 oeMJ+tY+9Xwm6zM47ceMXqN2+pwVYrwtBKZBk878gDRFsVAe9p+zU9qKVfp+WCvKRN
	 D/OZjWQw8UkWSE8qAkiNs15msbXZh3QdKE/yGiknzmDCTEzXfZ03hYvjT63bjHkA71
	 2ORC9+2LZnP4g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f9568e074so102864166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 01:35:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMW4jkbggx9zk/Tmgf/LAnQg4BSujQy4Rq+oybyCWMervu8D/HojqFfOuzQ1yifIDlTiX1wV7wVoAYx8Hj@vger.kernel.org
X-Gm-Message-State: AOJu0YwwjEvfMfocWT65skYSX2h2TWWKR0Zdr7MtsVpgYQL/rsufwi8v
	DIM2ZPHcrqRxc9rAHLuLULo6t3UrYJd6ZBxm1AM9CoLMraa68hapbCUQGFVeGus7zityLMIPfpm
	WEeryhxMP1ZQ5+07hGQJirEGh+bcVJtA=
X-Received: by 2002:a17:906:3818:b0:b8e:64e:1ed with SMTP id
 a640c23a62f3a-b93517b938amr145734266b.50.1772098547762; Thu, 26 Feb 2026
 01:35:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225145942.191-1-anmuxixixi@gmail.com>
In-Reply-To: <20260225145942.191-1-anmuxixixi@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 26 Feb 2026 18:35:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9b0euGHWkEu08BjVKM-pdoT2NaQ-0ym914+i6w7M3LMA@mail.gmail.com>
X-Gm-Features: AaiRm52MhbuAOjjv6sFrXs2sCUzma4avSSdDurYoXof7m5plYbchPat7yb1xDaQ
Message-ID: <CAKYAXd9b0euGHWkEu08BjVKM-pdoT2NaQ-0ym914+i6w7M3LMA@mail.gmail.com>
Subject: Re: [PATCH] Subject: [PATCH] exfat: use truncate_inode_pages_final()
 at evict_inode()
To: Yang Wen <anmuxixixi@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 11:59=E2=80=AFPM Yang Wen <anmuxixixi@gmail.com> wr=
ote:
>
> Currently, exfat uses truncate_inode_pages() in exfat_evict_inode().
> However, truncate_inode_pages() does not mark the mapping as exiting,
> so reclaim may still install shadow entries for the mapping until
> the inode teardown completes.
>
> In older kernels like Linux 5.10, if shadow entries are present
> at that point,clear_inode() can hit
>
>     BUG_ON(inode->i_data.nrexceptional);
>
> To align with VFS eviction semantics and prevent this situation,
> switch to truncate_inode_pages_final() in ->evict_inode().
>
> Other filesystems were updated to use truncate_inode_pages_final()
> in ->evict_inode() by commit 91b0abe36a7b ("mm + fs: store shadow
> entries in page cache")'.
>
> Signed-off-by: Yang Wen <anmuxixixi@gmail.com>
Applied it to #dev.
Thanks!
