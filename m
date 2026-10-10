Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0370638E8B9;
	Sat, 10 Oct 2026 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601268; cv=none; b=m01iprenfvfTmaO8aKMlhB6kZxoX1PZRTr4lqDp0RrxIOlZgyQPsJlfD3+2zTTHoPssuL2vXdy8+YMA9VwxSct5BdNXrwRyn98O1pDDIhq9r0ie5T8EwYjgt9safTczI6XNTPI91MvO+WwiMBhFt8L8DERuIghoaez48wMxPuBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601268; c=relaxed/simple;
	bh=MM2Bp8AYdpavi/YZTIulv/+tT97y9S1abYre9GhnIjo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XhAvFuEjDP3hgTwH4xbj0fK5F1RGrlUODyHGniiVKxVqcKidsDplUFIiqRM98UzM9M5N7BknWzmMv39nWybT6ESf+KGo45dZOemUbj1q3In2kiBX4mMtkaJhBgG44i0Jqbp2T88WI8kYxZ32/KOF/HhUkKHqQi5xLHrkAjcMkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: OJS8ygc0S+aTURbj4RhksA==
X-CSE-MsgGUID: aixXHEIASciLg0f986Qj+A==
X-IronPort-AV: E=Sophos;i="6.27,149,1786982400"; 
   d="scan'208";a="191389071"
From: Yifan Li <liyifan21@xiaomi.com>
To: <akpm@linux-foundation.org>, <david@kernel.org>
CC: <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Yifan Li <liyifan21@xiaomi.com>
Subject: [RFC PATCH 0/1] mm: page_frag: account page_frag pages in vmstat and meminfo
Date: Sat, 10 Oct 2026 10:59:39 +0800
Message-ID: <20261010025941.1253-1-liyifan21@xiaomi.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX02.mioffice.cn (10.237.8.122) To YZ-MBX01.mioffice.cn
 (10.237.88.121)

This is an RFC.

Pages held by the page_frag cache are not accounted by any memory
statistics counter, so on systems that derive "LostRAM" as MemTotal
minus the sum of accounted memory they inflate LostRAM and lead to
misleading "leak" conclusions, even though the memory is legitimately
used by the network path.

The page_frag allocator (page_frag_alloc / napi_alloc_frag /
netdev_alloc_frag) backs sk_buff->head and the frags portion of
skb_shared_info.  Unlike slab (NR_SLAB_*) or page_pool, page_frag
pages have no counter.  A preliminary measurement on a 4K-page
arm64 Android device shows 14432 kB (3608 pages) of page_frag
pages already in use at boot, and the memory footprint grows
larger under heavy load (e.g. sustained traffic through the
virtio_net / tun receive paths).

Patch 1/1 adds an NR_PAGE_FRAG node counter and exposes it as
nr_page_frag in /proc/vmstat and PageFrag in /proc/meminfo.  Pages
enter the cache through a single entry point
__page_frag_cache_refill(), so the increment side is complete; the
decrements sit on the paths that free the cache page.

The remaining gap is on the release side, which is open: a cache page
handed to an skb frags array (skb_add_rx_frag() /
skb_fill_page_desc(), without an extra get_page) is freed via
put_page() (kfree_skb -> __skb_frag_unref -> put_netmem -> put_page),
bypassing page_frag_free(), so the counter can over-count under
network load.

Closing that needs the page to carry a marker checked at the common
free path, e.g. either

  1. a page flag: PAGEFLAG(PageFrag, page_frag, PF_HEAD), accounted
     and cleared in __free_pages_prepare(); or

  2. a page type: PGTY_page_frag reusing _mapcount, accounted in
     free_frozen_pages() (requires that page_frag pages are never
     mapped into userspace; true for the current RX paths).

With either variant, the per-path decrements of patch 1/1 would go
away and only the increment would remain.  Which variant fits
mainline better?

Yifan Li (1):
  mm: page_frag: account page_frag pages in vmstat and meminfo

 fs/proc/meminfo.c      |  1 +
 include/linux/mmzone.h |  1 +
 mm/page_frag_cache.c   | 14 ++++++++++++--
 mm/vmstat.c            |  1 +
 4 files changed, 15 insertions(+), 2 deletions(-)

--
2.46.0.windows.1

#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address is listed above. Any use of the information contained herein=
 in any way (including, but not limited to, total or partial disclosure, re=
production, or dissemination) by persons other than the intended recipient(=
s) is prohibited. If you receive this e-mail in error, please notify the se=
nder by phone or email immediately and delete it!******/#
