Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02E837DAD5
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994126; cv=none; b=EE/zmqlwEX6vuUYY4hW8csUl5MMDz/HMxwLpnNIHO0W/3Ie/ZdiuhGWqw3c47MgFR6gX7wuP2Vcsh2trA5JlqJltqA1YOAII1DXPkWj6YjJAZqP1M4QPYiWL5mUnNc46eS4NNbbBuz7nRYQs7Gpr/KHwR9v3EadQFzKEvCY7UZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994126; c=relaxed/simple;
	bh=O9Tsg2DIkPFDuC4WYkkc9VidXQakooPjbM/qwj4bX2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZtlxAA9SH1pwIN9TK9sqlC1hdwSK9CXXOw3QXEA8pKvrP24XHA9BvFHrFZX7Wq6mTok/KdhmD3AaKGwB6Sffyy/nqGQtrkSG5a2bH98RgnaYqzZwsm4tYoqFVd57w5f5HI9Y9NdDr5TiM3B5qLYS9HbOT2Kmjr5c736odtU2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Yq/lpFdX; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Cyr5OLD0; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Yq/lpFdX";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Cyr5OLD0"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIYhoi4004499
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=uS52
	otnHr2tR2+z+5rHsosAozZEXrniXB9g7aN7M4kc=; b=Yq/lpFdXqUaFQ55y/cvY
	twJMhBIiYbKbykI5gtEAqvJgymqbZgRI51csQSJmHKmq6f0Hm2tAuq3J3+CZhnr7
	YNGpEpY61YiVWnjhq7OXI4VuZDEDQdYw4+sTBqEgd/MeO3oX9QisFYZ0o87SQSrN
	UEmCGAiZGKIv5kSWOlY9k1Tk0yqApjzW4Oteetqj4li77Yp65tqtNR01hlnllYk8
	UEtk+H5+ZXqsam73z01OYNRFfXqmpaNDfwlAQ935bfMF9S7qnk1sMtHPSL2YCswc
	l/WKybsXR++Ol+b/w17QlS+o9wgmfJSnbq82uPFsirfcfB6E0V5KSW5kr2Rmfx1c
	nA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g43e0anbd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:22 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e63df032bso27825485a.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994122; x=1787598922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uS52otnHr2tR2+z+5rHsosAozZEXrniXB9g7aN7M4kc=;
        b=Cyr5OLD0mDuOw1zUsX55YgzluFaL498FQ9VKQyVfAsAle8MGpUlk9jJJvGd3DP6o73
         /sgjqwkm/u8WcSo/NI9HmvXS6dZ4QonXZCRaKR8ZXBkVZXZ8D6HThCTKeSxlrUIRRrS6
         VrdaDNuiEfyril/e10TUzoP1Fi5DNjFtq8bUAKyE5s8N14n9JmsFn0khfr1RVbft05VJ
         BenpxwVpmQsQS/7hzQg0BDl1x1/WMG45spNBB1prxUGKaAmpOYml3iAFYJRG/XlvaCNw
         5vT5h6FOs6JMwsdAzRYcrntwI4xJnVMS0LQB/ITRaamdifDgn1rkKylf3FaaM9a76UgW
         /R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994122; x=1787598922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uS52otnHr2tR2+z+5rHsosAozZEXrniXB9g7aN7M4kc=;
        b=rLKlzg+QHToPggP/QjLybpKEjuOH3YEEjODBFI6dXiQjeQdRs0gBlnfTvsurnclbfy
         6Y6DOO2HaTT5z/9OXgzusdGqSO3RkGN0Vpcyq5611YyRbj9y9mV2olZBcM2Vr9JLvCOC
         pHIJdWVxm39fX91cfdVFQQyXZoq1d0jwn+bVxCU4uc5SoF16dVTh/7KS3FOUpnQgtO9Q
         GKMl+qugzY1cDjZNXmu6W5NycSc9Duj59oWwh0/Ejmy5fkxKq6snVzTQDjFP4Q3MkABD
         Z4a0fGV2ZzXh4yTNGEIYqUwwG11Qhb32TZGaPCNoWW3gyGS0p0PTcAeBER1QU7cYvj7E
         t9sA==
X-Forwarded-Encrypted: i=1; AHgh+RoiMPvByktpT4D4Aoel11oGYVeq7MJkQvqA10BAx3B3keGpVHNRGc3xgcKv7SsEjFD4oTsmfk37MJ+bKm4j@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKXvygBXE2z4r1H92J/5eUEyjeSzVjoDJjti1oJZY1BIuYd+a
	93HR4VtWKrlZu5ZwPIaWRHFpSgw+wl+xPYq96QgaZQCG+JS83dSym7Go4lg8amOUljz2kLx9lNk
	8sJiGyuhRPKvssq2petYt1OZakbGcYa630dAU264mD8sxEADQc/bALPaY81drdV4=
X-Gm-Gg: AR+sD13oLaeOhknl336jPjrnbLq3qx3a0kiQoXHcZiW8HcEvXntlTtxXi4pP1kNqESw
	o22fC5+cUW0vr9tK98U0HIzKNNhsRtFmlx4gGU6oC7Nlyc6BgbLLb+xTjgRQUfp1VdbuJYcYvMp
	kbJGYlGtRuqV/NmYRCdREpI+YjK9GFy5g0PHr1jA+g0TPgW5ILrqsU2LwxPOeyWpckwcas2dGHN
	9FcEy6zFpXrrKYuwMtzQjFVPy3A7gt++h8N0+SW/Ntv1bXw6iO6b2AIvKci/UYO3d/XwRHM+PdW
	XLYYDi5QmyvlZn2YdlkIqnPLRK+CK+270EwMjNs+0/LaNyxwdiuVBvQX6k7qIKRe4OyGm5xhJPD
	6G8S7YKhi
X-Received: by 2002:a05:620a:990:b0:930:9cbc:7121 with SMTP id af79cd13be357-9370652b374mr113512385a.3.1786994122231;
        Mon, 17 Aug 2026 12:15:22 -0700 (PDT)
X-Received: by 2002:a05:620a:990:b0:930:9cbc:7121 with SMTP id af79cd13be357-9370652b374mr113506985a.3.1786994121673;
        Mon, 17 Aug 2026 12:15:21 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:20 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:18 -0400
Subject: [PATCH v4 02/10] ceph: wait for pending fscache write in
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-2-0e5e53d47eb0@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=2448;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=O9Tsg2DIkPFDuC4WYkkc9VidXQakooPjbM/qwj4bX2c=;
 b=5KjgFa4rHDDNlNqr+ukt0N/yZwdNnaIHVZ5dUE/zMfXBKfQved4VywnPj/KcWF7B96dD2zhN4
 DZ9pOPzoGwYAjgco9ug4gnjGQ+YsGH5kko0oyjpSRbqsGnH5dvb0sGf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX5BEU/x9S8hZL
 7i8cVcPySu71A2qsCow8YxYCy3uNZPQTxYNgBd5+pykf4q4Dbl1l/zn5M3qMNzXQ+eOKe3c4/ju
 +g8nmR0ahkyBpxbvI0vk+f+B4KvDXhwasXBBIP6dc4pUOkHWO4Ql6h+56AhZpdgliH39/ubDXIt
 HDDcqjbzZPI40+4lTQB8lsvzARz3aTRBAqyt10SyeASXsszM8lv+1nSgFRMY++IMd5QdhJx7nxn
 QMcP4kOJEKbM67AVuolRBdSi2R3I4IFPp6e47G/UT4gOa3J70qCWamn1v8qun2eohpj0UzJx6kB
 bdhKNEbyJIVTnaXJ4oLJaxHQf/Y6u8LyxK96MATzgEC6ucZjXbBvV1JZLngehjFSFDlZULCH7ZB
 ZeHlPlnGrmq2GD41rs0vGekvwnO6jajDBL+35XQGVgUX4zK9MevAzvcBm6kzK7+cZci7xM1CrpW
 K2iEUWmu06vMHsKm8hw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX2TA25RpakJNB
 UqdT7C/uG5v9GmraKHW68fh6CLHbH2sfItib2TKOQx4VMS25qb8uzohk7A4uWslJA/KZa3cYMKU
 rfjWRzewnhA6DcV2/DgHzi4w4PS2KDmYxvc3HWbRFiAu8NdKchQf
X-Proofpoint-ORIG-GUID: YQiS_OCFdd5XncWTIbFfOK-WMPtPT6CV
X-Proofpoint-GUID: YQiS_OCFdd5XncWTIbFfOK-WMPtPT6CV
X-Authority-Analysis: v=2.4 cv=HLrz0Itv c=1 sm=1 tr=0 ts=6a835dca cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=zYp62tllrndxtlEyWVMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=10 lowpriorityscore=10 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170147

write_folio_nounlock() marks the folio with PG_private_2 via
ceph_set_page_fscache() and starts an async write to the cache via
ceph_fscache_write_to_cache(). PG_private_2 is only cleared once that
write completes.

If the OSD write fails, the error paths return without waiting for the
cache write. On retry, ceph_find_incompatible() would wait for
writeback, but not for PG_private_2, before calling
write_folio_nounlock() again, which would trip the VM_BUG_ON_FOLIO() in
folio_start_private_2().

Wait for any pending cache write before starting writeback on the
folio. Do so before bumping the writeback congestion count and
allocating the possibly mempool-backed OSD request, so that a thread
sleeping on the cache I/O does not hold either while it waits.
Add ceph_folio_wait_fscache(), a wrapper for folio_wait_private_2(), and
use it.

Fixes: 1702e7973410 ("ceph: add fscache writeback support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284%40columbia.edu?part=7
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index d5a349daf4d0..f1f4caa8f9df 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -559,6 +559,11 @@ static void ceph_set_page_fscache(struct page *page)
 	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
 }
 
+static void ceph_folio_wait_fscache(struct folio *folio)
+{
+	folio_wait_private_2(folio); /* [DEPRECATED] */
+}
+
 static void ceph_fscache_write_terminated(void *priv, ssize_t error)
 {
 	struct inode *inode = priv;
@@ -580,6 +585,10 @@ static inline void ceph_set_page_fscache(struct page *page)
 {
 }
 
+static inline void ceph_folio_wait_fscache(struct folio *folio)
+{
+}
+
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
 {
 }
@@ -783,6 +792,9 @@ static int write_folio_nounlock(struct folio *folio,
 	      ceph_vinop(inode), folio, folio->index, page_off, wlen, snapc,
 	      snapc->seq);
 
+	/* wait for a cache write left pending by a previously failed attempt */
+	ceph_folio_wait_fscache(folio);
+
 	if (atomic_long_inc_return(&fsc->writeback_count) >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
 		fsc->write_congested = true;

-- 
2.39.5

