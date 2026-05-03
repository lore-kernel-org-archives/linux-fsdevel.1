Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65542248B4
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777831142; cv=none; b=M8U9TeZ7mmTYba4Md3tZUaXpeBLZTgvIeLI7IXwI7ZOfBFFySLpft/KQskaYups/BqRfYXlyHydDBVT0i92EpGhveHvMP/4wzyZxm45ZWepMuGp29Mbs8dp0YFz2VFTXXHyet5WF4F1DwyypAPvxIEBzuAOx5mxRcprM/FrVu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777831142; c=relaxed/simple;
	bh=hVzHMQ85MveykDgGj1INLZiQi23DLXlBjZGj6hWpYkU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=G7032MiJ6E2LtXG91Z9OAGzrsgsuR+4RJYC/ficbjYlgL9Bx12eDwosyGn09Jag+KfDB7Rv/+Y5F/TC8QH773ebUVYNirPkQh6YxzS8cp/stxcKoEwIQC0iORb3HKDK3J+BKmFS166VkSF9/+NXQ0hcP5bKcp/FX+/fAJ/RGr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUIMG+y9; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUIMG+y9"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-365425c98c6so147588a91.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777831141; x=1778435941; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pFk0o4JWpcFOrDUzmGXYwzfHWtQM19RfFRUQ7XDLJQ0=;
        b=QUIMG+y9EQFcVj4Sn7Kh5XwCW6hw8X805ZbzrrUQjh6BN1v/ok/m/qzUAOW6UZD09i
         TYM8jwzhAK0lmBc2jq5g8ncpoaBjKBTrIyVhmdM795rR0ndpVxdNYnhvMdAdEX8tX/UX
         4isymyuotFWmdwb89J5p4k476SYs2tCDTPXIDPMvbFJkhMNLNnJcNE13Rk830Ym4YB18
         d3XSjycWf985k3Vz9SW8aWitBzyV9noLPDZTTTUdLEj9kVYmZdTsk9qGnOoZZ0D83FgF
         xzAxVBa1P7pvXWKJOQLCRWWVI4gUaNYDdt9fSYwJg+zNTrX9fSXcq3y2izQCkPziQPbg
         5u9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777831141; x=1778435941;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFk0o4JWpcFOrDUzmGXYwzfHWtQM19RfFRUQ7XDLJQ0=;
        b=CzgPdjsHQ/wc4xHR/dvuo7F1YSIvrNPr5NsAct1JB/McU2G1jcZ+m3qH1T7Wvt34iz
         Gvgx7SYMyZG2OmzTp6JPwexrHdWmu5DoPfxSJCfHUQae7go/dIHzGo9yuat5z69jF3Or
         CEZvgpAyyD1m1yVGDav0uYC+8LSIEa0Yz0jDMxiPjsscypyMJa1Q+5pHNpy1hwv8oJXP
         c/OayvV1avN6hd1Cb4+pabV0pJ/oUP9MHVvIkX6SW4+CNJBEzWa3HwuTBYX5LqrvDv8R
         VeEgB8UO48NRX2Oxt+2kgLOy0Nn3+hejuGrf7jh/afwzAkLkEicuImFZfcgR6T97S2Oq
         WLnQ==
X-Gm-Message-State: AOJu0YwvuVtiAuu/Rs6x99DMdscYTx91IBnFG5NvtQ2DMEb5oI0E6BvN
	wBB7YRz/DsnBhzdVHKN3Shp5d2C+HrhttxoUGjIDhlFRlJRgvnlWmJvV
X-Gm-Gg: AeBDieuCouhx1yNYtpW0ADto4bEF1yK4+xM+RFL36isZ3F6LLV1J4CkfQjTLE0YkeaE
	vj16hVfCacxKOfGCvwtrhO9eFgfPpyQp+8taEMUo4oaFVNRdZDRxLgO41gKlhy+2Fb0NSfciPi4
	4a42vNAafk8y1RbhvJOXRvOK4u47UBPVOED0f0q536Oyb+urqNMHiTo5nYEq8jEW16vM/iJ1tAO
	oG/OREEz25lR2anI1DFoUgoS5zYHm4WUIlzEahRsBUsBmUDb+2eqH+8dxD4Uiibw0RqmL9WCrNV
	IPSsl4btUVDlF9Tz88ImpISaMgY6pTuTFRK/m2FPbQqtowYC2EkAQc0KjFlUL3x14EwjtiI/p2C
	qVb+F4RPAqSSCKQFA7Ssm5Kvvzl6I0SZHgM24BgeBpJ/XCszJICie8IqInVnMgKeAVypT69dKOr
	D4Sxn66FA5ufpnvKSUDxsbjsWhLf9A6gzI
X-Received: by 2002:a17:90a:e18c:b0:35d:a4c0:a0ac with SMTP id 98e67ed59e1d1-3650ccefc6cmr7084928a91.3.1777831140990;
        Sun, 03 May 2026 10:59:00 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2aa41sm15437701a91.4.2026.05.03.10.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 10:59:00 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gregory Price <gourry@gourry.net>, Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>, Bharata B Rao <bharata@amd.com>, Donet Tom <donettom@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [LSF/MM/BPF BoF Session] Numa-Aware Placement for Page Cache Pages
In-Reply-To: <afYdH4Alu9QA18CO@gourry-fedora-PF4VCD3F>
Date: Sun, 03 May 2026 21:48:01 +0530
Message-ID: <8qa0sc06.ritesh.list@gmail.com>
References: <h5ossmwe.ritesh.list@gmail.com> <afNV5wbhsFQJLzxi@casper.infradead.org> <afYQz3YJdWB2R-1q@gourry-fedora-PF4VCD3F> <afYdH4Alu9QA18CO@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Gregory Price <gourry@gourry.net> writes:

> On Sat, May 02, 2026 at 03:57:19PM +0100, Gregory Price wrote:
>> On Thu, Apr 30, 2026 at 02:15:19PM +0100, Matthew Wilcox wrote:
>> 
>> fd = open()
>> buf = mmap(fd, ...)
>> mbind(buf, device_node)
>> /* fault file pages directly onto device memory */
>>
>
> maybe more explicitly, something like this
>
> fcntl(fd, F_SET_FILE_NUMA_NODE, gpu_nid); /* pref node */
> mbind(addr, size, MPOL_BIND, ..., MOVE_ALL); /* move existing */


One existing problem with this approach of using MPOL_MF_MOVE[_ALL] (not
specifically about gpu nid usecase here) is that, it only considers
pages which are mapped into process address space. So, unmapped page
cache pages are invisible to it.

So, the problem which I am trying to highlight here is - Today there is
no mechanism for a user to move/migrate the file-cache pages w/o
incurring extra I/Os. The only way that works today is to first populate
all the folios belonging to the file into the process address space by
issuing MADV_POPULATE_READ and then issue mbind(..., MPOL_F_MOVE). But
there is no primitive to populate the process address space with only
the folios which are already present in the page cache (which maybe
residing on a different numa node). Note that MADV_POPULATE_READ will
read the missing pages from disk too.

So, maybe something like this.. Would this still be useful? i.e.

madvise (addr, size, MADV_POPULATE_READ_NOIO);
mbind(addr, size, MPOL_BIND, ..., MPOL_MF_MOVE);

MADV_POPULATE_READ_NOIO should ensure that only the cached folios
belonging to that file are mapped into the process address space w/o
doing any extra disk I/Os. The subsequent mbind call with MPOL_MF_MOVE,
will then ensure that all the existing mapped folios are migrated into the
chosen numa node. And also that any new pages which gets faulted in will
get allocated onto the chose numa node because of MPOL_BIND policy. 

I believe there might be existing applications which might be facing
this problem today. This can happen, for instance, when there is a
workload which can run multiple times and may run across different NUMA
nodes. Our internal test team once reported a similar performance
regression with llama-bench on subsequent runs when running it across
different NUMA nodes. The reason this happened was that the existing
page cache folios of model weight file (from the previous run on a
separate NUMA node) were not getting migrated (because they were not
calling MADV_POPULATE_READ since it can cause a read of a large model
weight file into the page cache all at once).

With that in mind, do we think having something like
MADV_POPULATE_READ_NOIO make sense to address such problems? Do we have
any other usecases of this too?
Or do we see any problems with this, due to which it never existed?

(Note that I haven't yet given a thought for how it should behave for
anon memory).

-ritesh

