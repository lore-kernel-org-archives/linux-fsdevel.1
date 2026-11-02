Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660070;
	b=AvzDBv0qSDFwVmiOfThZBPoatl1/9n6DgcO7YxTP2vSvyKyGlBocXVQhn99NmSwLLdlC
	 L0bTm3wEqO5r3E8ORB7OMCuB8dQimUBEqJPYj11pROD8BFTswe3lqnuFnk8T2csyKoeaJ
	 +QMOAKmUXQHUG/OyKs2iOn0/NqmeKGQ2caN0vrfIdcHIyvM5iWLNagCz79v9bdkxmOSp/
	 WOYOLE6SPKA/k+Rov60EluHUvIUXEiDEEupZAWr3wlgD+04+p/Oo3ITeA2VQoPeg6CodW
	 x3rBEvGAU4ySlcKuprdvY4Q/zKiPmitJ1Hv+PEPs1+icfpkiuoioAauMmoPMfkBf48A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660070;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=bU2XFm23aghLbqwHqLXCouxIYI+ao2+a5o4nlmtbCMg=;
	b=4jCT3JP0nPKB1oGuoAMHDaEJeGOA3Y4GfJfkmupi5h0hWIbrwUx9jH1W8pJXNyHDvTi7
	 0fgthQ2n5OVj6DvTKHlkUrEl51EKSWAI6Pr+66U6W1mNbZH3aWoO4Hm2MhNZegv5oACKi
	 akJBlLMeMDm86qbrSIbcAQQtw02kqbzaQ3g59C4t2j9RJc4lASB9FcY+BGETNiLysKfv8
	 qd9AZBvN/OFupnd7rxz12aJ94H4NLrcutPQPtZ4OiNxr6gU00iHghONP1q5STB13kx2lf
	 0ejp8qVvrTigp7R6zp9Rd0GdIcFBSfp7zFd8s5mS+ko0uRx1weuFZsnBtJ5+q0fyi3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=sbg+U1tM;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=OvxmAqms;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B277606D80B
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B277606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=sbg+U1tM;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=OvxmAqms
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2LY78u3120324
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=bU2X
	Fm23aghLbqwHqLXCouxIYI+ao2+a5o4nlmtbCMg=; b=sbg+U1tMRGIzFD+PPuuM
	OGezq8RDKoBsN4FIxGeLbiBAeILuemr+cgQO9sbcuBgcOn/tx+xohj9X/ZEgODIW
	FF9Bkk6GjpnxmETgYMzmh38jU3YbA1tm62tuzxfaqRKaXHxjycSVdk45YdtEd47t
	Rt8MUkaxsFVn8YD68O+4HKyXy709qz4tWDmrNqgrwzYDwlu3NPE4DDW+NhLYtzCj
	RyGs40whGaNIM4k+4yttVVFgwa3K7qjPARlwvQfVrZ4MWR5wPeVe0PaJyJhefG+1
	0Eoe6EUvhIVe1PP9x4HUr3VRwKOCwJ/Ipzw9IyB3uvTZyJUEQ0XnNJJ1/XZAsrcs
	3A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hq1ufh7km-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:23 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so29342585a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660063; x=1794264863; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bU2XFm23aghLbqwHqLXCouxIYI+ao2+a5o4nlmtbCMg=;
        b=OvxmAqms0HEsXWndA6dX419U69IDpGu4J9q/H8YRkvV9z6zLEaqQtbMTPyrc3w6dWc
         tcADNKjBXru1640WFFbkEdmk6pdtrflSdmdkWxul77z+8Cb+RRWIObLypJddzA5YkE+9
         5VeBzQ7P50KF4iwdNCaCPA6vqRhXMJ1EA4cF+5NXxEtRUw/J7skl2+IYFbfNCgBGixCj
         rRJxuPdqTE2LdTMeMOxVg4wmvdojXODIMia/ArY+h88V4TiBmj42aXx0R0rQP69AJxD+
         lLmbImtj+Wdt4xdRhbldOjirLOR3crPYKgQs1H4YOI3ZxZXFaqZj01a30mYAo4s0qYUL
         p0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660063; x=1794264863;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bU2XFm23aghLbqwHqLXCouxIYI+ao2+a5o4nlmtbCMg=;
        b=A3fB5gaKxfXrqI23fXq2rLt6IwfMsVzK02UtdMpIsyktUkSgOPR7tHIwFckO+ZLlQ0
         LRjVlsA67G77b2D6KN/M1Ww/A4Go+qFQSHQHQDIuki6jMBPSjJJs+YVZUKTZGeiMyVg9
         sCP2atcLrQ1wsC2+mjXDwZ+OVy0m2vtxBCZfheyVn64D3pHOTi+mEtw3dByPlcU1k/rp
         U4aMxFIcMrUbaP0VyPbTv4vGeC7gAmEauEsSscdSLUA17uEnDdFVX+PX155T7R7T3Rht
         +NMEeqMDKECOQgKu46I3ZEIlCBRn56BSXdPUxJavQgMmH0LzkODzNxp28Y3qU7ICHPXp
         a/hw==
X-Gm-Message-State: AFq9FYIcnVGGvDBAmWh5fc7uVZZO8c/jANrdNy/iVMqWYnkfLY3sPM3z
	htvFy/CMJLHwEu5pdrBnBjr2/6GyrdA7ck2fp8envkY3PJbuKVKInFNU/R8+6V+LbD6ZjVjngt0
	CcH4kyVmW8j4zsOC+IYuKVGQ9W7jSWMHfCySBwtSq3UkuSKd/p0hgpvrYUI+4jUc=
X-Gm-Gg: AYBFou0WqHm7k+BBzii3fmOVdMEfSKEUOv3bzeEk4xVKIHI0I2OQ/m2y9QxQzu6zi93
	XkF5GhEETRFh0XWDDenMGnQ0Vxk2+pX6OHZD/f3AdCvltyv4x2jqsvfJUgssQK6sDWvUyk5b6A4
	v+jKY9i8Nz5XtP5dX9k5e4d9F4qoFpawxrsnCEAmiLlc7Xj84htDk0Ds3igxYqfSaGILNE262q+
	bykzHR/hNarDj8I3O/JgQMfPtfePV6kM+PwH4mCFfkrV5kKRuHpaZuPCqNpUlJqvmoYR6IKvh7j
	8WiAXZRO6lyKRBVtaoATXmgo0NfCa10AsLDw7Xnpl4zZSiVK12DLS6jln+kGf0hoamtOcxqHm86
	eaoWTgwmDPHZsTQ0UvopKlHb9a5CkgI9sx1Hi4Om80a9lIhyUnbM4LjWmMws=
X-Received: by 2002:a05:620a:1999:b0:93c:891b:90f1 with SMTP id af79cd13be357-944133ab8aemr2271862885a.26.1793660062915;
        Mon, 02 Nov 2026 14:54:22 -0800 (PST)
X-Received: by 2002:a05:620a:1999:b0:93c:891b:90f1 with SMTP id af79cd13be357-944133ab8aemr2271857885a.26.1793660062282;
        Mon, 02 Nov 2026 14:54:22 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:20 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 02 Nov 2026 17:54:06 -0500
Subject: [PATCH 1/8] mm: remove wait_on_page_writeback()
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
Message-Id: <20261102-page-wrappers-v1-1-e7280bdb31f6@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=1451;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=gOLWNH447008iOY03NZfVDOyDl5wENU6OW/hcTn46/0=;
 b=ubR53IdS4LeN2JRHf1bqY+gdeUIINZD96UWzXfpEu/YVk0R3s0D/8/roJ94WX5WGhqQg6/wf7
 mgpO8imxEYFDsxHSpicb09cc+tN1HuSSr2enwKNVHbZQSEIEpgUcfAv
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX/kmZEWmkYjqB
 rIx7IxMOQINFJH+ehCbUXs7i5rt+Jhj+EGX9G8L+3vMZI4JVUaXEihHvNCDPSbkFaJKRslKdu5n
 LzGyPqYGRW4JhzNQCOIh6LDk2It8TpWHE1ltSfoFE5FXAq7+r052TelUxXLroBWRn1mXaWc6zfn
 UGBseg40Q5Nm1TV57dySZ9cSF87kTHQk6eF5S8tBoIOzr4HU7MdM9D8WmaHS9SeN2uGcl2Zta01
 uZETsKYXJknU6ccRFVy8r+8KcqkhzZIGo5UYv4V82IsKB7Qh0MQrgyPWlSlfOP00W55DlkeBucV
 TgfJ0Zd+vq7/TilC+2R0wYhUKtn/cXQ3Uk2e6gOpK8x3b0T8gMu6n0ERRJ02tk34RTkTdDOHcf0
 S/wqUt+y3nJSAFzouGE0yBDMAI7cgSS45Y63/Poy6mrSKOkHbta5HO2lv2CDgsbEwqEb6eLMBUb
 kc3rHhbEFyn2FAanvlw==
X-Proofpoint-ORIG-GUID: gM1YunWxrrA_z6Qwr2YD7CxqrrCjJHId
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX1dC4Jq1X9JBj
 YDLnaRn/BLMcOXgU+ZNzkIJ3KBHGSgJiRKoGeVeFR96tD1hJ6/TsAe2kxJwoUvzZUOU30Q4mz1Q
 jDmlf2PuZenZJyO21HZd8urTXNIVWa7qP9A4LC+qyS6X1Hd0hrwX
X-Proofpoint-GUID: gM1YunWxrrA_z6Qwr2YD7CxqrrCjJHId
X-Authority-Analysis: v=2.4 cv=SKfXx+vH c=1 sm=1 tr=0 ts=6ae9149f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=qBqFc3eaEPVjc8k8qNUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=10 spamscore=0
 phishscore=0 suspectscore=0 bulkscore=10 lowpriorityscore=10 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020090

The last caller was converted to folio_wait_writeback(), so drop the
wait_on_page_writeback() compatibility wrapper and its declaration.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 73af18a37367..c0f7c06dc6fd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1299,7 +1299,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 }
 
 void folio_end_read(struct folio *folio, bool success);
-void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 6212fdd6761a..f880110ac980 100644
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

