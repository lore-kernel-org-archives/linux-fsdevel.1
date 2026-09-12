Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7B1EB5FD;
	Sat, 12 Sep 2026 07:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789197878; cv=none; b=ldRlZerscuRymcYXIg/AYMInpl/Tc+Eb2HpUhkNpwdvNz+qkV8E47t77/mdpuZTkEHJz6AOf/b7lrpqUbuOb5n4OJfovCtR4dN06GbZ2Yv85LT/ORRARAtnsQpWHLkRaaEJ7BDRRm3zvGf3RzMAGqIFaDXuFS6sJu04iz6oRa7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789197878; c=relaxed/simple;
	bh=Vq6CuhOmMOD+AuijHvtaj4qgpqMspuQOm/HUNibe87s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D6f0PIXrUq0W49PguhgZmPckLzvTwGJSlU3mszVBe4haZQvmVBzJlNcI4hTz/0/fXcC+I3q53m0m0uRF39DoJ9gKmD4K/8fcGNXHiq7TubznZzcTn8LQoEMmm4SPLR9n82XL5F9gcaawZHkL9s4nq/V87zidgzo2yh/49XK2MwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=u4T5MVu6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="u4T5MVu6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D351F000FF;
	Sat, 12 Sep 2026 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789197877;
	bh=0cVaMglGGiME75tsb7SvlcJkfEJutw8BxSeMbD4GcdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=u4T5MVu64uZuawXIlBM7drVa70yy5BYJ2yh6jb//uLAo+4ZfEmFSzfT4UXOu0bmUw
	 es5sSjwkUQXaXwOvvFFNNDQkkU89KRv/JEsdfiyyh/5Wyxb8NCRP0IkdEQyXedTZgf
	 A4WLQ22J62HhIKJIa3X+2u738nfNxA9PATyYjSfw=
Date: Sat, 12 Sep 2026 00:24:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: liam@infradead.org, ljs@kernel.org, vbabka@kernel.org, david@kernel.org,
 willy@infradead.org, jannh@google.com, paulmck@kernel.org,
 pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] read proc/pid/smaps_rollup under per-vma lock
Message-Id: <20260912002436.0605a85b912eb8ae406cecf0@linux-foundation.org>
In-Reply-To: <20260911194145.1781926-1-surenb@google.com>
References: <20260911194145.1781926-1-surenb@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 12:41:38 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> proc/pid/smaps_rollup can be read using the combination of RCU and
> VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
> required to safely traverse the VMA tree and VMA lock stabilizes the
> VMA being processed and the pagetable walk.
> Note that we have to keep the logic to drop mmap_lock on contention
> because even when using per-VMA locks we might have to fall back to
> holding the mmap_lock.

Nice.  Queued, thanks.

The speedups described in [6/7] are significant, although I don't know
how representative Paul's tests are.  Probably not very.

So I don't know how much improvement our users will be seeing from
these changes?

And I don't know how much usage smaps_rollup gets in the real world?


As I've no doubt you know, Sashiko is saying things.  About these
patches and about the current code.  Its pre-existing
clear_soft_dirty_pmd() driveby find looks significant.

	https://sashiko.dev/#/patchset/20260911194145.1781926-1-surenb@google.com
