Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FD57261C;
	Fri,  8 May 2026 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283350; cv=none; b=XGPkIFLw9ep3wc/RRtYoeDWTiLt/R1Nr/PM/fGrS6XQXMds3iGapAkcE5kCinR+VrMz5nQ3uvxbVZ6qaudaorDEhR7cCFrT9AvNWRbCzACXCCbvbKlJpG0YAmMIkzG/+C5SLLPia97qUj5cRH6zIHs+S1NVVVZitHNUJJgJottM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283350; c=relaxed/simple;
	bh=ljwGvxib9VGIEN21z9Bsr4IegW3/xiDgbiyxi/ymyd8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=boYin82WDQhbT8YO4XDxd9S6PIPvx6qdkOSJ7YZjbl5ehjHlqLYnQ7DqDvoTnIOMUK4GlwlQcRoz+xa27E9riSC6d9IjYSRZK9LtA1qodYcj8hcUQMzjgOW1VTR3YK6K0eNvzNll6M3+BrCDiEC7IkffdcHDMWl2z58YitFbPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EBtWCnR1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EBtWCnR1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F0BC2BCB0;
	Fri,  8 May 2026 23:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778283350;
	bh=ljwGvxib9VGIEN21z9Bsr4IegW3/xiDgbiyxi/ymyd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EBtWCnR1As1p/wp7qA6DSxZix0cYkiP9lE+pbxOzKVZeFvhOhYbbWGGJ06yx0O3qP
	 lGb4HPAUl6RUjFpBAmLxzxXzqsUn+ecLqumevhIH+p+oCV8YCvrHq0Pz3grnHNk6Ze
	 caR8dDkpWWRqsfdNDTFzDbSISeWVRgjAVb9w9GAM=
Date: Fri, 8 May 2026 16:35:49 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: fujunjie <fujunjie1@qq.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Hildenbrand
 <david@kernel.org>, Jan Kara <jack@suse.cz>, Vlastimil Babka
 <vbabka@kernel.org>, Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <ljs@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/fadvise: avoid remote LRU drain for mapped folio
 failures
Message-Id: <20260508163549.40a7f3c8c4286a553855b02e@linux-foundation.org>
In-Reply-To: <tencent_DEDC345B4071ED3C9B293ACD437B9C8DBC0A@qq.com>
References: <tencent_DEDC345B4071ED3C9B293ACD437B9C8DBC0A@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 11:23:59 +0000 fujunjie <fujunjie1@qq.com> wrote:

> generic_fadvise(POSIX_FADV_DONTNEED) drains the local LRU batch and
> then tries to invalidate the requested page-cache range. If any folio
> could not be evicted, it assumes that a remote per-cpu LRU batch might
> be pinning the folio, calls lru_add_drain_all(), and walks the mapping
> again.
> 
> ...
> 
> Teach the folio eviction path to report whether a failure hit the
> existing refcount check on a clean, unmapped folio. Only request the
> global drain for that case. This preserves the existing fallback for
> failures that a remote LRU drain can plausibly fix, while avoiding it
> for failure reasons that a remote drain is not expected to resolve.
> 

Thanks.  AI reviw asked one question:
	https://sashiko.dev/#/patchset/tencent_DEDC345B4071ED3C9B293ACD437B9C8DBC0A@qq.com
