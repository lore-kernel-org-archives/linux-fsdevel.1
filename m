Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2DF377551
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310246; cv=none; b=HsSbN6HbzdM2r6bBpyV3kDD6tT7khMHaPaycaL32KVCfqXeADLLize/AVG1dFE3jrUh2EWIDkBrIZtOIifpo6LL/aad2T70PzXSK4I6ZgibiK0/9PpX8syKcdDiTSdCS9UXBEEiHBvwOSBaGGf358tn7nsMEn4OHuZXpcVeC2rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310246; c=relaxed/simple;
	bh=rA3ee1bVN85AK8Xbqqgod0QTROlaUP31hnwYXO5EEik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpbqVUKHQLWuQpsCs9Poo5iYihdwN07KPLWQC2/OCGQhHGnyhIDhCmfZbu+uLP61topZZth1lmiiS0StPui8KGQExhuXPMEAvCGCPX1jSMM4Ga06moATAtQ9oR+daqUWLy7N27BnV9FO0wJVY34cFg8bKBwrypmltyarXf/2rxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=iHJauhNO; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="iHJauhNO"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KKOCn1507354
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=yDlB
	tkSZ/QVPh/7V2LuCLj7vDoerhrZrGeObhOfbEDE=; b=iHJauhNOQfQGuWQ9PBMd
	9498doyET3MaIYPPH6gAxhnfTbaNfiN2HpEWnhfQQydxrwb9YLjAr0f4Hzz9oE/O
	fgZj57LX1AT6vGPBI4TBSadyl2n+Ha4Tz+b8UVbJXRMfLIBkIuY/Ve9fGyVT4co8
	CWfypz/xg3x2wPetKTOGO0gbdH/nfd8bk8oUJYPlHyI8bnWD4jXB1S/B9q8XPwVg
	a/q7T59AHt1VqQQ1Jq/DCsxu26G8aGUFIr5qhSBAsd9ZVD/1vrojSd1jGW4Sf5ya
	FNIQdmkD5+yJCvLbmPd1L6c+MvkJlF6HEAnpWHT38ExeFCzYB0ApWQz8kBWW88CI
	Fg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e9a0bd1tg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 16:50:42 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90f4e81b8e2so1326529585a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 13:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310241; x=1779915041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDlBtkSZ/QVPh/7V2LuCLj7vDoerhrZrGeObhOfbEDE=;
        b=F3oKJwwtewjcRLq8uncwly3RecIFoE0nxbH7YadG0y27acih2/8WC+8OaPj7GT8OiJ
         b3OMiBtEg4wXAf/KC4urhNiukduLenuCpHlvKmn0bpU9XEgnKDyDGXEJqA4X4jI3RPYs
         eRuTCtbOhhQmHiaTdO1JQZOvR+x9G9E572gYIuTkTGZ41mB+wmJXeJQ2zmwQLJivf4WG
         DUMbSuHOm6OwGEepO5/STau3yiJRcYpla31f0+pzXdhpQb/rlBGStxOW1FkCAWzzb5SA
         Fi0JrKnwu2IRRpzXXBsWOI+4mpYMLEToazzB8SGWB+TwibP2R6Wsfb8pNIpq0iGgPKdQ
         M8Sw==
X-Gm-Message-State: AOJu0YwsN4y7cekDp5Xb4bl3Y6IsHZfu9E+Y3MiEYoFhacE/zNbo3bLf
	tUVC0R2bAJz19Kr87dmabgOPKlslRoXpbPGQzxkdPbCuCoh/ZE801n4pwtjwmvxdwy3iDe1DDzD
	ndlXnnj1iz/ChakHU+ql/eWPHKX7XcccktX1usLnuC/eZhXejw9T2znlnV69vkho=
X-Gm-Gg: Acq92OEXqa0Am+jiEEkzxJJ0fHmIzIpKKgMpU8E+d1jkbr2QL82NwPogQBxlPwle3J/
	wYPH9a4C+uwV+zf3QcYMeOontZRw/cFe5ZUTVyxXolpMAHaMXOfA/a2R6knj7Gj/KOxg9nRSJmZ
	D4q2bv/5IM1+dCivCFOXjvBY2fGr+Dh3cCbdEP45/TqwMdmoinGR4hBvKF7ILThI+DNIvpfhYjY
	lFb75mp7B8mJH0PT7mVdO7mc5UlJG2J8xLWEgjZgbihSpLu+jNObZ11ouihH7HH/VQ6BqseFBdr
	GRvBlainRj8RF5z+LkjgI7WI4V4WBGWD3BokdLqn2HNQP+sMWjd1E040eJBe4iwSoTvaJgt2Pf3
	ueuGQHBvg4R6sq17E2pN5rcaDyliJvC0cLLS84fsuZJKC96T9+SeMQGkgzM+6DcCAJ6cKU6WZzK
	g4+Q==
X-Received: by 2002:a05:620a:1986:b0:911:ed:d285 with SMTP id af79cd13be357-911cf9e0c41mr3857315585a.62.1779310241565;
        Wed, 20 May 2026 13:50:41 -0700 (PDT)
X-Received: by 2002:a05:620a:1986:b0:911:ed:d285 with SMTP id af79cd13be357-911cf9e0c41mr3857309585a.62.1779310241059;
        Wed, 20 May 2026 13:50:41 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37274sm2232692085a.37.2026.05.20.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 20 May 2026 16:49:00 -0400
Subject: [PATCH RFC 09/11] fs: move dir_pages() from <linux/pagemap.h> to
 <linux/fs.h>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-filemap-split-v1-9-c36ddc2b6cf2@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779310229; l=1369;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=rA3ee1bVN85AK8Xbqqgod0QTROlaUP31hnwYXO5EEik=;
 b=DCkZp86sCfuyRVBmRVmURwps78q7smwQhnDSiFfY5HPBUU3kJlF0UIoGU21dz9wQUTuZXJkNF
 UGqHDG78m7UBDAclN2Kez4FnTKNYWYrHvBGgRUTdHLcho2GLQ+5jpkl
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: xYHCMUOwTDC109Z1ioxymc64PTSsBQUo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIwMyBTYWx0ZWRfXwvQot+hS8DfR
 OQT0n3GKGhJGGU+e7f1c/xmj47cMb5+vOvkbPVknaxou2nB8whBYRz9ApSIB+74uI9Nwqt5ZhtY
 U/LXQ2fISR9JFdcYhjDEUNfyuf5zOl8gLEa6tCvLDakRLriSeHsk73Lq9QFj58I5SVMEFxYeVNj
 Mk6nVJHX50VxmyjNZ49UlJRUYp4qWjwl39PyY5E2/hoaK61g/h6Q99X0QOUWvZbg66VgC9pJiD5
 JsRpWyvqVHX74I487mZlbMc67FzOw8HIbPTtbY7LCYm3do81LzpNGWY0UglLBYZu2VsrWJcVt6p
 +48nwzJHRTabyeLXjn+Z/egcRn+RkIiapUuezrPdY7hqi72ZpYAnE146BQJU1AEGtDke1eW4lgd
 iCxN+NA/H89MQagm6l1Y7RKDCyDlnmYm8jCYT03rCJrVNzQo6qWZMnvU1RwYWcc5hXLDoDbAqzL
 C8GoAjYDB1uTe7wdPog==
X-Proofpoint-ORIG-GUID: xYHCMUOwTDC109Z1ioxymc64PTSsBQUo
X-Authority-Analysis: v=2.4 cv=KLJqylFo c=1 sm=1 tr=0 ts=6a0e1ea2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=8LwvE8iKX1rSyJpzT4YA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11792
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=10 phishscore=0 suspectscore=0 lowpriorityscore=10 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200203

This is an inode-based helper and should live with other inode helpers.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/fs.h      | 6 ++++++
 include/linux/pagemap.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index cd5088dfe9a1..776cc82932a7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1171,6 +1171,12 @@ static inline void i_size_write(struct inode *inode, loff_t i_size)
 #endif
 }
 
+static inline unsigned long dir_pages(const struct inode *inode)
+{
+	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
+			       PAGE_SHIFT;
+}
+
 static inline unsigned iminor(const struct inode *inode)
 {
 	return MINOR(inode->i_rdev);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 84ccb682cca8..f86a550ad516 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1356,12 +1356,6 @@ static inline size_t readahead_batch_length(const struct readahead_control *rac)
 	return rac->_batch_count * PAGE_SIZE;
 }
 
-static inline unsigned long dir_pages(const struct inode *inode)
-{
-	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
-			       PAGE_SHIFT;
-}
-
 /**
  * folio_mkwrite_check_truncate - check if folio was truncated
  * @folio: the folio to check

-- 
2.39.5

