Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A153769E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310243; cv=none; b=jCBC8niQIWJ9VbPzHhV4XXCupbBZIz0a3ks6NHP+LAdwJWiqaVtj49OE92td/GODbp2DJPxWa+Qd7tfe7TL7xM0pMHZAkjQ5I0k2ku7ICwTKzkI4kOh0bNCrPZzpkpBp5OchKObbStqgVewx+TQpZr+tyELvTUTby/7Zc5ii8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310243; c=relaxed/simple;
	bh=jJu/raWzDXHDrGY3OmHYJ5IRBMbRwIJjRLBSVuVduxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHANK79p5/Hprk9UytQJiMu0g+S+ac7ykjgPG3jJVqIrsPbQGX51E5Kuxpw3IZBw3yoPN+2mNe+lLYoJVs5UdFMy2ZNSzjfU8jiX+ABWZjr/GmpO30I6Yw2Zq2Uvt/Vngivgx5VXA8sG5tIHPYRKH5pv167bDX7ykY9YmZqrYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=B0T0AnEW; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="B0T0AnEW"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKOHEp2013659
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=sToO
	R/Pf9Se6n6q9d83MywFIBvA3eA1y47gZuXeAAaE=; b=B0T0AnEW8S1XAAxYRdDC
	Jd/njvke3xOxdIRYA722oTLR9w1rS83qi2Xp/XDadg2RZ+8QRAuRaruu3txhGiA3
	WcAY2ChK5Axkc6i1dUYeDzaiPGtTmG6btqv4svi1AzfXKUxyfoU5EodM0i5uGh23
	x2xzAkPIz87g6dPT0sjt9VI9w6jwiBO+VSPSwfPFtK9zKdtSPZ+yZ9vACywTq4JE
	YI48gAATuweguQyGWHYhDCRN2/puaW69TUVcCLHFylJ3q4EmA41rhDmy9uhUvA/M
	KwbYBh3TbT9t5d9IGqAdrbF3hRkt5T1kOdVsC2L5+Q0xHZz1vyoaL5P3LSXSqmpu
	4g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e9fdn2muy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:39 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9134059a60bso1538306185a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310239; x=1779915039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sToOR/Pf9Se6n6q9d83MywFIBvA3eA1y47gZuXeAAaE=;
        b=NZpPWy2eC8M2XHxLDIe/UQJpQk8O/xWaodLu1yCx21ElMMnfjipvNwhQC8ZssOjaeG
         9tbNQi0eg8T6Ft4VYSBNuV6VnaBekjEsidmauD5msSkBOSk2mfQhXU0ZNElxfXgj7SVR
         YuiCb72y4GBrJMo/HDmIvuLVqCwb1sMYeikpFyP9JJsrXuwZPwz+B5tj8AB2QbT+ZvTp
         DknP01qxy6hNd+g7LYyC0tHtyDkS7njRZXCGeByoQCzWcSI/dJDAupzqk9Zivsq3kf4I
         R4JNOg05ynNu4RC+ufHa045gS35CqifE8UFrGChHIdz5cfRnDo1vzxIAlg0ZtFq1gled
         kVbg==
X-Gm-Message-State: AOJu0YzBm1rQoVcl64JBlZPW/rnjKqbl7HxiLfdcRrlH/SHjPBYpzvsJ
	tDxtAFm9Cr7u872Ro4Vwm2vN2xofOWl8G733rp1wUSzYxnb6nOaEHcUooDpPu8xIhI2rG9hldZE
	7ywD8NvOzZkFB/DyfifRbI9wdh+92tqueyLitrEsz54u7COhfXCbvVft2Wy5MqjU=
X-Gm-Gg: Acq92OH8WZqA1TREmjw8Lt1tDOY2RmujjFDaMym+NCFEOTVqMNWu2Udci24be2RM7+l
	VtYEI9iGjIeA/Q/O4SkkMsAD8WZOK20mXmwtb/FO0LwbPagyf1ZcH3PVBWlCL2D2dmZG1682hRO
	d7e9j2rAjHtittt4AaQYVrttJFx7hGuRUkTM/4nCrfZYJvXStGtDi9/IrWJ/VAB7RmDFX2o0HBJ
	eCekoljeqGlsu4Hp3bqWKwO0K5qsXiM7FBRYifq/hqvoVoq7WYWkwwmPmPrx1EwlCiImwXQxznR
	3rm2lzCOG+dZ50xQRoSEmpdWbKy2pyoZUjVgNcyFdP8krLCK5hSz+4JSMK/3O+Uvu8b0BeNwhby
	6kt8YmjdCCZQxxjHzylVWm1Iqo7mc6gGhKeECIRCIHc0BZvNwskW3I+hmeSBDhkENnBM=
X-Received: by 2002:a05:620a:f15:b0:913:e19b:2f56 with SMTP id af79cd13be357-913e19b63d0mr2524458685a.10.1779310239188;
        Wed, 20 May 2026 13:50:39 -0700 (PDT)
X-Received: by 2002:a05:620a:f15:b0:913:e19b:2f56 with SMTP id af79cd13be357-913e19b63d0mr2524452485a.10.1779310238647;
        Wed, 20 May 2026 13:50:38 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 16:48:58 -0400
Subject: [PATCH RFC 07/11] folio_wait: convert VM_BUG_ON_FOLIO() to
 VM_WARN_ON_ONCE_FOLIO()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-filemap-split-v1-7-c36ddc2b6cf2@columbia.edu>
References: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
In-Reply-To: <20260520-filemap-split-v1-0-c36ddc2b6cf2@columbia.edu>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=1934;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=jJu/raWzDXHDrGY3OmHYJ5IRBMbRwIJjRLBSVuVduxw=;
 b=aWk4flyPY3yiLsLPfjIZ128cQrOIzopXW9sJDfGsMadODQh9UbsXyooxIwmWJlV2xXqudRhGw
 BU3URuIRQ6lDLnXcm0mJlBPdMp+Mm+NXsFS8CdLq15K50p/AHbAIbje
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: milxhUmn4oHQvuG-8cvslzodWbFreIj9
X-Authority-Analysis: v=2.4 cv=P/4KQCAu c=1 sm=1 tr=0 ts=6a0e1e9f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=VwQbUJbxAAAA:8 a=M6LSvAv_FjuMSCFMCIwA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: milxhUmn4oHQvuG-8cvslzodWbFreIj9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfX4OqRej0JJJHa
 KwzcxrnOKdGmuJ/Qzzdc8JIp5gBCK8IgeQMKeoP/dRzp7FcMMTnHwCL2T77kWPvN2NPi3ea0e5D
 GoAM6wny7DsN3FGnfyFDBCNR6uEtzghrz6nMtHE98OayPr0dQwGhmyvQzJeiXzsaSbAWf7O+Q0j
 bD0yQoMonseZnrfDv3ofVd4o4CAhW6OpOyoGs9mJ54p47lToNDtpPJ09J/Fls8xoPABy3sDMuO5
 TV6dC+FqNvB3AzjAgz7lW2J+BmV6XdJUCjevJTIiS3AmGAtlKoyFxBTjCZfnjxQeL3gRRO5OzML
 +PUIhWWYSmg0y4tzZqjylkMw5JyilsjKODe95QpyfK83rYPshuzEGp82tV0YZWmtHMvbwm/5CET
 73JXwZ/sGACeoKbRWW/3Zof7ynI7bOq4BKPi/tl1jzhNco83hskK3E12gX9xp0dRMSaHis4nph/
 p3X9DmGgGIq7unlgIzw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=10 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=10 spamscore=0 priorityscore=1501 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200203

BUG_ON() is deprecated [1]. The VM_BUG_ON_FOLIO() assertions in
folio_unlock(), folio_end_read(), and folio_end_private_2() verify folio
state invariants and are already debug checks. There is no additional
benefit gained by crashing the system.

Convert them to VM_WARN_ON_ONCE_FOLIO(), as is now preferred for such
checks.

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html#use-warn-rather-than-bug

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/folio_wait.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/folio_wait.c b/mm/folio_wait.c
index 70f808729f9c..52d336bc7fe0 100644
--- a/mm/folio_wait.c
+++ b/mm/folio_wait.c
@@ -465,7 +465,7 @@ void folio_unlock(struct folio *folio)
 	/* Bit 7 allows x86 to check the byte's sign bit */
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	if (folio_xor_flags_has_waiters(folio, 1 << PG_locked))
 		folio_wake_bit(folio, PG_locked);
 }
@@ -490,8 +490,8 @@ void folio_end_read(struct folio *folio, bool success)
 
 	/* Must be in bottom byte for x86 to work */
 	BUILD_BUG_ON(PG_uptodate > 7);
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(success && folio_test_uptodate(folio), folio);
 
 	if (likely(success))
 		mask |= 1 << PG_uptodate;
@@ -513,7 +513,7 @@ EXPORT_SYMBOL(folio_end_read);
  */
 void folio_end_private_2(struct folio *folio)
 {
-	VM_BUG_ON_FOLIO(!folio_test_private_2(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_private_2(folio), folio);
 	clear_bit_unlock(PG_private_2, folio_flags(folio, 0));
 	folio_wake_bit(folio, PG_private_2);
 	folio_put(folio);

-- 
2.39.5

