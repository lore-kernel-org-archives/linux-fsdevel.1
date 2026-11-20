Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204298;
	b=g5R2oe48IYi/kN8KlJd3TffPMVWnWFHV+jGXjZSpHlvB38pcXXeLxT3VxKJRn6iqoeaT
	 BnRywsN/RtjsOscc///k3DVoeU/QfJPCJANev0XB5V9Bd4w7MYiTYwkpTFtOu5RAuNcBQ
	 TtpzMVotq8+nyjbr9pTz5OwMRrr2G8wAKxcwSCDfXzLf+3hxMYFJmRnS1IqLEmWK/DylB
	 oN3/d857z5yJ61t32ngKg4Cg2qmxunwZtl+8XlxdzyQbVZvLtKL3+bord/MfaYpaKQQFK
	 5VkgSLH8SaXKNaFuQgDaTIWmD3aE9BdFx7+sezpWF46Fyf0Jrwqant0tNbJfIKU6jVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204298;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9cJLPnhCCqaqzy8xIMNIAAGiCcr8uWzwwAnlQW3eAlY=;
	b=KmywhCirOUBRvxCI5n2pDodNE9bHAKQg2VlFK4Fh8TCR4XBAoTzm6tr+q3okSbM2Bwu0
	 lh0qNlbPwEEUtolcmWo7/g3E0WrZLB+q3OvU1iHEXCtuI9UF6BJQyy7FT7K+cOSIxPTE3
	 XNLzpLIxaEP+7Cl2QSE5SSsidxexSDDBLnnJ7EEki96LizZpugNQP+DW3HXLb2FhwDIyX
	 XEYOy0ob52RNKW3IDJG/OyBJtdiUYk/oaRljhihUAgb8e1wzSw1bfXIUWK7taDyWbb/Ud
	 nqqKHzLfznIYTC6awf9AEwz4rm/uiABCNG0yOUR80vwm6C2wUpaB5AE/NTxOh7HhpUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=OiwPqAIv;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=m0UgFmDL;
	arc=none smtp.remote-ip=148.163.135.74
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E867C606A6DD
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 19:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E867C606A6DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=OiwPqAIv;
	dkim=pass (2048-bit key, unprotected) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=m0UgFmDL
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKJYBpi3725362
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=9cJLPnhCCqaqzy8xIMNIAAGiCc
	r8uWzwwAnlQW3eAlY=; b=OiwPqAIv0AlmHcxdo4Y6QFyYubrXY+Yz4DMcIulK83
	2VXN1xXuVHMMtZ3fPkgwvBhhRMjc8MzgAO1oKpwgzre78SrKviRBY073I0LxNrDN
	TG4Ab5/g5dwVJCJVNg6/kQq5eGcW0Zd3UU4zqj3fBVb02QZhubtNq5pJDcjeIgAz
	7sEZsf+01//69AoC4NGo6m/zCQZVOzscBPjf9LHp798DMzY9OtAWcszkiD0JEC13
	6bfH0hqZ+cYo5FZszYqdkpah1ttXRDJoGqFTEIV0z2pw1yy7IEO+Juvw+P6iuWn+
	T7pojjqdqpSHmDCDaSwmwTffscKaASCnVhmRwYcQ3MFA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rrn2cm3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:51:34 -0500 (EST)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-536778a8137so23761521cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 11:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795204294; x=1795809094; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9cJLPnhCCqaqzy8xIMNIAAGiCcr8uWzwwAnlQW3eAlY=;
        b=m0UgFmDLzmqYyr5O6RxdS4eAZfosF77MEqjdcKrVMp34fpsift4q1SBoadMLZKyRC3
         z5A6XeNqWdCbvS06w2UF6JDdMPnCyr1ADLu8aSxdYYrxkDmXhXA3mRheGUba5905EO+p
         GVHKs3TiUj0UjWXZWnU2Y0d3gbnzZTe6rYlw6itbgJN9MU5+pyMkrsKQnS1N5pvZIRNK
         Wmfdxff1S6saoENn4OxIQZU74/wqp96bhhIiDEUWTIlhz8AvJUGuVoPLQaS3qttF4+9W
         3ur+Z33Tmct838puUQSTtLlSeVploNqXHP3AIUbO8iqp9AWBFnr3QjYwnSoj7kWsK0z0
         /G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795204294; x=1795809094;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9cJLPnhCCqaqzy8xIMNIAAGiCcr8uWzwwAnlQW3eAlY=;
        b=07doxl8kr6izBWaB6KW6NFvOZidqw/B/j4kkpH5AJ8haSb+a3emL7+Lh7BnmFyE5Ro
         HYMVzyzzefO468E9nZZVk+3+GcuEjXluBPx4kaOBW1VhDvk6tkWUX7LRLR71ton9qz2N
         lCBYQEyc2Z8nI+22luemxUTmE3XbguwfjjSLwut+kh7MZ4GNjDvFRownpKnQUgIC4wPE
         S72SOskpfrxWXlTUdll4jgDV4ZVy3dDPkILbYzeaiEDYovAqlf40wvs9rqfA+Ci9LL/h
         cxO1dzihhFstNupe9FGw98qwvKCReK8xYjBj1b5/5v6Ekzi/G3ppaGVTzSJC8hpp9TGu
         nQVw==
X-Gm-Message-State: APuU4Z+n9Onf2xAOK79c2H+tfcy6MOJmI3I0RbXsTZqwuYeyOfkyj5uX
	DxfE+RLPU8UrBYq/KD2J539c+oveNpMqD39eldbjxFG+9fPDSAKZNd4HfobbPE/PoNUshAZmxHP
	2dO8UZUdIVwFIHBEKJeqajSKi+oB68tZzcULMM2bmRfpgb1zlfJI47ZBuVndURTc=
X-Gm-Gg: AYBFou1Te+LpINCeXUb5QkvfE1rB0zpRI+Y6tsQTeBm2gsoWo2SsblShm1QtrN6TZcV
	HDHHZiRMO2vVelHBvi7pYj0NYv40oOkoDTPYm6ISJ4fuzgCQYhA7D324cyI58qNoa/UTPRFfL5T
	1E/0tTq/ZSp9vtlz589F9NZ5ummebKVsnA21JVRKKGH0OI8Jp1bF6H2TJk7SBzCsqdHsWyO967Z
	zvidRHkK6/Jt9c1WVscQJkT1YjJ3GNsOkd2q3bghjMnvcgofbsZ39/x4b2TCozidmnDXY7/T/Dj
	nef9wjWgf2Lzqw481m/jFOoHIP0DhNOtEX93zZ2BqyHDlRaZMqpNH7wnF7MIz0POLf7t3r1aJlI
	qsbWCwEhPQq7QzFz0WLDs0f9NGoM3anKUWkywYtkQG73YZf2phdfwaQXQs2aKytfxyBTWG3z3/V
	AEXEy8lHUzpWvA9DQG4n+v
X-Received: by 2002:a05:622a:2283:b0:535:1b18:202 with SMTP id d75a77b69052e-55d769ea03cmr73000011cf.16.1795204293772;
        Fri, 20 Nov 2026 11:51:33 -0800 (PST)
X-Received: by 2002:a05:622a:2283:b0:535:1b18:202 with SMTP id d75a77b69052e-55d769ea03cmr72999741cf.16.1795204293341;
        Fri, 20 Nov 2026 11:51:33 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu. [128.59.178.217])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882c64fsm31402251cf.10.2026.11.20.11.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 11:51:32 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:51:17 -0500
Subject: [PATCH] mm/filemap: only drop dropbehind folios on uncached reads
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-filemap-dropbehind-read-v1-1-a373ac3fd993@columbia.edu>
X-B4-Tracking: v=1; b=H4sIALSkAGsC/yXMwQrCMAyA4VcZOS+wVBnMVxk7tE3mIq4rqYow9
 u5WPX6H/9+hiKkUuDQ7mLy06JYqqG0gLj5dBZWrwXWuJ6IBZ73L6jOybTnIoonRxDNyoO7c8xD
 dyUOts8ms7995nP4uz3CT+Pju4Dg+E7liP3sAAAA=
X-Change-ID: 20261119-filemap-dropbehind-read-db1046d9c23a
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tianyi Chen <hi@tychen.cc>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795204292; l=4127;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=/dZh6qIXS8/hlDlHkKu/8ShS6WT0I5PYluolWLn5EJY=;
 b=UeFEsJv0qY/2ABML8t/S23qbXkn6Dtp7EL1LHFco0i3gugjIu3SDH+u/LHWrokzSXBiAy0k0l
 09RUZT4JwYTDbMJvOC0OLdmWY64jtjcrTDS1ZtRtFTv/MnjTJ+AM4yX
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX4/J9mOwG8ANX
 /QCUBOOLB434W8zjvkOTzsW9TVAKwVrawLLV16oIBrlSj6e8wp5lAWAK6lExznX57ht9fWRMIwG
 yiE1WWFl7bXW6jj4wUwkzjFQJenrRZVIzDlg3pGDOuIi68jCXa1DsGPOuxym41+9FISnNEw4Twz
 Fn60bSQDfT5viX685UE9VjvWrj+0H6j/KNCSyLagODWmJpWiuLyfoJzWLgx744up17zMPKGyqPt
 3eWgzNSq+xIbPqtxX33afJo0GUvMWqDRQ/e9Mnx3VO3VgHIenTcC+OPNSJMTZjQO+ZZ+QQOLGud
 WLagkdhgjNUTBlBzi6OeqNQ8a6P4WNEChGMi4VUYxdRDV1ERk26eDbHpnNI7GTqbhuLIMFw9Oao
 /LF4LUUJR4vo7M1Uxtgbg7qCNEeHDJBjLGG5vCp6npquMcRIktAzjSlMk1XZadSu03xL1xPGskg
 sV99gG4k2O4/JmYcvfg==
X-Authority-Analysis: v=2.4 cv=C498WgP+ c=1 sm=1 tr=0 ts=6b00a4c6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=VwQbUJbxAAAA:8 a=Y9ewyai5-AkszFq4FIoA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: FiA3FNbfTtjcJxtHTqZayiU4nti-0DIq
X-Proofpoint-GUID: FiA3FNbfTtjcJxtHTqZayiU4nti-0DIq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX5YNNJDGF9qs8
 jri9HPLrUjVN5rNj1RXVZguDEwdboiQT18t/5LoSHQGv/0njOQBbuhnxMrPB39iFJm8klJjf/1c
 6jFfZ2d0blZFrvnMqxmx+w7iCXJawpQbuXbWGoYGHRHgT2UyAu88
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 bulkscore=10 adultscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=10 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200079

An RWF_DONTCACHE read marks the folios it brings into the page cache as
dropbehind, and filemap_read() drops them from the page cache once it
has copied from them. Readahead can bring in folios past the end of the
read, and those stay in the page cache with the flag set.

filemap_read() does not check whether the read it is serving is
uncached. A plain buffered read that finds one of these leftover folios
drops it as well, so the next read of that data goes to the device
again. This is wrong, as a plain read should leave what it read in the
page cache. The lookup path already does this:
__filemap_get_folio_mpol() clears the flag when a lookup without
FGP_DONTCACHE finds a dropbehind folio.

To fix it, only drop the folio in filemap_read() for an uncached read,
and clear the flag otherwise. Move the flag clearing, with its
WB_DONTCACHE_DIRTY accounting, into a helper for both callers.

With a reproducer that does a 64K RWF_DONTCACHE read and then a plain
read of a page that readahead brought in past the end of it, the page is
gone from the page cache after the plain read without this change, and
stays with it.

Fixes: 8026e49bff9b ("mm/filemap: add read support for RWF_DONTCACHE")
Reported-by: Tianyi Chen <hi@tychen.cc>
Closes: https://lore.kernel.org/linux-mm/20261119035808.431204-1-hi@tychen.cc/
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 mm/filemap.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index dc0ceaa58a0f..1bd91ff264e8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1632,6 +1632,28 @@ static void filemap_end_dropbehind(struct folio *folio)
 		folio_unmap_invalidate(mapping, folio, 0);
 }
 
+/*
+ * Clear the dropbehind flag on a folio so that it stays in the page cache.
+ */
+static void filemap_clear_dropbehind(struct address_space *mapping,
+		struct folio *folio)
+{
+	struct inode *inode = mapping->host;
+	struct wb_lock_cookie cookie = {};
+	struct bdi_writeback *wb;
+
+	if (!folio_test_dropbehind(folio))
+		return;
+	if (!folio_test_clear_dropbehind(folio))
+		return;
+	if (!folio_test_dirty(folio) || !mapping_can_writeback(mapping))
+		return;
+
+	wb = unlocked_inode_to_wb_begin(inode, &cookie);
+	wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -folio_nr_pages(folio));
+	unlocked_inode_to_wb_end(inode, &cookie);
+}
+
 /*
  * If folio was marked as dropbehind, then pages should be dropped when writeback
  * completes. Do that now. If we fail, it's likely because of a big folio -
@@ -2089,19 +2111,8 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 	if (!folio)
 		return ERR_PTR(-ENOENT);
 	/* not an uncached lookup, clear uncached if set */
-	if (!(fgp_flags & FGP_DONTCACHE) && folio_test_clear_dropbehind(folio)) {
-		if (folio_test_dirty(folio) &&
-		    mapping_can_writeback(mapping)) {
-			struct inode *inode = mapping->host;
-			struct bdi_writeback *wb;
-			struct wb_lock_cookie cookie = {};
-			long nr = folio_nr_pages(folio);
-
-			wb = unlocked_inode_to_wb_begin(inode, &cookie);
-			wb_stat_mod(wb, WB_DONTCACHE_DIRTY, -nr);
-			unlocked_inode_to_wb_end(inode, &cookie);
-		}
-	}
+	if (!(fgp_flags & FGP_DONTCACHE))
+		filemap_clear_dropbehind(mapping, folio);
 	return folio;
 }
 EXPORT_SYMBOL(__filemap_get_folio_mpol);
@@ -2918,7 +2929,14 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			filemap_end_dropbehind_read(folio);
+			/*
+			 * An uncached read drops the folio. Any other read
+			 * keeps it in the page cache.
+			 */
+			if (iocb->ki_flags & IOCB_DONTCACHE)
+				filemap_end_dropbehind_read(folio);
+			else
+				filemap_clear_dropbehind(mapping, folio);
 			folio_put(folio);
 		}
 		folio_batch_init(&fbatch);

---
base-commit: 15f114dac9a7bde1796f0e54e22726fd31cfa8a5
change-id: 20261119-filemap-dropbehind-read-db1046d9c23a

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

