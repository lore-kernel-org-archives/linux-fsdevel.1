Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793679507;
	b=CP6cNx4I6S/dXXLPvVzmfBazCFdkQ6CLRcS+oK90QiAkD0g0uRbrZ8Q1Zc8dXkGJmg7L
	 HzUEebjr013posn2vTbZ8jH6poVIDPP9JKfcneRR+X5IuqqlT0oTscx8PArUcQqkzXdXv
	 fDGTKRRwav+q67oUH/50m8vWSf2phFwyKPJi76cYaCdm/OfElwNcEi4zVyCrw/DQUWWzR
	 CHLa+Ob3Pdzfm48QrbBBOXw7CjOsrsB/KeX3fX8RBH20BI5RaYche5yuFFJ1fQ5wrvSwK
	 /fdeNyDOWDFln0/LUF9Erp9aWlGS0OjBM0ogCOnIN3cMOTjmPh/kKImJ11/xlu/1d1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793679507;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Mime-Version:Subject:Reply-To:Sender:From:To:CC:X-Priority:
	 X-Content-Kind-Code:In-Reply-To:X-CPGS-Detection:X-Drm-Type:
	 X-Msg-Generator:X-Msg-Type:X-Reply-Demand:Message-ID:Date:
	 X-CMS-MailID:Content-Transfer-Encoding:Content-Type:X-Sendblock-Type:
	 CMS-TYPE:X-CPGSPASS:X-CPGSPASS:cpgsPolicy:X-CFilter-Loop:
	 X-CMS-RootMailID:References;
	bh=x+dElKkp++qIJHqjVaYGMgPLSvYo/yZEgWC3hXRcnJ0=;
	b=azq8xBE9cmn6Ip2nLFb0Pc4++VjEKLetxfC6pgzUq+iu2GFW4GOdm5sAdaEo0NuYOhIL
	 S1p/bvNEUHqWErg+1B6JCoNqZMFv6ZYREfYpJfrCLjaOHrXifcdipdkWDymrGXcgsc7+o
	 /LABoaas90+iPb0cik4um6AMow5K8sQTb6mBGe2Su14j1wMd+gEXgmDcWcji7+Yp5e4fT
	 GfuASHADUu8pVyzCv9AqH1n2wa1Oby3JN7qsLHoa9xdeDSZkp2rULTJ75BWx8HNqSj7Kt
	 hpdwPtJKFYkStjxGhp5Y2fsKWm2FeP/+bt6ey/ZOB9k6yBWMEUgJc70DhBVgmpNOTUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=vKaUwgv4;
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B78606A32C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 04:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8B78606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=vKaUwgv4
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261103041818epoutp04304bf64c0723a9cfff2adac0b8ef244f~kbgANccLy3225632256epoutp04P
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 04:18:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261103041818epoutp04304bf64c0723a9cfff2adac0b8ef244f~kbgANccLy3225632256epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793679498;
	bh=x+dElKkp++qIJHqjVaYGMgPLSvYo/yZEgWC3hXRcnJ0=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=vKaUwgv4v9xGP3Otq6i/l/2q2NWcGAjxq0zMPwe4EQLDism8B8otgkinO/IDDJkxH
	 eKtcPOoCgrUEzOoTinlv2LD/uv8QTPl6AOHqqloXVs3lB3f9NZgQ+Ut3E2xpD+4jYK
	 gqJKpEY1H1srQUJ+lbC4R44dJE5A3/+iTMmRPldM=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20261103041817epcas2p3a3f9b84cc41517462395611187f08c7c~kbf-w6PNE1410014100epcas2p3L;
	Tue,  3 Nov 2026 04:18:17 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.212]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4jJb0T23ZWz2SSKj; Tue,  3 Nov
	2026 04:18:17 +0000 (GMT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Subject: RE:(2) [PATCH] mm/readahead: keep at least half of the async window
 when aligning it
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Jan Kara <jack@suse.cz>
CC: Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Ryan Roberts <ryan.roberts@arm.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <747jhqta3plrrx3bfikceoltsewshdpejdei2qjpn3onnvtu3p@cptmb4phbn54>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261103041816epcms2p19b933a93aed4463f954e901c7326e055@epcms2p1>
Date: Tue, 03 Nov 2026 13:18:16 +0900
X-CMS-MailID: 20261103041816epcms2p19b933a93aed4463f954e901c7326e055
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261102214705epcas2p4e71e245666406025381037104803dedb
References: <747jhqta3plrrx3bfikceoltsewshdpejdei2qjpn3onnvtu3p@cptmb4phbn54>
	<20261030-mm-readahead-async-align-v1-1-109dea6851fc@samsung.com>
	<CGME20261102214705epcas2p4e71e245666406025381037104803dedb@epcms2p1>

On Mon, Nov 02, 2026 at 10:46:53PM +0100, Jan Kara wrote:
> OK, I can see how it easily happens once that we trim the readahead
> significantly due to alignment. I'm not fully clear how it happens
> periodically. Is it that you do 1 MiB misaligned reads and so we
> periodically end up triggering async readahead from positions that are
> not aligned to the current value of ra->order?
[...]
> Instead of trying to second-guess the logic of page_cache_ra_order()
> in page_cache_async_ra() I think we could pass a flag to it in ractl
> telling it it's allowed to shrink the window instead of allocating
> small folios and then handle the alignment in page_cache_ra_order().
> Hum?

Thanks, agreed. v2 will pass a flag in struct readahead_control and
align the window end in page_cache_ra_order() after clamping new_order.
When a window still starts just below a 1UL << new_order boundary, v2
steps new_order down until the trim keeps at least half of the window.

Your diagnosis of the periodic trim matches the trace:

1. After the 4 KiB read, the window at page 48 has size 56 (ilog2 = 5)
   while ra->order is 6. Aligning to 64 before clamping to ilog2(56)
   trims [48, 104) to 16 pages.

2. Because of that trim, ra->size is only 64 near the end of the 1 MiB
   read, where the remaining req_count is 81. get_next_ra_size(64, 81)
   sets ra->size = 81, and ffs(81) - 1 = 0 skips alignment.

3. That enters a 13-window cycle every two 1 MiB reads (sizes 64, 81,
   63, 126, 2, 4, 8, 16, 32, 64, 4, 16, 32), where [896, 1022) leaves
   the next 128-page window at page 1022 and trims it to 2 pages.

Tested on mm-new in QEMU (XFS on NVMe, read_ahead_kb=128, cold cache),
reading a 512 MiB file after a 4 KiB read at offset 0 (5-run median):

- max_sectors_kb=512, 1 MiB reads: mm-new issues 3329 reads in 0.251 s
  with 9721 folios (0 of order 7). v2 issues 1031 reads in 0.200 s with
  1039 folios (1021 of order 7).

- max_sectors_kb=1024 or 2048, 1 MiB reads: mm-new and v1 allocate 2839
  folios (766 of order 7) as ffs(255) - 1 = 0 skips alignment. v2
  allocates 1039 folios (1021 of order 7).

- max_sectors_kb=2048, 3 MiB reads: v1 issued 348 reads with 0 order-9
  folios as ffs(385) - 1 = 0 skipped alignment. v2 issues 265 reads
  (273 on mm-new) with 252 order-9 folios out of 277.

Daejun
