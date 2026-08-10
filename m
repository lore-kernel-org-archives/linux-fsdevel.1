Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D879A3E1222
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371668; cv=none; b=KHFjmf9JF0rqd51TMGhvAbo59XtJtv0giL5lUZQNzZd7h19+9Np9t059EAm2wEBJ8pFHIB9j8Fw43dwwJFKk8WZPMx3h/X+31zIdkQWMoo1qhUzlOpr2unOZKAxNVGtdKdw+3/1Q8ZXOAfHQ6yZj5jW0k2z+8P9cRAxTHyPDntE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371668; c=relaxed/simple;
	bh=ACXOp9y+JHYQJ0ReTJpnKp8/uZY8YUAMptYnBA8kvCo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hYmeUWjOrZZ6UG4BK04PCWfhIjQ5MGSVilapCZyk/qTDs/jqmiEPXzoTH4/FMuo9wgBMyCVj7NKguHNhCm/N3XNUOgZiL1HtvBtyF56e7QW5jjdfIDDLtAlcecoJe7N5WjY3loQ/EPNLJbHu7bjucJCxxjBsEjucqQhx9Z3zUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=PFXqVoxS; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="PFXqVoxS"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACbabc3845396
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=5w6GJ667Z7vMoCNVVHReYDBKGn
	+cpEFhQPr1lMRr49E=; b=PFXqVoxS+NOl9bmIXYL3YIp2hY8Bjy5yDN2e7AC1jg
	r8i/Wj8J/qOLiN3StNd39ijLtyyDukVv86U1RplHd0TW1M+Zdkpz3NZd1wdYoYkg
	Ab0T5odyxBIPPPo+Gfp+hLqeRvvWluGZWKSPdlPZXBcQq1lhU4mNQ8Skv0YLMWKq
	xv1X20KCU3KM1J+K4iQSCU+iQ2ONlTN0HOk3Enq72FkrqHY5TDKl6oLbiumAkksX
	L/RQJI0R/QrkRzOljF5COvH/SOPTetdOovvi6sXTiPD3EjXFxisKgOB9h/hY3qcX
	+ntMji3V/MA33Ackbre4+AGuO1C2gylF+J6nzgVXobMA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fxyb9bkqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:00 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52ce64c41efso36521311cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371660; x=1786976460;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5w6GJ667Z7vMoCNVVHReYDBKGn+cpEFhQPr1lMRr49E=;
        b=qkwKOfEnfQjATQG4tNQuA+9AWsqrAUZ48eZTa6UZIE5AP34j8QMdhM0QPBSpqlJGHk
         Cx9AKPiUvdxu3OOMfNs1ioESIeQzlGF16xRj/pto4PdjJtAkSp98r16MyLfJHwZjZpM8
         2nqFR/ZvK/6kFWEQUjfM+MtRriMHSQwsq4a/NLvqurU708sw5WcjUWIrdHARXtLy77ho
         cs5u5wElO3ngXvJw2ncxetfaOM5mPEoQkPJC0bKgU5WtUdMTlo/d0/b6o5rxhyFAnAj1
         Tvfc9ko4PfRj4zk41f45k0r3tEdIXhm55+jf1R2qrr42heibY3gO03EQmD3cB8sTqDFP
         /nrQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfId5N2DjlNKMU77+7hfPK5CuIGzhFGfqFJH+dx/WaPc04a8uFGYHlSHhcqBmG0m9vJPoAYwZyoSNL5cxq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw477DbzAlAurYcpVsVCMpOYJD0QLTBlvVzVOMyeWrL1dlbYNvr
	VtUSupySP/SHYM9+2RGi9GnJNBqfTBRVgryQQmT6aLPQRYSvvOAsuvPaT+uHIuhcwGiRPWUKXp/
	XtwMVXMU9oM20LBfiwuNtJCC18r0xqDRO9Dgd7C/r/VvDFJ39tqkNs2OQkzgCM/Q=
X-Gm-Gg: AR+sD10g9sVEh+A5kIkc3bVr3Im4E3KtpH0KxKsUftFD/SpIswWCJOmofXNTSufmUWx
	gBAzBhbfxz0W8v+dbf0vQ2DgivxSZF3OvdjSChSSgz/oWmcaPvoD32tUDR5W3oo/YvE7LMqLYXU
	Qpr4JMfjHvnYbv6x62f3tg9u8KcsG/f1C35vgNI/k2gBHPM8V3l3IZmKGkxOkNnkMZG2JXsM1aQ
	wNcRrrF5UYJHYYk/qB1Xe51IvWy2GWLLKx3MLmnLaJXR9YiAPhb9mGhDeU2Cpf46vgjXqCoeyWf
	xOCMl3qNO2NruAeuT5XmgbACD/u3CMnoAefnzbMZ6JhPj+GuKMGxDkWnNVrhZ+t2qTAJMOeYrwo
	MYEk+uYNS
X-Received: by 2002:a05:622a:292:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-52d4bc69834mr23278731cf.22.1786371659568;
        Mon, 10 Aug 2026 07:20:59 -0700 (PDT)
X-Received: by 2002:a05:622a:292:b0:51b:f98f:ea5e with SMTP id d75a77b69052e-52d4bc69834mr23277461cf.22.1786371658878;
        Mon, 10 Aug 2026 07:20:58 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:20:57 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 00/12] ceph: convert writeback path to folios
Date: Mon, 10 Aug 2026 10:20:11 -0400
Message-Id: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABveeWoC/43OTQ6CMBQE4KuQrq0pBQpx5T2Mi/485KlQ0kLRE
 O5uwY1xo8tJJt/MTDw4BE8OyUwcBPRouxiyXUJ0I7sLUDQxE864YBXj1EFrA9BJ4kBtR3sZK5P
 DAZTUN1oB06oUwuS6JNHoHdT42PzT+Z39qK6ghxVdGw36wbrndiCka+/frZBSRoXOCiNUJk0mj
 trex1ah3IMZyToX+CeY/wJ5BKu0ZlIxUfAq/wKXZXkB6bzJcjABAAA=
X-Change-ID: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=3170;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ACXOp9y+JHYQJ0ReTJpnKp8/uZY8YUAMptYnBA8kvCo=;
 b=8yxS8/k/8Cj60JPuVMLbUBeRarDFhQ1QH80zzwBEKGFXjioIAwlZi8hiDozO/ZJoisfXCPyN8
 7RI3oF8PRwxDA1BkhE/62IJtccGWJ7YxQstqvtfv0K4kxK4IRrerTaI
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=QKxYgALL c=1 sm=1 tr=0 ts=6a79de4c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=K5e0w50Y35hYhEYsqgEA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: IQngvFgjiFKcBQi8SURQGIi7Efnt0H8f
X-Proofpoint-ORIG-GUID: IQngvFgjiFKcBQi8SURQGIi7Efnt0H8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXwr7b3rC8K9Dq
 XLaJi6pWLQXHvIl0GcqdsXwyLEbg8Xk0bBvOK54K9WajMgirmiuFth+2y2FDK8ep9eHC+AQDHzG
 I1Q/a1fPlraJd+gKQ8cQazgZzf7I0/zESmHrvnh5zj1Bw72Gxjy9OEAR6s+WgOUseE2JXKZmXii
 JnsPG9ELq5Td3Jq8yZR9UByAgN2mOfVf1Sg7iRtqoPlvHI4vP9npnOyA7FTPWbAU7rKdZnrTzHt
 RbWL0l4bFlr0tgX26SE9LNRX6rtXqLrAnZRiVsRKNtXc8sdAjMrwHczOp1lP5am5vobsPanA5b+
 Xdk1cfOK4PqFM1rhNOz7mw0OnC7TWzWNHRdcTFZWEAzGu1t1ktVTVTOvYplEJLoLkpEe45gffUn
 pN2E2LN4OhqUIOtWRZPto1GyGLLtWvI1fCv0KWq6lraM8qFTOg+tB+g9cqCh7oIv73zdaTd8H2d
 pRwktp+k2rnmt1tafLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX3LjFVsHeUVQq
 ULnLEgO42iBzYlOXvfHTMhM/B1pZmB9dPpTJ+4E5jQ4PHmTHZDExkYphaNayYa7aUHwQdoeZuW5
 zpwSpPsnyl5of+8LP3EoN7CypsHPI3gqAkmSXmvV0IBCnhFHiKlF
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=10
 clxscore=1015 impostorscore=10 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

Convert ceph's writeback path to work on folios. With these
conversions, remove three mm compatibility APIs whose last callers are
eliminated: wait_on_page_writeback(), thp_size(), and thp_order().

This also fixes a couple pre-existing issues discovered by Sashiko
along the way.

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
Changes in v3:
- Add patches 1 and 2, fixing a couple pre-existing bugs found by Sashiko
- Patch 7 (was patch 5): Rework the ceph_submit_write() error path
  conversion on top of patch 1
- Patch 10 (was patch 8): Remove the BUG_ON(), per Sashiko and Matthew
- Link to v2: https://lore.kernel.org/r/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu

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
Tal Zussman (12):
      ceph: fix error handling when the OSD client is stopping in ceph_submit_write()
      ceph: wait for pending fscache write in write_folio_nounlock()
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

 fs/ceph/addr.c          | 154 ++++++++++++++++++++++++++----------------------
 fs/ceph/crypto.h        |  12 ++--
 include/linux/mm.h      |  21 -------
 include/linux/pagemap.h |   1 -
 mm/folio-compat.c       |   6 --
 5 files changed, 90 insertions(+), 104 deletions(-)
---
base-commit: 30c0913a2b44a66dc17283a88489b3f3e12f4327
change-id: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

