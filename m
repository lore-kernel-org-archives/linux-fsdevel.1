Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCA44756C7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869554; cv=none; b=JIaNCU7N+Kxxm6C2rtXyPqxpZHj3ivVP6mGO3ARETnRg0u8VeFlkt/x/QvQAUb0Yn4aOjOSddmj+TyZCB9UrliQ3i4rmr1WemZgl/2PQvKxC8igNKkBA/yugoMqvifa0QX6dt0SomArVBx+MIGGdO10QbYTvD5WhKchVG6SACYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869554; c=relaxed/simple;
	bh=zWM2+49jEMwBQwNik+CFCtiOiR0VjtZ6SxoPtniyer0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bmhSBIOe7b/PXySbc80KmFxiQ8IC4qdgdup+8OjvStr3trfMs7GEIEYzcOkfPo7SKbez+ErSM91Mh0C17dvQtMRkg1TrCp11i4LuujB9gI9wxcbLV/ny+87VAPqMXOyRnr1ID3okfPCzBYV8SWEPnjjjn51uzoVfSeQedbk3FL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UowxIcw3; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UowxIcw3"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IY7UB2212956
	for <linux-fsdevel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=7YfZUeIFW9TVPjgB6SoqKQpgS0
	HUMDYLvGLEC86SVCw=; b=UowxIcw3t3wlAFDlemaKlByrLPdlI2o72gL5wLyZGT
	3X+Plr2b9u0eN0d8sTL1eMoYEv3VOcAZriW+ZfL0uXbvwZobyV0CxBiillFFSlkF
	NKa7df5UgoioU5Jf3R6TXVK/fP5jURHOjiQuR2OL5l9MAnZYdO0ButMqwbYCadVg
	iNjDOR1V8U1JI3KwMVi3BFe7VLfiIzrXFRlKezajPClhIoISeYk8tTtsJGP1DqVI
	oEiL8Pq0LHbS1tGVSjS7MOtrQapJr37nUM97XJRHVq0x8GV/6GW6tG32UIf2k7JJ
	nSW0yHhQ2U9exk3fU+lP7jmykSyJ3jE3kRrNz8aIQLDw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fukgqs6a2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:24 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51a8db414c7so1494781cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869544; x=1786474344;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7YfZUeIFW9TVPjgB6SoqKQpgS0HUMDYLvGLEC86SVCw=;
        b=lKGWqJD+Wqliaw/4wPBkltiMdD8jRpmsKm++IT1tzIJgeCG0m0hTTSb4JmznhzqXXg
         9RyfXKcUo+/BfHz36D5jMCmidXFk1SCX3NTE0ZmXQGKTHaJTwduF/iUBChhiJ+a2nLaZ
         c5p1E0pG5UVA/MxqXN+i5Zt/c5G6G5K9O/IJblmGN+tAyu49rUwEnrNE9+tsY+hYOrf2
         9IKmJnO0Gsku0h6eKmw8zmV1Z8WxZnntG38yPpYQfph4xqzo4VPOZWFsVxb1hjW9Z+GV
         fzaGEakAPJ6+7l2s9txJDz0eHewmx9qlWUw4u6EZNDtlrh0gotg4A1L6D38rv22rUFx0
         xbsA==
X-Forwarded-Encrypted: i=1; AHgh+RqIarZr4cGt+Bs78ghqP7p5dAdVBHQJa7KoRH9wYTMYmGGd/TkzkgNZBBx0jmGrVJGPGMQlPtfzll16JBH1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8JlJhoavmjI+jZj4MHNDoUpO0yvD+S2aS8G+2aggBBuWwQsvR
	nUbGgBvT4eC6+yZ8X6moq4EflQYAtSMRdRX8IKharVG8zFhKZhs+CRpdprxzmBVUkPR2L9Vs4S0
	juS7fjrKwlR4taFn2L9uVNEHSjT89d8uZUVvLjUZ55imYdeYhEgbS6CBzI2FULdM=
X-Gm-Gg: AR+sD10kadFhYaX+QiJzrtIv5WNMfLe+/LDCARWG2CfleseYYPaMKiRpyBM9oB5thxS
	qLOyITh1IzV+MBys27J0ddksUoZByyqF7H5bQX0nu9IKE2OTW9sSG+C8tUo6PUvo543DFdo1OYy
	Sgks2HvHHkcuAXNBPKQ8GdVBTRUftp0tYSzCfqR0fQ7/HFzzrVjPYZ4rktJCybqEcIA1JE+w572
	sWrQxfFwZd4REitNZv66lBtwwd3yXtlFnuNHBNxdy9C9VSnBENZjFHfjJoNtXTavDnM66IejKGM
	2pU9t+BIjrC09d/DXWV1xM96T0FsCxxrpiAmMxZOcdiYR8wz4S+rbTW2XfbPtCSRE2bkRGa2OS8
	QohxjSsZC
X-Received: by 2002:a05:622a:2487:b0:517:a7ff:935f with SMTP id d75a77b69052e-52ce5fa471emr14549161cf.9.1785869544307;
        Tue, 04 Aug 2026 11:52:24 -0700 (PDT)
X-Received: by 2002:a05:622a:2487:b0:517:a7ff:935f with SMTP id d75a77b69052e-52ce5fa471emr14548641cf.9.1785869543831;
        Tue, 04 Aug 2026 11:52:23 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:22 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 00/10] ceph: convert writeback path to folios
Date: Tue, 04 Aug 2026 14:52:08 -0400
Message-Id: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANg0cmoC/42OSw6CMBRFt2I69plStBBH7sMw6OcpT4WSthQNY
 e8W3IDDk5yce2cW0BMGdt7NzGOiQK7PIPY7ZlrV3xHIZmaCC8lrLsBj5xLCpCiC62FQWZk8RdT
 KPKFGbnQlpT2aiuXG4PFG761/bX4cRv1AE9foarQUovOf7UAqVu/frVQAB2nKk5W6VLaUF+NeY
 6dJHdCOrFmW5QvsOSvR3wAAAA==
X-Change-ID: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=2554;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=zWM2+49jEMwBQwNik+CFCtiOiR0VjtZ6SxoPtniyer0=;
 b=fEDv7IHpkI8eMWnAST4q4BAmT9PhWrien1UJlpvi3iP8NJEIOvrTfVJt2EbDPSyKLSLZeHGWS
 jpYM3a1TgRsCm5MC1re6zBif6kyMG+VfIUTLjNCYLi3vuoSxRq6czKk
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXwrO9JHr68vzL
 /AmisRlLn0eVmRhOQGRSXWTMI2UjrwseiOqTb+76va3SAyGG6KGi2ZpnrDDeqPW1VpgcGaEAV3T
 6xA6veBfy1tFXb7ZUTVmZcNOwVpxiymxvZcT/Tg1iSOY7Fr8Oo8H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX6il7DktxdKtG
 OTv6+LASqn+tLR95TwgNM7T5Qi+kUQTeWrwn8EJO9S2PBe2KDiSkrIE2WfXMAr81d4Fzblsh4w+
 oqOhNhoBbAV929ZX6FcR/JRBebRbrK+LBu4VOb5l0LCjWuOWhg2Xb4+ffxXLyHUiSzL0ExgiSaX
 EPIicTx1FJa0JzEAqhyeNT6sgQc7HzsvNO20cATXdry2LgJa+PLJn4PnP+clqY8vT5tCpBmv6ED
 VtYnVp+Va7GI/hzHl9Ur44b7chGX8iuImhc8v7XlwXsEvIm/tIcmGPejtzd0HbZqFNP5oce7Of8
 xU2hAK7GUF6o+0H8m53m1qVKCZTOKGy2q0CNylhk8/LmX+gRPxhkhAZiv77nZAbT8vfyEKanFil
 nR+hnQMeOawFbeLpUQ4ONj/2GTMTWN2Vafpk8i375H5LhY40cVb4lnnH9U7mQLJoTucsRhpHI2J
 rVGHGek35LFFQFn3UTQ==
X-Proofpoint-ORIG-GUID: yd3x6v7E1avNkVlGN88IXrNS_6XX7qTh
X-Authority-Analysis: v=2.4 cv=X+Ri7mTe c=1 sm=1 tr=0 ts=6a7234e8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=CvbYRxD_FV8rGtwQpYYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: yd3x6v7E1avNkVlGN88IXrNS_6XX7qTh
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 impostorscore=10 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=10 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

Convert ceph's writeback path to work on folios. With these
conversions, remove three mm compatibility APIs whose last callers are
eliminated: wait_on_page_writeback(), thp_size(), and thp_order().

Some page <-> folio boundaries are deliberately left in place where
ceph borders on some gnarlier page-based APIs:

- libceph's OSD data plane is page-array based, so ceph_writeback_ctl's
  pages[] and osd_data->pages[] remain struct page arrays. Folios are
  converted at the array/libceph boundary.

- fscrypt's bounce page API remains page-based for some functions
  (fscrypt_encrypt_pagecache_blocks(), fscrypt_finalize_bounce_page()).
  Possibly-bounce array entries are unwrapped to their pagecache folios
  via fscrypt_pagecache_folio().

This series is based on the ceph-client testing branch [1].

[1] https://github.com/ceph/ceph-client/tree/testing

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Changes in v2:
- Propagate tags (thanks David and Matthew!)
- Rebase onto ceph-client.git testing
- Rename the series to "ceph: convert writeback path to folios"
- Patch 1: Drop the folio_test_private() check in
  ceph_folio_snap_context(), per Matthew and Zi.
- Patch 4: Introduce ceph_fscrypt folio helpers and use them in
  get_writepages_data_length(), per Matthew.
- Patches 5-10: new
- Link to v1: https://lore.kernel.org/r/20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu

---
Tal Zussman (10):
      ceph: add ceph_folio_snap_context()
      ceph: convert ceph_wait_until_current_writes_complete() to folios
      mm: remove wait_on_page_writeback()
      ceph: convert get_writepages_data_length() to folios
      ceph: convert ceph_submit_write() to folios
      mm: remove thp_size() and thp_order()
      ceph: remove page remnants from write_folio_nounlock()
      ceph: convert page cleanup loop in writepages_finish() to folios
      ceph: remove ceph_fscrypt_pagecache_page() and ceph_fscrypt_page_offset()
      ceph: rename ceph_check_page_before_write() to ceph_check_folio_before_write()

 fs/ceph/addr.c          | 120 ++++++++++++++++++++++++------------------------
 fs/ceph/crypto.h        |  12 ++---
 include/linux/mm.h      |  21 ---------
 include/linux/pagemap.h |   1 -
 mm/folio-compat.c       |   6 ---
 5 files changed, 65 insertions(+), 95 deletions(-)
---
base-commit: 30c0913a2b44a66dc17283a88489b3f3e12f4327
change-id: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

