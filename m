Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F891331EA3
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165688; cv=none; b=JrGBL8nPUh1JZcesjfDGxN98PDwAAjFYLF5mU1BdtPNeiqRuvu7LEgrwtyLvh/ryxqmWDOYDZi8ZFb7zBO2dMTnG1E84ilcbhph87Ld2EnJ9jC9M8OcOjivsxgaSW5BK85H3+OYNGKu5FTPfz9JM+zSLYdB7kyZ3kL5vd9NKVEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165688; c=relaxed/simple;
	bh=DHX+4Wg1e4Qw7ccksMIpKrJjz1QqiF673121nPa7ct4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHuRuMPj0jQ0L3bEdEBDNXlYV4g4GQ9f5sgq4q0N1hy+rFIyOLhpN2xahznXfiVFO+ve9sHC8+YA4jl7UdX7dgAsIGnsm/HZC4bnS246gTP/Fg/2HWNYa8VdZnFBCn/tUiCGw+6PAbO+xmrXNiak3cr6zjoMQtYYFB6DqSrHhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRMxTDuu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRMxTDuu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A12C1F00A3F
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 01:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784165687;
	bh=w6KwiVdJzjeyC88Ywg1fGCHhkNezDjXA+HpFPr5TVXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MRMxTDuuQvT49x4fRiEF6gfbhIhI68ho0oMllwyMc5JGJCpyX5/QvzMSX2jCxD64W
	 3GYNBKOyMW6QjnpDOXkKKG/vQ58kiKTb9lL7sFiZseGMQLtQw4EHYVr8KpDvCbIetx
	 VTPkTvUZL7jwzk6uHcN5KTyazA3yVZqSMcUaeh/w+pR4Aq6CURMu47Alh6wOxgc8Gs
	 p7hwwjLAcMvh81+X4FuGSrdHlDi1FI2dc2sw3HJ/OT6adJ17NZa8HVISnNLuCaCybl
	 pYd2wxnE6svPu+sNGXFn5TdlP3b1vTsfe053MDbhbxnxc64RLt0XC8rcWZjbUl4SAw
	 3m9Fdv9vSQ/wg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-698ab9aae16so2138085a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 18:34:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy69IlrJ3Gcq8cpsmRtxu2v0QbdIFlZbuzzg6EIiYl1F+xAhs7B
	LQN3FIFk1bucbOz7HjCQ783yMGb++UhK94jRclyUm7+ptxhcjpQR0aFROOq50mn2GEV7jy/qbbI
	O7J/KMA9lSbF1GRkc+2yONkOWE2b8EQA=
X-Received: by 2002:a17:907:268c:b0:c15:f029:63a5 with SMTP id
 a640c23a62f3a-c161f393b9emr1059018766b.50.1784165685877; Wed, 15 Jul 2026
 18:34:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-review-matthew-v2-v3-0-3c996b687a5e@gmail.com>
In-Reply-To: <20260715-review-matthew-v2-v3-0-3c996b687a5e@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 16 Jul 2026 10:34:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9UkYhny_p-_Yv33_mhSC_Kd=bMjRRAOX9God-=LVa3Gg@mail.gmail.com>
X-Gm-Features: AUfX_mwzw_Si_FVj7HebA9MQongunmyY-btp_8dvG7r3mwmmbFKnkIcrYaFZg4g
Message-ID: <CAKYAXd9UkYhny_p-_Yv33_mhSC_Kd=bMjRRAOX9God-=LVa3Gg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ntfs: Remove __folio_index from ntfs
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, ntfs@lists.linux.dev, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, usama.arif@linux.dev, lance.yang@linux.dev, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 10:38=E2=80=AFAM Hyunchul Lee <hyc.lee@gmail.com> w=
rote:
>
> This is a continuation of the NTFS part of Matthew's
> "Remove __folio_index" patch set [1].
>
> [1]: https://lore.kernel.org/all/20260608210618.3437216-1-willy@infradead=
.org/
>
> To: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: ntfs@lists.linux.dev
> Cc: usama.arif@linux.dev
> Cc: lance.yang@linux.dev
>
> --
> Changes in v3:
> - Patch 2: Fixed the boundary check so pages straddling initialized_size
>   are zeroed(Suggested by Usama).
> - Patch 3: Rebased on the top of patch 2.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
> Matthew Wilcox (Oracle) (4):
>       ntfs: Inline zero_partial_compressed_page()
>       ntfs: Remove use of __folio_index in handle_bounds_compressed_page(=
)
>       ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
>       ntfs: Remove references to page->__folio_index
Applied them to #ntfs-next.
Thanks!
