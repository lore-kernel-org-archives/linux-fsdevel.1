Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854012;
	b=UzXTftpzVD5z322Jzis4625jBovVwhAf3Ve8A5BRBi1l7mECAsxPIJJlW9U1GGYad4iT
	 w+m6TQuWjtlX4P+iL4rXQu6GDhbl/kjgRU+ML4aB7vTs908H0djncTJFxskxDTF/KOtYr
	 4PGFZzPPYDj3aKESvXs+iu/ztlFMN7oM+HShQ+9nQn3v2RJDwxwjHpjDFoAJC4OYJlqL+
	 mRJoWwWALaEF73xGxDjf36M0FgV9sDohKJnhBz8k82PQVWcWkuv77NASGlvSouzgxcNXx
	 n1rRwi1uBIOLnRgn8Yb4mgHbrQvIMMVlFG9+5fe//akkf0Idr7iiOaeeA2z5oY5bNvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zf1hqnxgUUaXyC+52Twk933Fjs/9VQ8uLC08DreXCRw=;
	b=ZB+vvYg7W4ndGoY8rUzrNMyUbS4JbbwhBNdDtj7Dl03vZLHCgOPtboZRA/OPZ4H4ClKX
	 Tun7ixCAMaFK9zR7xtN43KIEBjCVHhdoo8dz0nmxGCZXB+4KqktM0PnJmMj/oMmReb65y
	 3UXlczt+s0mbSt2kshAon0XJZINHfWRQm/J9vg0zU+W9b8/INI3MTPQucnGX5lf/ZKjj4
	 CEGO8Iy6kwAQBCc9ChbJdaUbiUSqUTk+qs6Gi79MHcGTqXHi1l5bguwPHDQ0M/JkCLRDu
	 wGEWq5bRsM3t3usF252v8Uec90MEv2NSDCIK/Q5rrGS61y5b5KAqi15vcAxWHFqzOeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQww79+A;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1142606A32F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 18:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1142606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQww79+A
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-862b9c2e78aso936928a34.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854011; x=1795458811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zf1hqnxgUUaXyC+52Twk933Fjs/9VQ8uLC08DreXCRw=;
        b=UQww79+AcALvW1dj0W1OsDNLiDRMYe7F+ykqbHn2PY7/l3tGkUNBQWVfd35Ox2NVoK
         hWcV/85omatpF2td6QBVB7vUyo4uxKJgrfKM71P7WRdKkdQMrkSK7g9FUNXkowQ29JPu
         m7H3nvf8Amp1vXNCuud1FhHbSJmhR8d4NWL0zVdoe5UiDc43BfXpMCS3Eh6J4rBCFa7H
         naFM+9+myGA2Oy/0s/CfHOJstRK/a7Uz2tsELjLpmcMCtgcqMGFRbYo7WRzT4dQLl/i5
         pW70+bDTLaYrc5KJPzDaIEX0kydgCdPyirGE114SSgYONnh2D8wnDv2tcTEGIiFNZNLO
         R+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854011; x=1795458811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zf1hqnxgUUaXyC+52Twk933Fjs/9VQ8uLC08DreXCRw=;
        b=al1807rd3wNTI95y31K9QmC017l1N4UutMh61PKxqf/yxFhoMKb+qG5z1cjKgUXvuF
         hqcWHEXkTmQQvMV3KS4drTD3zb17PS9CqMRqgyZ8yA4SfWppLMG6C3sk6GQLJyLmMBkF
         exy71oGgWoxoWkiMaprdveN0t4QZU6XPwkG07qawla8fGvtUNSMzhe5rCWrGlVnaS6OT
         ezLPKzyR7KnHsvP7r2o2HGA6QF4elmQflA08KU78uBNT3A+DhZ1ctIj+hjjod+xk6lXh
         Hk1hdI8EbSH8BNND69Fsi0pMwpOyPfBbAwFTF7BRjzhjAAfYJudKEN8OE1VioYIKUW8T
         WBpQ==
X-Forwarded-Encrypted: i=1; AL+hErEB1EfjRG0tEP/wmFWTlS3PMcBeBZuee84tjaO1l4fA7mVZPCssQEjgi8KaML3gcAO8of3mW0F4gD4kOxV0@vger.kernel.org
X-Gm-Message-State: APuU4Z+2Hs//1XzCCQqrP8mMwA4mheJowf3IiDOdDjIT09T2RUOMif3i
	+oQr0DTK4iFpGRJ1Kh6U2DfEXWL8GuM6pKC8lzmcku1ShujoPHvjMB0e
X-Gm-Gg: AYBFou0l1gISf5T+ncUKQ32nmqrjSMOUOvAtMnu0YARQDFKGG+31j17bY6bSM4FkT+e
	0jrzmQbN0xwgiVBtqqaDBGsE1GEAxGPSYtLW53J07/MW9NPwlfrvg40mzLYrXSzGkQeRQPyeveb
	hT0CJRRQwVSdwB4ckMycChr5G0/kfiEo18qMrJE0XVIyp4HQCc1yHfhmAnMEJEDmC6iHPdlgS+y
	OAkWLJ6J0Nk+TIWdyxwJ7kuR03aFBZrStOLNkWNbP0NHNwnwTb2bPhwSGZSwJT+DK5dsytoNH8v
	Y9wQXhxpVCBKC7YZxT7V/Wxl027CucGGyw9cHidWKFwGVJ4PlfHYRbXOumQikFDUWERPD92lY2b
	0a8iAV3Vh3hy7tWVRaUvqN7ujNdp2kNjwDkgGjLxNdjOwHKU8uecD4teb61togq5yoqUIwZuX0Q
	C+GU2DsM7dc1n6WIfK2QSMs1ne7q7Va0cnYjgtgpjyxmMUtMCU8MgP8q2V3GWQFNBhxSvq3HCKV
	FSUiC4lguHNtpwhx10TxM8oZlzouPdzTKlQAndg042HIYMPpzsiPV5Iq+ISLAxeoqCQ1pkJLOAo
	bcSIvMkVcylggSUQdVRYsBwrXa4/FvBgrnn3Z4RrzRA/862BuD/Yf8JJYSvC
X-Received: by 2002:a05:6830:640e:b0:862:c685:84bf with SMTP id 46e09a7af769-862c685924amr3847900a34.4.1794854010849;
        Mon, 16 Nov 2026 10:33:30 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862ae607cf4sm6939137a34.18.2026.11.16.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:33:30 -0800 (PST)
Date: Mon, 16 Nov 2026 10:33:29 -0800
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	liam@infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com, mhocko@suse.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: don't PTE-batch a swap-in of a folio with a
 hardware-poisoned page
Message-ID: <avtMXFH75SJFpQjZ@devbig011.atn3.facebook.com>
Mail-Followup-To: Usama Arif <usama.arif@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, byungchul@sk.com, david@kernel.org, 
	gourry@gourry.net, jannh@google.com, liam@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, 
	surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	kernel-team@meta.com, baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	stable@vger.kernel.org
References: <20261116063624.1382944-1-usama.arif@linux.dev>
 <20261116063624.1382944-3-usama.arif@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116063624.1382944-3-usama.arif@linux.dev>

On Sun, Nov 15, 2026 at 10:34:56PM -0800, Usama Arif wrote:
> do_swap_page() checks PageHWPoison() on the faulting page, but the
> large-folio batching path then maps the rest of the folio without
> looking at its other pages. A poisoned page that is not the one being
> faulted gets mapped anyway, and the fault that would have reported it
> never happens.
> 
> Skip batching for such an anon folio and let each page take its own
> fault, where the existing check catches it. do_set_pmd() already backs
> off the same way.
> 
> Leave a freshly read folio alone: it is not anon yet and can only be
> mapped as a whole, and falling back would free it with the poisoned
> page still in it, which the retried fault can then get back from the
> page allocator.

LGTM!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d477a4f986bc8..51e72fb40655f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5158,6 +5158,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
>  			goto check_folio;
>  
> +		/* A poisoned page in the folio must take its own fault. */
> +		if (folio_test_anon(folio) &&
> +		    folio_contain_hwpoisoned_page(folio))
> +			goto check_folio;
> +
>  		page_idx = idx;
>  		address = folio_start;
>  		ptep = folio_ptep;
> -- 
> 2.53.1-Meta
> 
