Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF1D3EDE78
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778618777; cv=none; b=hnfT/hESSge+02qt0Dw5ous6IECk35OiiiNQWxGSbobrRrixFhGUU8yDLcBAe9zxnOWi8raTxyrp6ySl9zTn4W+yfxO2TCRBMQrDcSielkY/sr2BOqhJJz8wSNbcr22TpCZ5FHUfUV1lHmV7zkkF3/s1Kyehc95AFhASATJEsHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778618777; c=relaxed/simple;
	bh=EKfXg3Kedd/2DkHbNXwGJTPidd7Pkdr/1XwXuXKdOsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u2iZ5APqFdc1FZLf1WEd59TUMweqRrQZ/UorSCEF8hcRy1IfvRLHjrk0nMdaUPeEfv93gpA3WoytVEvGZtSTTHd/fobl1mI00ZjU/u2cPRLzjdmeXXrjuitFdX6DmjSD/nvOsYxBU1hDG2FfAcp/3o0V5jyrLIKJTMMQ4j1TToA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Pk8dx9tV; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Pk8dx9tV"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CKjj3R1838363
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 16:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=oYr1O3U6/SXVN5rudFYRAdAuWO
	paLoIuDsz1B8w0T78=; b=Pk8dx9tVmrD/akIDvKQ1+od69ZPWbp3kgH5UZcm6nz
	8tt6kga349LKljWsRoDFOPUMZp8jsrqL5zhzGk/SgbfOxe5//Ls7qLRKRYtF36Ow
	VsnkmR1ffrTr5lZ8FsMfQYE7FfPs5nnadc2qCXneVS+fNnELtpVga5jrXnDfYQCm
	DeLPqMVXJyrXh5BvKN3d48KanEWTlMKhm3aXspXKyGPJGyLRxdY3rd+F4WFvB8VS
	mjPYCUxGELPw2o3bYD2Zbe2amGp6q2IKEwFYXOVJSjiIHH+EsSWGjI8KByMPpNc9
	a1dXV0G+ywH5aXAIMpGrzTASAP5snIzHnNCfUD7dtWfA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4e456rkt44-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 16:46:09 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8eaaf673eb4so1297614985a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 13:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778618768; x=1779223568;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYr1O3U6/SXVN5rudFYRAdAuWOpaLoIuDsz1B8w0T78=;
        b=dJ6C6r37t/3PFdY8tZslXNLPniVm+Sq+1vrxpQuAOjkqkBxJi2lsz7zOXr1B0l631y
         56nVCByUXpzEqN5eWOkYe2YDV97cr18pFvy9vbHYBwAhW0qMcPEG85fIn/r2zHcED50g
         HyMk6nONEadgVowGZVdefYZZLSRTKtJGLY/bAmhS0GecLodkATkvydcWfKRQaJuTxweW
         91D39eodhcg9ElDK6PIxPNT0QGvwwnD0bUfZxflKSXFz8PAFCsHuX8gnNa+Vn/4SRdP6
         MQTk2XXWq3541D1HquyQKagWnWmmGSGZY6e41rZxVp99162LV1nNNCoKjM93QoEd5BE5
         RUSw==
X-Gm-Message-State: AOJu0Yz/sb3+8Z8HTqV6+tsbnqMBUDFQdHP8L1BuEQf6RDG6DkbJo/N1
	BXeePZDiNFIn075OWVR6l641KJDWZF2ke8JUOso32CqS0SJwNe9AH8eDWnYgp05aGOHt6/HXVp2
	JxsT0BXE7wq88FMedoqXodBHwgzXyNmeC9uvR5qorPRWzxxq8QGboPqALlWy7FJE=
X-Gm-Gg: Acq92OEEAevyrNK8owIQ7pwwOjBbwf458qbuLznb+hCQoBQDQ27U01yoU/JZIK70sAw
	o974nl48QnZONTH9crrlTLNGc3Js3sKBgHuaBFtK8ZoGjncYmcJyxCPkpJy5ZbA7OOw36H21i11
	sloVgnzwYsa/WG5/Vg7/N30VU9vcwZFM3Wa8xkEqVWX0Mb2fNf3cU7T+wmBnYcNl/QdUq+yX8zt
	r2POPEu9v5XtI8v+rQgX+oOLDl7sWcQLJW9DbXyjzVAfuT19JZHR2eryinw2JJNWZQNyWDf2Z6p
	w++hOzpxfkrSoE3g7jEbcsrVrb7YM97IXZKUBUXb/AxvOR4QgV4kpG8QXTiiO1i1yRSGDjtrPlc
	HiXF95EKTBq7CKN6d4lOg3aXRdKIF91rpohtvwwR2Iozc7rykaVh00RCf651WIkZuFpc=
X-Received: by 2002:a05:620a:2a0b:b0:90e:5b62:ea07 with SMTP id af79cd13be357-90f8b2d998dmr99073685a.56.1778618767923;
        Tue, 12 May 2026 13:46:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0b:b0:90e:5b62:ea07 with SMTP id af79cd13be357-90f8b2d998dmr99068485a.56.1778618767456;
        Tue, 12 May 2026 13:46:07 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-90ccb338844sm374224485a.22.2026.05.12.13.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:46:06 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 12 May 2026 16:45:59 -0400
Subject: [PATCH v2] mm/filemap: fix page_cache_prev_miss() when no hole is
 found
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-prev_miss_fix-v2-1-4af8e5c1ae62@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAIaRA2oC/3WMTQ6CMBBGr0JmbU2npWJceQ9DSFuKTCJgWmk0p
 Hd3ZO/yfT9vgxQihQSXaoMYMiVaZgZ1qMCPdr4HQT0zKKlO0qAUT151E6XUDfQWg3danutGoUb
 gD7cc775byzxSei3xs+sz/tJ/powCRWOMc6g01sZe/fJYJ0f2GPoV2lLKF0C55NWtAAAA
X-Change-ID: 20260510-prev_miss_fix-fcb308472131
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vishal Moola <vishal.moola@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778618766; l=3136;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=EKfXg3Kedd/2DkHbNXwGJTPidd7Pkdr/1XwXuXKdOsY=;
 b=XtPXuvkoCm1dLlbLMYm8YnPBn5FHXiqvrKn66Ff+O/0gAOrwSIpFbZ4yjNJznwjCnTf+2djQV
 pdORZT40uA/CCnyUGfFOCNYhfjqQxp4soMcu2D6CbBB5SZVlZnkmFn8
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=d67FDxjE c=1 sm=1 tr=0 ts=6a039191 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=MarPr37N4K3uxDc3k44A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: fJPgKE2GTX_bT-U-mJTN8-Mm0U_IDnRc
X-Proofpoint-GUID: fJPgKE2GTX_bT-U-mJTN8-Mm0U_IDnRc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxMiBTYWx0ZWRfX+82qhcIyfJlP
 xTJ6kvaiQdV7KDt3KeTh1dajuqqHeSScRHlY/cmVT/WWNGhTDrA/Toy++cC+Fm7YDttgy3GkZ8Z
 lzwraY7OK1wPBQ6ojItEXhjZd7wJNgxShXP3OgkJVFm03MMqxqXddyu8LMW8RBawCdJKXFf/sj7
 nRfjt5f9b4VsAlrUcVqfdHGavxnPikNO/3CsyrOz2NYwpDfGOv0nTHugVUUoC8HyLEVmlR9PPPG
 apREo+kIWmFSXwqEVpFHBTQwT/8n2kvRnmKp6BiSd8Gi44mm1S784BTeG12lg9bERvyD8SKBCA5
 YC00QUY6/0/E2nnLL4fxJ/4r9E1AqQyPk6Md7L7D8mapi0zdflcoSUWsPVPxyaFTPGHMPfcTShA
 94XlwK4p6MkfHX3eo2gUZKuWNbN12T+Ma3fNjtSXXDiBCnXc4gygzWY1gmZAXUj9EjmCourAcPD
 gEB4+5CjssbHo88ERWA==
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11784
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 impostorscore=10 bulkscore=10 adultscore=0 lowpriorityscore=10
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120212

page_cache_prev_miss() is documented to return a value outside the
searched range when no gap is found. However, the no-gap-found path
returns xas.xa_index, which after a successful loop is the first index
in the range. As such, that index is misreported as a gap.

The sole caller, page_cache_sync_ra(), uses the return value to estimate
the cached run preceding a sequential read. In some cases, the buggy
return value can undercount the contiguous range by one, shrinking the
readahead window or pushing borderline requests into the
small-random-read branch.

Fix this by returning the start of the range - 1 when no hole is found.
Update page_cache_next_miss() for clarity as well.

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
Changes in v2:
- Change return value for clarity, per Vishal and Jan.
- Update page_cache_next_miss() for consistency and get rid of nr variable.
- Link to v1: https://lore.kernel.org/r/20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu
---
 mm/filemap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ab34cab2416a..4263d9775998 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1808,9 +1808,8 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
-	unsigned long nr = max_scan;
 
-	while (nr--) {
+	while (max_scan--) {
 		void *entry = xas_next(&xas);
 		if (!entry || xa_is_value(entry))
 			return xas.xa_index;
@@ -1818,7 +1817,8 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 			return 0;
 	}
 
-	return index + max_scan;
+	/* Return end of the range + 1 when no hole is found */
+	return xas.xa_index + 1;
 }
 EXPORT_SYMBOL(page_cache_next_miss);
 
@@ -1849,12 +1849,13 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
 	while (max_scan--) {
 		void *entry = xas_prev(&xas);
 		if (!entry || xa_is_value(entry))
-			break;
+			return xas.xa_index;
 		if (xas.xa_index == ULONG_MAX)
-			break;
+			return ULONG_MAX;
 	}
 
-	return xas.xa_index;
+	/* Return start of the range - 1 when no hole is found */
+	return xas.xa_index - 1;
 }
 EXPORT_SYMBOL(page_cache_prev_miss);
 

---
base-commit: e9dd96806dbc2d50a66770b6a86962bd5d601153
change-id: 20260510-prev_miss_fix-fcb308472131

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

