Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531FB39E184
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994126; cv=none; b=pdPBJPvclnyISe2oXt0nPljuOneaVNxwOQ2INEcyEEszLofuFCD7EAC5b0NN0mKCwkBK/bCvGHM3zicDZBSgooPdPeidUWXgOzbcnpq1nx7aAFdQhmvvd0VOo9Kb1xeKAmH52c7+Q04P23lHjXkysca3xPNB1dK7iBzCCMxkdEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994126; c=relaxed/simple;
	bh=qVTLNDcbt+fJaFQvv2N1X2GXRE68u458QdYuIn9iM4c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U7A8jKx8P/qjXKoeKWCYuU6r22Zx2W9oKLsc4ZgAHPssWwKr6wHKfcsZrYQhQRZeJoEXzfDK5uslQB0ovONn34UWBv5Hgz3QkyrNKGcYHUnRk6rOGFdx4oeT2E3pf3DQF4a31nk/YfPYAqvhmadVoNtrhipwdY2Y842FzJh/aHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cgEgAngC; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HAjkOu/Q; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cgEgAngC";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HAjkOu/Q"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIvptd3767471
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=uByW3kj0cNB59zzwcHQzAIcpQ5
	hlDdKKnX/d3JEUaiU=; b=cgEgAngC1RHM+L8E6tBdYeQb9iqkzadtLVuGO7mbO9
	dilB7H3YOGvtt2vHYykmsGIODc1BHasv+wdsMlwcbS0ndqFt5g0i2bsISQifFRRO
	AvN5cQ74rdLiu2fUcZqjlirXZLEcST2aP7hNlyPjUxI9sAE/rQM/NZydkpRTzuXk
	1jYW23Pd3Sd2P7p4MUCh6iVRpXjkrAp4rMSHJTvMC07sc4g6b/gGt2i9EXmc5L9h
	+K2uDiT4VkY82cIdvKXvmBdCBcxvXs7vX1HkdMf11l9sqOKM2Z6sVt1zK8gQ1Ygc
	uJOo8waAMjVBMOMjpZVQOu2B0ZgOoM8YBnqxD74rd1IQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r85c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:18 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936cadb0e8bso321286185a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994118; x=1787598918; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uByW3kj0cNB59zzwcHQzAIcpQ5hlDdKKnX/d3JEUaiU=;
        b=HAjkOu/QbFK7hEg3KyzRM09E9sfFkqK6OwFF/TAc+iRR6KuyFls+SgeukC0Dm8CaCN
         F71STbvOs4wEuoOxoj2/9yvcyJ85/dSK22hhp97+mAVXw/IE/X1T96N+JT4Cvyoy+SXk
         vOl1Ms3VJAWbOoksddhZFXe9Yn6ZXdYkiARUbaRtx2GRSkhTZOBtWYzpuzMGwWVtITiK
         +/V6gzgBn8N5S8rl2C/K2hEZGsUQaMlxa2sDWPXfKRV3jk8+CyVmUzbBum+CrDpepAUG
         9QQYoyfKQ/Tyz4wSFzmvmyJVkQNlwlBfqGFu5csGCSGtbk2+F7bkf13Ui7b9CoNBpkwk
         MUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994118; x=1787598918;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uByW3kj0cNB59zzwcHQzAIcpQ5hlDdKKnX/d3JEUaiU=;
        b=BFC4fCeL2XHND9TEnuSbGdQQ9PxE9c4EnUh78563WKb4ftRcvYNQwgA27bXZESRG8K
         tx2ztvIplldeR+W0qcFM0U8iFddswq1i+pNSObnK0/BPZeIqqSiN09uIU+vgz29Kpl43
         OWvJqjLJsPmQcwbGm06iCyoC2uRzgvvj7lYFp3mqcVNFsR/Q6IzYAcwO6aDnJu0NkCVG
         +roNAo7UDUtg95jvZ2Kodp1gnVx6qCWiQwBb4pzvzbi0JoOu1tm+5h4EpMrEG+r4ZHs/
         rsgsFeffUBWcYX3uq9QgZFOk7QmzuiGCVskdj/uVqK2ga4/GA0P7/BUdW7AzfgISzeex
         DEPg==
X-Forwarded-Encrypted: i=1; AHgh+Rr70+oBlYSwUAsA5AD11qPqq1oBn9MCoXm3NTeGpBBtOp7QkCT9QWRdkuHW9yugcQ0WtIJ6uZLsR7ym7zF+@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ463bs7kOhmaUpOg7wJ1cjS1egGdpK5kTYAMoGGYAS2/w4yD4
	nBMBYOnVELSFeE9u+VFgCilgUOLe8rtXfFLRdV+7EEpa33CsZSDO8HuCdQ/DQZ0tzo64eyPCc6h
	jPfH+0ODykKh1sPPoipAVXxljyOdALIpEx8mRir7coYXpkbt77jdrKSib8CxMuo4=
X-Gm-Gg: AR+sD12095f6r36JqBdh85AYZuWuEXPRyE4HT681XMSrfVrEd0Ww2UdaHRQaFLgFq9x
	Ozlryx2ZjCTpdeMw7PBYJmkgVzfeupRGdMYb9PXGIJ4Vk5OQ/+/I0rnFP14h5WS1WVjQwGp/oJ+
	dxYlbF4cl14Stvud8KraG9TqaA6cPnAkRYIflrHTIIj9cqXQru7JJYFeJRfr0DqPzvnxRfsdLeZ
	XQQeDj65wDuslwI6fgrTaWiuC0ZH/5L2B5no8jX6pSo3x49t7tjfaj7v5roBL4PwEQmaKBzcb1m
	PsoEkLKhNaucIJ7gNYtyvAQ4XY5wRoCqy0zby4Z1ac8E/LF4fNsOdBK8kQZKePGVghvhN5lSrZG
	prWo4idxR
X-Received: by 2002:a05:620a:aa08:b0:92e:db1f:185c with SMTP id af79cd13be357-936d2355b08mr2578315785a.43.1786994115618;
        Mon, 17 Aug 2026 12:15:15 -0700 (PDT)
X-Received: by 2002:a05:620a:aa08:b0:92e:db1f:185c with SMTP id af79cd13be357-936d2355b08mr2578304685a.43.1786994114838;
        Mon, 17 Aug 2026 12:15:14 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:13 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v4 00/10] ceph: convert writeback path to folios
Date: Mon, 17 Aug 2026 14:55:16 -0400
Message-Id: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABRZg2oC/43Oy27CMBQE0F9BXuPq+hEnYsV/IBZ+3MAtECM7M
 a1Q/r0O3aAKiS5HGp2ZO8uYCDPbrO4sYaFMcahBr1fMH+1wQE6hZiZBGuhA8oSXWJDfLI08Dvx
 qa+WWaERn/Yl3CN61xgTtW1aNa8Kevh7+bv+b8+Q+0Y8LujSOlMeYvh8Hilh6/90qggM3XjXBO
 GWDMlsfz9PFkf3AMLFlrshnUL8DZQU70YN1YBrZ6RegegIFvANVBUNoGyVa0L38+3Ce5x9vt6w
 kgQEAAA==
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
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=3475;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=qVTLNDcbt+fJaFQvv2N1X2GXRE68u458QdYuIn9iM4c=;
 b=YF0CAtusldpvdNFh8yT893tshJfP33e71vJS/zp9Vyv5PiufZBdZxAi16AvQVuq0GUUWC20VS
 /B4v9H2a8PNB9uBQuLwzJLJsesUtNCcC4r5QOysYJvEWLuOWP5opkIY
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX7yUbFcACNXMO
 azmknqDdDgpdhOIlADqvysBR7TJMtyN33rdNqmf53Kj4SpLipJS3aUC0TKqRig8Rfvu/lIPBuhT
 Zh+zxf39twILJViRjgzvsyhSWpu+8RSvK2da7vwnO4s5VwrO1blblvCboHPTEZ/uoRhs6IZEJqy
 XmbJqMtJfa3zcNMy23jkRGOz7W9cgXoMfgU17fYVcgyVdylw9spuJUuaay8I4nWSPhQLFRMX8fb
 f/3Bedhy3ciNLKKIVpWA5jgiqM8abiyXzsOHMb2bmlfOZz5spdNYIZM1+/bdiNelyjWShgif7H1
 bLzrnTYhY8SYplY0vI2qoXjSsTWIB0ZASnfga7/gNfCO05G60peGuWzWnDO2242uSn7s1GxTr8Z
 +gL1hLGSEaCyfRqooom7SD9NebXL22pPxjIwk4z8Heyn2QnTWigMr5eKpAKQz5I9cj3kdnZdwHx
 RHV8iiGzpBdhE3us1vg==
X-Authority-Analysis: v=2.4 cv=PKw/P/qC c=1 sm=1 tr=0 ts=6a835dc6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=K5e0w50Y35hYhEYsqgEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VAx3Hep9Abczrz9RtTNKNWs8zciE4W_k
X-Proofpoint-GUID: VAx3Hep9Abczrz9RtTNKNWs8zciE4W_k
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX6dBJ+BqSB3Yi
 FZolSuEk84QQet2wZ7FrDrrru3oeTVCdWxtwkcGyEK1jNAfBJiCN1eXminu08xDfmN0TX1OhBCt
 nXxOPJN0PRQD1HsVA588XoAqQVOgb635zJKV8Q06JEvASLhs7aWM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=10 lowpriorityscore=10 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

Convert ceph's writeback path to work on folios. These conversions
eliminate the last callers of three mm compatibility APIs:
wait_on_page_writeback(), thp_size(), and thp_order(). Their removals
will be sent separately once the conversions land, per Ceph maintainer
request.

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
Changes in v4:
- Rebase onto the current ceph-client testing branch
- Drop the two mm patches removing wait_on_page_writeback(), thp_size(),
  and thp_order(), per Alex
- Patch 2: wait for the pending fscache write before bumping the
  writeback congestion count and allocating the OSD request, per
  Sashiko
- Link to v3: https://lore.kernel.org/r/20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu

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
Tal Zussman (10):
      ceph: fix error handling when the OSD client is stopping in ceph_submit_write()
      ceph: wait for pending fscache write in write_folio_nounlock()
      ceph: add ceph_folio_snap_context()
      ceph: convert ceph_wait_until_current_writes_complete() to folios
      ceph: convert get_writepages_data_length() to folios
      ceph: convert ceph_submit_write() to folios
      ceph: remove page remnants from write_folio_nounlock()
      ceph: convert page cleanup loop in writepages_finish() to folios
      ceph: remove ceph_fscrypt_pagecache_page() and ceph_fscrypt_page_offset()
      ceph: rename ceph_check_page_before_write() to ceph_check_folio_before_write()

 fs/ceph/addr.c   | 156 ++++++++++++++++++++++++++++++-------------------------
 fs/ceph/crypto.h |  12 ++---
 2 files changed, 91 insertions(+), 77 deletions(-)
---
base-commit: fce4f3da41f1145cfa400002ce3a66e4a89a1902
change-id: 20260802-remove-wait-on-page-writeback-8e0cb766d4c7

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

