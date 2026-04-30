Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DA43635A
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561195; cv=none; b=Mrf9Im7DSS5Mg3DbqQMT3siM2QCQ7W4BhJYY8dwLjLx+W2FX2GnNHeEC0EcfvO7KZ41hzKWClqZRJUFvphKDYO+2TDjS29DLlUWnXBFAkY+eewK+pnVCh4As07H4qn9ddSKzauuAss9CxII3kTqYYKJwwcUY1pON6Yoh++SAL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561195; c=relaxed/simple;
	bh=8DvaFwjxwsoeIlv9bLGBMZmbAOLJ4yato5vOLCesxao=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=HEoE9UlNjCLvK9oA3d4R6ayD0+4aM18oay8ExxFYVl7zIm/Ot3bzaugkEpfXKGPBruR8MukA+0kgRSE5pg8TY0p6KUQO1Ea9jA+SSiMIO9XO5nwwkUz715wP7YokUe6t/k9gUm7gjQ07DH2y3YvL1yA6P5Xm2O1733nViizea0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e01eUXn5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e01eUXn5"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c7961d7bc09so437532a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777561193; x=1778165993; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ltj6T683SxCXf3LsBkB1ReWgsQhETBHz/ogGUF5RS28=;
        b=e01eUXn5H3ZuVTYFzT67EF/o/yaZKD0aEfiMMoFmcq/hnusZtNfvEttB1INp1u/kgV
         yfdD4UPMowBXp3qKqkNs1hNJRMs7cwtcAuInwnzcdN7CxH34KoaOPgTgpb7NQO3BNP+I
         QZuuHHS1+mMXiyKvdNUUc6usjyQUv3HsBGKW5wNRhqgI3dox8+BDP1SEpjnNusKhi4Te
         dp0eQ2auvtZhKD4CWoITlmLmGGv0hkCAX1V2FP31Bi5yMAQwh1lL5cyh7vUYGWw8eYYb
         ttxOM0ndBrNYIgUQ2TeJRSSqynNwaK+3nayx/okYpzDvR0pMSgKvtj2Y1ZPll1K0RWqI
         upsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777561193; x=1778165993;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ltj6T683SxCXf3LsBkB1ReWgsQhETBHz/ogGUF5RS28=;
        b=CQuX3nf7rAOGs5tk9CEWBu2apqGIV6MjcQpUSFStkmMsYulMy7/Lh5uK360MwdfVPL
         /5QBS0hACvTkKW66diKU99Qt1z818kXhjH/iIThKq55DgdDIHq0PaO8l0TOvn/RN5FIM
         DzHQSEAtdoXtCcW+z3ILkiuryF6tHuD4k2w48qt0QxdEfs6p+U2/MEDB179EAXtdGJ0E
         xLkAZgD2N1ZFWlyUmEKCabkQjpMUTh0X8apCw24kXyY6oHgw5gj0p0uuOqvnnTJ3CO79
         Q3X4B1uKty6z1LN+pCuTZ9Ysr3E8jR5AoKhFDYnvHP6QgdudXnBJlMsXP2RCvCFQCFOa
         E3Yw==
X-Gm-Message-State: AOJu0YzVES8GgvDqBdEYNg4SJVsoLHkSJOi9Yn4dmOavASh0ACku/JZe
	Ex4VSAomfqwUflh4GmYeDP+Xw/Znyk7nipE+g90J8PIVkSz/AR+8PW/igtNJRw==
X-Gm-Gg: AeBDievEqsrpDxx3QLabnDZr7yTKa93uwinwCWOE2bBWK9e1GjRW9W/q3wZBh4sV70h
	aJ/G4vuWKysX3vo1FkVxLzNTO8r1pcH7OczBVwmvuXhUyvq4gkCgHDH21Nney+OCUFmA8sbibvU
	fiIQguHpL6nF5VBkTiwLBEALbLVXWdvniqCbnlemNL9M4AcyiXCjQ16bBAl5b1HwWIWxoV3vBzY
	a0jye+Dpnm6R7RP9P7Vr3awh71ruyy7MrRPE+z1H31vYHtcHOGxhbu+U9W4R4mFMUaSoDl5E2y0
	JxfKvjxzki215kP6ApIy2c1UvzBu8+7ZwSTB7rWF/K3dSK/sZBn27WFpMn6oN/ZcnpymGF4m6K3
	f3kQjrT3S+d9gAOp3Xlmy3K+v1TMmQzD64z43FPxUXUln/yKpiTUgxSlWMy7rqI4goncEBko728
	jyTO9XOirHajp4dxhggCtnuyrpXtpKK4EI
X-Received: by 2002:a05:6a20:9190:b0:398:6461:688c with SMTP id adf61e73a8af0-3a3cf56fd5fmr4020396637.2.1777561193436;
        Thu, 30 Apr 2026 07:59:53 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd606a079sm5010555a12.12.2026.04.30.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 07:59:52 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>, Gregory Price <gourry@gourry.net>, Bharata B Rao <bharata@amd.com>, Donet Tom <donettom@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [LSF/MM/BPF BoF Session] Numa-Aware Placement for Page Cache Pages
In-Reply-To: <afNV5wbhsFQJLzxi@casper.infradead.org>
Date: Thu, 30 Apr 2026 20:13:08 +0530
Message-ID: <ecjwse4j.ritesh.list@gmail.com>
References: <h5ossmwe.ritesh.list@gmail.com> <afNV5wbhsFQJLzxi@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Apr 30, 2026 at 05:03:37PM +0530, Ritesh Harjani (IBM) wrote:
>> Linux already supports memory tiers and there are ongoing discussions around
>> promotion of unmapped page cache pages, which lets kernel do the right thing
>> for userspace page cache pages on a tiered system.
>
> Well, you know my opinion of that idea ...
>

:)

>> So the question is:
>> Do we need a userspace interface for the placement policy of page cache pages on a per file basis?
>
> What do we do if two tasks both "know" the right NUMA placement for the
> inode's data, and they disagree?
>

Yes, that's a fair concern that I too had.

So, the placement policy only takes effect at the first allocation i.e.
once a folio is in the page cache. So in the common case where two tasks
read disjoint ranges of the same file, a per-fd policy might work
cleanly - each task's policy governs the folios it reads and there
shouldn't be any conflict.

However, on the same range, whoever instantiate the folio first wins.
But that problem exist today too, even with set_mempolicy.

>> 1. Is there a need for an interface that allows userspace to do per-fd page
>>    placement and maybe per-fd page migration?
>
> Ideally, no, the kernel should observe the task and get it right.
>
> By the way, you're familiar with how filemap_alloc_folio_noprof()
> works today, right?

Are you pointing towards the recent work of yours here?

16a542e22339 Matthew Wilcox  mm/filemap: Extend __filemap_get_folio() to support NUMA memory poli..  8 months ago
7f3779a3ac3e Matthew Wilcox  mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()         8 months ago
    mm/filemap: Add NUMA mempolicy support to filemap_alloc_folio()

    Add a mempolicy parameter to filemap_alloc_folio() to enable NUMA-aware
    page cache allocations. This will be used by upcoming changes to
    support NUMA policies in guest-memfd, where guest_memory need to be
    allocated NUMA policy specified by VMM.

    All existing users pass NULL maintaining current behavior.


Yup, that sort of is laying the foundation work for this discussion :)
Although I understand that it was done particularly for guest_memfd only.

Is that what you meant?


> I forget whether cpuset_do_page_mem_spread
> is on or off by default.
>

Should be off then I guess...

cpuset_write_u64()
...
	case FILE_SPREAD_PAGE:
		pr_info_once("cpuset.%s is deprecated\n", cft->name);
		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
		break;

Is this what you were referring to?


>> Let me know if people think that this discussion qualifies for a BoF discussion at LSFMM?
>> Or do you think it's a bad idea altogether, if that is the case - Then
>> please help me understand, why so?
>> Before starting to jump on the implemention of any of this - I would
>> like to gather feedback on what do others think?
>
> I'm just concerned about what other session i'll have to miss to attend
> this instead ;-)

It's good to know that there is an interest then ;)

-ritesh
