Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A59509EF1;
	Fri, 18 Sep 2026 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746285; cv=none; b=cbsbDAqyfO77reT0KlvJboh26Vr6ZObx6Ih5KL5OyEoUrlNaY1bUQ5XDe4ESFEy9GkV/Hgd9eR6b1Lc0watZxaVRZI//LP7rNoelHAw+GWt9DhWhgRwJIoyCRUYD3WLkvvRyRuq7rG4HIwsQ65GqnJi01ofprpeVRK8gbkAmmcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746285; c=relaxed/simple;
	bh=IykjiLSlPo3kpA5rLA6AwgWQ6W2sODHNc2u/NZ0mIGk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Hj/dUjfZujsMa5v5fkESsEmj1Yx+dcKrZfYzrN6BVtOLfNJKAKKthheHs/r6Fgb2rMBAh2NNlLB1d/IHr4vwOgZtnTvz3Mz7LuC8etyrqv46L18yeP7KpQjH/84Cr0CWz+zIIIG673bMnj8wpfnXo48tKH+C0nxuZOjtE4MVWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PVYDC95n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PVYDC95n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304E71F000FF;
	Fri, 18 Sep 2026 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789746283;
	bh=F5GxhBi0EfK7oYbT1liNeUQi6p7p1t4bIMnqIiho6fI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PVYDC95njTGNGSvrI17qkadoaNvtm+GWaVh4lh+NpLDGAcI1tgSaOKNYRFnGebqTY
	 4INwLt2VzXTqAyc75l8cZFUHvX5I0La/UG933dRQz/sa+D4hafDTB/rNL92bx3lAfl
	 2snx0KOs1WrQoTcBm5I7F3gCB4lC9IO+mcBVCdIg=
Date: Fri, 18 Sep 2026 08:44:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org,
 willy@infradead.org, jannh@google.com, paulmck@kernel.org,
 pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] read proc/pid/smaps_rollup under per-vma lock
Message-Id: <20260918084442.c95296b529cd8bf003e38bd5@linux-foundation.org>
In-Reply-To: <20260918153318.758387-1-surenb@google.com>
References: <20260918153318.758387-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 08:33:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> proc/pid/smaps_rollup can be read using the combination of RCU and
> VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
> required to safely traverse the VMA tree and VMA lock stabilizes the
> VMA being processed and the pagetable walk.
> Note that we have to keep the logic to drop mmap_lock on contention
> because even when using per-VMA locks we might have to fall back to
> holding the mmap_lock.
> 
> The first 5 patches are cleanups making later change simpler. The main
> change is in patch 6. Patch 7 extends existing proc-maps-race tearing
> test to verify smaps_rollup content.

Thanks, I added this to mm.git's mm-new branch.
