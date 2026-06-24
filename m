Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595B32570D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280343; cv=none; b=jicnF4snI4R4SiqV6oUdo632fNxfjkV9bm/HAtuGToW/2AsviPkWlYBbJRSCco3lGVuMnz8ZDyQDizEhDSlpxZWSEr0DAMDuWqHoUP6/gmpf2SgD6JiLq2DGwQaUti6gHLu4vRHHntr8hV2HG5wubqkF6rogbsiT86S5wBHK/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280343; c=relaxed/simple;
	bh=erQYG8/mN72Ytzc4c3mCm3utSEhjOA5qXYS+wO3UboY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gfiHt6iwUFMrwg66btZ5Ud83WwW/7Pq3HDzlMY1aUSJy3LfJ4gy78WFc7UAmzBppiVDlLluOH1/dPrcv6MqBd7lZRDVE/q54a6HQcRQ1Ka8F0CCS/brnxtC7Jmjkc3UBU/mPZbEi8skMfy4ujg2rCAIsd7kl//S4blDs6cSiw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYbXH6fZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYbXH6fZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5171F000E9;
	Wed, 24 Jun 2026 05:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782280342;
	bh=s77aan8zIzbHun5dnnm2xBxH+FDWkBe885fh9Pyq530=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYbXH6fZ2OqXmSrLU4YQgnYPoqjDbDmOKYUgo3N4fwLQ9atg0r1vt1gxoEMcdtGx5
	 Bry7j79MLeyAQ9UdZJ3hfYHia6tA49t8nf/1b3o7ISCdfbc60nGuD1DRIziLthPxln
	 dhSNA91jnPY2OefMlxZdoot5SruW4wg5XA3vfiB3im218D/auWv7EnqYJhZ48fXjq6
	 IqvfRys/sb3T/Dk4jPU6zfuIoHq4TuKYFe1kxU5LRwetHg6hd/Lwh+lzGFM2i266oL
	 fgh4bju1HuvFq9BAMDnVRBjSbf06gZedg8edRGeNc8w6/dE25vc9fNj3t0QoPITPFn
	 nD/8sA48K4yBg==
From: "Barry Song (Xiaomi)" <baohua@kernel.org>
To: willy@infradead.org
Cc: josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] filemap: Remove file pinning during fault handling
Date: Wed, 24 Jun 2026 13:52:19 +0800
Message-Id: <20260624055219.49097-1-baohua@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20260622192114.1147198-1-willy@infradead.org>
References: <20260622192114.1147198-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Now that faults are protected by a per-VMA lock instead of a process-wide
> mmap lock, it is far less important to avoid holding the fault lock while

We could have fallen back to the mmap_lock from the very beginning in
do_page_fault(). And for GUP fault-in, we have always used the
mmap_lock so far.

> performing file reads.  The per-VMA lock does not prevent operations
> on other VMAs, nor does it prevent iterating through /proc (see commits
> 6b4c9f446981 and a75d4c333772 for the original motivations behind dropping
> the fault lock).
> 
> We will now submit I/O and wait for I/O to complete while holding the
> fault lock.  This removes the need to return VM_FAULT_RETRY which means
> we won't fall back to the mmap_lock from the VMA lock just because we
> had to wait for I/O.
> 
> This should result in improved lock contention, although it is possible
> that some workloads will find themselves contending on the VMA locks
> due to them being held for longer.

Hongru reported that 82 of the top 200 Android applications in the
China market call fork() in heavily multi-threaded processes[1]. It
would be good to take existing applications into account, please.

[1] https://lore.kernel.org/linux-mm/20260623075805.466317-1-zhanghongru@xiaomi.com/

> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
[...]
> -static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
> -				     struct file **fpin)
> -{
> -	if (folio_trylock(folio))
> -		return 1;
> -
> -	/*
> -	 * NOTE! This will make us return with VM_FAULT_RETRY, but with
> -	 * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
> -	 * is supposed to work. We have way too many special cases..
> -	 */
> -	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> -		return 0;
> -

Does this break FOLL_NOWAIT users? They are KVM on x86 and s390.

Best Regards
Barry
