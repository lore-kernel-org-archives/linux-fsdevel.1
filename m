Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E1320A24
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778450213; cv=none; b=CODym4pzIU2OGLNINIn2jJw2izzUed+6Du6XNneaOLiLcalYnbEUqtzCShYeIQKH5ZRqYsvzgTHqPubWlxeMzBwb1l3PePHK4qMxZgybJAn0FBIk9uRZG8z9b5RS/1sxT36CpQQJIhs0mXhMM/Dzbg2x5jeOlmX6U7mcjc15FxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778450213; c=relaxed/simple;
	bh=YxgrvZR3kH+gqOp0C/o4cUtDxnd5s1ZrRJGL8qXBbYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oxkuwMGITQZFEhfLqv4WCV+ISvaU6bYWfRDDTAG3T1l3pBM993w7GP9DyLTEaZY+EmYohyRfCxVyBpcJK6QlAgHHHLdyRewl4SCNNuqCxqR30x5KPUH82gvo8/h+qunDRSr4vXwnPS9SZMXK/CNDb8PR93ifBuYaZDQqwqaR/cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=fAaUJTUb; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="fAaUJTUb"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AINcg92560675
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 17:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=jKIH04EBx4jQOhPZmlThKGkQBf
	xOj/8qm7n8vOuVizM=; b=fAaUJTUbaDBW2iznlyx6Vm8sXgjlJH5i+JAkG3UUOm
	Qz0ypTsyTuKuf6/PPsuWLbBVbN7LAiM8sAfJESDCWRX3iNPVhlcxbNpsMQi9VPUS
	7MzCUrnUN51R1k7I99YgSNOGiCc4whpEycBAVe67iADCnpQTPRs73YXMyaAu+NzW
	lU0Z456X1YjzBhMK19LYkSNNvzY/jMNpPNyXk4Ex8EUTs+kuzbGcjZ/K1t/pcwwg
	7f/W1p8/iNluGOZZmgwZPRRgA/4JtLU7zTbygEAdoZ1U/+4LLyMdAYzEcx2pbMjG
	j6CK33PhfrcQ6tNNVHltK92PfxKWVFTxDfuEEFNAxzCg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4e2y8brmx4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 17:56:45 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5147078691fso87305711cf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 14:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778450204; x=1779055004;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKIH04EBx4jQOhPZmlThKGkQBfxOj/8qm7n8vOuVizM=;
        b=PurIxgblVWWq6frJhyMhUWf9j35INzEY+wDLAkJD2qotfJ5c63H4az6Vxb7DSLJMFY
         YJs6ZNR4jw/p31Bb/czbLB2AkzAJze/TmOu9xPBq1c6s9QwgqAjM+RVfGC4o/bkAS3fa
         R5Y/IHsDe+7xAv+R8HZP1AlXvS5K8rKcg73jBBtKhdKP7zgbpeCBH3GWnFe/1Kkn06x1
         JLekB6cIFLIMrtxlc29m0XvwIXMRMknhGCSSC493zwHb44EBZqHRxvFkGuqJ4FaS0Mpo
         623R0aD50hVosV9GTuG52r+7yqBHoymG5tIr3V9lG3nKggwz0uqJAbvGnlyhduPLMQWV
         +l0g==
X-Gm-Message-State: AOJu0YzZfKjAN9yXnrcPnIvkO+btpG14FYMIklwb7FwELRbAiBP2s6IO
	xAhx4lmBoRBLWeRViQIVlB4/fGRs2sfNDxoyHoyIlluYpUhFe0qd7RKDie/SLOeMLu8HL7ADIOe
	Uqq8HTpzfch/0IGfh5oEOySMv054EPQPFX4wAkZBh4/Yr4txg8wNdl9GD/AlotDk=
X-Gm-Gg: Acq92OFdymB46wXCawxMl4ef40kzJvUpEhWb+XQiK9B0qlwOwcm5h5pmRWnb8O89V75
	PZmB8qxpFdBB3rNDO+SeakgCW+CEN317YBOqxOD/7S8Brj0qo2UOHzwMPlsD2u1tZWmNf8sp9CK
	d6IiDpMQ9+nNMvIF+LwhMwUvBBj3Ex053STozaMM2g7RyNEOaR+Uzk9qsXMPvPTivA/PHK1lmTe
	b9Ttv97FG2vGMgPvFmdCIvTgV6EK9UrDe5En2yh7zRgZ1aL4mj7LNVwz1MvPj5RkSgNdEDnh0E9
	HBCg/vmrU5XmW6ooyIWvAV3GoMzSDx13BAHxzn37lgeOJN5fXGnYJ5QCGIkWalZ/QPHmUPeB7T0
	qT3emmNbdgkBzLMXlSBeB7k8wSqnFQ6FRkpEVXsQobs21ycZvGcEV0NYeclT3MNC1hh0=
X-Received: by 2002:a05:622a:4a05:b0:50f:b2e4:ebb with SMTP id d75a77b69052e-51461be0195mr329587161cf.10.1778450204585;
        Sun, 10 May 2026 14:56:44 -0700 (PDT)
X-Received: by 2002:a05:622a:4a05:b0:50f:b2e4:ebb with SMTP id d75a77b69052e-51461be0195mr329586971cf.10.1778450204171;
        Sun, 10 May 2026 14:56:44 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7bf34asm77435591cf.14.2026.05.10.14.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 14:56:43 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 10 May 2026 17:54:17 -0400
Subject: [PATCH] mm/filemap: fix page_cache_prev_miss() when no hole is
 found
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAIj+AGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MD3QKgqvjczOLi+LTMCt205CRjAwsTcyNDY0MloB6gLFAYbF50bG0
 tAH0Y+thfAAAA
X-Change-ID: 20260510-prev_miss_fix-fcb308472131
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778450203; l=2462;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=YxgrvZR3kH+gqOp0C/o4cUtDxnd5s1ZrRJGL8qXBbYc=;
 b=zuLTzWpUjYMr/4//I6PYJbD7PvfLdjx3DXr5QmAfuqXINNrNXe1pK9UaYL5e09CsQeAr98oBT
 sokA9lNXDL3AdYSyKB6hATmOVyudprxle0XPxjA/aDJ3KX0zzWQEK3g
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: vMBFRgzmsXBFAnKxdShNBu-HXElQ3Yat
X-Authority-Analysis: v=2.4 cv=VI3tWdPX c=1 sm=1 tr=0 ts=6a00ff1d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=ILz1Z2p9l7wduT6Ju-UA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: vMBFRgzmsXBFAnKxdShNBu-HXElQ3Yat
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDI0MCBTYWx0ZWRfX9xcHhecdMo+f
 G3KVOZMuolWWfyYRgRjYWGtRe1NvlQP25EK7qwWu0gH1+PvfzwzXqPKd5/1aZRM4efkZ6iKnXkQ
 B8XnDkuoY4NXnoLtXqfCYEZvXirpYBPRIKzcmtVt065N4k3sA17GvnhzhD49ZS3E/AROF3lZWnZ
 If1wE4nG/G83kcFO/b10ayVcATF4vo1EQERw3ADf8jqeA1LwzsCQfPdebiNxuQm5kWffGk5JUcC
 jWqL5n6eu3Pw1Lb20nEhASHjdVBO6GMhp0WJllVwMhIdLWLa8G1BLvLFgs77tQl+byEepvK/JnZ
 Ax1fwIGk20krVxpUd1M5ii7XU0s37i3szwxzTJgpknNvsF4j31kG4EOyslJTx0qI5b37XsfED+4
 nZUkBnIEE9LCvgbq3EddfSsp4VivKV4mKd1WB4uqs9UZUn4a8OxqpIMj8vEfmfAlUMkufuXVPun
 cTHoNgNZgPeIb940X3w==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11782
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=10 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605100240

page_cache_prev_miss() is documented to return a value outside the
searched range when no gap is found. However, the no-gap-found path
returns xas.xa_index, which after a successful loop is the first index
in the range. As such, that index is misreported as a gap.

The sole caller, page_cache_sync_ra(), uses the return value to estimate
the cached run preceding a sequential read. In some cases, the buggy
return value can undercount the contiguous range by one, shrinking the
readahead window or pushing borderline requests into the
small-random-read branch.

Mirror the fix in commit bbcaee20e03e ("readahead: fix return value of
page_cache_next_miss() when no hole is found"): preserve max_scan in a
separate variable across the loop and return `index - max_scan` from the
no-gap-found path.

Both helpers were previously fixed together in commit 9425c591e06a
("page cache: fix page_cache_next/prev_miss off by one"), but the fix
was reverted because it caused a hugetlb performance regression. hugetlb
no longer uses these functions and next_miss was subsequently refixed
in commit 901a269ff3d5 ("filemap: fix page_cache_next_miss() when no
hole found") and commit bbcaee20e03e ("readahead: fix return value of
page_cache_next_miss() when no hole is found"), but prev_miss was not
addressed.

This was found by pointing Claude Opus 4.7 at mm/filemap.c.

Fixes: 0d3f92966629 ("page cache: Convert hole search to XArray")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/filemap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ab34cab2416a..545ccd59777d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1845,16 +1845,17 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
+	unsigned long nr = max_scan;
 
-	while (max_scan--) {
+	while (nr--) {
 		void *entry = xas_prev(&xas);
 		if (!entry || xa_is_value(entry))
-			break;
+			return xas.xa_index;
 		if (xas.xa_index == ULONG_MAX)
-			break;
+			return ULONG_MAX;
 	}
 
-	return xas.xa_index;
+	return index - max_scan;
 }
 EXPORT_SYMBOL(page_cache_prev_miss);
 

---
base-commit: e9dd96806dbc2d50a66770b6a86962bd5d601153
change-id: 20260510-prev_miss_fix-fcb308472131

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

