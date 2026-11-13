Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605199;
	b=Y+VrRFw4/lvgLO8KX2NsVSfRReFvGgkaOyHSHaxRAt8lGDnl04uxWHZElMUpHGC8e4nc
	 6aNmWh6781KI5jWuxCOW2PmgKlI49STSZKrrmSu/kNNrCC6t6SKgNfzTkDckpg+3CMcy7
	 f4p92iL85Hyo2uvamJwt73qep79MfK/flbCM+qMMn73SXrovvFP8ueH9Fzto4wAwmV4mH
	 lJAOAfvbZ/11ufPUs7n0dL4scTMOdjrkxRLQJakN6JDmToPyG1U8k5OmNxnpy78HfmKcR
	 JpgxW15r+VTpDzOEY+we3XMXsR0eBbHCw/pZtmm8GR7MlOQm6e5pHeKLr0kMStX/KWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605199;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=6XYL3m7pR3XD5gcmbX6twLNHi5++AAkwL0wMnUcMCNQ=;
	b=3/g7fwH4bZEpKL/vjyJuokAy0cTxUKOz9JGMQPwFMNulQxSm3oERPZIjvHIN/H84P5/V
	 uTasYWPoAG7HMidPvOLJbT/PEtwAc2MT+wc4LbhZ1AHf0xh4Uhwm8zbP6krzx3TWyrg4Y
	 Pw5FaIDPiKVKrFfybpj11vbnEoywWNhDM1qMg1QoFtUnfDMcuVe2NOMPgRk8hEzj49mEJ
	 w7qX1GR+1f4yvlNmDLyC/OEw7ZB3EqzIsJILVh6XiBzt0ZIr/R5Lj1O4pPUQ8oiulUNOA
	 zVKec5K6i8Y78CoYFjsXSIRFHiYAhHQ8Rdc8vk2EFi0Xlj9hPftEWVKkFNyLGkDm3kA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQZMDQ4M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C971606A8B4;
	Fri, 13 Nov 2026 21:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQZMDQ4M
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794605199;
	b=zwVYN0MwUAH0RUFiuR4FaGH706a2K0w3E6C5TV24J7debfJgLpzfnJpGWOD9DHevCZq1
	 TO/lWr96llMbb4DNONPjT6zHjzAaHAD5PuzNPN1C2vb9OInq1IpAn0DgIGtkFxQJbuA/U
	 9gTbgpQBVP0XPT0/t8JYcB0hvASqR9WKBixYaqYZy3MVz0BKQGU3zOYgezVJYgqea9eQQ
	 sxECD2kvLsyskQr8HaOeXXtGyvvhbvDUFe+8lqxYymONeGweran61baKg7UKxJFeS+ISe
	 DxzaAWFSmdtsS/eAbpd0eT1hxBd6AZbIUy/NdHOCcMh1xW/VUAG9Nfc6hD1lpvTuU6Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794605199;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=6XYL3m7pR3XD5gcmbX6twLNHi5++AAkwL0wMnUcMCNQ=;
	b=aW32Z7rjGn5BlKbLe5edI+84i/LHwQY3e0O4evm5OGuCxV6SgoZ2z9WDN0W3DvWPN42H
	 3jET9XXtjuQCJlGi1fJOos4Xg/ug24o1t8cSpZjcXhuxvZZ44ayB9D2DG0M5wZFIJP/50
	 sIY601oXoq/pVpanBolTXgtD9UiwbA3QlPQ9YYeYpiMIjlOyuINAVOjcLblCBMHsYKxAr
	 E/ksmG4T6svmr+s9nccknhJXH682fzVDTBwyQKHYgpRpKlhw6waVBsjgxdWX/dKy6UgGB
	 eRaApUMoi/ggo/W9bUH4qD0VDTv9NpWzexDRLPZLxXlN+wqW5kS5FSL1RLJ1gaXGAfQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 73F451F000C5;
	Fri, 13 Nov 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794605199;
	bh=6XYL3m7pR3XD5gcmbX6twLNHi5++AAkwL0wMnUcMCNQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=lQZMDQ4MTntkn55cSd4mrJU1tc44GgQmig8hNnszUECieY07GJNb8EgAhtS4PpZN3
	 LQZTdWR1YAywc7ZOKsRDwjS/DEYU00xmM5RhuYLi8hsp9Rs/ZWEaOyMy44hRy5KnAU
	 OcF+jyttVaAAmtwXVBmd5Ku26GEm7WOvfebgy2Af4csez949LgPcxWvMnEEh49SQ7U
	 CnrHTRBLJySnHhdeXOIVo6NOxPZ+HYzLIR2ZaIGg7cPvkh+EDqCxKvMutrs9K/pf7N
	 BqxU7wD0xE2RX5GfYtubs16Pyk8lMFZNdCdFBgjPBhqABEeO8TCIAfWawaH5IlGn0F
	 4sptIQ3bLthsw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C658249B12;
	Fri, 13 Nov 2026 21:26:35 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Subject: [PATCH RFC 0/8] mm/huge_memory: clean up and speed up large folio
 splitting
Date: Sat, 14 Nov 2026 05:26:16 +0800
Message-Id: <20261114-swap-thp-split-v1-0-dfa8d4fa448d@tencent.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0NT3eLyxALdkowC3eKCnMwSXYM0C7MkU1OTJBOjVCWgpoKi1LTMCrC
 B0UpBbs5KsRDB4tKkrNTkEpBRUGVFqYWlQOtKIGpja2sBcGOPo4wAAAA=
X-Change-ID: 20260915-swap-thp-split-0f86b554b42e
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Zi Yan <ziy@nvidia.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794605194; l=3345;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=/AbmnhDe2IJOrI78TkMUD1kXfK1J0O/e9ZtX3/CBXHc=;
 b=ZvIY7X4nvjD93wMA1BdYlQtatOQkZhI09urInLIAqNDsnRzPPbovJU2IFJM/8GMfgHOgpdduy
 bFeZZpGL/5QDNi+NWOuQeujVOGwfqIr1SpMs/ffdtk2+JnI4XBof3iu
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com

Hi all,

This series slghtly cleans up the large folio split path and reduces
its overhead: uniformly splitting PMD sized file folios to order 0
is over 20% faster.

I realize this might not be the best time for pushing more optimizations,
but I am posting this as an early RFC as it adds two helpers, folio_prev()
and xas_prev_canonical(), and uses them to walk the after-split folios
in reverse, saving a few local variables, avoiding a for-loop pitfall [1],
and publishing the folios with a single Xarray walk.

Walking backwards also changes the order the pieces are put on the LRU or
the reclaim list: they are now in ascending order instead of descending,
which is the actually intended order. The effect was not very
measurable though.

New code is mostly the two helpers and an Xarray selftest. The change to
mm/huge_memory.c is LOC-neutral.

Worth noting (not part of the series): I found these useful while
preparation for supporting all kinds of folio splitting folios in the
swap cache. I also tried to get rid of lruvec lock for the splitting,
or at least decouple the lock and reduce lock scope of it. It turns out,
not cleanly doable at this moment, and the main blocker is: MGLRU.
MGLRU will read a folio's size without holding a ref, solely depending
on the LRU lock to stabilize. To improve this, another rework of MGLRU's
reclaim progress is needed (which will also cover the problem fount by
the MGLRU-FG series that MGLRU sometime have a higher contention than
CLRU on reclaim isolation).

Testing
=======

Split overhead on a 32 vCPU x86-64 KVM guest, 31 GiB RAM, 4K base
pages, 2M THP.  Split a 1 GiB shmem file (512 PMD-sized folios)
uniformly to order 0 through /sys/kernel/debug/split_huge_pages and
time that single write with bash's `time`.  Medians over 12
interleaved rounds per kernel

Test script:
   mount -t tmpfs -o size=2G,huge=always tmpfs /mnt
   fallocate -l 1G /mnt/big
   time echo /mnt/big,0x0,0x40000,0 > /sys/kernel/debug/split_huge_pages
   rm -f /mnt/big
   umount /mnt

Result:
                        Before        After
real                    17 ms        13 ms   (-24%)
sys                     17 ms        13 ms   (-24%)

End to end test showed no regression.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
Kairui Song (8):
      mm: add folio_prev()
      xarray: add xas_prev_canonical()
      mm/huge_memory: avoid an unnecessary folio size reading
      mm/huge_memory: walk the after-split file folios in reverse order
      mm/huge_memory: publish split folios by walking backwards
      mm/huge_memory: rearrange split routine handling for better optimization
      mm/huge_memory: walk the after-split anon folios in reverse order
      mm/huge_memory: walk the folios reversely for the release loop

 include/linux/mm.h     |  23 +++++++++++
 include/linux/xarray.h |  49 +++++++++++++++++++++++
 lib/test_xarray.c      |  97 +++++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c           |   8 ----
 mm/huge_memory.c       | 105 +++++++++++++++++++++++++------------------------
 5 files changed, 222 insertions(+), 60 deletions(-)
---
base-commit: fae273e48c398c56b819151a607a6c8792dadef0
change-id: 20260915-swap-thp-split-0f86b554b42e

Best regards,
--  
Kairui Song <kasong@tencent.com>


