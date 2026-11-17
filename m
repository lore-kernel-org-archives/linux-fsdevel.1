Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913706;
	b=bQvwogUVdykieFIqB5Q1c8fDjR3uu9unTQdzmA+vEz2eLu/YdmJ4Y+s1rc226QrfNtOS
	 ie0PiWHKHFBfQ8qtqZWlacKfrVFBpTGZV7/BmcGFcyRG9QraND7N13LNCtwBlpe4t5DEp
	 g1WKatOHmZVUmkvpdiWT5WrCmjrb21icXkKoHj9C8318TsM/glCRrGemLHjb0woEgxrt1
	 kKt0x1MlBFUtNz9k0VUnd5GACCLaxtbrNKhjKRdsJDJTl7jbwB8y8OTZdhQ4doU0Nh9mG
	 /eSfd1txjW4NVY28+sEaMMCDMhpS/QlgQvOk+9I9u4ewVZi/TPuYiIRPh4kBslsrKbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913706;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=YdKhAjlrPqsB5ZWJA75kjf0hOR5+o724DAc3k4bz9WM=;
	b=Ezh1Cur6iI+bpg3/F9ujJo+PbemoLG1dUbqvA72cN6QdrEqrEJZGVS4JL2MF5ZKxYFJf
	 5Q2rblYGKl+zVbaljt3X3E95WBcl5uEVqBZjEcPgvVFcuDXPiz2QOKmCJvsFo2l2bG9ma
	 CyZUe/gdaqdHzD/IcsIlHZxN60FcfZATummcd3A9Per93fXN5c3KN1SbUxNd+XCQX7824
	 4mcGVadgh1IJTEKe5xbJE0UZAWON6APNPECcO1EWak2AKmdPEBNYUFtzGPOOr0LSbWr4v
	 99CIxeAC0z/B39kkFVPaXaKENMIuyYOvkGeUeXlHGqhJ3emqfyapYlqlHMv0pau3rTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i42A6mGs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C0606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i42A6mGs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C456C1F000C5;
	Tue, 17 Nov 2026 11:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794913706;
	bh=YdKhAjlrPqsB5ZWJA75kjf0hOR5+o724DAc3k4bz9WM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i42A6mGs1m/2c7xuDaJjRuy6qzeiHsNaT6Zm5eWfthLrcj4PbmVkpKnAFrVxp8v2O
	 irz3PiSL6POBvGgR8ZnTZMY1PQ6birHVjAaN0+3x204001nihiTi+2afuYQgHlOVS5
	 oQDZrbcLpvmp29M6kIppk6W+Hkr460I6sK9x15sNRtfXPlvjYkh75EX2AOYfQxLw+6
	 05Vy7FgO+0K4iz8UO9NHbC1yD0ggY9xlJVs+Nbf2IY/t26xvSC2JbSoJJRbBhTM+9i
	 JmDQe2qqL8dkE1hGnADAGzz/EjcbboGNLd+gXjqO2A634vCWHRKYZmm3kWtcI1t+82
	 b1MM6lXlnXiGA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 0DBE1198004A;
	Tue, 17 Nov 2026 06:08:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 17 Nov 2026 06:08:23 -0500
X-ME-Sender: <xms:oTX8au8V4nBt8GHehzG9hEqmJJ0HaqqYpvNCV17AYD01BZPOeQVoJQ>
    <xme:oTX8albihyzYQlQnLn4T8BJ1gmqebndkTGMmqke7yUKcnK4APtbn3JWjy7RmzWS1O
    903VKbw5yuGRiyo2tXIWrsFF59yQYsrhEMhXzqsAs4SpsOsB0bFlII8Cg>
X-ME-Received: <xmr:oTX8aof3KijgYivzYrK9nBnwExCT8RjMBh5aunI6IasdxrPsWMBJl7d84B0>
X-ME-Proxy-Cause: dmFkZTGX1nIRce2EM7hEBPteoZuiZssnqMFZnuwSxMXg3gdmnTZl+fiHHzX2oBNXSiJsJf
    I/e9Vst+BHtRoyhl9WMXbh0/gwYGA9PqFYtIQKVLnyIVXb7zeXkz3N6uhReUZwYIR13hrL
    T7ZKOtu8DTAvwxpGM2l/jnWnCIUE81n/1kRkdUv7Pbk4yGbDA5DNCGU9aTD2f87pwBPfTr
    rivmGIjHyKUTgsoUG2wWa17dtgrQbqrrvlenEILMaH+BW9Hs46eNWXt0bxG7yreAceLvHU
    ykd75nYuGULyxecIDhNRoWGFcA9fGbFbcVW4tk858GUqeki7QD2eIO+z0vcDAwKw/ynInP
    sWwWo9LqVy1pNvVl7TC/bdvcrBYzidU3wgTdfM7PF/ACKjYhVqJUDR4nF2WHsgIJkAgHko
    jQrg9+PgzOxv5SmLJg+FedzvnFL9reKS7CAIv5vLVs14Pm9QAsrvbDh5Y3ux770Ee6Lylf
    QHJSnA23fNSUfcqNN+j5YKQFq3fQdWYKd5Abmn08WZZrlG3Oco8F0URxA+G4rAxR94RiqJ
    2j8o0SVRMPvmI/p3bUn1elP1e6Qrm85bepxgnGGrnWYIJ8HNbKRk3RaRBGvmHndZKENqeY
    0tjgazk8jKruqR2gzfcA0Xc7V/ggyN/xuX/0HQPJJeCbrpFjE9Us76Op37bA
X-ME-Proxy: <xmx:oTX8akr9YirNVX1wT6I5G5ZjYWf3es2sMnWiTwbMdWr1ECImBZiNYQ>
    <xmx:oTX8ap-CF8l49la4aQ3MiWU8vChpmqwjhx7rwe0W7ZElJcHjBI6y7g>
    <xmx:oTX8agIyOj-Cr_Jzcwge6FSvAsEAQMzbe4chXdGLMu5ExOmtq0LsFg>
    <xmx:oTX8anPcMSoAHG1094FhYNrpeOK_1uGbri0f_Ow_pi9ufrHjqAIjRg>
    <xmx:oTX8ak_ghEYWw0nYrtaE_8lytzaka_ZeBAYsR3IPaoc6K0mVmgCaNdE_>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 06:08:16 -0500 (EST)
Date: Tue, 17 Nov 2026 11:08:15 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com, 
	mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, surenb@google.com, 
	vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fs/proc/task_mmu: don't read young/dirty from a
 non-present PMD in smaps
Message-ID: <avw1Yc1W6BurgC9x@shutemov.name>
References: <20261116063624.1382944-1-usama.arif@linux.dev>
 <20261116063624.1382944-4-usama.arif@linux.dev>
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
In-Reply-To: <20261116063624.1382944-4-usama.arif@linux.dev>

On Sun, Nov 15, 2026 at 10:34:57PM -0800, Usama Arif wrote:
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 164b4efc5e093..ad9fdcdaa2c40 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1029,13 +1029,15 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page = NULL;
> -	bool present = false;
> +	bool present = false, young = false, dirty = false;
>  	struct folio *folio;
>  
>  	if (pmd_none(*pmd))
>  		return;
>  	if (pmd_present(*pmd)) {
>  		page = vm_normal_page_pmd(vma, addr, *pmd);
> +		young = pmd_young(*pmd);
> +		dirty = pmd_dirty(*pmd);
>  		present = true;
>  	} else if (unlikely(thp_migration_supported())) {
>  		const softleaf_t entry = softleaf_from_pmd(*pmd);

smaps_pmd_entry() dereferences pmd six times :/

Could you read it once with pmdp_get() in a separate patch before this
one, the way smaps_pte_entry() does with ptep_get()?

This patch would then only move pmd_young() and pmd_dirty() under the
present branch.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
