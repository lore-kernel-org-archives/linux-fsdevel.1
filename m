Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD333AEB29
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Aug 2026 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786306060; cv=none; b=TxczPeAJOCvw+f+mYWCUeTncXcX6rzg+WTMJ/6DgVh9Q1Yyamk6y4I0wtLE6uCmFJixwjkktfSfdPXBXIqW9UsZWfE8kGsELdByB9qYynkuSrcJBWv9MwKPlOKUitPiYTg8yoyDYphUjhfgBBNdbY1QqMmSG0BZpdIzBBS433YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786306060; c=relaxed/simple;
	bh=4l8mwGCLHsnbyRzKZdgPmnVtCPUMm65xloPvyeu9tsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dbJblxoCWg3nU7tk3/rPmAYByUjWNwHFhp8I4OGmv7n2kMlW1PfSi0Kpg2jNcM2/8+Diu5/nq2wSiFL2203K8c4/W9up1GgjZ+AfdKz5rx+PFhgBIk7mI28KjNNlZyuXOQAG8w6ttApvTnuSh0XOcBNxP+BEWcSf9AFHFSCL/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UFY0AIMu; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UFY0AIMu"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679J19L02171710
	for <linux-fsdevel@vger.kernel.org>; Sun, 9 Aug 2026 16:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=jZrGIT5Oc6IdSUTOzkB0db3oK/
	pXj2mbEAqJhE25bU4=; b=UFY0AIMulSQgSJA+PrJZwPqEw8ueZ9/KK8iOaMxVqv
	ocy0IaQRrnuW6I3KsqRjCGCL64ryRjQ37jzA7tDknxDOZbtFUxrveBx8ABCbrIdb
	qXrX6cvNz1845j0i+6NyMhESyGMXk6o4rkvM8y6FE37+O6EiiwwyHhgf/FvuQyS/
	0hP5YVB9iUpBsxouC6+jLW0ZO1dOX2EB62VSlXvLPOw8yiLJeM6j/RVnvcH/+tsZ
	9BBrCuaEed4l7EKPVO4YLVt4hFuCbVfiAmXIUIp63TMU6RE0NK8ovzAwIb1gMMdI
	bCXXov9BMpARsw4SEfSSlDcu3mcCV8c5qXBB2YWmZr1w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fxyb9865b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2026 16:07:37 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-529ae8e96e8so10863171cf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2026 13:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786306056; x=1786910856;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jZrGIT5Oc6IdSUTOzkB0db3oK/pXj2mbEAqJhE25bU4=;
        b=YW9xEHb+5fy7Ik1wa1Q6BfsbzZPQWH5jEFCVqguX3KKvrsl7Yub5Ia6oPdOwVuG2E9
         EdOilQJ5SOp4sDBvz6nhso8+ikdS6/PAljTFsCV8o81yGPE2Tb9ZIs9xsMi0/VQlmCs3
         7PQfNbbb/q5jEWXL1PeKg3hQ76p9AuF6+bDrZC/unSWmWgoCFLF0CmxSDUsVKmUWw9mj
         Xm1aoHmpvwFQPl4Wu+NNM0VfKZ3cLEvZLs2SEn3YrPw7L5WKxpR1QYjj1yyuKjaiDKFG
         zE+aJuRMNlMYeQDrDS/fdxqaqz58BwxNTTr7Tjbtrd8vc18KVPyguUaScask+jit+5N6
         fLfw==
X-Forwarded-Encrypted: i=1; AHgh+RplJ4G2qdtBzfxrFMoAkcxUlyiNJ8kB4nFlVeD8YaGifjoVwiGjHU4UCRcwunzMf9l+uyy/W23sN+8jSE3S@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91R35QJVVsw3wvOOE++uEqsGao7Vajtq9PWbrnQs2UNtqgSYJ
	1aoIWwNlJ0lvDazr7h8eUFq7rYXXN5VYDdN82/FJ14K/wtt3XHb3qtGnvhvev4o3stUPHCcln9J
	6oZmYgljeYay6C4afD9gjd97Ex/6vxOaGl5tFDxSIX5RyIu36dCM5GuS+pkdl1wc=
X-Gm-Gg: AR+sD10ulwPuAn23vdaqnPEFY4yBjiBWgnH9nAFVYchMGWsUe7cqOMFcd5w4dYwodc+
	SNVCCe45yyhI8OQgUXRpWAwsmvV6De/4uGmUPuMMmJNP75w/ptMIBfz0BnoN/FGmIaxcrB36GHs
	hsk2MrSbnQowOwxSycImoZ1HCkIDE+tFMLXqRI0B52/M4Pockhnnw5UqEvB/LbfQGLySuLIrOuJ
	f4yXU6it4unoB9aqhDRYug11F7Xc/+4o8mXeRNt3m9l3m0tiMYPaDLVYG6v+9US6Cx6rzXNSdrt
	C9cppdLmNSh9+TUKXrQtl4SoLt60TTstRLG4C231W4tQ3DXMBHCFJ0neICf86WxThGM4Wy201/t
	XYVfmrE4=
X-Received: by 2002:a05:622a:143:b0:51c:1c2c:a8bc with SMTP id d75a77b69052e-52ce61fa747mr328162521cf.37.1786306055999;
        Sun, 09 Aug 2026 13:07:35 -0700 (PDT)
X-Received: by 2002:a05:622a:143:b0:51c:1c2c:a8bc with SMTP id d75a77b69052e-52ce61fa747mr328162151cf.37.1786306055575;
        Sun, 09 Aug 2026 13:07:35 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021509a5sm24687569f8f.16.2026.08.09.13.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:07:34 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 09 Aug 2026 16:07:10 -0400
Subject: [PATCH] orangefs: use folio_pos() and folio_size() in
 orangefs_page_mkwrite()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-orangefs-mkwrite-folio-v1-1-4978a4239475@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAO3deGoC/yXMyw6CMBCF4Vchs3aS0kgFX8W4kDrVAaRkpl4Sw
 rtTcPmd5PwzKAmTwrmYQejDynHMKA8F+OdtfBDyPRussc7UpsEo2xoUX/1XOBGGOHBE8pWz4eR
 s1R4hnyehwL89fLn+re+2I5+2GizLCjbOGd56AAAA
X-Change-ID: 20260809-orangefs-mkwrite-folio-ec562f7625b4
To: Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, devel@lists.orangefs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786306052; l=1956;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=4l8mwGCLHsnbyRzKZdgPmnVtCPUMm65xloPvyeu9tsE=;
 b=Tj0cQeR4tlFVEEa1fNMy9VukpZ3yf7TFCxJhRplLZC07kcZNHTJ7s1aJx3KMcB5zv///hkthi
 j5qQ8G28ud+A1vpFZxnNJgG9ZwU2LTnSZjMUPez2a25fm0PlrH03uAY
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=QKxYgALL c=1 sm=1 tr=0 ts=6a78de09 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4ZCcd2BMeRglEraMWuXsMg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22
 a=VILNMIIe4WjoVSEO4DUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: nYeWO164hM_GVABnw42ecLdBLGm3580y
X-Proofpoint-ORIG-GUID: nYeWO164hM_GVABnw42ecLdBLGm3580y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDE4MiBTYWx0ZWRfXxk0iLq8b7+Io
 wbtkIYUDFE5RrELQz7nhjXV6T2kU5jFy5+JImvooXYGEqCsRcRK34i6sflVw3mx+hAKOMpujoT3
 fwgb4PoBO5HXr8g5a5J8aqpD+lyB0JccxReuInJjXp5x4e5wyTiiolrA2LdPiEhrRmSrOlEB5Xt
 wximBKJvBQQ7/XYbLWEDyuSXcNjXXCPzO0ZmKGkS4YVIBvqk1KvPErJMQVxEFaz1u8sYQueD+DT
 stKURRa7Aj1pQkWmRDT53r2IjLfDOqJ1hVuZq6uS0oUfpCoXx0dik1PEJR0OmJf1Q8QiAeSRm9I
 ST271tM3rJd1FGO46t75puoBP6KayWlNhpXOqpIHDUlevXJoD/SaxB7UYtsl94h19wpUuKXNX3d
 JnMhbaZ/QcUO+TGDMKa7IeV9FeDL74BPtXB35Ac7R7Y9kNg6wNAFTdPXcEn8sG40+ffV21Q9/RX
 L2W3ptjvqvzlzgmEBBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDE4MiBTYWx0ZWRfX4UN68F0pmHKq
 WCHsdBPwkowDJvMxwYywVe2ED9F2nFaHbaJpz3vxPCVRumLagPDFih60maOCGZBaSapxk6Gk6+P
 6xAcj1hst03DFwUExkDcypAbSwPCjehvxY59ELLW01vIeZrq2ybJ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=10
 clxscore=1015 impostorscore=10 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090182

orangefs_page_mkwrite() records the faulted range with
page_offset(vmf->page) and PAGE_SIZE, although the write range it sets
is attached to the folio and the rest of the function already operates
on folios. Use folio_pos() and folio_size() instead. This gets rid of
two calls to page_offset(), removing two calls to compound_head().

No functional change. orangefs folios are always order-0, so the values
are identical. However, if orangefs ever enables large folios, this
change is necessary for correctness with the current write range
tracking scheme. Tracking only a single page of a larger folio would
leave the rest of the folio's dirty data outside the range that gets
written back, leading to data loss.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/orangefs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7143b64b5b25..cd3273c88e03 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -652,8 +652,8 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 		wr = folio_get_private(folio);
 		if (uid_eq(wr->uid, current_fsuid()) &&
 		    gid_eq(wr->gid, current_fsgid())) {
-			wr->pos = page_offset(vmf->page);
-			wr->len = PAGE_SIZE;
+			wr->pos = folio_pos(folio);
+			wr->len = folio_size(folio);
 			goto okay;
 		} else {
 			if (orangefs_launder_folio(folio)) {
@@ -667,8 +667,8 @@ vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
 		ret = VM_FAULT_LOCKED|VM_FAULT_RETRY;
 		goto out;
 	}
-	wr->pos = page_offset(vmf->page);
-	wr->len = PAGE_SIZE;
+	wr->pos = folio_pos(folio);
+	wr->len = folio_size(folio);
 	wr->uid = current_fsuid();
 	wr->gid = current_fsgid();
 	folio_attach_private(folio, wr);

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260809-orangefs-mkwrite-folio-ec562f7625b4

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

