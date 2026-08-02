Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304C33C3F48
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689622; cv=none; b=i3UX1BimZjUGjz3zKyZpq4kQWGRTQcTH/8pJ8K2lUeYfOEoC6p1yI2qrvQeWtpgd9xfKDz+33rD8B+cHjLolCVjDtJj+fzmhecDW7dQX1QcOIqFwpxKHOHAh9cuhiFOtuokKnw5VVE4+naZbTT/O8fDEb744OFDugEEOLk38PIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689622; c=relaxed/simple;
	bh=2VkgDhoLJZc2rtRUaEo1H+FE+H647yEoceZpR1wCk5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JF22TrDHCzHtuw4+2gx0Yfv8IjEK8epUnyecypc1bQ8rEtfw64ZVXzQJtCi/jZULQRBDxzWBMJ5Z3SWMNseW1O/Os8bCL4k0aH9pravi+ucSoh7hIe2I4dxU8H9rGC/26x3ZfjYrRxHOsgl1IEh8zXz4uZuxlLLIoOQevRRrtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZiAxOXOQ; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZiAxOXOQ"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Ge1Wl107519
	for <linux-fsdevel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=iXtH
	coi8cVlKLUHZRCUmBtHXjzieXyTC4IDYVelJs2g=; b=ZiAxOXOQ3C5l4e5uF4z6
	qf860eJMZ+uFHA/DGWEFHgkHs06bLW/WI9JvjPDgwqRmtv3akXM8M2t4dQ0d4sHZ
	LDwA9H8xKpBXfBZmHgdurZDBdVO9mZRSvjz14TBpcaPL7oUD/ZZ/Ha3YqSSCzk85
	HROLuAGoTH2MFGWls7o5GW6zZJossm0QmOkRvZxBjaQGrsgapg5dob+RAWPYjVKe
	I/DwPmS6nU2zRow2146FpSc0ywFMFlHtA1b+ZY8K3BzHzV+CVxDmUKbeipqony73
	tf33GiAkxC9ykvzGHcm/wbWM2UVmeXDSYhDgm5U9y9+QURrkhIJ0xuFI0v/nr32f
	rg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4ft9m1r18x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:39 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1eb52e1fso46526951cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689618; x=1786294418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXtHcoi8cVlKLUHZRCUmBtHXjzieXyTC4IDYVelJs2g=;
        b=DoCfuhu59HA1Elhncpr4t8i+Q5ECu7ZNZnmsbLBRreg2OkLf0VCCs0YjkLFn3VVm7W
         Q5DHraXORxfvC8oB7jA3hSBeYAPVcqpYoP65E1gFtzxDbSImzScGpEQff78DBxzrnJhF
         Mt7oszAqkpIgyAQrXOI6P8B2I24N+GMTtAc3lFiv87Xc6a87TfonXY+E3nWTRQhbFa7I
         mJVO70bgTEj5dQhzB179OtJYmpRoJt8aNUALXmSVbFrjLo+o/4nsVP6frC4jw+vcTj7Y
         6cMEsLqqt+4Ada0JxYp+ulznpP4L3oe6btWjmeKhF3m2ikM26YyyssunrRxXEszgNC9q
         c4qw==
X-Forwarded-Encrypted: i=1; AHgh+RpFwPpK/uxxrfi3UA01SVk/LE9+VhD0RB34kcqaNMUdlUinXXUtsnBIsWtWtd3EFpondFE4XnIirKaxpsCJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AKxT/9bEsk7jFQTJQ7xgU5hHjg4f787746bVlDOoCIngKKY3
	9GfJJnkFAL1uuYUG0rznT6fsQhXrADaA/iiFupgeWsJsckFUNBSdSWoBnTKxgjV1CJQXfSnuABr
	LSsN8mbyCYu03EKOlbjw68v6AY6njVETH9ob0T/kwUCjIstsX1+ORaMGcEN+oUSM=
X-Gm-Gg: AR+sD10E2ljyvsndhNEg6D3/QgrgnK/mvBpyzQXOMtC7H5T58asx6Hu9qAx/axglrlW
	IjxJz4TmoQVecX90rgG7qRyEyV/G5nbuhAh32uhZ+ycaoRDb3EqznVHWS/ciFtjVcazwT3dNYiC
	fOA1B9hyXHqOxl8/1YPl/F4BwlWf+Mo4j4FetEMo4BuGhf5g+2Jkilxdt93RVEO+7ruaqOMFPhA
	gQVJGhFVLL/udicOdBfWuMfEbzOlEOSJzRLhVj/z4DDKq6S3jwwZXcvOFNyJomwSD/gN7IrSKvP
	p70x0r30Ah1rrzmegpnykBoZhW7BtF6aWntDBX0W96mpwj8K0cBdF07D80FCSXxYyVSf9Yc33zK
	LolqBKO4qAzNnMMzUB5Xo+N3wzNnfuMnX5+EX5P9nB2FT5TCgS5M=
X-Received: by 2002:a05:622b:89:10b0:52b:6543:d8a with SMTP id d75a77b69052e-52b654316e8mr58751381cf.26.1785689618606;
        Sun, 02 Aug 2026 09:53:38 -0700 (PDT)
X-Received: by 2002:a05:622b:89:10b0:52b:6543:d8a with SMTP id d75a77b69052e-52b654316e8mr58751081cf.26.1785689618191;
        Sun, 02 Aug 2026 09:53:38 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:37 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 12:50:04 -0400
Subject: [PATCH 3/4] mm: remove wait_on_page_writeback()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-remove-wait-on-page-writeback-v1-3-6c35d6b3ad36@columbia.edu>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1337;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=2VkgDhoLJZc2rtRUaEo1H+FE+H647yEoceZpR1wCk5A=;
 b=7I8Fp8rUC2g3MzaZ+Eu5F/2t4vVqj+514clw9LyKXp/jE+0VmFnNxeE1hGpUOS8CgVyOCh1FG
 mTjLIEvkVwqBiGVtq5g14hyqpkS2MRwjm6LTEH52tIQWJPW6dN55Ram
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX1ULi6ig1Qr/r
 XA3/Hj74KpbIQ7pwn1k2z/sWNDMcmQFl/2x9WulGYjDR/+UdXm0hoOcnuHxCY1gBCyAS+phr8NX
 fYkPMT5orsOL5SGAjCPbRO4wRU7cSpTiUYwcofhETc9OB0bCnU7E
X-Proofpoint-ORIG-GUID: OrnF_ihXCgpOoiaCCkgVL7PsgVee3sBI
X-Proofpoint-GUID: OrnF_ihXCgpOoiaCCkgVL7PsgVee3sBI
X-Authority-Analysis: v=2.4 cv=FdsHAp+6 c=1 sm=1 tr=0 ts=6a6f7613 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=mRZAEA7ckj0XMcVDBXoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfXx2k7Wb2wDrn7
 JgVKPRzAjZEEKuJ/nUO8HeVXaV3KQcTMdVBsoQsKZemzZRyAuFDnkYijPm7XO+n43ZjR0yum4j1
 e89qzEOdNy8mbbpWzJ6HrVDVWMUjZTo8pXi0PMu2vL8o8KC8yMt+Y2ROfxI3oBlP0rLuGry4r85
 MKHfyQO2mbLkREZ+sNmeuXVnYCFT8YHAzqTAzURxbjMysoShN+hAZwqNItqL+1AmYQd+99ByHud
 FDaBKWqidlc/nv4BGFcP4pyjdhh4q656VNApDbr5rAySsNbjNu/bUqVafNmwXOziujqGILNL4RX
 ZOP72dq7kCxd/PnZo2YOohi266WwBojfiuj8MXDDyin1PhezCWf9e2ct0YClpF2mODmbciPJRHS
 PAV43TOwQYHwEtpvEXFZdS+UHj6kQH87ym/H70Nl0HhFOaG8SJRpjp00a5spfmj+GNTKMtPTo7f
 /a4dgC8tkwDhpI7Zkxg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 spamscore=0 adultscore=0 bulkscore=10
 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

The last caller was converted to folio_wait_writeback(), so drop the
wait_on_page_writeback() compatibility wrapper and its declaration.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4e8b2b29f6d3..c8666fd14d3d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1335,7 +1335,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 }
 
 void folio_end_read(struct folio *folio, bool success);
-void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a02179a0bded..ae0271591d37 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -23,12 +23,6 @@ void end_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL(end_page_writeback);
 
-void wait_on_page_writeback(struct page *page)
-{
-	return folio_wait_writeback(page_folio(page));
-}
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
-
 void mark_page_accessed(struct page *page)
 {
 	folio_mark_accessed(page_folio(page));

-- 
2.39.5

