Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25AA4398F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420814; cv=none; b=h8+uGuFmn6mfqIL3LpYFykYsEsozzzW7nMBhJodLoRH3EWHOXE0Ioh1Jq2I+410WwWLm8JHTGozhauswVT+0PqvTD0Pjh8bcDQ4hPUTmK1VENshmFI7BUbjipOMAjVEqOAvFNISgqJC1m5VioG8jevFChB4mHIqu0PqsAvhtRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420814; c=relaxed/simple;
	bh=Hav448WQglAeJfIVDkQG66BKGv/w2yMHVGM9cIcSMEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4TgLqnfcaq23fk9FurEChJRXw0i3I4+r6PzS1kt6Bts8sXNGg35Wb8FnvfFmxH5DmaHnDRHRiaJ60Hcxu33XmMcsA1n2Pw19fGMR5GuH1b1xd2eauJiHMaW+15sr85T16zqNgYtw6t3cSvMIorPNfmr6+gLHHXps5MoeIHMcHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=I11whn3X; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="I11whn3X"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f256eaedf8so18683656d6.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1785420810; x=1786025610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QLkNt2H80eZrmEFB7rGaX5sD5ucgaW5cZGvSCwvv5/E=;
        b=I11whn3Xj9L/O2JllZcs7W/FHE32wX5Vf1zE6rMOVZzBbyajXJnEkAjIWnaemIUUlU
         fQgTZtx6m9iTQZp4r9byYd/HuI5bWhZLC8wfJ5ODPg1yhQ2l9x1DmXDUVo6a89sm2Ak9
         cG5t11qgOd2rT9S7/gQaqq9IuXL8cHWZn5joW+uqxa6acrvJp+1hoxhgtiNnqRgy3y41
         C70mQ3lb6YhJbg+TBVZlRramwTcPf8zT8vDAmNkGNuCSbzV7ZDCy8xJ1+G65zjmGPh7g
         ZXC8pumqDdMkzyugP86hBoNF6VaNPBsXOtNkhUDK1NeaRa2z/0oygXEsstQoaVgJSVas
         LeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420810; x=1786025610;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QLkNt2H80eZrmEFB7rGaX5sD5ucgaW5cZGvSCwvv5/E=;
        b=iefixs/icycz60Ouf4WDkN0lM097GK36lLJMUaZBdi21QoMVJayVJBFwEj0d8gAfqC
         oRUb0mUiI79jf68659zjA17xnUqOeEqwCczXvqVBDstMjO5UNhUREwIacf1s//GIj1ey
         vZRp/TeqS39HRNfA9SPCsiY+iW5z+Wph1zCPUTh6l1h3f6nhqCxGFlnLCddaUNGLrI4d
         1cPV6yZ385VOvxFmNsgTkTpuENhZADOhnAG4a6NVrp1vqBmus9m5tPOC3q42RGDqGZV0
         yyzm4HtMd9PUZe9og47SaULqbMICbZaamgqpCzeilqc5y/FwxFJLVluhq5eYEbpptYrF
         sYoA==
X-Forwarded-Encrypted: i=1; AHgh+Rpz5HTBFlkeV/zdmSoApI4F88av6XzBMSTFhlRc41B8PFYg2QhvbD8xtk6pA6c5GPQU9vzRqpH6oPN8PzbD@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYHTAEdJ91MGVqp+q2n2RPy74UgENPrx9aC+Us3947UdUwQ+K
	mw5omPQbDePGx2d3NaaxTCmhZtcPhl7wXBC+a5FEJGJheTNTExDa1MmXAY+s8ogkXLE=
X-Gm-Gg: AR+sD13FvMW38XmLrJiV3BNsKC0SLz2HOuhj3de+l9xJRucMguJNZxcEKdxgoC98W+z
	MDJLq9tCwsnbVsVUQ2+YWRuh2B6FkZZsdKXiba5g9ur0iqlTRZ1m3XF9AB+yvrwrH2iCNEAih+h
	m4g+OHOyoyyxN8cAK1/nM96/SJZP3vepDHu1zlqybfw3JnR0XEhbSSMqXR2Tc1N9tUbkfV2DOPA
	0v1E5lkmfX9QDV0hQXCGNQYUaIcE0BJdHks6e8lGEyXI/tIsmNPXj8Q/nzDmUnqyaFUj4Ufi1zc
	fKUBE0gN46m17zLi0d350fLAHAabZiF7Kv1yWo0kyz9ax496tYmtdD6cJUEmW/MRukDxLnG85y6
	jeJZaCy+QCBcMK6FMCGa50fxwILXENEbunyH7GaJ8aiWY3TO2uS0kxIrLF0CaXCvCU3JJj5TGuI
	R32vGo1p6Cc59bdvJb51YkndQD3UBVGus1fcyfJFGSXpG9fvNiYkyx1SjcEHY=
X-Received: by 2002:a05:6214:5a0c:b0:8ee:39bc:8fb4 with SMTP id 6a1803df08f44-908347a8e44mr25915246d6.33.1785420810359;
        Thu, 30 Jul 2026 07:13:30 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908323eb758sm18842216d6.28.2026.07.30.07.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:13:29 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:13:25 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	William Kucharski <william.kucharski@oracle.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH RFC] xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()
Message-ID: <amtcBZ-_QVRgCd6b@cmpxchg.org>
References: <20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838@nvidia.com>

Hello Zi,

On Mon, Jul 27, 2026 at 09:51:40PM -0400, Zi Yan wrote:
> XArray operations that allocate xa_nodes, such as xas_nomem() and
> xas_alloc(), add __GFP_ACCOUNT when the array has XA_FLAGS_ACCOUNT set.
> This charges the allocated memory and avoids the workingset convergence
> issue described by commit 7b785645e8f13 ("mm: fix page cache convergence
> regression").
> 
> xas_split_alloc() does not have that flag. Add it when necessary.
> 
> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
> Hi Johannes,
> 
> IIUC, __GFP_ACCOUNT is needed for xarray node allocation accounting when
> XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
> convergence regression") fixed a workingset regression with it.
> xas_split_alloc() does not have it, so I imagine xa_node allocated during
> folio split would cause a similar issue. I would like to get your
> opinion on this.

Yes, you're right!

As we had discussed on the THP cabal call, we should use the memcg
context of the folio, as that could be different from the callers'
depending on who's doing the splitting. I.e.

	memcg = get_mem_cgroup_from_folio(x);
	old_memcg = set_active_memcg(memcg);

	xas_split_alloc() / xas_try_split()

	set_active_memcg(old_memcg);
	mem_cgroup_put(memcg);

There is __folio_split() -> xas_split_alloc(). But there is also
__folio_split() -> __folio_freeze_and_split_unmapped() ->
__split_unmapped_folio() -> xas_try_split() -> XA_FLAGS_ACCOUNT ->
__GFP_ACCOUNT. So it would make sense to me to set up the memcg
context in __folio_split() already.
