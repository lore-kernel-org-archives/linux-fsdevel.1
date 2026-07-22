Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2032F532F;
	Wed, 22 Jul 2026 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784680781; cv=none; b=tg2eD1v9PfmDiWddPyac7a6xhJiU+CkCxNfTREhdKNOWUFjE+lfPTEaFllCkCTMuPAtNxv+9BPNdHJ2niaA3DO7VBz75S36nlz2TfAr5hBdmnrsl0iLsYyl5i9dXLBok5ZKUrXrYaxYBpJEF2ikXoALFoJe3wv+DLKKEiRceLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784680781; c=relaxed/simple;
	bh=yPqqsX8FmDYIcLhVyuYnZ1OKodGL1/le1XmudwKlhoA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X7OW92T1nx1BmYEQ2FnTkcPFkP7CvSiDxWeh1fD5MU8VkEWaazc6pSYhIoYpwihtgUqxifTFTJugr03hOgbarVWFTBS9D2HuoJ2C2E09gjWYQ8vcO/jCAj8oVhiouAycRwx/BYhcgeY+RUNdGtzICoEgYfCyg1eIQ2rq9UkY2pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AK1Hw3Sm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AK1Hw3Sm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E418F1F000E9;
	Wed, 22 Jul 2026 00:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784680780;
	bh=y4T+aKPpaxnS+ujMYR/jYT/mPnpjNhh6DW0nJJXIn5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AK1Hw3SmLevzjCH/JoH2SIgM7swWP4Gt2HRraacUJ8IS55kQUs9s/QyO+ZT888jkR
	 6ZTufHq6CG6vgzXadLNeUebypKQ660K4mFGmJB96nZDpIZiC1nlmHvnLUVqQibY6+5
	 rHdoMJqu6RE6gCj/eBpUTy+g4tmbyBu1Zvu+P4P8=
Date: Tue, 21 Jul 2026 17:39:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kaleshsingh@google.com
Cc: surenb@google.com, kernel-team@android.com, android-mm@google.com,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro
 Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: proc/task_mmu: Use walk_page_range_vma() for smaps
Message-Id: <20260721173939.6bee67b6af17b54961daf4f8@linux-foundation.org>
In-Reply-To: <20260721051903.691848-1-kaleshsingh@google.com>
References: <20260721051903.691848-1-kaleshsingh@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 05:19:02 +0000 kaleshsingh@google.com wrote:

> From: Kalesh Singh <kaleshsingh@google.com>
> 
> Modify smap_gather_stats() to use walk_page_range_vma() instead of
> walk_page_range() when walking page tables.
> 
> walk_page_range() internally calls find_vma(), which asserts that
> mmap_lock is held. This assertion fails when reading /proc/pid/smaps
> under per-VMA locks (where mmap_lock is not held).

So the kernel is emitting a WARN trace under some situation?

I'm surprised.  The offending patch is only six weeks old, but we'd
normally hear about this very promptly.   Is a bug report available
somewhere?

> walk_page_range_vma() walks a range within a single VMA and does not
> use find_vma(). It relies on the VMA lock instead (when configured
> with PGWALK_VMA_RDLOCK_VERIFY), making it compatible with per-VMA
> locks.

Sashiko said a thing:
	https://sashiko.dev/#/patchset/20260721051903.691848-1-kaleshsingh@google.com

