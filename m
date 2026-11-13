Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548763;
	b=oLifjmhRJK/tN0uV1otjocFc7pHrlr826ILTHj/v/1wHQTDugN2WeBKvkr6K/f19tI5p
	 zp/udwtdUSvv7OvhUt4VuOVcxmmApDcaSgZlW74q93VERdQ6aO/noDgrkQnX98ZohVDiU
	 Uz5B1MihVYfGQ8RYfqXZOhL+VXK41bV0zbnEBPij+PSv3+1wxPJJClupxAQ8lET2pnLTf
	 S74S0Uvb22YWfuKH3/nRjm5kTvUMbgQRMG4mWtINRl1E7LI3/QmfEELznQPyAbWBWPAY7
	 1+Ig4v1PY75szoZE/qJM/JJrh8T+voePBrotz+lrBOGTIQCupOlJfGCcBYpTunBRIBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=v4rRGE+RVmHQmdWS08eNxSiiu1iRCMHoWjayyFspKz0=;
	b=Btpk7/AURahLQexUgMU/xsqawk44KxYu4M5u3XHW6OW/IpbeFsZpW8oWc8n3N2P5yibQ
	 XDrKIzgQb6XLtdzPJo6FM1JG0W41uyncDL2Mxe5JB6kDoIVt4VXF30wRhUwfR8GZzRyzM
	 5KMNHnJfD7h4JBIWXAs6ZmHhOrG9hyh2lJtpy14iNekAysnL3cJNgtDkPPJLBxDageghr
	 HFhtUKK/sS6fkVu+oLcRPIGMtz5AAGmcSH54CWtnzMADMQ/WD88UB1GG118Tdg2hCpoIZ
	 ZduCINAYybKHiUbK4+EpdjniRQsxBLPLQlVzsBKlWLdj0+zkv5/XGNQrVOmJEGrFMSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=L9WiFkNG;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC4E606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 05:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC4E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=L9WiFkNG
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93cc1ab5f6cso139109485a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 21:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794548762; x=1795153562; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v4rRGE+RVmHQmdWS08eNxSiiu1iRCMHoWjayyFspKz0=;
        b=L9WiFkNGld6M4dqrx8vyVoTO+36iK2D+PYcnl4ufq1WMLBc8k2m0hk0QMRIiWOx867
         2or1m7cJ/nCUIfXIelnE1Ry0I7ANJ9rWfem1gDY7zTuYNZjQA49NIfXKnY6mcSZUXJWV
         wjz5+IfvRsaE+jJXttt6ZQeTaQEhdyfA9qO7zwbjEjfxQ7vJJjxbuJ6i4oBfYauXIhq+
         u7vGybm3qsMXBOVzbMiquUiWvBcgC07fl4QoJSASgGMqBrIQdDrQ50boOcWoE+pJfVA9
         N/03AJ1xchiinnt4Bh57akGjIUs+oTMChQxem77huu6DD/1OjYH9LDU9+aTVdReduOE7
         QcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794548762; x=1795153562;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v4rRGE+RVmHQmdWS08eNxSiiu1iRCMHoWjayyFspKz0=;
        b=sqzrQpWMP3WdOAWer0mYiyETGm73nkRbY8J5L7QJe17/+8W+BTXjrIF96pbB86EKRk
         ZjbcISDJdayQB3zOshOiVj2QBk/pZgX2tHH9vthFZEhrJ1sCXLtF9pc+qBhufJgylKi/
         eCJmUc6+sYnWaPZUgjcVVffCO0JvUiMdH2ObWZxtKAhXE5S/GYuOhg/Oxivyg4zPTcGC
         KkwC/0LUw82yBqEEVp7l8LPiYurtmUlcpRsKg1Kw/YBvmaMlM1W2fi9h7LPfdEM7RQoP
         4KPcvKAKrVjy5HdFFCFoAvEX19CL3bKgbE1u1TabGnt5rp/yX+bNZ1h3JDtO+wA9rnOH
         he9w==
X-Forwarded-Encrypted: i=1; AL+hErGEqkLJ7Fuhpt+ZVT07DmoHX17ctrmmWy2FwuC4iR59076fyW95/behWyqmif+uynRkTn7wNZvi4akHp9t5@vger.kernel.org
X-Gm-Message-State: APuU4Z/E3RjO/aYlA1+4J3hgxGHjWjuA/RAS37HjgO1z5JL0Jlw7h6vs
	m1EmV9g+srSEwtPdWQATIOf8dtwFpC5LGtKG2rI599V+FuOdPYzuUBv3R6pap2Zvrrw=
X-Gm-Gg: AYBFou0w+x0k3VpDyofjB0t6wdTHwhbFydkmp5FD8zMGtqokaHIpEo0kQj/d4pmlIWY
	6Foc1VGKq1D07aSdXnAau+wwl1uBEe+XtvZU7m4sIgLuet7DLmpDRM9UIdQItkvlFd7dOcEeCJP
	WTELglu/bp164bVJ5JwdorrjDol3NlthPOEPrS9sWda3EYD2sCfer0pw+hvZedDgUpu61RyTTJf
	jy2a/M9+9lS6pSgrEB3XzIFA2neOFEuxZvv+h0YF1HJdun33jGwu44sRQAZxvkiBsuXrquAFjdS
	+lnQB09yxquNPfbUVevBv4P4V2KQ5wkpAruBDrjCMB59ckoBP8N9o/yPB/FfW/D5HagMWrV6nuG
	/N+Gp1YisvlafCW07YoFQbp4NuYd3e4+BzNrm0UqfghgA4IKbPv3IFznjZyKke5WeIwY8m4dadF
	WX1ZMmqrlEmXQRXIcR8cRJN3Faqfa2qBA2Rpfb1t1jA3tP+8xu4Z9EzdkQK9GU46CQYmv1zSvnd
	nicz1yqODxHHaeQRtSTqIxlEKFPTjeQ0xBKNWeBFEStVpI+Fg66gv54i0EAsEvUvrY6kAFkQDnC
	453T727pZS14u8d3DOnVFAfxeOcoGRifDN3i9QqJThAkjeUsnmAUDC7dleLQS6DCw7U+BY3Arh6
	Z7YrwlaY=
X-Received: by 2002:a05:620a:801c:b0:93e:c12c:fbb7 with SMTP id af79cd13be357-9494bc76c5amr274209085a.68.1794548762215;
        Thu, 12 Nov 2026 21:46:02 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c836f6dsm108597885a.22.2026.11.12.21.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 21:46:01 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 07/12] mm/mremap: resolve uffd state when the context
 is dropped, not during the move
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
 James Houghton <jthoughton@google.com>, 
 Andrea Arcangeli <aarcange@redhat.com>, 
 Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Andrei Vagin <avagin@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Arnd Bergmann <arnd@arndb.de>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 =?utf-8?q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>, 
 Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20261111-uffd-state-fixes-v1-7-00713d368976@columbia.edu>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-7-00713d368976@columbia.edu>
Date: Fri, 13 Nov 2026 00:46:00 -0500
Message-Id: <179454876058.482102.4630783467113971871.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-11 12:55 -0500, Tal Zussman wrote:
> Without UFFD_FEATURE_EVENT_REMAP, the new VMA of an mremap() is not
> registered with userfaultfd: mremap_userfaultfd_prep() drops the context
> from it once the move succeeded. The uffd-wp bits, uffd-wp markers, and
> RWP PAGE_NONE entries in the new VMA must be cleared as well.
> 
> However, move_ptes(), move_huge_pmd(), and move_huge_pte() clear them
> from each entry while moving it, before we know whether the move will
> succeed. If a page table allocation fails halfway through, mremap()
> moves the entries back into the old VMA, which is still registered,
> without their uffd state.
> 
> Writes to a WP range are then no longer reported, and an RWP range
> becomes accessible without a fault. Nothing restores the protection
> afterwards. This requires a page table allocation to fail in the middle
> of mremap(), so it is rare.
> 
> The uffd state must only be cleared once the move can no longer fail. To
> fix it, leave the entries alone during the move and clear the uffd state
> of the new VMA in mremap_userfaultfd_prep(), right before dropping the
> context, using userfaultfd_clear_ptes() like unregistering does. A
> failed move then puts the entries back as they were.
> 
> This adds a second walk over the page tables of the new VMA, for VMAs
> registered for WP or RWP without UFFD_FEATURE_EVENT_REMAP.
> 
> Like unregistering, userfaultfd_clear_ptes() also asks for the PTEs to
> be made writable again where that is safe (MM_CP_TRY_CHANGE_WRITABLE).
> The old code only cleared the uffd bit and left the PTE read-only. For
> private anonymous memory this saves the minor fault on the first write
> to each page that was protected.
> 
> However, this adds spurious minor faults on shmem and hugetlb. When
> resolving, change_protection() rewrites every present entry in the range
> with vma->vm_page_prot, so a page that was writable and not protected is
> made read-only, and its first write after mremap() faults.
> UFFDIO_UNREGISTER and UFFDIO_WRITEPROTECT already behave this way and
> lead to the same spurious faults. This needs to be fixed in
> change_protection() and will be done in a separate change.
> 
> The entries no longer need per-entry handling during the move, so drop
> uffd_supports_page_table_move(). Where the old and new addresses are
> suitably aligned, move_normal_pmd() and move_normal_pud() can move whole
> page tables of these VMAs again.
> 
> clear_uffd_wp_pmd() has no users left, so remove it.
> 
> Fixes: 0cef0bb836e3 ("mm: clear uffd-wp PTE/PMD state on mremap()")
> Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Is this a fair summary:

"""
A page-table move clears uffd state before the entire operation succeeds.
If an allocation or later operation fails, the protection bits cannot be
recovered.

Transport the page table state unchanged in both directions. Resolve the
protection bits only after the move and VMA callback succeed.

  ... details about spurious faults ...
  ... remove clear_uffd_wp_pmd ...
"""

Anyway, I was able to reproduce this reliably by injecting some
ENOMEM failures, and the change looks reasonable.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

