Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484650;
	b=5PACrNoc+Zk1y5n5hkPnN3IllyLSJmFTNL6nKtPnLz9CA3VfIARqrktSdzh+1qdYcRyZ
	 89/0MUK5E+NQd8ZoELXjOqy+exx9LDrWWgwDP3OMehenhpSsS5IjLBp7hez2JE3HnhBjc
	 g9Z+938dSqEPqv0tMNe8AkngBsCDl3pWwdgYlP22tM2X1ov+920qCxJ6JiIV3aclG8fPG
	 MHbDeXO+pvCPgUIW02LsNb0ZuNREPwan0Mo46qSB0nfm8P2ZLnqD0iVDKToTunUZhB9Zl
	 65IoIX7fsV7LXl5mW0yakD8h+tstYUVw83PGlJ7oWhj025INAMUzfUgyNXKnjR0AOIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484650;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=k/+u8wryAfnhidm+5ywgfAqYpYqGesuyWI0G9gxrH3M=;
	b=GaQRrM/sb3ChTeH6kXYdF96USWEDontNzis+ZWx1Rby01G45i4DE7QxygZAnPXjVE76N
	 tKBDMbk5OmFw17ZWcfmyeN4Tt8cEdpbzCCqHRKe+6mTBHpUx43YqT6WQ2D9i9SwI51Knm
	 ZdAMLZVT6G4ZYFeHEeQGBPyATPUmaSf2kx1YgFbdu3eu5yIfVMf4YlYn6w8d5GgP/o51y
	 +ssfOZC1oNbAQfzfMA3nc5SK3ma8piP3JNe6JMxxY+OBYQbW5hD71EZUGhKSuP/TWk/b+
	 rs9ugb7GoEfLfNB+XciwSh5vJcJrLYJAgYaerQP8obAiCEkY6Ufca4a9of+S9XUne3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3zQOrdN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D89606A330
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I3zQOrdN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D7E1F00A0B;
	Thu, 12 Nov 2026 11:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484650;
	bh=k/+u8wryAfnhidm+5ywgfAqYpYqGesuyWI0G9gxrH3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I3zQOrdNgul9MB7prRZt7XD4EGkGFdeC+C3HzVNHwAMV0RSVzO6CzfgZWnzLmwI7z
	 MtJpZdBTjvwg5XCxH+ZJOVI8FiMN4i9rLq5RLNBe3cSTOb78W85wHzmUU4NIhVxUQK
	 Kk9b0IRIyxbNpPPdw8wiKIWjvsejEQnXmHiXjSnR4ZFl1MxNjoSW29e5V72LPrE0s9
	 MzewkAy+G808m7jz6VSIgt16VCWf6px3epIOq/hgnbIvZOUj0js+FOcQJZHDywaE+7
	 Q+AAt1Im5qfJGVnn0bDhD8Lv1X7OOGWm4Qrjwdc9FYefeae0HEAvJCeH2kkXOlyokV
	 obNRpu/+1RHmw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 87819198003A;
	Thu, 12 Nov 2026 06:57:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 12 Nov 2026 06:57:26 -0500
X-ME-Sender: <xms:n6n1asRvSMKt8lZqdd3RjXkBszv8fyN7gvudjZ6B-hleSXeLQe5oLQ>
    <xme:n6n1anW0Fi28Ad5aW0HqQq03DJ5D4Lus8cC55QBxYpFOj1lLblchYvpcU0dVye168
    wrRB9hgAI55MllvGHJLe-HoL0KoEtuA5KhIQipSngKG9ZkXNOKLOpkX>
X-ME-Received: <xmr:n6n1arLLRDMZpcLHqdbwdiVwGBSthKLghs4bvAc7vJBX6XWSv5lcKlpFaH0>
X-ME-Proxy-Cause: dmFkZTGL2ysdhkk3Q9pSt2a5lMctqQHoVOdfgIyLipUx3E+AndjfL22w/xZNqzjFzzjnCp
    T7Ix2eZi3R+Ok4cLC5pDLZGlqK6/fRWNOk4EMBXA3XtDSI4SYuCWPZNLAf8yK5UlN8vx2C
    y7dwBVBBDzu1P0KLwuQU8Z5i+vDsCEutU7YUWMwYrfJczw5P7lhzk/UsejRyA6boaMFoIS
    gO9Rx78X/oRlsRLfma1744JtL3eevcxkOSlTvxTiPgGaJGIlNAZbWt2PIOgm0CnT5k0gVO
    82PkN21pLWvf37VPkhFIqCat/ZUGewQBQBbHv+FXP4g3ug7PyqL6jjLs0shLXMHOf2oNOb
    LlIpCM0cwQ14viXtqL9cJV2Dzw3UHNOvKh94ZVPVIb95qY/VnTh++hSbHErInnC1c8eQ9k
    5QtEibIXGPdPPWtarIYOe8cnUq8Ln0QU+1xjw5lVLGObRRtQ+aAuwOyD8B4w5t/O3/9zP7
    iiWasIeWv5WVygzL+iG0ByJ7ySSv9hE4kfY2O7AZY3rKC6Yu4fNHwCn26rxFCRrZVYLA60
    RATf+q+PGmsA0uLMtUucAQbXNRtHp/u0WqNfbv/1zM7Tqo78BfDLhqhH/2vxMT4Hx2jAln
    7KocoYABcsVaC+Be0Mi6oyEGDqdJBq6ebeRL6g0zbg1Ljb2ejRvtr6jj6V3A
X-ME-Proxy: <xmx:n6n1aqZLdv_DDmx5T42wQsF6revHzywPm8jyJN43zuQKciQRF2Aamw>
    <xmx:n6n1aj99ug-UY_yU0sIuRzEl7c2IXugeH0gaQRaXCBanrPZH3JXKng>
    <xmx:n6n1aiCqcIyXbRZ9kBG5nquPKtXvxBpYlhSmIWP2owWiuXFq6H_MTQ>
    <xmx:n6n1aglzBfNwD9G9fnVYF7FZKuJK2Sg0gIKJkGrXiLFmhuf7c4Cj3Q>
    <xmx:n6n1amv2QK_j6pHPaO1aeMV7A8UBidadsbclmalFiy1pnE1uiNHuKoqO>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 06:57:18 -0500 (EST)
Date: Thu, 12 Nov 2026 11:57:17 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: Tal Zussman <tz2294@columbia.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/12] mm/madvise: send UFFD_EVENT_REMOVE when installing
 guard regions
Message-ID: <avWnaR7VVEGa7yNp@thinkstation>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>
 <avTA58zlxJZ69TB8@thinkstation>
 <e19f1fff-f1a7-4c2b-8908-2d3ee6a49069@columbia.edu>
 <db9ed03f-0b85-4360-a2e9-f6719773c7eb@gmail.com>
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
In-Reply-To: <db9ed03f-0b85-4360-a2e9-f6719773c7eb@gmail.com>

On Thu, Nov 12, 2026 at 10:40:38AM +0100, Jose A. Perez de Azpillaga wrote:
> On 11/12/26 12:21 AM, Tal Zussman wrote:
> > + Jose
> > 
> > On 11/11/26 2:25 PM, Kiryl Shutsemau wrote:
> >> On Wed, Nov 11, 2026 at 12:55:19PM -0500, Tal Zussman wrote:
> >>> On an anonymous VMA, the zap drops uffd-wp and RWP protection along with
> >>> the pages. Writes and accesses to the range after the guard is removed
> >>> are then not reported, and the manager cannot know that it has to
> >>> protect the range again.
> >>
> >> For RWP this only holds if the range is registered without MISSING.
> >>
> >> The zap frees the pages, so with MISSING the first access after the
> >> guard is removed is reported as a missing fault. And there is nothing to
> >> protect again: RWP only covers present PTEs, and a page faulted back in
> >> shows up as accessed in PAGEMAP_SCAN.
> >>
> > So this makes sense, but I think this gets at the documentation point
> > raised in the other thread. It seems that to use sync RWP "properly" it
> > needs to be combined with MINOR for shmem and hugetlb (and MISSING for
> > holes) and with MISSING for anonymous memory. Is that accurate?

Yes. Async mode needs neither: a page faulted back in is mapped without
the uffd bit and PAGEMAP_SCAN reports it as accessed.

> > If so, this should be stated much more explicitly in the
> > documentation + man page. I see that co-registering with MISSING is
> > mentioned, but not the rest of the points (reclaim, collapse, etc.)
> > The example in userfaultfd.rst also registers a MAP_SHARED mapping
> > only with RWP and MISSING, no MINOR, so that should be clarified
> > too.

Without MINOR the example can lose data. Eviction runs in sync mode,
but an offset that is not mapped in guest_mem, either pre-populated or
zapped by shmem reclaim or collapse, is mapped back on access without a
fault. A vCPU write between the pwrite() and the hole punch is lost.
With MINOR the access faults and waits for the handler, like an RWP
fault.

> > Hopefully this will make it into Jose's documentation patch.
> 
> okay, if Kiryl is okay with that I will add it to my upcoming patch.

Yes, please.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
