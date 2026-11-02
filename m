Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660069;
	b=dqVrs1v3ir9wSNHoO1K5z+JpRON56LU20ZPQjW6l+DPIEP7I3slNwbiQeaDg5PfJexeK
	 iXReVKePSWSChhC2FIo8QLacGJ/cQK1jALPe2/MXhoj2p7zjpMv+Qys9qrQPWICr5fuXC
	 Bb5amERbPa3ozDmYDwKpGtPMvIXWVwpydfZ9ClkzyxWh4RAdN+k+eHz0VWSrNOwdjvk/V
	 bdjG0SPimvQTzzFN7jrY3ZuH4IDLB8+iqCXQWPxnKkSQXCBTLLWwMnZDuW4gCMntMwxyd
	 f7CrCiiqSHWqfM+rxCMGmdaw2OOAUot4hBb7tsyHy1nBaG6gbBjW2G53FmMT/QHdNwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660069;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QB+Kodww0YjbqkDlDn8auNZEe9KRZmhyQt/bq3VTDUw=;
	b=kBja1Vd2VlVa91YiSzHhcTZz/1e+zAPEs8PX0nW1sfrhcYMmjqxiocHvGM2lgE+4TjMr
	 sYuffw3YJP2QhOR6F/8dGxcxCHOYcflJdhvYjvWuCf6ntQxtRcGEnn+8Xlv9ILbqLS5M+
	 9RKkiWKXYvkL8lZkPEWu9zejS3yzn3mj088/vlXAbzFvr1cFcOxgDq+MT2tDceAiVRZJN
	 1WZBZOeJVYPiDN4F+LCX7aMtdSEvUte8I53wiPHkPsS+s3V3Kmrhoco8SRAmVhL8OBv+c
	 x7PkitNxXu2gDFkU1ZKIL2NTYsi0kdH5fygT6OlbE24CRCJHnwm+wGwisrcUU6Ti3vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=UP8T8JT4;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ffMKOr8a;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309E606D80E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E309E606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=UP8T8JT4;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=ffMKOr8a
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2LY8qx3941418
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=QB+K
	odww0YjbqkDlDn8auNZEe9KRZmhyQt/bq3VTDUw=; b=UP8T8JT4XhH3B3sSFq+4
	S4d33LXKxSWafg7fr9TJab9HY4RmGgw05xsWTPtVL0/Oj/7IPg1vPUzPNT1AxWTG
	gowuNIsMzJ++Bc/463BsrIQAU9Yiy8fjJyAxclZot6aKWaBilVnZcFqFKUsCsUrk
	Cg3Bdr109dijpn1mAOjZ64MgjnPJ+YteMoyAdlXDa9bSUG3dbRQ0pS8W4RfxDsyL
	7/SpTEkKJnrhtY18YtsN9hTYdsrJSqjXnGUBSJY5Un5Zx8oLcB1Au/HEd3XqsTCa
	Nq3QH05Qh1dWsWPyWVDLih82j9abAz/iXHzQKJw0snjkaZO0qchigu5Nu7GGZ9+B
	Yg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4hptgqdryc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:28 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb93c874bso26549585a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660067; x=1794264867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QB+Kodww0YjbqkDlDn8auNZEe9KRZmhyQt/bq3VTDUw=;
        b=ffMKOr8apdOhCvEkTqGjlt0/fT8HrVe2kFegT+v7GumPt7vHAbSDXbLUKzE09ThsWQ
         df9q7OnE1W3wWIl2sd3w1NS+9r2BPrVSH1OVw7x08SLC3VAfm0QiOGUnGXJ9kwhSFVcJ
         Nr1Zb0LEfkgIxKzi0N0Wv2myYf70c8ZMtw2GbjXWXQiB537Y7rmKYoaKSURKX+DE8tki
         G4ffxworc++BbLh8aytM4dFrL3UYlxgWChVfjOb9SK/7IuOOyreC752W4qmf8kdX7dan
         bryyzEUZmoPeDK6iKWm6wwh6wid1F5QOv/56pWxoJG5Fc5mGzgjJ8EGEFp1tWW5SLQ2i
         GVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660067; x=1794264867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QB+Kodww0YjbqkDlDn8auNZEe9KRZmhyQt/bq3VTDUw=;
        b=Bw2M9JzMxNZmTOzAJ/OkaogYTnO8NgQWjNRpQXnNysM1GF33Rra5dy+3lsvz25tOIL
         LssJ/uoGaspCCgkhtixmvAXmnCiydOWmMkvRCxyOYPohyMNAwwIgS6ecqlrhfKdMEtr/
         6TuZU41r2WYCqoZVQ33UQf91I3M0McPVnGVfJrcmEWM3AdPzVtQ7dXJm/qdTThuG1Moh
         s9FzBhP3OuelEXXnBU2e+6qsphLR9IxCJVlZBVJpBnNzoI5R+R62KfbJ8GdB7Ow3u7by
         gNF2U/LJGS3qn/MXqYx0fbirzCsgZOtIvEEoMNP1rdA6+EVhKFc/PTKYIuZSng6pl6Ep
         pLMQ==
X-Gm-Message-State: AFq9FYIsc6UhzJZQ91qua4FX3DnqsTK3R4pVbutpXV5j7y7f82VS8gEA
	y02sOfV3SVcXG7OGwliDRI0d4Edm60sR6aaAThoxCYSGWBoZyyQhKQzwUFD+e++HxaKnWVSdlxz
	jKWlzlKpfNk1wrb+LxEenrVlBcvNG3o4Lu3wkmecGYcl6qK96Efij9vFJrlXwwVE=
X-Gm-Gg: AYBFou3UM86yLdqnVzAmsGL4S3Au7QBGM/A5NpLXWm/Lhw8fxGBxc2QSAfrh8ijEZIC
	tb2JO5lyTt27DiZB2h/Y5XkmwCKyInrWubMJXsMGpI1kzsZLsHYNIMtHExDdrfcqf1ONdn+DtRq
	NFMuCfbI1FiJC3r+ExOGa+IR410clY9kH7whjPl6PEbsD20zXgVmILHZa0vPp7bTZTMHbIil7AQ
	zhzI6r1p9pFBDC0YAngAmyY5bWc5WB/rAxPskxCAFaTFFV+KIRA68diJmTTfnROt1RQKcKnT1ZJ
	wl+gmgtKsVv10QOHgpus25xIReXHQvaSCAAC7ondneKZAtOXNXZh39IguSHTIwE+lTQaacPIJLG
	oCuoJrm0UbuRRawIXXHvtM/QEtJaOqGpVU/CEz5uuZyLxhrRSxCa5aOVwJIQ=
X-Received: by 2002:a05:620a:2696:b0:93c:65e3:df81 with SMTP id af79cd13be357-9441335ea19mr2262639785a.13.1793660066863;
        Mon, 02 Nov 2026 14:54:26 -0800 (PST)
X-Received: by 2002:a05:620a:2696:b0:93c:65e3:df81 with SMTP id af79cd13be357-9441335ea19mr2262636285a.13.1793660066393;
        Mon, 02 Nov 2026 14:54:26 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:24 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 02 Nov 2026 17:54:07 -0500
Subject: [PATCH 2/8] mm: remove end_page_writeback()
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
Message-Id: <20261102-page-wrappers-v1-2-e7280bdb31f6@columbia.edu>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=2548;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=WI+DTq2D7/P9pyV6U4b9t4H3I0UxHbIun2IjS1qcWJ4=;
 b=+gkUHqILM6e53SAF7LH4ave7gB3KDeZbj+/L3ZVPpR7W3XY5YPpd8ejGvm6Y8Kug5izztbeU2
 Kx2Td9t8LjDBADg74xb1FJwpNiM6tOe5WEBZ8mTh85PLkgrh/HiAcjn
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: BKsjj-kYduxHo2B_IZqwQronpAlRmYj9
X-Authority-Analysis: v=2.4 cv=B+osQ+tM c=1 sm=1 tr=0 ts=6ae914a4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=K3LvcDGZF8AM--xSYNkA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX9LLrh1LFpj6e
 rDjyHjkLclC/LwsFxpmihUbrKsNiwpZSlIU/AAI1aQQfcPLjL8fIIrUKBPySV038x6AfQMrdb42
 TwJfQIfElKJF0qwz/mWxzuWdnp+PL+pcSqh/NsWKbXDx+g6S3M9L
X-Proofpoint-GUID: BKsjj-kYduxHo2B_IZqwQronpAlRmYj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX4s0mVIgOFeTP
 9lTUDWrkbEvIIXTRYc0D4RqP/YiHBX/97aUH2GEOarT3AgV7KGJHJB/e6TbG/rGT3Jki+rU35zd
 6gQs5In94H6ShCJcEqucZ83iKoV4wCfBMp0cJOsJHKuKxWy5SO/BDrQqPk+9dqi/ftpff2AyIs/
 RrWiq1i9E02DOZ70apmPi4cZ0ulQdkp3QiF/4P+Mc02Bl9M9w02zxoINtjiFC/OqpsUTVBoC5P8
 qu7XrXiWwHxuIa7+wKph1GJYpNJ5yOyYMeS9v6Qb7iPjC22UxNeNlgVAmxmqO50vXfq5XfwtMEd
 hN1rbTFds1mgextw3nIyETppFR0yZ+BUB5T6JfvsI2l26FpLly9IEEWWbbcFjAZ/zOp3lmg8aG9
 gXKSL7syQEmcS+DALimGusUGdxHU9XuMy4724HnB3TKG3/LTi8G8OseiCDUqRpc4Gok3qxf4YNl
 X+44m+LW/uiHhE55voA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 clxscore=1015 adultscore=0 lowpriorityscore=10 impostorscore=10
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020090

There are no callers left. Update the two comments that still named
it to refer to folio_end_writeback().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h   | 1 -
 include/linux/writeback.h | 2 +-
 mm/folio-compat.c         | 6 ------
 mm/migrate.c              | 2 +-
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index c0f7c06dc6fd..692ce3867a1d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1301,7 +1301,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 void folio_end_read(struct folio *folio, bool success);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
-void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void folio_end_writeback_no_dropbehind(struct folio *folio);
 void folio_end_dropbehind(struct folio *folio);
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index b749a9a5a5ee..c50f404141b0 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -124,7 +124,7 @@ struct wb_domain {
 	 * writeout speed.
 	 *
 	 * We do this by keeping a floating proportion between BDIs, based
-	 * on page writeback completions [end_page_writeback()]. Those
+	 * on page writeback completions [folio_end_writeback()]. Those
 	 * devices that write out pages fastest will get the larger share,
 	 * while the slower will get a smaller share.
 	 *
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index f880110ac980..9f2cd0ebfbbd 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -17,12 +17,6 @@ void unlock_page(struct page *page)
 }
 EXPORT_SYMBOL(unlock_page);
 
-void end_page_writeback(struct page *page)
-{
-	return folio_end_writeback(page_folio(page));
-}
-EXPORT_SYMBOL(end_page_writeback);
-
 void mark_page_accessed(struct page *page)
 {
 	folio_mark_accessed(page_folio(page));
diff --git a/mm/migrate.c b/mm/migrate.c
index 94e8cd46c6db..953af633ec0d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -859,7 +859,7 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 
 	/*
 	 * PG_readahead shares the same bit with PG_reclaim.  The above
-	 * end_page_writeback() may clear PG_readahead mistakenly, so set the
+	 * folio_end_writeback() may clear PG_readahead mistakenly, so set the
 	 * bit after that.
 	 */
 	if (folio_test_readahead(folio))

-- 
2.39.5

