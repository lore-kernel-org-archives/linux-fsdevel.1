Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E796282F10
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515763; cv=none; b=sY9w88yV4AsR4IxIzj97DxQikBbbhcE6eXhPP6TYOy/ULZ0LZUfUYdCPNF+spOmtZNVGxv10SZ5yoDF+CPN6XNiqMTwH6JZTtL5CeOcaFmVE3q9SUpv6poqrUlp+cYaT1OLaXmWBmmgwMnwNSM2DvNtUNz3XGwO5F2Hzsgqt54E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515763; c=relaxed/simple;
	bh=dxg52INW+Mj6Q6Lb2jquqMFPjl6/Rh2+AATGon4TcZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IdOG1QgyMGzb6muzcfKdFjZwXPwx5/Ll1DyQDNTJW/iuLHbaqGPGvideyuSVO+7bDvUyf0zOAypxmjIzSYdjPJDsEJ2jYEgTFSPDCa9CdgvDsJDFLfflJP72Sjz8nV3s61A3HKlxingVxo0jM3mhB9EUlg/dqPwnqJ4xGFOmhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Oe2VLdiG; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=erM29vpc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Oe2VLdiG";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="erM29vpc"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FMbNAg2571339
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 19:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=uZE/najFT9R5zTEBz7Fhsb26kJ
	qZDk8owuOeuq8Y1m4=; b=Oe2VLdiGVsKZ19PvlL2qhCRXsxSeze/p+R148PoKqk
	JQU/6vxvqL+/5CyvNmq2sQGAWD8vVOmyvHNISYnC9p3ROhXQnEreUKiaMH5vYHrx
	kDhMOv8vW/a+eatdK895SrrI4ycPRWs5yTEjZ+BZil5/f+Nnk91NTJQhfRcyR9ji
	CNOZ+aL8PXpF6epP7fFhIzf6sBllao8JxnOoACzvuMLEG1MlsW9KUArXfFrVMdaV
	PA0luBiyaa6kC7X+G/Vvc7YO0fsSf1t1qeDAZ2qhGMXPYJV3xqsa/cPyVn8q1nuF
	EUK6AdtpUGXuLk6siHS6BHAraJD1j9x34g3Z/hUl5ELg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gqbwd9w6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 19:42:40 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-53001b668a6so142191201cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1789515759; x=1790120559; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uZE/najFT9R5zTEBz7Fhsb26kJqZDk8owuOeuq8Y1m4=;
        b=erM29vpcbDGBHpifWzdJ1M/7wDKmO8O32bCFuDaPmH+gOX+VZMg/0PRn2UluG4t9us
         QS73N9RcBpp/h7QbF/SZkpbaI8mgSzAok9nc2AfaDKM1rkicB9YOqaxYed9bUDEFDZcY
         AidtMuMxofLNbKf5ynz2iKLgJoqv+W6rVMGfW0TQGzWm+RO3fgvMdIRyBjqGQ0ERkoge
         pdJXQZvoY3zAXbu4Kc7PUyZjOcytimnv3pHwyU2bMoIay+RMsM46gGOY/1mJASCwdBKP
         S4N+BWfxPA21aEi6VukWWVIFbsCEDe3y8WivLsqM2yWchxPLI/itvpbOjF3fRmIKDk6E
         +txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515759; x=1790120559;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uZE/najFT9R5zTEBz7Fhsb26kJqZDk8owuOeuq8Y1m4=;
        b=KQ58mYUfQbHVCCwwLDaBfv7m5XxAwGAV6pncCxcFyxYoFEdEBUqenvRrGQxftdoA5K
         V9Yacumvq1Ern/KneDYqeqCd94qFbOxMJ8+HA4v4+/sulplwiFmLn3BNKFHzRSQxaCvR
         VG5r4NdtvgwwAZyCIsmhVqXKIb0SsPgJluaeiror8caMZAJe1j8CUCzPQTVsBIyMFisA
         ME9I52G9XnV/A/wDZIzj0KBFr/EK48gITHTG+9jdXK76M3D6Lqlo2nIiAyseJiIq+eC5
         s0C/RHEY+eQayJM5eAY9dl+BhMs709NYEy4VSNTsMWKllpeI1WAPZTnj0OFdVDTEw6+s
         nWaQ==
X-Forwarded-Encrypted: i=1; AKwUvBx45F6l7b01yv2V8CjrCPxavAOpOO+dFFbnKyMlS13nXb6Eaac0gaMJGCB0KTpBY2WpJtAeEpKdrDWerT70@vger.kernel.org
X-Gm-Message-State: AFuF++lnit4ysCIIERZepvvQ5+9/zzT4JNE+JE6/stfZPL2YWTFbi/wE
	B/fzJjfaq3zhcZdFiUYN5WmtTkddRhx2YG4Ll3fNRbniol+karCHmNR0voKKl7Q7jdoj1A9NslL
	5MQKhnPul98Cf+DpvRcA3QvUTea4jEwsgyglMtWfwprkjUESgT17TEfNa4nTEoNk=
X-Gm-Gg: AYBFou0j2kswInA3XcagtOEeQXhlHSNrPQMZdsu7lUO54vt8edIT6A6Mkxj3Z1pzy59
	xlehgiE1Mv561Pz6k+Isag3439BHpIhGxylcu+A+gAI1f6Il97eC2o4BwBvcX8bi/sCw+3D1lFI
	H7oPsJCaLAn+vPSS8ygUOw7kMCyW55ZXXL5gN0MFjNdpcFUgc14pV+tAUW4+ztSVpbLRiccYKGX
	By9D3pqLz08Vp5KRgSJq6doCLYTS+BzuhYy5HpMjGzJ+a/aAlZRSURWvZEvJqydseAqRxsUSk5V
	9WF1wnYpOQZcW46vfrSIib+EamVkECJWtkrWWzcqYfzjSXbv/zYAGChNrIZOl3oMGzqpSiwA2eW
	3taLVXvxAkkiKKcj5VNouc2pN09tSAXffijdg5VFkcTu9sh4E
X-Received: by 2002:a05:622a:14d1:b0:516:e10f:7140 with SMTP id d75a77b69052e-5327f1aaad1mr8805451cf.35.1789515759297;
        Tue, 15 Sep 2026 16:42:39 -0700 (PDT)
X-Received: by 2002:a05:622a:14d1:b0:516:e10f:7140 with SMTP id d75a77b69052e-5327f1aaad1mr8804961cf.35.1789515758797;
        Tue, 15 Sep 2026 16:42:38 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-179-204.net.columbia.edu. [128.59.179.204])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be7f316sm11399396d6.25.2026.09.15.16.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:42:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 15 Sep 2026 19:42:15 -0400
Subject: [PATCH] vmcore: convert mmap_vmcore_fault() to use folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-vmcore-fault-folio-v1-1-a0cb6278670f@columbia.edu>
X-B4-Tracking: v=1; b=H4sIANbXqWoC/yXMQQ6CMBBG4auQWTtJHQ2oVzEsoP4DY5CaFogJ4
 e5WWX6L91ZKiIZEt2KliMWShTHjeCjI983Yge2RTeKkdFdX8fLyIYK1mYeJNQwW+NyeLgKoSim
 Uw3eE2uc/vde709w+4affibbtC9g6lTh2AAAA
X-Change-ID: 20260907-vmcore-fault-folio-4b382eeff262
To: Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Dave Young <ruirui.yang@linux.dev>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789515757; l=2125;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=dxg52INW+Mj6Q6Lb2jquqMFPjl6/Rh2+AATGon4TcZU=;
 b=vdxoyuEon/H05Tmo1Fpa9qQA+JGXLiAWR1tlAA1+IiA+X8bmd6jRJvtBx0LctZl43TGXziRTe
 +GTwRByLmR/A0o+4UaXDSlvV8ydx7axk3vRrDxpQ8p2sw2e06k6g4vx
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=JeEpPkKV c=1 sm=1 tr=0 ts=6aa9d7f0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=hXAsoc/zAxyCEdIRhrpmVw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=LFCUUKIxLatyyoosy-EA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: z9c7IEl-RPDH69VkAOq658WrJnmKal9O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDM0NyBTYWx0ZWRfX1uDOrSBMX4oZ
 JPwBJV3dP509K4Wuz3MOyQRBYQ5h9ETnLwN+lfl3JxCo+jr+t+pbM9NODjmnb4wIuv5U4MAzIS/
 wHSkzA7X1oAbTBUs1donn2wjugpcnPeTi0yE4EqpQq5bmw7jdTzs9hW42l19zM1FsFXwjir/M1o
 LRMziqTySHjfYK24MB7oL0K9aY/ObyWodMgTOdlOP4CjJC7HO4/eaF1nwfWC99ZS9JZgbW97Edn
 Zv2ZjCAx/WKDd6Lnrp5g2nBd4dtmOELy/qT2DN5UiVkjeG4fGuzlb0BbT/Cp5g7dmIaPtMG9w5M
 ENTJLy/lILcrsF9eMBMBrYhp7CKRPi3BeuSgiQLntUUq/ypeV/51E4ffogwi3RkAz8GSmhAU4/F
 ctRNoWfIbtm4zMoceix1Ib/RbaeIjbOeCFfIFkmSl+BbJNf3o0alpqFk05kfmJuibCIHLe1wZh6
 m+eEYTHzItj6iS+J2lQ==
X-Proofpoint-GUID: z9c7IEl-RPDH69VkAOq658WrJnmKal9O
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDM0NyBTYWx0ZWRfX8U3dzJtMZH4D
 OaQ6EPi6KYbMVLBrkLu9bhgKZzTQsdjUPUk80CGsHsWK0jnBKIBSErqxOjnlU71r+SDF/+gMKDN
 hwSBhkzEnVMzkivYcjP8HauxfNsgFyYcs+Iv0iUpmLrXcsFYqBpi
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11906
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=10 adultscore=0
 impostorscore=10 malwarescore=0 bulkscore=10 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150347

Use a folio for the page cache page the s390 fault handler reads the
old kernel's memory into. This removes four compound_head() calls and
one of the last callers of find_or_create_page().

The vmcore mapping only has order-0 folios, so the logic is unchanged.

Compile tested for s390.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
This is based on the kexec-next branch of the liveupdate tree.
---
 fs/proc/vmcore.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 44d15436439f..2dc3803aa11d 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -474,29 +474,30 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 	pgoff_t index = vmf->pgoff;
 	struct iov_iter iter;
 	struct kvec kvec;
-	struct page *page;
+	struct folio *folio;
 	loff_t offset;
 	int rc;
 
-	page = find_or_create_page(mapping, index, GFP_KERNEL);
-	if (!page)
+	folio = __filemap_get_folio(mapping, index,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
+	if (IS_ERR(folio))
 		return VM_FAULT_OOM;
-	if (!PageUptodate(page)) {
-		offset = (loff_t) index << PAGE_SHIFT;
-		kvec.iov_base = page_address(page);
-		kvec.iov_len = PAGE_SIZE;
-		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, PAGE_SIZE);
+	if (!folio_test_uptodate(folio)) {
+		offset = folio_pos(folio);
+		kvec.iov_base = folio_address(folio);
+		kvec.iov_len = folio_size(folio);
+		iov_iter_kvec(&iter, ITER_DEST, &kvec, 1, folio_size(folio));
 
 		rc = __read_vmcore(&iter, &offset);
 		if (rc < 0) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			return vmf_error(rc);
 		}
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	}
-	unlock_page(page);
-	vmf->page = page;
+	folio_unlock(folio);
+	vmf->page = folio_file_page(folio, index);
 	return 0;
 #else
 	return VM_FAULT_SIGBUS;

---
base-commit: 4d17a004cfd5489f88ad0a7a151dea11a533338b
change-id: 20260907-vmcore-fault-folio-4b382eeff262

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

