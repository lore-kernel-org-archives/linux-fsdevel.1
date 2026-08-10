Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E793F65FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371675; cv=none; b=aiHTKTXFt4a4PeYFYeYNyjIXjbCXBuL1DK8EA5MRUY3hOHonSla9XKeNzL9TUrf/EgC+V0sbv9yFEV8d9HoHK7OFwQPYgayo4+eUaSVWj4bp+7YLhJlA22MKZtQqGTRVPWBvyl2uftn3vzP0t/BNaPEoRHvNI3+XTezDWZR8nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371675; c=relaxed/simple;
	bh=bC/X5LUNCwcfzqxhGB05BNOZAidcTm2p6b14nFOUhtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rqrWFx7jiU/nBQDjeyvk9XkbEzhvhmjVaSXnMLP0chDzaVx7dIC9qKlLrB1giVwO4IZa6Dl1fxSVJdGy7AeR8LztUUEChlc3x/10lEyo4xcoVC24RaBrPcjSkNmakVEUIZrEwR5Nl4FHfn57ghpEWEMwA5oEOMY90sTo/Cp2Cdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ccHuRGEe; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ccHuRGEe"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaW8j2991211
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=lUdJ
	8GftPVQWe/bytIhh9qzgnz0Y4e69yuiSB69qTBw=; b=ccHuRGEeALBOBGJMKv6L
	A5Til3j2/Eu/yO/cO8rSg5+O05x+lVf11ATFBAh+1d8SkfsYyLcuM0taPN8BRW7h
	Ihj3MmagLVOT/uSeoL8BH91px9Pzph+LZ2Hl+263w6kka3H9tK6BR1TLpJTNAazs
	x+pz84aOE4pSka49HRgte8Hp+KH3UiuinLP4FiVwIfxcrM/i7WwrFrR29/GjiiRE
	NRCtBDXC95QVSifxpU3sgrL7T0dK3HMcnFqlCYyyZZjDMvLrIRf4nhTpNNV2yRO8
	ewO4Txvzcfu+W7mt9oUdEAXr+7vcv5qJNF9sAYMGhbVFDjv23ELqkbTM7K1INQcU
	Yg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fxykwujdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:06 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8f0c46bfb6dso40135676d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371666; x=1786976466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUdJ8GftPVQWe/bytIhh9qzgnz0Y4e69yuiSB69qTBw=;
        b=JwEqs7aM1JRcQBrk3z+7GWDoiZno9yP8td7UYyhZWC8uUr6xcjaG6+4lJyLFcN/eaP
         FMXDLBPCHOWqVKU1nPq860o1NRaEDJz/Q0X1hrgFZe3OuPbWYH7JcavYi2E8cLYOQ1B/
         OG0cp24DmeEQ2tHXix3BfmcNybtnhK8kpAD1WXz5hi63bLanmqABmj/p1fxP9b3pMUdU
         AgoCdgIHYNS6VFHQCCsDwuK/r7ttOod4/+Wt31NhMVoiScTiVcBqJqj4A7Ocwbhj7DZF
         oW+LOQU8xR8qb7gh6/SWDXU4N+Ib3e4N0bOUX5/GBkRk5u/d4+wczEZG4k4Ua46DDKmI
         47PA==
X-Forwarded-Encrypted: i=1; AHgh+RrXZSoBPq6G6FyEWCMOEfzscFkiafQyVO6P8Z6mJ3KdqnG5z0Bw6WrKzr80whraZZb3Zo+2QTq5habiuYm/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MVVgIfsgckcaW/zSxjNFbUson9J8OpuEYm9LQS5nBa0+LM15
	dZNM3NKJg71bQciF+cAW8PhwMI5hHh/JuWGzFn9cK/2zBX4GV3EABz9d4bUFX5g/fwQDkaNftOD
	VFujLupJmvYfLTEBAtKknXV2MiS+QqDjP3W75ljC7EIZfy282C3PBsKUqaSo5/dc=
X-Gm-Gg: AR+sD11KhpffzTWT12Y7vPMDx0HEeQedijqTNpF1fPnzqdaBOMdeWEBVmLq0eDvDeT2
	zAbwZxULMYOvueGRKPv7uSMH74zBjAk+MrC1sB6yxoasCfOEThdwN5ieTAyMp9XHTtFRbEdPlFM
	Mz5WMpC6URLWaKzQTb27SoHiYuHqvx90aN0beRlWpZuskbtmwVd0cfnRwDUzIGV8+oZZU80CXNm
	a9lOAoY9P+Y95cTrS+/rdLcED4rV83YKgmMHLdBeb1Bga3KFIo4DlS6QQmZaHVhdyevIsDbVMo1
	3/ggWFqMaQqee+lPElPv0TywXto++t2NeMwxotmwEaGUGSXiJYMkSLdhn2VEpX6lVxhzcBUkji4
	76oeci29S
X-Received: by 2002:a05:622a:a0f:b0:50e:635b:5579 with SMTP id d75a77b69052e-52d20975cb7mr245780341cf.19.1786371666011;
        Mon, 10 Aug 2026 07:21:06 -0700 (PDT)
X-Received: by 2002:a05:622a:a0f:b0:50e:635b:5579 with SMTP id d75a77b69052e-52d20975cb7mr245778981cf.19.1786371665399;
        Mon, 10 Aug 2026 07:21:05 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:04 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:13 -0400
Subject: [PATCH v3 02/12] ceph: wait for pending fscache write in
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-2-dd7531704f26@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=2136;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=bC/X5LUNCwcfzqxhGB05BNOZAidcTm2p6b14nFOUhtA=;
 b=p/ml+Ve4lftJD+H+kNATKF2FjQfAQG2I6SrAiFbDZQLHfjVFfFFrODbMCdfNhfz5ZM35qVRfQ
 /xPdai/ySDxCiFP5iaL/zocXJ2PC6z8jt9HKL1MXrWU9AH1wPz/l1MU
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: CfB9JQYmb81_whtM3f7mj-z9kTALJu4M
X-Authority-Analysis: v=2.4 cv=S43pBosP c=1 sm=1 tr=0 ts=6a79de52 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=zYp62tllrndxtlEyWVMA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfXxiiwqPXepRxJ
 5yO87RUoR6n1exFnKCUHCXbUtstFP+MJv/t7f39FGCY62QyuWc1j3saUtDKuKKMTeNV0iP4+0nv
 0TOtOv1uCBrn8S1SGIdmbPcHEPpbQ8ax+13oJ82kQhvo9qfPIlslh+pK4JrW0yIPJ4IivqgcZ11
 ArrcozD0luisBA/ra4WT049QV/2Xcu9rlloaPXTusoXIvGfBBUodyYq0Lf4T8f2h8e2RPYyoPAJ
 7zLd+J1NEMkMXg8CTapMhHaL4pQ9AwQqgPmcwTNAyU1HuMYoyWObyrCGqj8N5Y0xiH2rgBXp7bP
 P5LRIcDHkeU19bKjAU27rdTR3PRCHlAftjFJU5XOBNRdpxqHTx+YRoTUDDf2UPms0j+XvBU64EZ
 4BOFWVcGTQyXzxA2KBqsAY74wdrnSgGDsAtk64vxmtLuOfsCIrSqb2Tm8hpmxIvtZFIMe97q8uZ
 0U4+1q7HF7Z3yPg9mhg==
X-Proofpoint-GUID: CfB9JQYmb81_whtM3f7mj-z9kTALJu4M
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX5JWYGlCxq+8t
 gwWlD1kW9F44yds9vHMLsx513bIk1CEUO5AhIUkDx+Td/HnMBO7/CEUb9b/MfeE+sJiF12LCzNB
 OMw7sxKUDcNcgAKi7XT9vNZpbCmNSMWX8xNyyf+FxxuCqNmMXn+4
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=10 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

write_folio_nounlock() marks the folio with PG_private_2 via
ceph_set_page_fscache() and starts an async write to the cache via
ceph_fscache_write_to_cache(). PG_private_2 is only cleared once that
write completes.

If the OSD write fails, the error paths return without waiting for the
cache write. On retry, ceph_find_incompatible() would wait for
writeback, but not for PG_private_2, before calling
write_folio_nounlock() again, which would trip the VM_BUG_ON_FOLIO() in
folio_start_private_2().

Wait for any pending cache write before starting writeback on the folio.
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
index 8cd24f66c981..de0113b23940 100644
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
@@ -803,6 +812,9 @@ static int write_folio_nounlock(struct folio *folio,
 	if (wlen < len)
 		len = wlen;
 
+	/* wait for a cache write left pending by a previously failed attempt */
+	ceph_folio_wait_fscache(folio);
+
 	folio_start_writeback(folio);
 	if (caching)
 		ceph_set_page_fscache(&folio->page);

-- 
2.39.5

