Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF833B960C
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 03:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112358; cv=none; b=ihmXVQruG89cIi7/xsMd6dOyYMd1tuiKF/nSR/ZTqMWr91+8X0cc3CsI7bqhGqR4PBQb/tamZwMizJswP3v0hDi8Sui6f79chZAQB+16R6PLt1sbE9wLDngJfmpJRKb+hru+4Oe1OPeD0/Ah3ORbi+Y9m31/ZfnOfBUCHa1pz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112358; c=relaxed/simple;
	bh=YPiZVfutGHLcCD+o5iVeksaNVWkh+aaGWV9f2eUOkaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Drb3j85MqMSnS87x9gEObj/yniqfT6xDa9u+zU7uLNOKJwrARqMiTTK/MXBOz4qju31mU99UtECZCYQkuwtB7x9vPLtYKfCuPyWu9eZyBZ59eIm6ZaUiq/p/XI1Cn2vQG5XnTWIjJxHFeu56CdmesZKtL+8LFHBKk6c5o/kKLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc; spf=pass smtp.mailfrom=hev.cc; dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b=mVNW5eGK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hev.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hev.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20230601.gappssmtp.com header.i=@hev-cc.20230601.gappssmtp.com header.b="mVNW5eGK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82989744ee0so4037495b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 20:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20230601.gappssmtp.com; s=20230601; t=1773112357; x=1773717157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gnfc04EYdLBOgTA22D3ZA5OANJFWm2SEibGG/QoA0M=;
        b=mVNW5eGK2CgiGYnSDn3EwcAMpafyN/YXcSQxZZAqlWLPVxJPHaHbIGyQ20TIjySzW/
         cpcak719IVrt+zqy6dx6RwXuqxVsrk04AGu0tUiGm/bfG8xzM/4sYJf74bx5P1yNoCYp
         50nfPaDqAIpoFv13C7/nT3UqwFO7SZQXgXEyBs0tJxSagb9CPEfwSm/G+R5VX4jcOe4H
         QsTYfJRSvS9IMvq+y3z8KIpbNXNtFEugZn5yBzJSJ4TUDzLfn6DKBC2V8nRyMd/gubFA
         w4OdLl50/Ztdjbm8NsuVwUYKYKlf0HDH+ECv86soKV+UrNaegWroP7d4QhFiFFYuSSlZ
         S4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773112357; x=1773717157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Gnfc04EYdLBOgTA22D3ZA5OANJFWm2SEibGG/QoA0M=;
        b=oPyyGjLrB2IFDbYXiPOHhk3kAiu63u5NCHoYobdEb9JPhXaME3pwbR311vYEJjFjBz
         pAPFmtr8H8YO1L5FHP57xO4BZ1PkiBGhEdX0lJmN/Sx/Njhhsxk8wJ43JnXOrMy0rjj/
         7pn3aQZo+mW4+10aLWBvXy5MThk0YRjFPPpX/d3zudc0bkWoFtYtwSZLgqlMdx7mtjHO
         aoq7LKa/4TI/xOidnJUNNB4bUI6k48Z7+EpnD4cM++I+F9YIe4lsQ718QU577BSqioNb
         aV2+ScU02LTJngxuNxEyGqO+zS9f79cfesLblp8zpgCt65UGnE7sTLGfuqRNEJ8Gn2F5
         yObg==
X-Gm-Message-State: AOJu0YwN9f051NmVLmUePA4OrQLglFH6juKKEalFancXU97MfYH8jqlV
	DNwPSoizogJ9omCJmjN54JdV9NEpPuNofzUrEDjeUq0BCd5923k8v4gQP6rZ0w6QUDc=
X-Gm-Gg: ATEYQzxRBES1V5urlS3hWuQvVst9JBr1rOOCiFfKeQSobnTyoFwNp7VaH3uggYetxEt
	dqu3yop6VxytzdHcHMTOQHpo+50fUKqU3SaLYZ4oRq7JBXez+fkmdT7F/dQRljyziNuQvc1Q8Gx
	BDKkBa1JYVvwjVwdcIYoZgj43IaOZs5t9l1I0YmoFGWcfl/gEa9jlNSHL00gN+S6J47MeDe1gaX
	DLK1HG0L4HoYSJh/xput/0hMi/mpwU9+1Y5TH7UQD0jmuZ6nMxTFfyQ2g+V7IZ7YJVqXurdYecp
	J6TmINnyTwSugGb0uHlyXhBU1WvQHYJgFAmvq4rQIwfTIs6AnmGxTPnzB79OkXTQLF9vLnAiAya
	89XK726rDAjWeb9XHS2aGieuNTdiOYFVO4SDSsvUS/Oxtwrdf3ILA59c5/RjvOOaElAVl5Gkg4V
	q3e9Y0DCkK
X-Received: by 2002:a05:6a00:1a8c:b0:829:810e:8af8 with SMTP id d2e1a72fcca58-829a2dc4f99mr12713671b3a.22.1773112356834;
        Mon, 09 Mar 2026 20:12:36 -0700 (PDT)
Received: from localhost ([2400:8902:e002:de08:5754:7dac:85df:935a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a465c872sm14213691b3a.19.2026.03.09.20.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:12:36 -0700 (PDT)
From: WANG Rui <r@hev.cc>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zi Yan <ziy@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	WANG Rui <r@hev.cc>
Subject: [PATCH v4 1/2] huge_mm: add stubs for THP-disabled configs
Date: Tue, 10 Mar 2026 11:11:37 +0800
Message-ID: <20260310031138.509730-2-r@hev.cc>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310031138.509730-1-r@hev.cc>
References: <20260310031138.509730-1-r@hev.cc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugepage_global_enabled() and hugepage_global_always() only exist
when CONFIG_TRANSPARENT_HUGEPAGE is set.  Add inline stubs that
return false to let code compile when THP is disabled.

Signed-off-by: WANG Rui <r@hev.cc>
---
 include/linux/huge_mm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index a4d9f964dfde..badeebd4ea98 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -570,6 +570,16 @@ void map_anon_folio_pmd_nopf(struct folio *folio, pmd_t *pmd,
 
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static inline bool hugepage_global_enabled(void)
+{
+	return false;
+}
+
+static inline bool hugepage_global_always(void)
+{
+	return false;
+}
+
 static inline bool folio_test_pmd_mappable(struct folio *folio)
 {
 	return false;
-- 
2.53.0

