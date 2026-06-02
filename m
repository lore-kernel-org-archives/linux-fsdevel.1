Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446227456
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780358704; cv=none; b=JftaZAS/QVVP2QlbEM2PF4JLRgnDh7UdqIk8oFC+pFdHCWJnVFebSBtOrhUxsujoNlW7fQ71SUTYn6sz/2zBJDrj4u97upGOgMvXv+l9KC51HuG13VdGy0ncWQpYV58kcGURT93GPGR0l7Z992Belh9YoiY55kzOhBfLe/54UZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780358704; c=relaxed/simple;
	bh=mFk2l6W+m0dTjT3bSIpE3D9nFqo228ZT5sV8j1xoHmc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eDL9YtMxNp8Be/8kyAeS7AZOC2nEaEcg525IKT7iF86V+NVsGvL8Q1pD+U8d1Lb46Zo6k3hU/oLkrtklXLFjywV3njEnDVDHBrG2PH+qOfmAtca0Qvqxs4fdTWwMPzSqCLT7nAgciAgF1N3RMWsEX5XNvAqiGpNzghw3c6dHgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=jbAoYU1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="jbAoYU1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2FE1F00893;
	Tue,  2 Jun 2026 00:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780358702;
	bh=VkfeLI+37zLW0sMlnQTmo8K2Ux0zvzJarLoyrF4Hw+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jbAoYU1jMIllEKyXViMDWhrfLeiinTuhaCfnLb2Wal0c6n2SyKfW766R+dbmhfWwA
	 Z9e8v+f+fyRopf9W9/SB4GA5Qs0CPcJovDAcGuAT+E3xl8nYo4SMZ9Cb4WrEhO3v1v
	 IpQibb9QEb2/FV1jY1XlvgciDuGAmNss4+CtNZUE=
Date: Mon, 1 Jun 2026 17:05:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Hyunchul Lee
 <hyc.lee@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 3/3] mm: Remove __folio_index
Message-Id: <20260601170502.a3328023425ca85409c77957@linux-foundation.org>
In-Reply-To: <20260601192626.150804-4-willy@infradead.org>
References: <20260601192626.150804-1-willy@infradead.org>
	<20260601192626.150804-4-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jun 2026 20:26:22 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> People have been abusing the existence of __folio_index.

Patchset is rather amusing.  Perhaps you should have called it
__folio_index_dont_use_this_or_ill_shoot_you.

>  Since that was
> too subtle for them, use a bigger hammer to make it unusable.  That also
> makes it unusable for the FOLIO_MATCH, TABLE_MATCH and ZPDESC_MATCH
> macros, but that's OK, since we don't care what fields these fields alias.
> 
> ...
>
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -101,10 +101,9 @@ struct page {
>  				struct llist_node pcp_llist;
>  			};
>  			struct address_space *mapping;
> -			union {
> -				pgoff_t __folio_index;		/* Our offset within mapping. */
> -				unsigned long share;	/* share count for fsdax */
> -			};

`share' went away?  What's up with that?  Unused?

> +#define DO_NOT_USE(x)	x ## __LINE__
> +			unsigned long DO_NOT_USE(_pad);
> +#undef DO_NOT_USE

Sashiko says this doesn't do what you intended.

Sashiko also might have found a few existing issues in ntfs which the
maintainers may choose to examine:
	https://sashiko.dev/#/patchset/20260601192626.150804-1-willy@infradead.org


