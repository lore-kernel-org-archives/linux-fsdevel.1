Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A8925A2B5;
	Tue,  7 Apr 2026 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572386; cv=none; b=YZkrq5aNYHFyI9Xru1fkvSdQ1hVWPtIzcBs4IyYxnf5lLLdxNUHhtdE1wk8pFddcGNNpRxiMi3FUSa2vWqBDAWu5W7ik83sRMo0La2qz9P75VrzJ1tjWpBRzDbzoq4zziwpZ0ln0wNyU1EnqR467h+pxV1lmwSWBXxUoqSG0ZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572386; c=relaxed/simple;
	bh=WJCSs57FyEtx1BbwUP76PgD4nrF7tpFgSLQ+QREMq7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z228DXKS6/WP4Z34AjNinfBQRDRHPeMnpyVdRS2cewq8d4aKCutZ09abxowoTB+EC9zpCvtRzEbUQnYA3XY/xG+mxaKnEfYZlQRfhYLBxQSdj/upRcPO2JW58sTHlFDQ4Yuf9OBNvbBKxZ4c65TBS5ETQ4FmBk4ZvhukVjIps8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOE5Rr4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOE5Rr4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4675DC116C6;
	Tue,  7 Apr 2026 14:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572386;
	bh=WJCSs57FyEtx1BbwUP76PgD4nrF7tpFgSLQ+QREMq7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GOE5Rr4qgmLYU2OH4Qi47OtekLjs+ja1Duqn/llCdgWOet+tpqceQ/ScTNFQT81uq
	 p+tCsjAb/YkYh4ONw8FYpMf5VZE9ff3ECyxpUHXUwzfvEvKqvUGk8X+O/+gH5DuMlP
	 6z0lZfunwTkL0qJ3/YYMeCxMlltNiapBGZG0ZSCz9yFLFuJmKQfr7HhFJagDekaW5S
	 MRKXMmOp5lGba67NTRMOX4/oV6NHBgYZl4rKau4kKBq94ePVbTQJ8peCjE9dJ82k6h
	 wClQA1L/NANAfFyuMgMTiyxy785U6AuedrPKMIfR6tVaf+NFmq9KxpNrLKyO0GI5uM
	 KHe56FJUFh4Pg==
Date: Tue, 7 Apr 2026 15:33:00 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yury Khrustalev <yury.khrustalev@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] docs: proc: document ProtectionKey in smaps
Message-ID: <adUVjtFC5HZgnqWU@lucifer>
References: <20260407125133.564182-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407125133.564182-1-kevin.brodsky@arm.com>

On Tue, Apr 07, 2026 at 01:51:33PM +0100, Kevin Brodsky wrote:
> The ProtectionKey entry was added in v4.9; back then it was
> x86-specific, but it now lives in generic code and applies to all
> architectures supporting pkeys (currently x86, power, arm64).
>
> Time to document it: add a paragraph to proc.rst about the
> ProtectionKey entry.
>
> Reported-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

LGTM, So:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  Documentation/filesystems/proc.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index b0c0d1b45b99..d673cad7dbe4 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -549,6 +549,10 @@ does not take into account swapped out page of underlying shmem objects.
>  naturally aligned THP pages of any currently enabled size. 1 if true, 0
>  otherwise.
>
> +If both the kernel and the system support protection keys (pkeys),
> +"ProtectionKey" indicates the memory protection key associated with the
> +virtual memory area.
> +
>  "VmFlags" field deserves a separate description. This member represents the
>  kernel flags associated with the particular virtual memory area in two letter
>  encoded manner. The codes are the following:
> --
> 2.51.2
>
