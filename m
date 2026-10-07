Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A6390992;
	Wed,  7 Oct 2026 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791404340; cv=none; b=b91WT8/vRI0lQwJQ0hnWobz6uHwFYhgLdv5koNAdMv0mVDZFs5m7ZvsqcOjzUic2pnP6W7VFffqBeFgf8T4Xmma/5Hm0no/IR7rzrLmiB50Kuw6tVSMeyu9+dxWrs1jn7G73wiSBsnjtS+DtBRP5nl823W8XOUnmNHMCPq+0uWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791404340; c=relaxed/simple;
	bh=Nuf77IWEwLTeoTr0gGZ90YTRxTdS9j6RoPOrb9nzvqk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ewKLhhC0efWzOlxmZyDSMMSuhPkyjMtO79HeEYm1/nHT3LSqHzNfdFZNMYnPKLSW8u6gtm/C5Zkfce5OzBcDGq5rcScW6jTJfdCoSibXwO6ULsbQv7VBp2Cc7RlHRu2zT+KOSmi1EBoBTyuxbrkC7kLALaPt2LjU4dZ9S1pBEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hkA1pUQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hkA1pUQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE561F000FF;
	Wed,  7 Oct 2026 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791404338;
	bh=d41kn530ujQXx0WENCPEp/GR3x+3qSK853uJA2lQe2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hkA1pUQ9hmXJ5YjSWckXbDjIG7G4wQNaBiVAqevr/9CFrRaNQ8rTINww986xmW99d
	 wV3tZAhsdcIbKshZRPlm2SwVQmLqV3TNIAivlP0MFA23WL3MSnaM8CQ0UnoRLmxXnx
	 7wkwV9mCJS/9Kuxz+yASeRuOuu+SrQUuMP1Zximo=
Date: Wed, 7 Oct 2026 13:18:57 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Serapheim Dimitropoulos <serapheimd@gmail.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 fujunjie <fujunjie1@qq.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Serapheim
 Dimitropoulos <sdimitropoulos@coreweave.com>
Subject: Re: [PATCH] mm/fadvise: skip remote LRU drains for ineligible
 folios
Message-Id: <20261007131857.15fd27af78322d14c4075db6@linux-foundation.org>
In-Reply-To: <20261006-fadvise-lru-drain-v1-1-1e8fcf785057@coreweave.com>
References: <20261006-fadvise-lru-drain-v1-1-1e8fcf785057@coreweave.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Oct 2026 00:27:19 +0200 Serapheim Dimitropoulos <serapheimd@gmail.com> wrote:

> From: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
> 
> POSIX_FADV_DONTNEED retries invalidation after a global LRU drain whenever
> mapping_try_invalidate() reports a failed eviction. This includes failures
> for mapped, dirty or writeback folios, which dropping LRU batch references
> cannot make evictable while those conditions persist.
> 
> Filter those failures in mapping_try_invalidate(), while the folio is still
> locked and before deactivation can enqueue another batch reference. Leave
> mapping_evict_folio() and its eviction safety checks unchanged.
> 
> Use a boolean retry flag instead of a failure count: generic_fadvise() only
> needs to decide whether to drain and retry once. This remains a heuristic,
> not a test for remote LRU references. Preserve the retry for other failures
> on clean, unmapped folios, including failures from filemap_release_folio()
> and remove_mapping(), rather than limiting it to the early refcount check.
> 
> This follows the problem identified in fujunjie's earlier proposal, with
> the filtering kept in mapping_try_invalidate() and a conservative fallback
> for other eviction failures.

It's not particularly clear from the above, but this appears to be a
performance optimization.  No increase in POSIX_FADV_DONTNEED's success
rate is expected?

> Link: https://lkml.rescloud.iu.edu/2605.0/07547.html
> Link: https://lkml.iu.edu/2605.1/03284.html
> Link: https://lkml.iu.edu/2605.1/03732.html
> Signed-off-by: Serapheim Dimitropoulos <sdimitropoulos@coreweave.com>
> ---
> Tested baseline and patched kernels in QEMU on ext4, XFS and OverlayFS.
> For clean mapped files on each filesystem, 32 POSIX_FADV_DONTNEED calls
> produced 32 lru_add_drain_all() calls before the patch and none afterwards.
> A separate dirty, unmapped test using ext4 data=journal showed the same
> reduction.

The whole point of the patch is a performance optimization, so it lives
or dies by measurements.  This vital info shouldn't be below the ---
throwaway line!

Also, fujunjie's original had timing measurements, which are nice to
see.

Anyway, I totally believe that this makes things faster so there's no
need to do much work on this.  Just saying.

We're in lockdown mode for this -rc cycle so please await review and
plan to respin/resend after next -rc1, thanks.

