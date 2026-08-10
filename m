Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45D400967
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371704; cv=none; b=arZRU7w9DA1LHAC6GgxYbb5pfOz5NsctOLj5ZwzyxW0GDniuRq97YGZ97+SU78lTgg+lWFsJWsFrtjIhl3XufuSJyzuT6WtybK0hY/OQemnRTE2xJ8rH3oXQIaK+hWUfJaT6kgvpGIXSaSHJjXVzF4zmUxM6xQ8BmE3AHIGOSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371704; c=relaxed/simple;
	bh=GT6KsnFlFKH28GmoGfMAppH64tmtgEJSjAsPDSSVHww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S9++rilBroINR5V6IyGM9bTsM0Q8zsmfcAAJqKctB1ghHb0rGyWk/7lkVynUom5Lif7iHoU8SqSo21ciXW22URwGl5vm/jjT4LVshON7lmvxpaQVRLgxlHxDCvwe3Uc8oVhncE619HPsO6T2E0GIcUTlwZ8hfFAtfvMa8CNazl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=dLmpK/OL; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="dLmpK/OL"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AELJVe3538964
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=IVyh
	2I0xknPiazMq45DWF306MKF484odlddz5jbEe2k=; b=dLmpK/OLQz8CU/TbBRcD
	wffnn2Mb6OYdhpCnoHsIMBQCQxCM2lOU95CMLabWmepCtZvxKZAhrqWQh14IpFyx
	zuMHFDaY1FvGUWkLbUOavcfk2cvFAdJsSGZGuy4wGxHZYk8PuY0HEdt5+pAv/zYI
	M77KIk9rNd6/lpD9p8mUMcv9ZqdeJnMahAHeJgkPYsqr8TqEDhVdnWVN1AxT5Wqn
	AId7tMIW3zmi5qNzbCmq+0Van4AMFJuZ2a82w3pU6fsDl7cBmHwlHKVGENOqvo0m
	rEQoiWjLBF3P7s84IxiauMhiMiJpt7yb9IW58R3+v/vu6liLLu78R69CEDr4FqW5
	Tw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fygb6g033-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:25 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c01ff996dso26642861cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371685; x=1786976485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IVyh2I0xknPiazMq45DWF306MKF484odlddz5jbEe2k=;
        b=RDVA0vdlzBtEOFczw6UTaUjQmDpiu94A3WmBueVzqVYCH05MttVm5K1pGUVIUOAqAG
         idlIH9ekE2jCSM1qXN6U6+syjwdV9aS+ACnKDBpJCh+YKdF8IIoKxSxv50yxg0eckqi9
         SRp1domsUNOTqEf9OupdyHUgod2XMp0NbmnE+thr2yf7sOVSc74RQGmkJVbK4pts6ikq
         gBDLoVEaDAsV8Gd4a1yzElfwgEJNHUR5atpctf2Abt/ccPUuYEBgnqvImbyi67UjYWEV
         B1GPnImU31oYGyC1YOTatZpzzzj3Fs2k6a44CFEounD1TmGZ2Pl65H1uzAtnp8vptCwe
         9qTQ==
X-Forwarded-Encrypted: i=1; AHgh+RojGJOR01H7cCtgTdQ3+ISMe1nrk0Qqmv05T/zXoRro4ieSFfFTG/GPEgp1B06T/MoYRmY3VXjq9r5YxBCr@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DWMmgUxD5+kBZ7A3DtG3ekFycTuh0gp9SacolleDLaC51aXR
	cmvpsIF5Nd5iV5q4LLjruC/0YRNKOQZsB15ef5toU+H9QxLWNGirCgTOEEPUt7efm5AAEkIw9Gv
	6HwV75Vd5h8A/YH7evAlkQQvTCihegquBdq25T2b6DuGKKMl3gYjq0uuj7BZmJlM=
X-Gm-Gg: AR+sD11WPrHvnGMznfqnBe0ZVa8epNssQNCNp95LE5+KW46Sx5jNFfTTwRwOLu8c1Bw
	0JIdWBCxNHNBrrGH3GVpMf9b6BrBXyV9Y04EXX/EGvwzYPCwjumivBmIoqr7DZ/4gLqP7+1HWxC
	kmfR9MRs+WETXH+tSTzHiafvuA0tZWd6PKLum/BSY/U31iBfBx95yH156Gluy4ms/kgwtvXBXVd
	zVhrT4HtfwmFuOCuXMimuI1/FDYIDPOCUUaNl/ayNDjLEkLYbh/UzL4EQma5Cm6+3NKC22GwYhk
	sjSaHLZkkaW+ismgRJEu+KgguNXb67RFbz7Hgm4eiqjk5LjJWSoXZyY3iUWlJdCoREtf0JI2uwI
	ymi7wq9VA
X-Received: by 2002:a05:622a:c8c:b0:51c:2340:bbdb with SMTP id d75a77b69052e-52d18fd59d2mr274381331cf.26.1786371684851;
        Mon, 10 Aug 2026 07:21:24 -0700 (PDT)
X-Received: by 2002:a05:622a:c8c:b0:51c:2340:bbdb with SMTP id d75a77b69052e-52d18fd59d2mr274380581cf.26.1786371684393;
        Mon, 10 Aug 2026 07:21:24 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:23 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:19 -0400
Subject: [PATCH v3 08/12] mm: remove thp_size() and thp_order()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-8-dd7531704f26@columbia.edu>
References: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
In-Reply-To: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1262;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=GT6KsnFlFKH28GmoGfMAppH64tmtgEJSjAsPDSSVHww=;
 b=byVHWSYhAVOyPGElt43i+q4xX+4IztrMsjuV0Aj4ZkDgjduVsEwlE1w6aC03ZvxffCRtw3I34
 YJP87fwzSOrBu/eta67oEU9hFHy2ow571dm4QIVUtQyq6PukSc9Oav4
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXww4GCZGnK0VX
 SUnIzhEkFKhiL87t/nPE4oo8NWDf7gSKNDQvF+1WSEQv0C5b4EsGPZidOtgYRRYqHi/51DNI89C
 D9vP9CHD4y1//QC12WpV3ZxMJeb63yfsPynCu7UuIhgFCKPyR6B9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX5Qm01ORUSya7
 tqJzzsekyxUJ3IgfaXjkgOU7fE4hkYS3JTsaIktAXBwGV1GX7dGeHRqGGxvqsP5JY0P5uO7cp+t
 11FX0/ikQtdOuOOn4fz3+ssZE1Iae50PMbHUl/HYA79bsLplRR51QNu+mWtHcyacKFKtYsxRuGQ
 YrCjO0/8dKieUQMK7QBLmrEZjVX48v7NoTtMkOkwWxgDq+suUfVHz+MaFW5OTnE/BLZ9hipdENH
 YOCyGgcnxbSgxVLoILYa+AJtmQfwXtlrGBFwwm+5ToeEXJ6JPCBNDhtM+AiqKn6/3ZcGYs9EljL
 nbv58lEYO3tmYfGu2IEIMy3xnQTFDSxZlS8pS1Pgod4lG3drptoVNwdWRaOz3Chet/a1XcvxToQ
 a9HugZdJg3M3qTxTY8LT4DUJsvBu+fpvcO7eWjJOFMHUkREoC55ESjhpMMzjqnsF3RfLk750cXu
 zSjzjwjdqWGluQ2IS2A==
X-Proofpoint-GUID: NtIdOMUgavf3JHZr8NUg6NCiSOUgJdkH
X-Proofpoint-ORIG-GUID: NtIdOMUgavf3JHZr8NUg6NCiSOUgJdkH
X-Authority-Analysis: v=2.4 cv=MuZiLWae c=1 sm=1 tr=0 ts=6a79de65 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=5wpFShScvf9Uq2YMFBAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=10 phishscore=0 lowpriorityscore=10 clxscore=1015
 impostorscore=10 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

The last callers of thp_size() have been converted to folio_size(), and
thp_order()'s only remaining user was thp_size() itself, so remove
both.

Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/mm.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 485df9c2dbdd..48e821454ca0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1966,27 +1966,6 @@ static inline unsigned int page_shift(struct page *page)
 	return PAGE_SHIFT + compound_order(page);
 }
 
-/**
- * thp_order - Order of a transparent huge page.
- * @page: Head page of a transparent huge page.
- */
-static inline unsigned int thp_order(struct page *page)
-{
-	VM_BUG_ON_PGFLAGS(PageTail(page), page);
-	return compound_order(page);
-}
-
-/**
- * thp_size - Size of a transparent huge page.
- * @page: Head page of a transparent huge page.
- *
- * Return: Number of bytes in this page.
- */
-static inline unsigned long thp_size(struct page *page)
-{
-	return PAGE_SIZE << thp_order(page);
-}
-
 #ifdef CONFIG_MMU
 /*
  * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when

-- 
2.39.5

