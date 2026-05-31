Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7EC360ECE
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270174; cv=none; b=khkP28sv6SlnkqbXagJ3X1R7TQnzI58pW/p8EiArzVDSfi0Qul7/4DPlawhEpid5PL5TgMglrDyTuEuJcCNHh8rDrrkfxP27nwQnI3zsc6LyOlJ3uCX+mWwMWAZM3HSpJPJc9nTFPcwoGUSPKHwrREVyJKAlU0Gefpg7E6AvGgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270174; c=relaxed/simple;
	bh=wpN2DMoqi9CmEHMcXbGGMbu29Axnf2IHOptAkTUYXbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWsfsFOhvTx9IO2gL752rwZFBGrMqwBmFSX3kWmzksg+okB8WzOy/NKdqTwHNgKDBHlXscP4znaR3Qr/KmUYSI6A/ejeztdRYpyz5rBAi5qyURBBcXhbxH+AFzzMyzspLmlp2ulclr7qrEkdy1qpqXnvlFk8h+6/AzaNzfejHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3MSwmDq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3MSwmDq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45eeba68948so2648581f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270171; x=1780874971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQRXdo9YxYwyrzUF+NcSdzn+gwHEuyRiq4J1P14JkS4=;
        b=F3MSwmDqrJ572O84JWel5Y10PTK+Qu0ZEj0/BHeMgVXume+YGx40fQGSAGCHlq4bP1
         xXHlPMuNgCSBBGMBgG842gSM4RQy/+zm8eX9D7uZgFMSuGLu+CsifFZsXdc0ZgObtkDr
         dJB9R6s1MEonwcK8o6snC/F99JU0hGe7BH9qZxSwv56N9ayEAWuG8VxyOo7rMW+KTmvM
         VKWr54ZVBKzIKoGetpO6+7hIHEf2Tsbq0mD+pDUOEKIcN9qrgQqKLaginOxNry7hle6a
         N/7dPS2Pgy3gdWeazu8wvWiC+3Q8W7d9qWAg3jAlVeUCAuX1UE4pqPjV31eWWw8sHtNR
         IGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270171; x=1780874971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQRXdo9YxYwyrzUF+NcSdzn+gwHEuyRiq4J1P14JkS4=;
        b=UvIHnqaSBQvGAZ1GL8ObI1c73UO0nsafoxpUumAMymISqqMcKn6y5wh7/HnWryDAk3
         hA1bL9ZuYScMCUg5Qta2/U5t98zo4eqG4cZ68NcYew4Q7VfZmXt0JzlPLP4tNNY8W6Aa
         GhMNgGXuCaoU+qW9R1UXReoxJLuiUYsLVf8IUr29ivItCk8vHJ0Xw3Ojel8u/RptKY7M
         npoiB3PoU+oyW3tR+nNsrZIgFBQVICixmx1usjsKm6hhryhDHbaTqhUiF6u3cXqnxK61
         2QsqkGWeredB5bV175HtFWwMxj4xMk4zsIAEV8MCLY4McTEGcBAbhsk3Uud5tKIEx4KG
         XHNA==
X-Forwarded-Encrypted: i=1; AFNElJ8GBcLWlPYINMhTclbQwWRPwn0E045+qyDRYuutT8+Vx4ehiW/Sos0wAxx/oJ8B0XApI2A7c3IhWXcowpta@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhyk8rw9ZyT4MCyKdE0POW2CUVCS+hJKUqd/gndzvHK7WYEPxL
	hcXFho83+VNGA1btHkrNX27HLcAzfMW4lkMkVr1LDdDXsB74sxCWkrnH
X-Gm-Gg: Acq92OEt/FbJH3rlAzwu/sVw0Kh8mLNyreWjO9KAjZAehahbIAMKm704lI7GWj0/FxE
	gSQHiPKWzASXFJllmjaq1vOOZnUYfVUM15pi6xqk4v0B4k9VYZJOtNdMxZA4pudVp02NhDf7ml8
	UzUWjiIlar5dt/D5FuH/3QflUaMEiR9dt5imk174M3SUrZxIi9rTooZUxj2PYPTfj17Sp0Det+E
	WRXWbNwTmI6WCAo856XeNH5wnNhNLZl31VoNMP4O7XSMVV+hH2CjvlDmD0yEkap+n4ykVvulb76
	ZfqA4ttbZgKY1VOUSbz0YJve48N7ckT4MG75+B1zNng4NSRvYOezBMi055LTT7CLnctFOA5OEQh
	sIah89LRKfTUT2hCqH1aT9OCBvQcSHf1M0+55C226+BcSDjV6q8vUflbCxF2s1O+52bNmrOu+2r
	moPsgtd14+eoDlennqeIpq92JZoHrs5sgwfVLaRQMXd/Oxe15O4ZO0EvPMOzHfx77zmOufrD/ce
	cI=
X-Received: by 2002:adf:f14e:0:b0:43d:7d24:b510 with SMTP id ffacd0b85a97d-45ef6b5ae44mr11062126f8f.22.1780270171265;
        Sun, 31 May 2026 16:29:31 -0700 (PDT)
Received: from localhost (pat-125-253.wlan.net.ed.ac.uk. [192.41.125.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb7asm20512971f8f.20.2026.05.31.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:29:30 -0700 (PDT)
Date: Mon, 1 Jun 2026 00:29:29 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: abuehaze@amazon.com, akpm@linux-foundation.org, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org,
	dipietro.salvatore@gmail.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, stable@vger.kernel.org, vbabka@suse.com,
	willy@infradead.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <20260531232929.mn6f76yrnc6e4cpf@wrangler>
References: <20260506123326.17293-1-dipiets@amazon.it>
 <20260527162412.19922-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527162412.19922-1-dipiets@amazon.it>

On Wed, May 27, 2026 at 04:24:10PM +0000, Salvatore Dipietro wrote:
> 
> Thanks Ritesh and Matthew for the continued feedback and guidance on this thread.
> I'd like to summarize where we stand and ask for your input on the best path forward.
> 
> Summary of approaches tested:
> We've now benchmarked all proposed variations (pgbench simple-update, 1024 clients, 
> 96-vCPU arm64, huge_pages=off, PREEMPT_NONE applied [1]):
> 
> | Patch                          | Change Location       | Avg TPS    | % vs Baseline |
> |--------------------------------|-----------------------|-----------:|:-------------:|
> | Baseline (no patch)            | —                     | 101,979.75 |       —       |
> | v1 (original, iomap caller)    | fs/iomap/buffered-io.c| 141,194.20 |    +38.45%    |
> | Ritesh's suggestion            | mm/filemap.c          | 139,200.61 |    +36.50%    |
> | Matthew's suggestion           | mm/filemap.c          | 143,863.82 |    +41.07%    |
> | kcompactd background           | mm/page_alloc.c       | 134,278.47 |    +31.67%    |
> 
> 
> All approaches recover significant throughput. The kcompactd approach (background 
> compaction and returning nopage for costly orders with __GFP_NORETRY) aligns with the
> architectural direction Dave and Christoph proposed, keeping compaction out of the direct 
> reclaim path, and lives entirely in the page allocator. 
> 
> Based on the discussion, I see two possible directions and would appreciate your guidance:
> 
> 1. Page allocator fix (mm/page_alloc.c): The kcompactd background approach addresses 
> Matthew's concern that filemap.c shouldn't know about PAGE_ALLOC_COSTLY_ORDER, and aligns 
> with Dave's vision of removing compaction from the direct reclaim path.
> 
> 2. filemap fix (mm/filemap.c): Both Ritesh's and Matthew's suggestions are minimal, 
> backportable, and preserve lightweight reclaim for non-costly orders. 
> Ritesh's variant differentiates between costly and non-costly orders, while Matthew's 
> is simpler and performs best.

I am not very familiar with THPs in the page cache, but for anonymous
memory, we have /sys/kernel/mm/transparent_hugepages/defrag which
decides what to do in the event of a THP allocation failure, whether to
enter a synchronous compaction or wake up kcompactd.

Check vma_thp_gfp_mask(). Maybe you should adopt something similar called
file_thp_gfp_mask().

The problem with fallback is that your application is never going to get
a THP and eventually TLB pressure might actually end up slowing you
down in the long run.

Also compaction is only really tried if it makes sense. That is if
enough free memory is available to actually perform the compaction and
have a chance of creating a large enough huge page. So compaction is
actually never performed under accute memory pressure. Which means your
system actually has enough free pages, but somehow the compaction is
slow and inefficient.

I am just trying to think loudly here and address the root cause. The
real problem here is fragmentation due to unmovable pages, probably in
your case the page tables. We should work more on reducing pageblock
type mixing. Also page tables can actually be made movable so that
compaction can treat them as movable pages.


> 
> Would either of these directions be acceptable for a v3, or would you prefer a different approach?
> 
> I'm happy to test any additional variations or direction to move this forward
> 
> Salvatore
> 
> 
> [1] https://lore.kernel.org/all/20260403191942.21410-1-dipiets@amazon.it/T/#m8baeeaf48aa7ae5342c8c2db8f4e1c27e03c1368
> 
> 
> 
> 
> AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico
> 
> 

-- 
~karim
