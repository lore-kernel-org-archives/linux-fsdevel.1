Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1293F58DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371688; cv=none; b=IqrqXjipfvsFsBYjrcLt5ywO71yjvClSNanc2HBhdWrnZjwf2XrVhRJElp6R8c9tFqNrgiducsa/m89vFVThIUFOk3lt61yfZrRKO5hGe3NCXhdF5UHSCDrLnTKi0BBnMLBe2WXKy/bT2B53Pz3aD3TegjSL/h7On6S/Po2bJXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371688; c=relaxed/simple;
	bh=6dxbAtDCmrnDYkfOuWrS6UKuWVd+lmgUjReNrbBmSH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bkNWUs6RxaV/VtAwGKVM5UR4etXBheMisWUJfxyt6ZYCLkQn7TX4Nrf1mMgLcw0yCt7QPGLb/p9MSOtiMfDptFMSH9ckUT0B9341OKTqg3L12VlGUjxt4Px510A21Ico8EJeg4X+hnDfxdyr+fIt+/8s9Qzl0PyJjxJFFch7628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=a4TWNTA0; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="a4TWNTA0"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACadwV3011561
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0np+
	Mh4g6FbtGTotF1tdHYY92zqeAhsY3aQwW/2FAQ4=; b=a4TWNTA0jldsAoQxZpdx
	gKVTI89o/WtLiku4lqWkbaqHIimCfvpBOsgmQ3NajBr6av3Jpzs89t9CNmBh7f2o
	pzbEZyuRQSQbgKiVFtnMjWs+j5H3OnPItob8B9Dd1sZxJxtbG+RFPFg7vhx7GrgW
	ImrBI4iVxj2sJDW/QYuOBwgzVJyurI/l5jpngzk/or2XmHNedXJ906ILCXFqu0+T
	uNXrQpW6xeFnMltsG4qhCFkSiXXTntJoht255EHo1peTIMWpX7fTQJFYpl8LPYgk
	h5uu9ArmsWvSbwlSIS4z4J0dnYIpex7PF+bzADVBDv2Pb2rhVsBL38kgUv1Dz+zD
	+A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fy0rkudd0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:16 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1eb52e1fso36746021cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371676; x=1786976476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0np+Mh4g6FbtGTotF1tdHYY92zqeAhsY3aQwW/2FAQ4=;
        b=L2Z906dWopxAGsOK/leboH6rUNshSDVOUh0xsp8uuBVd1sMTC2BlWOxzTjpUDBrwbr
         bw7B0VJ8fD59zQYk6yyPuHVrmVhUcHtXLG0JeAaiPt5ZJ8yGLrmsasuWiv98bXv4KuCN
         y8dHQGTFj6F1rqinDzt3NnoogHV/k1P4K3D07isOXgu9wACW2QUpzyQJd9wXx9uYcBlC
         bciX8xF+S6/f1Dxxc86X6lEWTu4BXaCaiMnpMpOEw6vQrIdqLIcd6J9maf1hJSbI3MxM
         EOIf1rnB8ad3pnPAurZ5SRadnKJH2GH3jCp1AvQ/R7OukFP/dCRIMx7YmvP6yELvHtju
         apVg==
X-Forwarded-Encrypted: i=1; AHgh+RoFoc3PvlmaQJfyEGblBuFZNQSjCvnQzpZs9xDR3UDC0xd+cxgXp3OU9zqjtQcKolJB9KaXaypqFq60ulBy@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSBQ52imGHZCiOOGAuqssQ1jIJPq0smY2UAvCD3UWBlZaYQek
	sjm9UdSOzax31V77FneolEQOKzW8hofANK0QxZklQnN2GLAqyWDNMlsqkP49gPLj8os0z7apsMj
	6prf1qnCJq546hw4HOC9NN/eTXVap1HmfKXGdpICSTp7wxsoq/uSpRg2ATVVXh/s=
X-Gm-Gg: AR+sD13sGkdhNjpmh0AWThW0ZMloPGs2wt0dF9n8XwyIhTbKxzmeonv1vovAqpcgfBP
	Fcv5qb699rD0fBYLWzBvClApSoGYzZbvnW4yarSSfndWmkyRfS/ZkzszVq1mfa6i/z3+F9rz+Uy
	xsehXox48RlmHIQW1QWrg2ihn9JtI/UsMcZB31pyIfG/7G+I8HqjMPGxrSGgfTcVbocD493x/oX
	lH2YjxE5uCSxc4Xj94iMq4UFPykJj7yLL3MMu2gMEvZbspnATyORNAPg9C8Yf+LByDlOT4tqUYi
	XsGR8XEaYnQKorcf2ROhYEGoE0A2ANIRO/BxlCq+Y5DmlEkN7mph2lYT/7862bbBNzQ2T0DWqaD
	UhndKL8W0
X-Received: by 2002:ac8:6f08:0:b0:52b:4f1a:5fde with SMTP id d75a77b69052e-52d4bbae79bmr27114221cf.19.1786371675737;
        Mon, 10 Aug 2026 07:21:15 -0700 (PDT)
X-Received: by 2002:ac8:6f08:0:b0:52b:4f1a:5fde with SMTP id d75a77b69052e-52d4bbae79bmr27113101cf.19.1786371675218;
        Mon, 10 Aug 2026 07:21:15 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:14 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:16 -0400
Subject: [PATCH v3 05/12] mm: remove wait_on_page_writeback()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-5-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1451;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6dxbAtDCmrnDYkfOuWrS6UKuWVd+lmgUjReNrbBmSH4=;
 b=61yGVyVUUcoA+BeFj6z7ZvMKTrknl5Vy07EqPr8fQbcEitcS02/CCYCNWVboS8DvW4Ni4Bvq1
 Ka4sfab8C3RD10XylVk59bT0fPLpe6Z6WhfUVMqvXYkJBpnLyaK94HK
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX2n119AC0i3QA
 lbV/EcY2wv3Nr3LPXVvi6YW8Anhs7hFDQhBpk6Ph0y5bNQFxY6et/zqW9ZxjaH3O8r6jen8XkLl
 61BtJoVsLQsQ7qB1hN8NlPWBfJiU55dDI4QCAB2QBmb8Pf7iESzt7u+Sra71yZtp3sNM/WpBgN3
 rfapv2o/1roSBEpFfF6akqhkgo8+ctZMoDbKaMycCmmJPwdw2Vb9v1Oh7wO7kFswzMo1XADb+So
 8Pdw+sJwXsbDcZUVocnp9EzPbzJqE1fUZ+QslJT3eqolIG61M17OQ3E8vvFdnTGKqIfk5Pibtp1
 l+OnXo9hCCkw7/c8mgBxIgo7fQfFkN2CizEO5CnbIaqMfPp1cVzp0OdLoH3gpvNG6U6iKgHZtnq
 7uWdQA+LjwJoe9Yx4dKQyrVNW2QWEwlgED9zh2owIBW/fODhjsglWujN8qDlEJuUOuoSn/R/x2O
 ytdZE+BfCWIRNYkJvxQ==
X-Proofpoint-GUID: eK9Dve1BOS0Bfvj-a68_lZ8YEbxuZ5cO
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX0dvLWaN4PbGN
 lPvV+mEQYlwQB0idxMyYPEE8EbaGhAiXFzkqIWD/0bIN968TXBvKdwCuYpU2xJeuBLwfHPlsI7g
 zINLyATZ5XGMu6j21N6Y0ncS+9lEki5QSfp/fHqdo7tCDwFBy9zV
X-Proofpoint-ORIG-GUID: eK9Dve1BOS0Bfvj-a68_lZ8YEbxuZ5cO
X-Authority-Analysis: v=2.4 cv=WPlPmHsR c=1 sm=1 tr=0 ts=6a79de5c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8 a=qBqFc3eaEPVjc8k8qNUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=10 impostorscore=10 malwarescore=0 phishscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

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
index 2c3718d592d6..3748dde2b97e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1240,7 +1240,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
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

