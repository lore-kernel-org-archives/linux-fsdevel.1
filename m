Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098D376BEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310247; cv=none; b=s3xXKo6DFRkV1qy98ouNYAo4xi/LT2ftfG7dYeWre6K6VT9zDzRXVr9fEk+S0+MeKh9FSsC+GKy77tHVuNhVEwYOXqGsd9ETt8A9i8POsTFyV4/7RQzpMxa/WMARDobHmlDJxiSGqT5CEToyWLdZTD/JSneV2nqkXXm2ixTyWkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310247; c=relaxed/simple;
	bh=MdnqSRc2FJHBhrARlYsy3cs/9UevS5fEoCvn0pE0sDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ke3Sqd4MHNSvNc6rApWw2ZTHcMDxdw7bFqmrUb9gSM5S8wXtBlD0yzHmLzv2uqNIOi0evFafJx0FxffyJSJXTXnehquZ2iS1v8CIu9Il20mi2VfGapiLIsssF7DP4jBYDmYDWcW3Wjaat/MGPWGTCsQb4KVe6LqZ87NRDUwaHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CxuJGpWL; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CxuJGpWL"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKbrHB1686386
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=y+gj
	tILqDLOQsRHv/xOkAmWQ2cCtCFJ6veJFyW78pUo=; b=CxuJGpWL+kS84wunAt9h
	U/LMKliWuP4nB71UXrm5g2rej0P5N7Idq6BmiNfKDH80LLeVfW44ieNa0/BkXXsi
	+L9TIuteWD2e2V/oKCwp2pBm8/BevB3hAA68MBGegIkV4f6lcMhzEeWtaWIZ/onj
	AS5ayl3chCL64tG3bR5sORVXXnch8+A3TP6eyrsP+oZjdBtNP6ga3aSMnRwc0p6/
	BYV5Iilum2otM/TkKY8H/+zERGVJ7saJ/nflnYcYRup6RXfZY6tt6SAiOZhn8cYW
	OdnmFxoq6yyFwNO6fg+uSBMB8Kt/ndgipMDZ0G1TcX+iqata3s5oeMrGTtuoq5nS
	pg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4e9m5n02f2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:36 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90ccab62c33so602053285a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310235; x=1779915035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y+gjtILqDLOQsRHv/xOkAmWQ2cCtCFJ6veJFyW78pUo=;
        b=jK9/JJ4SInQ2MiyV2PHiFNJ7Ev2ykJoxCSBlFHtQIi6UIhR79Sw2wkkHosC9RwO2lw
         /cKSsE6TgCoCFDQEkjTXEhnuejzwe3UqjmSvZjmk0qz/6G98byWL8qPzzjh/qO3DDlqF
         Fet++H2wF3v/dHfjMU5z7dR7oo537qCv94jfAmAD+55e/fBpH26Wh0zGhy3FyTAlKG26
         8UotgR4HkAY+7J9n1E413FszeVjCzQfS+SGSHvApm0srh9z7HIyW4eWCbNnXrBujbvci
         Dhii6spPqn2DV35p8TdsVplvy68aJeY0d9E71lMXZQFVkaI9mpeNMwXT64Nk2tBizn8c
         7iOw==
X-Gm-Message-State: AOJu0YwHtLHaQLBgGjKmKzjCML9WbRoqCdBcbahR8bYuNAtsg4FX7/Hk
	3k8erlgvb9op5bBzuJ2QZa0ASBr76kwLs/UykG26b1ioRY0Ly559I5zWT/MKUv/pqMi1hnH9VGI
	0EWbuopm49TeSZ3I7yLcn31QofaiLYOjunm3BXpVJ2AutFsQvv8Y5MnlvfQYgzTI=
X-Gm-Gg: Acq92OHxpvqF51e3BmN2cS8dvXhECtinb2L+ymCk0S/oCWD/JWcJ106Lj7iCfBVZR2S
	AAVxep7EICpVC7E6uKk630HO97tw0FSUUGKD19qr2ALM/xm1eE2bfPzAcBxYHrBTnAlPFFMXLL3
	ybvcK3i1+a5/luIM8/I2rIJZ/8waQUlvh3jS4wRcEeihNzrLH0SyRT/tEq1/SqcP+auYzyB2N0/
	0RgqNhl9cXJxwrZ6ZCyTO+VCozoHeKjdmJRmZsdgUqmZ/vtspF1j0M2bRbSl/KHha6uI4uh8PAh
	VxtFoyzFhVsWHKlzyTO0Y4UfjBMrMGjjoEv2rlFD7CgdE16ePDz/s2pA30FsrzjTGXr41TORtGs
	b+jwE9sztlG3PiooKGTVCzOkf9utmnhaRM/fBx1W/BHAdA2NtujU7q9/gX21Cge1DET8=
X-Received: by 2002:a05:620a:4542:b0:8ee:dc47:3b70 with SMTP id af79cd13be357-911cef062demr3495258785a.39.1779310235395;
        Wed, 20 May 2026 13:50:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4542:b0:8ee:dc47:3b70 with SMTP id af79cd13be357-911cef062demr3495254485a.39.1779310234746;
        Wed, 20 May 2026 13:50:34 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:34 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 16:48:55 -0400
Subject: [PATCH RFC 04/11] folio_wait: move folio_wait_writeback() family
 to mm/folio_wait.c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-filemap-split-v1-4-c36ddc2b6cf2@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=7803;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=MdnqSRc2FJHBhrARlYsy3cs/9UevS5fEoCvn0pE0sDw=;
 b=rkMG4EwgIAXfDMJhpCN/bphiVIHAebicxGt8s33PBw5nTp2DJPdH7PqP6gawcVTAxyPkOdXvw
 WsorbnVQOqHC4h13v+JdnPOZqm2wLrEZ0r4jbfVOfOBi4GxGI+ybNHp
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: Ad-wHxRxhoX8HA1HGDMUQzmKmhGprpZu
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a0e1e9c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=oq273MN9QaURjshXV2UA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Ad-wHxRxhoX8HA1HGDMUQzmKmhGprpZu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfXxZp5ZnfpmTFa
 ucxKxTQxoMRsyWskv3TaVQTNQC585D0jtmMFnkK7EjrKnhRh8mOOduCw32ygJ5QAP/A+/DjXp0n
 HoRT2Z0UeNQOAj0wzyPih3AK8TxitKL1v6dVyEhCv8GjNxTMZ0NxZyPwOXcVqPpobWsigOrNtEw
 JnLkPmKXU8bi5a5BuVV7VOYpbahFcmDUUuf9WgmYPsWf7eoega7H+U+KLPz2ulzva4YDxXuiZht
 y9Tv8abt+Sa6LFLzsasJV/sqfb3D+OwyW7lCrP1daQlQl7jgGA00w6v/J08LCaD3wdo4axqZTX9
 VOtTcEyKwNdmrV7fUpj7w7vf72tc3Ur8e4u1BEvTOwroy3I43t0eeA2RIXt5CYjBaqKw4lDl0VX
 I9rKwZcQ1agWspxmDn7VVMGRliIUOpjUMmG+wamS8fGRaT96g2sUFnPA0Jn6J91RXsn/wNmnFt6
 fqm+AhCz2Pjg0NWi0jw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=10
 lowpriorityscore=10 phishscore=0 adultscore=0 priorityscore=1501
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200203

folio_wait_writeback(), folio_wait_writeback_killable() and
folio_wait_stable() are thin wrappers around folio_wait_bit() and
folio_wait_bit_killable() on PG_writeback. Move them to mm/folio_wait.c,
next to the rest of the folio bit-wait infrastructure.

The legacy wait_on_page_writeback() wrapper stays in folio-compat.c, as
its days are numbered, and it will be deleted once the remaining callers
are converted.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/folio_wait.h |  4 +++
 include/linux/pagemap.h    |  3 ---
 mm/folio_wait.c            | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/page-writeback.c        | 66 ---------------------------------------------
 4 files changed, 71 insertions(+), 69 deletions(-)

diff --git a/include/linux/folio_wait.h b/include/linux/folio_wait.h
index 80ddf1ffcae4..4a5cb2fcf046 100644
--- a/include/linux/folio_wait.h
+++ b/include/linux/folio_wait.h
@@ -178,4 +178,8 @@ void folio_end_private_2(struct folio *folio);
 void folio_wait_private_2(struct folio *folio);
 int folio_wait_private_2_killable(struct folio *folio);
 
+void folio_wait_writeback(struct folio *folio);
+int folio_wait_writeback_killable(struct folio *folio);
+void folio_wait_stable(struct folio *folio);
+
 #endif /* _LINUX_FOLIO_WAIT_H */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7f65c2b0097b..84ccb682cca8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1074,13 +1074,10 @@ static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
 }
 
 void wait_on_page_writeback(struct page *page);
-void folio_wait_writeback(struct folio *folio);
-int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
 void folio_end_writeback(struct folio *folio);
 void folio_end_writeback_no_dropbehind(struct folio *folio);
 void folio_end_dropbehind(struct folio *folio);
-void folio_wait_stable(struct folio *folio);
 void __folio_mark_dirty(struct folio *folio, struct address_space *, int warn);
 void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb);
 void __folio_cancel_dirty(struct folio *folio);
diff --git a/mm/folio_wait.c b/mm/folio_wait.c
index 06156e138c09..9d3328717bb3 100644
--- a/mm/folio_wait.c
+++ b/mm/folio_wait.c
@@ -15,6 +15,7 @@
 #include <linux/delayacct.h>
 #include <linux/psi.h>
 #include <linux/migrate.h>
+#include <trace/events/writeback.h>
 
 #include "internal.h"
 
@@ -572,6 +573,72 @@ int folio_wait_private_2_killable(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_wait_private_2_killable);
 
+/**
+ * folio_wait_writeback - Wait for a folio to finish writeback.
+ * @folio: The folio to wait for.
+ *
+ * If the folio is currently being written back to storage, wait for the
+ * I/O to complete.
+ *
+ * Context: Sleeps.  Must be called in process context and with
+ * no spinlocks held.  Caller should hold a reference on the folio.
+ * If the folio is not locked, writeback may start again after writeback
+ * has finished.
+ */
+void folio_wait_writeback(struct folio *folio)
+{
+	while (folio_test_writeback(folio)) {
+		trace_folio_wait_writeback(folio, folio_mapping(folio));
+		folio_wait_bit(folio, PG_writeback);
+	}
+}
+EXPORT_SYMBOL_GPL(folio_wait_writeback);
+
+/**
+ * folio_wait_writeback_killable - Wait for a folio to finish writeback.
+ * @folio: The folio to wait for.
+ *
+ * If the folio is currently being written back to storage, wait for the
+ * I/O to complete or a fatal signal to arrive.
+ *
+ * Context: Sleeps.  Must be called in process context and with
+ * no spinlocks held.  Caller should hold a reference on the folio.
+ * If the folio is not locked, writeback may start again after writeback
+ * has finished.
+ * Return: 0 on success, -EINTR if we get a fatal signal while waiting.
+ */
+int folio_wait_writeback_killable(struct folio *folio)
+{
+	while (folio_test_writeback(folio)) {
+		trace_folio_wait_writeback(folio, folio_mapping(folio));
+		if (folio_wait_bit_killable(folio, PG_writeback))
+			return -EINTR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
+
+/**
+ * folio_wait_stable() - wait for writeback to finish, if necessary.
+ * @folio: The folio to wait on.
+ *
+ * This function determines if the given folio is related to a backing
+ * device that requires folio contents to be held stable during writeback.
+ * If so, then it will wait for any pending writeback to complete.
+ *
+ * Context: Sleeps.  Must be called in process context and with
+ * no spinlocks held.  Caller should hold a reference on the folio.
+ * If the folio is not locked, writeback may start again after writeback
+ * has finished.
+ */
+void folio_wait_stable(struct folio *folio)
+{
+	if (mapping_stable_writes(folio_mapping(folio)))
+		folio_wait_writeback(folio);
+}
+EXPORT_SYMBOL_GPL(folio_wait_stable);
+
 /**
  * __folio_lock - Get a lock on the folio, assuming we need to sleep to get it.
  * @folio: The folio to lock
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 833f743f309f..50f548bbb375 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -3042,69 +3042,3 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 	VM_BUG_ON_FOLIO(access_ret != 0, folio);
 }
 EXPORT_SYMBOL(__folio_start_writeback);
-
-/**
- * folio_wait_writeback - Wait for a folio to finish writeback.
- * @folio: The folio to wait for.
- *
- * If the folio is currently being written back to storage, wait for the
- * I/O to complete.
- *
- * Context: Sleeps.  Must be called in process context and with
- * no spinlocks held.  Caller should hold a reference on the folio.
- * If the folio is not locked, writeback may start again after writeback
- * has finished.
- */
-void folio_wait_writeback(struct folio *folio)
-{
-	while (folio_test_writeback(folio)) {
-		trace_folio_wait_writeback(folio, folio_mapping(folio));
-		folio_wait_bit(folio, PG_writeback);
-	}
-}
-EXPORT_SYMBOL_GPL(folio_wait_writeback);
-
-/**
- * folio_wait_writeback_killable - Wait for a folio to finish writeback.
- * @folio: The folio to wait for.
- *
- * If the folio is currently being written back to storage, wait for the
- * I/O to complete or a fatal signal to arrive.
- *
- * Context: Sleeps.  Must be called in process context and with
- * no spinlocks held.  Caller should hold a reference on the folio.
- * If the folio is not locked, writeback may start again after writeback
- * has finished.
- * Return: 0 on success, -EINTR if we get a fatal signal while waiting.
- */
-int folio_wait_writeback_killable(struct folio *folio)
-{
-	while (folio_test_writeback(folio)) {
-		trace_folio_wait_writeback(folio, folio_mapping(folio));
-		if (folio_wait_bit_killable(folio, PG_writeback))
-			return -EINTR;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(folio_wait_writeback_killable);
-
-/**
- * folio_wait_stable() - wait for writeback to finish, if necessary.
- * @folio: The folio to wait on.
- *
- * This function determines if the given folio is related to a backing
- * device that requires folio contents to be held stable during writeback.
- * If so, then it will wait for any pending writeback to complete.
- *
- * Context: Sleeps.  Must be called in process context and with
- * no spinlocks held.  Caller should hold a reference on the folio.
- * If the folio is not locked, writeback may start again after writeback
- * has finished.
- */
-void folio_wait_stable(struct folio *folio)
-{
-	if (mapping_stable_writes(folio_mapping(folio)))
-		folio_wait_writeback(folio);
-}
-EXPORT_SYMBOL_GPL(folio_wait_stable);

-- 
2.39.5

