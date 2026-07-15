Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6D366562
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 01:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079535; cv=none; b=G7oxoaG0g6w32VvqUyYyQHgA0mkhx/qVEQtkjiN9WCOc2VUlY5i34J1wM4vpLkuHfcRKzcHnsBki0eyF4YkTbxMU2XZQmMdQDfYNYygaRFewOnuCKPYkYGm1JeMP7xl1q9R9WLDUGgL1JsxBtA4mc0pbhPT7Ezq1hvCtWOdcvfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079535; c=relaxed/simple;
	bh=f8z/LhhSeiGx0YLXejZbUorQu3rV9mes2JD6R/uSQcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHKcWr28KPpwXILv2e0q61G90KUGSXh6q6ce2gklQqEVD2hTCJo/h2Ft1byaTPj2MaR7oVnKcouCtUyy82u0EDaWVvjELygsk2s+WiGZflkslyhQ9CfwsZiWozoYThLgJDWnlOT1jjiT9uJoXWBEyRWYdxopo3s6vY9zCcYwOF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIHukF2G; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIHukF2G"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2caed617615so54913645ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784079533; x=1784684333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CCVOviJ6TW1eoujnKBvwmbbtveOW7jpl9A71qAxKeF0=;
        b=DIHukF2GF0JQmkFmNb7DBIKRmUaqG8nBNhWEWo1K1d99Y42Nzfxp1EAbWQ228AQLzz
         1HU7InMi+Roa/aRuZN2XRLsSHKymMPZif4ApwPevN9IgyJknvJjvC1OqTbD2jbxchW+X
         Z+6LQwMxKMyfRrtGBSdsO5mh5WRzOygIofP3nn3LgwTcHXyFb1I0erMGuKRvJhBwvxBc
         kx/hZ5uW4j4MUjrIQttSx1WzLAsGZORrOqEhdnFGCWxkvIYiQIZCMGbCs3u0SPFeZ7VS
         1Oi+GGU5qFoyhfL5Y6GR8qQ2l+226yEfPKHm7PIxR21FgFM2xWilMzeIvWnJm0zqBNbq
         Z91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784079533; x=1784684333;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCVOviJ6TW1eoujnKBvwmbbtveOW7jpl9A71qAxKeF0=;
        b=hefU+OJ4GdjjphE4mzP8ALY9RT1E3XuwqNWQasPtIdSIuOjy3JTXrlISz1Mj/PFzFg
         c3n7P+zdZl5tLGgTTE/1QfsWPHuWx/TvvejgJjfRKBNpeYU3bxNDDW+F8i7rDG6OyCOs
         W+c8tADF8Y2+94BvosBkuVg8pNbx3cNsDi4X703ljZXfZ9RgA8VG2sd6ZKDADOHwbEwO
         oGeAuGDuxrlm0pcHDi5I1qKorlyfs72rkZ09bFi+kAUP91pFaiwK2li/p9DZ3VS+0+xr
         5+EzKSXW1ucp16lFLVrZNvhkLfkG3f/QNjj8URm/Ghm9LvMEyUNGjymB71Yih0FBl3nt
         rseA==
X-Forwarded-Encrypted: i=1; AHgh+RpWw8KU+rI7CKsaFk1kII9CzmhAdh+HtjC3dAdWXbfKetK7kXf2Ou2AmcCtwvAypdld4aLVH+ut7Z4MuVXt@vger.kernel.org
X-Gm-Message-State: AOJu0YwE8gWLx0ergzpw3329royZEGZv0PhPjbdZF7opZRHbxCnwTP8W
	dW0pLWzhr0DMEr8zpX7noubHjxdMOGzTSKSl12kyc6vETy93K62Ni8q0Br2MTr4m
X-Gm-Gg: AfdE7cktG8QHNpM9IOy+AQvKAWrhKaDizRyEeMLYOCiVHbN0Ucn3bE39l1Q2U774x+e
	7B+HK1Emoq5R5eZaQQKs9ZeZcz2ak7ShDQXBMthxxtt+Puizc7FNuZBAdlZHAaHcjJL+rym7d8W
	G6gy5CLX9gXFZ1G3WYgCmEsNXgKs9vbVf0bnNbxVEm6oKkTp0Is3HMuhZNXjiULf17yOutEVNKU
	JTQ9uBvrh/+ghqB1LSkMgP+wdEBxjr3xiKKUqWaJ6m4MilkQsBzjADajddUQZrBqFWtbXpQuzPw
	KLvWyw4R9YcktwXrOHyGwO93o5wH3cgVqsQXfCATWVY6wD3haL6NXuET23OVGMoT4JqUfD4bP3i
	fdFKXEqQL3VtmQd0EmourONcEDdRsOIrBF9nRgtiDF2B0dDX3G906O+QDQDtaI5D2wjBKR/sq1O
	p2XiYp2LUZbSnpgkJdTWE=
X-Received: by 2002:a05:6a21:d82:b0:3c0:9c19:659d with SMTP id adf61e73a8af0-3c36c42555amr849460637.69.1784079533391;
        Tue, 14 Jul 2026 18:38:53 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643399sm11080617a12.22.2026.07.14.18.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:38:52 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	usama.arif@linux.dev,
	lance.yang@linux.dev
Subject: [PATCH v3 3/4] ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
Date: Wed, 15 Jul 2026 10:38:02 +0900
Message-ID: <20260715-review-matthew-v2-v3-3-3c996b687a5e@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715-review-matthew-v2-v3-0-3c996b687a5e@gmail.com>
References: <20260715-review-matthew-v2-v3-0-3c996b687a5e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1915; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=TRJ3n3ISfczJK3q0xHH43P90Tc9BsvL22PZunl/JTiE=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqVuRuNoIzE9kcsYle7zSZK7cVhdszSu3dQhIsT
 CL2qX682nWJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCalbkbgAKCRA08jD6945I
 0/L5EACE03HQ/Ljn80HMkIJiR32r+XZp75DZfSZyDsltFHxUx2nDZ3qW3OTzt6Q1vUtNqQ7Y9Wt
 Nf/rhsciLnumeYx7zVWYdIDWVzHa6imc/AG3LQ7cFcnhCMxTXKvaMjsrQ6lWgXVGVkztGrAiYMV
 1xKv0/hU8vMaBFUgIJd02BLR4LfORhWna0qYvT2qEfyd93QXnwT5RmOEN9gF+xsdfR+QRllx58p
 A812TRgIg+UaIiBGzJ3Qzgfw3E7gqPA5xVTaQkX3eJTVZSaSP2c7l4QpXjYKB8+DbwBM7L88n5L
 9xbPi85KiJeVTB/XKjp8ELL0rcJoNLbHdqmaPFesI+MjnXxcL65vdGcwoa3CA5CHMcCkRhKMiG7
 MtGjrq3xOVwnrydx1PNAHkbjb5SomhYs0Paw72CmF25duFWMLoRpVepBGhWhE4oPK95nfkwLlCh
 5TjunIpC6R2oIsCdkfK3nIV8L8P6zWdqqK2L0C1EiCkZ0KLcY4MwrC7Kwkuy5EGPRvxf8JeIX+K
 fkAzhWnOqI7e5dbI6ZSZJybrlRZKfb3Tog0XTvq10IriWP0vpKpHycRnFdpeJCZ8K5dM5di8FUD
 2+2hQfGOIpvq6XyXEzcpEmIzknLdptyGuX5xQsCuSbok6HonunyGXK0N7YM3Nw++qAnJke8x7ac pAlBF5tdIOThgOw==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This fixes handle_bounds_compressed_page() on highmem memory
as page_address() does not work on memory which has been kmap_local(),
only on kmap() memory.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ntfs/compress.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 8078041b8796..f03fae63c199 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -109,16 +109,16 @@ static inline void handle_bounds_compressed_page(struct page *page,
 
 	if ((pos + PAGE_SIZE > initialized_size) &&
 			(initialized_size < i_size)) {
-		u8 *kp = page_address(page);
-		unsigned int kp_ofs;
+		size_t offset;
 
 		ntfs_debug("Zeroing page region outside initialized size.");
-		if (pos >= initialized_size) {
-			clear_page(kp);
-			return;
-		}
-		kp_ofs = initialized_size & ~PAGE_MASK;
-		memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
+		if (pos >= initialized_size)
+			offset = 0;
+		else
+			offset = offset_in_page(initialized_size);
+		zero_user_segment(page, offset, PAGE_SIZE);
+	} else {
+		flush_dcache_page(page);
 	}
 }
 
@@ -223,7 +223,6 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
 				 */
 				handle_bounds_compressed_page(dp, i_size,
 						initialized_size);
-				flush_dcache_page(dp);
 				kunmap_local(page_address(dp));
 				SetPageUptodate(dp);
 				unlock_page(dp);
@@ -759,7 +758,6 @@ int ntfs_read_compressed_block(struct folio *folio)
 				 */
 				handle_bounds_compressed_page(page, i_size,
 						initialized_size);
-				flush_dcache_page(page);
 				kunmap_local(page_address(page));
 				SetPageUptodate(page);
 				unlock_page(page);

-- 
2.43.0

