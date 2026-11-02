Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635267;
	b=BFRGM7OErcv4duEp49pimtPEcbl10G8hd7zCk5X0d6Bzcfb32YwrVQojFYZuI2A1dRji
	 gbtnc40xzEYAedOdiDkQxsxgLojD0tsYqpEK9lsVwTHYq38EDWCdwTzErHVTjLIhDERFe
	 lqrVLV6/mn2PtItgjVB/LsipNJ0LG3i518oCJymbiriJ+Va0ClSPi5PR9ZQq7TMsFvSca
	 yYAjrla+ITZBnzSmQecYlJRC7W+mKGzeDioJkFhiAMBvcYbwpq4p+AJE/G3nDkaUsH6yK
	 tcnt2cfU0mPIP8HNy8tOEy8x7zWiU5OINKb9x4rugZy9YaNqrYGOQeDPeXyq2Eem4QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635267;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RU2jBCpKBxpdRBvA25bZWKawafbZ9XeC+7q9nL03NOo=;
	b=oRvMsFK2Jm91CsZrPMFvkQkY/7/a0Lat9C4EIAfKJ0qQgZ/ZQ9OYsCh99fLysENUYFGD
	 NTE4oMDlovoktyuuLI21n3uy7E0Vgij6Yer1VYsuOkdiIjkEOjCXuauDcNeWCHzJ95wfM
	 KF7yv3gG+7o3/YfeKcFT7o0XPBKYrHdDban3j4rGm4uoqksgW6siRyJHh2GEqNJomrcVz
	 b8ajBhCYEY7NmKgTBDBLftvyk3FFybdwXVskpIJaHujkLldmCO/zaAHR0NWaAHeaZe5qS
	 DylGtz6ePMWoUQCHmqOxfB5NqgqULcChGRaRmWuWweMW43YA7vKc/YJvsbQOnag1+cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=aHkxSWKA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE77606F233;
	Mon,  2 Nov 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=aHkxSWKA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFA31F00A28;
	Mon,  2 Nov 2026 16:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793635267;
	bh=RU2jBCpKBxpdRBvA25bZWKawafbZ9XeC+7q9nL03NOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aHkxSWKAW00AelAnZ15EN0hJ4hUc68nQkGl5Z4sA8HrqpLJeS40HhdTES22CTJwjM
	 +NTau/6fUurg9JwioJilYiO+jiKK2GC+5ggVq17dH6E1ChUpNa2Dbn/N0CH7P/7OC6
	 YCkWVJO4lvYbVqWMcJO6ZaMVeyjqj4bnSSbktN7Y=
Date: Mon, 2 Nov 2026 08:01:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: david@kernel.org, ljs@kernel.org, jannh@google.com, liam@infradead.org,
 willy@infradead.org, paulmck@kernel.org, pfalcato@suse.de,
 usama.arif@linux.dev, vbabka@kernel.org, linux-fsdevel@vger.kernel.org,
 yi1.lai@intel.com, oe-lkp@lists.linux.dev, lkp@intel.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] selftests/proc: use RSS in
 /proc/pid/smaps_rollup tearing tests
Message-Id: <20261102080103.6e3f602364747ac6adb13f5c@linux-foundation.org>
In-Reply-To: <CAJuCfpGmPLBRhHa_dmyP10QzyRyvcWMYDLU0+J9t-RCLBsTaWA@mail.gmail.com>
References: <20261101154503.3203036-1-surenb@google.com>
	<20261101110100.90796bf33ef50307a7698dca@linux-foundation.org>
	<CAJuCfpGmPLBRhHa_dmyP10QzyRyvcWMYDLU0+J9t-RCLBsTaWA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Nov 2026 07:43:17 -0800 Suren Baghdasaryan <surenb@google.com> wrote:

> > :
> > : The patched userspace test passed all six cases on an existing
> > : x86-64 6.18.57 kernel, with a PID-namespace adjustment. That kernel
> > : predates ca5480fb53fa, so this checks selftest behavior, not the
> > : intended kernel's procfs changes. Separate syscall tests on that
> > : kernel confirmed the EXEC-merging and memlock failure cases.
> 
> I'm guessing your bot was using personality() to make the tests fail.
> Again, I'm not sure we should handle such use case. Should we?


: The concern is pre-ARMv6 CPUs, where READ_IMPLIES_EXEC is set by
: default. Nobody needs to call personality() to encounter this there.
: 
: We already addressed this in 0685630fdccb ("selftests/proc: make
: proc-maps-race work with READ_IMPLIES_EXEC"):
: 
: https://lore.kernel.org/r/20260808200312.6326-1-kmehltretter@gmail.com
: 
: That fixed split_vma(). Alternating PROT_EXEC in setup introduces the
: same assumption elsewhere: RW and RWX both become RWX, allowing adjacent
: mappings to merge. The parent then cannot find the expected three-page
: VMAs and the test fails during setup, before testing procfs tearing.
: 
: Yes, the focused x86-64 check explicitly enabled READ_IMPLIES_EXEC to
: exercise this behavior. It wasn't tested on old ARM hardware. But I
: think we should preserve the existing support for those machines.
: Populating writable, then removing write permission from alternate
: mappings, preserves both RSS and the required VMA boundaries.

