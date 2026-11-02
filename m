Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660085;
	b=3KBJlf4xCmllrYD1bW+37RIYQbRGtbiZEHVqCB1VHj7dCDrfGuZLEqOHwpfuZvI+w2im
	 dqRrVl08AVFI/eqN/XIAtrOlSr04+wo/CFjHpxyd5yZUY/MVbfM+nodEM1SR+9ysgirOe
	 ZWCba2Ny/O/knkB2sVk/tNlo+flXufXQBETq1lG+a9M4m+pqB4lI1Uy2jpY+T226CcCm1
	 0yIKoTpag+xhMoNcZz1hhiByUkF/U0LM3XuC8EVhQ9as8a9S377LPLjN/grJO2OmTJrXQ
	 E0R9RTqyxGKm3NM6XI4Y3Z158rmLDLWoRDX27pkL1clgaZlJXgPjcgqp3lkVE1PZJNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660085;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9mApYXyVMf8wWl3gldeOyYhwrTicSkRy7tZqqnYd04o=;
	b=K20qQ27Se+U1PUdY40UqTJ2qX5S/EVHnp95igiI3f1JPCuKdOoJNP2baKrSz20A6Cw7U
	 AT69cY5Ht1IR8rAXHbkrE+4V2AszR3ZGIgXs4M9kMEmbURXuVTL97DWyIhZxyP8OWbuD7
	 H3mxFISZmrtXsGu8F6ytl86T1Gjx4zgs7FDwrVeqcZyz97CqeYBSogNjFiJleU3OiMnXB
	 /3dQn4feVbCRO255QvmmcAxiTzhZN+lrtt2j05cRadpgdSzgHzwSIqoUAUtZP61q8tszJ
	 96UgVtMvAQYQWjKmSCKIQMCvxlv7NZZd75ZQkTrPhntZTQfNJuO7+dCA4h5vnpD9LXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=egR8AAPu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=cxKIvwTf;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32016606D83E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 22:54:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32016606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=egR8AAPu;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=cxKIvwTf
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2LY7ul3358481
	for <linux-fsdevel@vger.kernel.org>; Mon, 2 Nov 2026 17:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=9mAp
	YXyVMf8wWl3gldeOyYhwrTicSkRy7tZqqnYd04o=; b=egR8AAPup/lxUzDssFWL
	AyVFd1kfHwPxMkMi2GuVuHfDsRFEIKaLkYEXjyGf4Dmghr8ngZbT10w9Z70F6JYv
	roiTL+gXlO9tZg7hZU57Xv7DtXNxcaQs8mSMTIYrT7jXk1uH3Svie7U7ydnnpKKV
	0Qz2VixSdqSORAzH2hTOclwtFadEPdsuSsVaFA7KC3umQM7yBgY7HsmreyGpnW8W
	pIar7yjBsROX7T6rXOSrZnzorbW2MRsB7mnhO4bMRmjhyWEuScjMuyev7LAWBvzN
	mBYnenRZSXCrOBS22/91raI7v1xaub4yhVMGojZqFPJdwaBuqtFxUpexdkxaTGIQ
	/Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4hpwfcv62b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 17:54:43 -0500 (EST)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9308eafb465so385554485a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 14:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1793660083; x=1794264883; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9mApYXyVMf8wWl3gldeOyYhwrTicSkRy7tZqqnYd04o=;
        b=cxKIvwTfbioiZw23IAfVVrFCw9RQ+F9mgsXnpNw6/gXLC0fiZ/5HJfVa9hThGC0h8V
         DImQSYpiqSurToQelxguJqa0/1vxmTIzIy/YwqK0FLI8jtCMWv6WTugY1tCLJ1ksYRuh
         dSDu7OTmMaGgVVUZMERIDU2XNVe2RXQueOEJIsuwFPwJQVg3caUUTjl+OMMXCRtEN0Xv
         CLWNOCCMNCKLVJKWtHoTQ7cuTxIcmDp0MHtfAzDNwYc/eBU626cZNavJ8QxOl/C7pj3E
         P0zc7ItsDhUqKXsQHV/XeyJ3zPqoPFe+iHe+TO2+PFatcJyHiMUegMKkRxwNy1kol9+W
         RRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793660083; x=1794264883;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9mApYXyVMf8wWl3gldeOyYhwrTicSkRy7tZqqnYd04o=;
        b=mmYq7CvLxjSg65XogIN6z90jqCtopodbHxqJZgL+hSRo53bemmmsJDXe1szBtDLdyz
         bmeZI5ocPGCsUKRfqSwtA+TYuRZ0j87SMalVwMSedkkY4AQwkjhpslowChdYKhxHf5qi
         smIKQtVP94Pc7mq7YYapg/Ss8ydkzKAN+WZszhopR1bqarqW9Qd6+AKudIEDOiG5eSQE
         TNma1WLvE6wajOICU41mZbXdv/edNiGxw93icBs3EgmFLEeEhbUnOVKXDgFVHFlGVwLz
         rdHsYqIKPqeir0uW9kf3Np77LDEwOvDYEpw6qJioiyjvr7tDiE24nSDOfCwD5vBKcpdL
         w36A==
X-Gm-Message-State: APuU4Z9Ib4MBqUXVI2k+upRLCqrolh0ca0SLDkl4E/7MSJZ7wl1JNcoC
	05bmTyoHdQAdKSbJ2GpvGv1+LNw1OK8qPPyaOIaYe7hRJLfC3pTfNhLWzgTv8nBJbrFp8R9rSWy
	4jUqxXclgMWmN/jDn5lRZ9BgTXUhvSZwqEJKmx3aGOR05h1UEKGCv1giLMMaSh88=
X-Gm-Gg: AYBFou14lqdZoV7aa048OZVcTuLkQdXoaxfujSjdbPwurlNUD72h0Khge3hUBw+mGH8
	ffVEPoQKZn1DKPqSzXQHGyjfsmKi+GKpIeBsQaIZJ9tYWYL3CHIh2/1h4USldJcMkGfLWNbbS+n
	IynhsrewP4EYHzmIQfdsmgitcrpV1fpJpZN13FFWwaPYazsBjMoSaThnLookmTfedPYeeAGA2eV
	9NzRs8cFPutOYYfVD7l2M85mHFQBUzvJgkn3fLOKB3NuwF7W7pDtTMjCUNwPTKyRcn1O2NHgazY
	jhQBXjVgyhrUlaCz5fD4LdUKxf1y0h9xmNKv2R1mWu7jeSEDeDb8Tg4QWl+SaB35VVxhpHg1cXu
	iKZ+buK0rcOhEPAQ4jWGmvipeoJp+YcOQrjRaDed13RURBJO7gW2vqA24HOE=
X-Received: by 2002:a05:620a:4612:b0:944:14f9:8ef5 with SMTP id af79cd13be357-944216f1f37mr2015908585a.59.1793660083404;
        Mon, 02 Nov 2026 14:54:43 -0800 (PST)
X-Received: by 2002:a05:620a:4612:b0:944:14f9:8ef5 with SMTP id af79cd13be357-944216f1f37mr2015905585a.59.1793660082956;
        Mon, 02 Nov 2026 14:54:42 -0800 (PST)
Received: from [127.0.1.1] ([37.142.157.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b8011csm24710529f8f.31.2026.11.02.14.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:54:42 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 02 Nov 2026 17:54:11 -0500
Subject: [PATCH 6/8] mm: remove find_lock_page()
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
Message-Id: <20261102-page-wrappers-v1-6-e7280bdb31f6@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793660051; l=1351;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=WnZiaoLf1fsKtQgiDJZzhQv/Ag7bXfwRtEW2BWXMMlQ=;
 b=grLgHIiUTLhVj/AOEt/zWlW7iXhFRri7nXn13M7PaWaw/v/JlVsyYfny63+C2WfvSqYvj7nNe
 A30CPFguwkACa96UKMPYxAYi1hmuInopEbrf8htf8EJMU92e3oURAqY
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfX1Bfpvm7VVp6Z
 zpSp7GLJtdKA1NlNKbOvDe7r9ziLHuDlXt948/bX4t7EfBQZ3ScWCS0ZEOBOTdzBXp/Gkj2+0Qv
 UO4v0Edl/9GXu+eSYaAx9YNKkOr/kLeAOCJOjTrhg4YSJdusU228
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA5MCBTYWx0ZWRfXztusG4fzhkfj
 pO7fTTx22zkimKJ6vdWlWTYS6GOwxDZhK9J+nxNDmbsxHK/pZEKvSSY98Kz7UcwcOyLArxuLwdt
 P51f1WSjK4CU8clQGQfajLe7gLCFCKFBqOHsy7VlGDManIqd72cdWXhhF2j0QDLhebiFGHbkQym
 t79KKQinvQOhcD98w56UnbPYOaWqHo+FP5JLvxTEWfqAmBxm38J8jp953u54+mXjAfq8QyFjGcg
 teQODQZaU7n8YWren04uZttjJ2+GZ0NofChJE7LAcO9iTglraHfVs7dzevugyU3cFiFSuito/E9
 ZWS9jg0s0qL4uITKpSnCZeEHaiUgREQhPtkG3WXzkIu2mrNi8/ubJtYPlMykNRJCLT4C8sf1dli
 BWEvqVTd3ahosET/+TSAMJBQoTGSduHohkVoxVwlmWDJer6iq10/vcsNvW0FK/UwPdF/am03827
 arvOwsCpMUEheNhB8bw==
X-Authority-Analysis: v=2.4 cv=dNszC+Zb c=1 sm=1 tr=0 ts=6ae914b4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=Qz3frfIdACK70Hl/8c7MJg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=S2mxmGJpX7xwPQT3_3AA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 3f48bgxU5JN5VwgsjMyR0GYft9IcxXt-
X-Proofpoint-ORIG-GUID: 3f48bgxU5JN5VwgsjMyR0GYft9IcxXt-
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11954
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 phishscore=0 spamscore=0 bulkscore=10 lowpriorityscore=10
 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020090

There are no callers left. Remove it. The name still appears in a
sample function graph trace in Documentation/trace/ftrace.rst, which
is recorded output and is left as it is.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 00e32f96b459..a92329805acd 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -846,25 +846,6 @@ static inline struct page *find_get_page(struct address_space *mapping,
 	return pagecache_get_page(mapping, offset, 0, 0);
 }
 
-/**
- * find_lock_page - locate, pin and lock a pagecache page
- * @mapping: the address_space to search
- * @index: the page index
- *
- * Looks up the page cache entry at @mapping & @index.  If there is a
- * page cache page, it is returned locked and with an increased
- * refcount.
- *
- * Context: May sleep.
- * Return: A struct page or %NULL if there is no page in the cache for this
- * index.
- */
-static inline struct page *find_lock_page(struct address_space *mapping,
-					pgoff_t index)
-{
-	return pagecache_get_page(mapping, index, FGP_LOCK, 0);
-}
-
 /**
  * find_or_create_page - locate or add a pagecache page
  * @mapping: the page's address_space

-- 
2.39.5

