Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699CF3F23B1
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994142; cv=none; b=s6AlG4uGsyLXr4A9pw3raC1nF5NxkKwqP8T/d3v/AwKqwSB5WZivgUO+8983p+Rp2Eu4Vl7CMGfWngpq7r6otARY7+GLocfF4g9PV0vqGzvQhijSEDcd4UUMZmVyQptvZBvSwZdkLdw575akX03YFF57irzaFnvHiLchYNiPRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994142; c=relaxed/simple;
	bh=3Yr47TYe7cqBT8sK97KQzuLWu9tCzz5B2cD6geWhTi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOClrnpWBMGiwhBJGajfsoqXFUVb/0BgL9sXmMP6G8vb1FtkVqTUZ0NhBO3jxWWw3LTXj7kdGr1q+ga7E0zDvHQ6YDIFE/RYJSNApDXoKgnTN+eq+fdihAGacVa818DvzbhltOV2EI8PFqma3Jah8glWt+uMXlVf8/oTMKZo5Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lRg4L2ed; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=s4fObNcp; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lRg4L2ed";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="s4fObNcp"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIvdAF3766559
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=cv9x
	6z4kwz6bNvCwiXVm4zgaYEgf+1gg2Ey2bAsoUhc=; b=lRg4L2ed+Jsa2qHswH63
	KcodI3Hp8a4vPrVCD4k5YIU72t4hpEtRkrS4qasMfGjF3Mr4Sq0B7UE54JO9kkmS
	kAGoo3cloL+bXCOdDvpTRPS8BqjS4xLlI5o46K82KXQHVMk7yz/mkLZidYD1mqpl
	UxmIZQscOgNneKO6nlbvFMnTr3QpAEbABExwB6Pc87qYdC+VtKxYC7hUoDrSJLkd
	sXTg66q8bEllO8ycecl+3HJTG8o66q38vFjq60xj4k0l7/OFvfkiDOA6Kx4eQ1US
	6NqyJ0pzPdJgXiUEC4WwIiF8pqrxknFDhszQQI0zDGFiZo5tKCe0ZvGIq0zmZDYO
	Aw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r85fg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:37 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so26652585a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994137; x=1787598937; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cv9x6z4kwz6bNvCwiXVm4zgaYEgf+1gg2Ey2bAsoUhc=;
        b=s4fObNcporOsOmyzwbnfWITzmy10mUhfEtV1auH0SSfiJo5DMSHoWISGRSUoRjLoTq
         aotGZ0ACtBr6phs9ZV36w935kdNNZosT0N1vMXDwa8+jpIoVLoo7WTRR8d93fwSghMc6
         tyintB4icStbTOt0HBkZxY0ic06wGS5GxfSTSpot6PrI2JDIbvOZsttNXLFGCHagqaxq
         YXtZtbOePZVmNkEN4NJyc6PH/btXp02HKHgIN9eHOOM3/COG8nKeE4MYtRXd9tkGw2Uq
         lZpy6bS5X6ZM7buKBOpH0T3vhw8w0ZvXHXQn3YncYmRx1DR2XlZFDuNgy0EL3bzD/O4p
         Wd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994137; x=1787598937;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cv9x6z4kwz6bNvCwiXVm4zgaYEgf+1gg2Ey2bAsoUhc=;
        b=s7Zj5vE0i21AFpUIMvjxfEqyRp108bMYIL3YvmrN21VmQ6YZfeU7J80IRzr8YqSKHA
         B0efbW76sZ7fXcOhzCQuF5V/yZDip7hlcvjA79l5nYJbsS2/i6EeKVqESgHB3HcyYxo2
         L/8RGqHMDem1EXpr8/gmbSsGRCC9Fz7ARk6Z2/Nk9qF8rxWsrTbRYiLI9mSHh3zAB5t4
         9RPTfN2KqbXalaVOxsmDp2aqgaxcgE2h2O7ci5Cqo9TXMyAnMuBMmH6lrsrKDbQMKqCA
         CTJTLpbrfWSGAC2tIbHMSb+5yCuX03C4ejSuyZsnnEN3gV5+m6ShpekbKfWNRnajXKwz
         hj4g==
X-Forwarded-Encrypted: i=1; AHgh+RrevxCW4fmb34wOYcrZSr11ry4sNB0ewhxyJCdsVwke0MvIfpJN6g1hHQkVPwiHDhldi242GEWTKvxdMn7U@vger.kernel.org
X-Gm-Message-State: AOJu0YxR4z577w3JoBGpgXTeu53FE64RPkHvE4uzqSP+Rvb4+Rxn5Txi
	eBl8A2Z6Yys5NQ9ynTeD9qnrEEBCT8SCgpLIF1xaYT//FAcRcKJHWNt3IXpIT996UOb3xYO8YXC
	z4k0LRX1TyR7eZwbd9uWe5TKOPHEeDcsM0X7pufLVycLwZT3fsPNiQAYsbT/OXjg=
X-Gm-Gg: AR+sD111bdrZVz++4EzAmacd4h7voHvQ4aoEg1VEKAkoTKQNBJStpQNtQ13E8FmPtnj
	hZ3u3MPO3fthKMrFs9VTpW/B9a9XWZ74tBdrvNdxFSkFe+8Aew3/8omJBguUtVYr4Hl782t99NH
	MFvAfYyw2YymD904qAwMirjMY16NbpfS5gmomUeeJEj4wSGfXONIUmRkWDuHvRtpGT2zbt4gEva
	9lKTGGGowqYyjGwwMjfpPUntoSnEDtUMpH/0vi3n8GeksTn44XrkCFS4Hp65vYgf+7YaHem034p
	y14nUFbx2qB4E3ltiE5I588EopNCM8EfSch20vUgZbo3i22bNw/IzQF/htTkaSKZ9UGUAN55Xjl
	FngAZze0K
X-Received: by 2002:a05:620a:2313:10b0:92b:6e09:b0d9 with SMTP id af79cd13be357-937066cb326mr126138385a.21.1786994136517;
        Mon, 17 Aug 2026 12:15:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2313:10b0:92b:6e09:b0d9 with SMTP id af79cd13be357-937066cb326mr126132185a.21.1786994136084;
        Mon, 17 Aug 2026 12:15:36 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:35 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:22 -0400
Subject: [PATCH v4 06/10] ceph: convert ceph_submit_write() to folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-6-0e5e53d47eb0@columbia.edu>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=4837;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=3Yr47TYe7cqBT8sK97KQzuLWu9tCzz5B2cD6geWhTi4=;
 b=HevgqnjCrhv7I6rtbygRfzOdftYjeffz3QrWztwIqA4nnzsdtsyhS4Vf1/OT/2/P9RAjsOas3
 +udOFxtguS3AMtcBhXi8TgPRbonGiMlS/BouQqru1fUXtT3VoqirO/5
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX+FlvYCnb9qPf
 iXsePwJWDStP1pR5nXNSBar+IxFFaEYlp17G7hv6DSh8WnTTsPRZnMOpZUlEdqvks8diiPnzGp+
 RniG52i74fvowOgOkRD8d5LOzAOtUZdaJCrTxr2oEqZ/hTnkJwjrYtEUAWoUFeEVUZryii1XxFS
 Gv+Sghi6thIIiY0IUehazGb4/pmW57kcCNyDdWwIXQ4ov1ziS50Yu0/wadeuEKoeV5seCiTDX5Y
 4DxeeZSEoEiv7znOtJP/Y/dRFvTbsJCr1mFfSLCA9LHLXw7+FoFwpcO1V+k9A1C7pgKm2eep48v
 Kuww2tRm8tFCaW8slLLcGgTeBKSLnZUKy/BpkwxlLPcmI1v3lPO1WBJLD1D9YVxEX0fsqetiUCA
 ejeDiOSIW3mk4nDHb1u2WJl2vqtrIkOEQHcq11Hnhp4BQGh/qrFdo7EKbF8sxsAyQ0g+BIgzoCz
 3tQTxZ+zaUG4QGstnHQ==
X-Authority-Analysis: v=2.4 cv=PKw/P/qC c=1 sm=1 tr=0 ts=6a835dd9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=RfODlEta0-z8xtihUo8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: ouGCHBRgeh3ck4zk9A5ExK5SzGYHW2Ih
X-Proofpoint-GUID: ouGCHBRgeh3ck4zk9A5ExK5SzGYHW2Ih
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX9RYw/Uj0Tl0U
 iZvAY+tV1sSLYXeKZ2XfsM61fA0t7FDL4mjZE5/ctblI0eWd14sROUjNXDmoUUg3yJjxTPc9E3m
 Gs99BZ0JMPLFpIqglCO1xNwWTigs6/SeOAoSMjahbEMNc7GZLg74
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=10 lowpriorityscore=10 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

Convert the request assembly loop and error path in ceph_submit_write()
to folios. This drops ceph's uses of the set_page_writeback(),
redirty_page_for_writepage(), and unlock_page() compatibility wrappers
in the writeback submission path.

Add ceph_folio_start_fscache(), a folio counterpart of
ceph_set_page_fscache(). The remaining caller of the latter in
write_folio_nounlock() will be converted separately.

In total, this removes eight calls to compound_head() hidden in the
page-based APIs and one explicit page_folio() call in
ceph_undo_wrbuffer_claim()'s caller, while adding four explicit
page_folio() calls.

Note that get_writepages_data_length() must still be passed the
possibly-bounce folio, not the unwrapped pagecache folio, as it checks
fscrypt_is_bounce_folio() to round encrypted lengths up to the fscrypt
block size.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a34849374f65..2d89d3d51bf1 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -553,6 +553,11 @@ const struct netfs_request_ops ceph_netfs_ops = {
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
+static void ceph_folio_start_fscache(struct folio *folio)
+{
+	folio_start_private_2(folio); /* [DEPRECATED] */
+}
+
 static void ceph_set_page_fscache(struct page *page)
 {
 	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
@@ -580,6 +585,10 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
 			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
+static inline void ceph_folio_start_fscache(struct folio *folio)
+{
+}
+
 static inline void ceph_set_page_fscache(struct page *page)
 {
 }
@@ -1458,14 +1467,14 @@ int ceph_submit_write(struct address_space *mapping,
 	struct ceph_client *cl = fsc->client;
 	struct ceph_vino vino = ceph_vino(inode);
 	struct ceph_osd_request *req = NULL;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	bool caching = ceph_is_cache_enabled(inode);
 	u64 offset;
 	u64 len;
 	unsigned i;
 
 new_request:
-	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
+	offset = ceph_fscrypt_folio_offset(page_folio(ceph_wbc->pages[0]));
 	len = ceph_wbc->wsize;
 
 	req = ceph_osdc_new_request(&fsc->client->osdc,
@@ -1489,22 +1498,22 @@ int ceph_submit_write(struct address_space *mapping,
 		BUG_ON(IS_ERR(req));
 	}
 
-	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
-	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
+	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
+	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 		for (i = 0; i < ceph_wbc->locked_pages; i++) {
 			fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
-			page = ceph_wbc->pages[i];
+			folio = page_folio(ceph_wbc->pages[i]);
 
 			if (atomic_long_dec_return(&fsc->writeback_count) <
 			    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
 				fsc->write_congested = false;
 
-			ceph_undo_wrbuffer_claim(inode, page_folio(page));
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-			put_page(page);
+			ceph_undo_wrbuffer_claim(inode, folio);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 
 		if (ceph_wbc->from_pool) {
@@ -1530,8 +1539,8 @@ int ceph_submit_write(struct address_space *mapping,
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
 
-		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
-		cur_offset = page_offset(page);
+		folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
+		cur_offset = folio_pos(folio);
 
 		/*
 		 * Discontinuity in page range? Ceph can handle that by just passing
@@ -1564,12 +1573,12 @@ int ceph_submit_write(struct address_space *mapping,
 			ceph_wbc->op_idx++;
 		}
 
-		set_page_writeback(page);
+		folio_start_writeback(folio);
 
 		if (caching)
-			ceph_set_page_fscache(page);
+			ceph_folio_start_fscache(folio);
 
-		len += thp_size(page);
+		len += folio_size(folio);
 	}
 
 	ceph_fscache_write_to_cache(inode, offset, len, caching);
@@ -1580,7 +1589,7 @@ int ceph_submit_write(struct address_space *mapping,
 		/* writepages_finish() clears writeback pages
 		 * according to the data length, so make sure
 		 * data length covers all locked pages */
-		u64 min_len = len + 1 - thp_size(page);
+		u64 min_len = len + 1 - folio_size(folio);
 		len = get_writepages_data_length(inode,
 						 page_folio(ceph_wbc->pages[i - 1]),
 						 offset);

-- 
2.39.5

