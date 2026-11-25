Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596185;
	b=1BX6o0xbpZnaQV0jJXu1nhFCZwYQZfpaDRmRcG1wObt5Lw1TYwh8+vzXEIiZR7lJj0Gi
	 skpVcmFcqOK9//01QWCYc/RbrYSwNtfSgbbUXnJBIuBSapojkWnR+bMAiiH74FD+Fpu2s
	 jE0lj67w25Z0SkELE2pvKQjlBLNGtjzHsfnjFvQOIrJhncZxATCXZs+GNSjm93IfrdKRX
	 vZ70OmBSknkHzGhdudYjxjtAjkdNEo61N08LG0ngryxTFU0QN4xUpOQyjGLeAGpIMih4j
	 9iQZKy27F0NKLf1oU2/QZ0MXuXuSicnFK9ALiFr0Co0yUpLQ0d7sBWIwVwFh/Ws1w4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596185;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:User-Agent;
	bh=1mOvzWhP6BsC2DveCsIqITs/FmHLNBNTXAMNKDO4qhw=;
	b=4oj9Wg1CpwlK5OJVUEtesLJnqFp0eJeA7eBEJfZO3dDLxpgPTonWmS9YyD53Mmvp9mvf
	 +KVZRBgmNiw5yHFAVUfe3zopFdLBfhDHF395AGJ+y8EKy8kz4B8Zb2AP1gjQsGIcueOZO
	 n3KfMG8HwYMhkWvICQzT8f6/m/+RbpiPkkxzNdvXLmb0A+dSXm5dx3i715FsbNtUtvcDE
	 Hg3X26ilbzoWlBzHMPvn207ruSFK/Z7y6LZL7mBf7lRx5dGZxmA20iUYKQlFn9I2JWUmT
	 FXwagBVgtCbQ1uFHgxDXoRIlmrX7NEzTwy4JFCGsXVPbm4Z7/nDScbIdcIx8v+J9iIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74926606A321
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 08:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74926606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C2816732A; Wed, 25 Nov 2026 09:43:00 +0100 (CET)
Date: Wed, 25 Nov 2026 09:43:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: willy@infradead.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: what is the correct hugepage dependency for large pagecache folios
Message-ID: <20261125084300.GA23551@lst.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi all,

we ran into an interesting cluster of issues with an LLM review for
the (not upstream submitted yet but public) xraid code.

The LLM complained that largest_zero_folio might only return a
PAGE_SIZE zero folio, and this can happen because either:

 - CONFIG_TRANSPARENT_HUGEPAGE is enabled by has_transparent_hugepage
   returns false
 - huge_zero_init can fail to allocate a PMD-sized huge folio even
   when transparent huge pages are supported and
   CONFIG_PERSISTENT_HUGE_ZERO_FOLIO is selected

This boils down to three interesting questions:

 1) should mapping_max_folio_size_supported check has_transparent_hugepage
    instead of CONFIG_TRANSPARENT_HUGEPAGE, or do all the required bits
    for large folios in the page work fine even if there is no hardware
    support for PMD-level or other mappings?
 2) should huge_zero_init aim to allocate a large zero folio even
    when has_transparent_hugepage returns true so that file systems
    can assume to have a file system-block sized zero folio?
 3) should we fail to boot if the allocation in huge_zero_init
    fails?

Note that only 1) really applies to the current upstream kernel as both
current users of largest_zero_folio can fall back to building bios
with multiple segments of zero_page, but for some of my pending code
that won't be as easy, so if we can't actually reliably get a common
zero folio of mapping_max_folio_size_supported we might have to allocate
a duplicate one in fs code.
