Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58E1714AA
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079528; cv=none; b=IJB+zBelwJ+ur9QwS/ik7UgX+OpHNZ6gYm4BdAAerEvuLQPgPSQS3LzQVqielOosJmbGlmQPB9HZlwlLElWob2jiwzfx7gzhzT1rMREZgCbyna7eWsJiha9KBkyOBjWMWeVi/TASW7CPnrjxCJvTgHzSjrf+H0lGBhWmmQvHdD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079528; c=relaxed/simple;
	bh=36W67RmH5hXk2GWT1Q8Um9zA/ZFMgU1CMu+VhSVmeVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL787GRxpIn/KCr+soIPn8MH5AOFAxIjOVbKJjdFOuOZKEbVx5xe+hJSWyNW7p3Gktbym4ExkSfLoIRUGcJ4wq+ISQlm7F8Wian7Zq4OIAQEXlKJgvibrBHElYc1ULjCG1NgeuFbv5hlkKecYh+LIGnsdgCSLyvQrMnLlXcqOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9aCUGxw; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9aCUGxw"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso3558125a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784079527; x=1784684327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EjW5lTWxLCnVY/vldHhy8VJ53gqcIIkNYP2oB02yWV0=;
        b=i9aCUGxwbfr5YL3NfYGynKoI88SoO9LVbGvh4TNwArWHGq6542wXtMvna6LjDp2BsX
         gAz+N9I6a+R8r4EsGJvnDVltlFJNgXPcll6UXrRKgVWAGrJrpS1E8pObeVi+Poi+6SJz
         cqfA8nWkmt7W8ShJOHm1RCsdyVWnG2JAKfOoHUDetWEDOB/HknBNl0t/9fbSh+jxHt1x
         ZJkPOSFXmEwwlkSAk4LW4PyZaWYjZXZLCY/kE3jZ/cJea3A2kKu3VR7OAX/iSw9rRTID
         D1hN8T9VpIsLgRotBtPNGtSOwctt/AD9hiRY0/3B9dCwnNCyuY7Q3jj787DmVY0OP/IO
         4mdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784079527; x=1784684327;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EjW5lTWxLCnVY/vldHhy8VJ53gqcIIkNYP2oB02yWV0=;
        b=h2+ql94tLcz5Um4hBSbpMT8lKt091XzgrhGNojLcxJwEMN5wVJBZ/bBXohbhU6G1Lf
         jjEiHwpetJlFEFTmdFwS/hjMPPV7r0Yd+rZdjyX6KFYbenIWkiB+3X+nmB3tXm9O4CYv
         5WqmHEj9wbdjOviGVDisTX3uCDTdB+4UzSCf0gqVQE6RI4494gAC6lzDsyLjbul15cov
         NayxghsX6kXt2Fdtm5nzeN8CzdjBDn65gzEl2oHpBij1O4m7r3tijefNhvHZWqNtKgD5
         ZlfVPrV3txTG1lGijCYYmRJPN5bx+OR+jupBtqe29I5hYA1EQGMB/XYphPTyB5aw2P0C
         TYNg==
X-Forwarded-Encrypted: i=1; AHgh+Ro/4a4LJ1GVCf81SR9OnnNHlI3dyOdlf5zs7SyDH1fojAjSapx1me8ws+2brEbFZSAoHChrK+iquOmCrJPQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwFAzvom2JoyD8wJy0gXvmsHLR30hM9J0aoK+CU/8pu8mSwqdIs
	Ha3cuTGGerGeNooILD+PRtzKUUFh9ALwlBiKbBuVmNkVGPkpG8DK2PNt
X-Gm-Gg: AfdE7cmqUr4eHPbEkoY+71e/TrnTyf+RSfXEYbwlh0S/jfJKW+QDG1FL8zqP55J9TmC
	ufyx5s1w/Qj7waUciKslI0AyN8APNokcOoJRumUjiG+1c6C+PW2UQS3N/aGOoAYt9cLucjz0ep+
	gpcLImHJR3eBwaxqVOvSPt812n2xod771twE8wISGkIEWECojMkImPMx/OSBQC9ijcrqeDobgSl
	cFkKUNbJQO7yvFnKh4/7fsFk5Q12lpDvCk7c4tQKqr1lMkD7O3S/WukGZSGcVRfkYkdTk3WYbek
	fW/Zio1B4elMSEv59bS1/38nYepKAJ+DhBpjUMNQY7a4Wfy5IFZ2oFsRrX1otJaxX+zh5i214qx
	/ghDgqe6fgPQGqXvT70TsAJj8UkcJ1bHhd5Y4eq5x9Fz7IVRzIo+53jYu54c5mQ9O0vZ9VMUkWT
	j5LclblaSy6LvaftbzI6M=
X-Received: by 2002:a05:6a21:689:b0:3bd:229c:dcab with SMTP id adf61e73a8af0-3c35738e888mr5763801637.17.1784079526833;
        Tue, 14 Jul 2026 18:38:46 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643399sm11080617a12.22.2026.07.14.18.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:38:46 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	usama.arif@linux.dev,
	lance.yang@linux.dev
Subject: [PATCH v3 1/4] ntfs: Inline zero_partial_compressed_page()
Date: Wed, 15 Jul 2026 10:38:00 +0900
Message-ID: <20260715-review-matthew-v2-v3-1-3c996b687a5e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2095; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=eZlVwutmrn5+9vjBX24DhNDtYv8SOPRCB9m8OIPm5nc=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqVuRuayJavxD6g0rXjo7CuF5VfQTX09Y484Y2i
 frKwJWAxweJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCalbkbgAKCRA08jD6945I
 05dKEACoN5HFq4UqHeM0YECzH28tOVekPnnDN82BNMlgC5PXFhWLNq55rsZQzcn/4LjMoulsHsl
 MPN02i1d1C1U8J+DI+vFO7cw5wCkLKNvVeYuOrv1yl1GnIveHhXpKUVw6hl+SUjq9Z/UFc1naTo
 qTtrugKb1x4vTOsNWqrgDL5rZmcHPPLUnCJ6XRHWVpJ482/JxIMf7Fw7ZIEDFpukJE2Jx6LVs4o
 kF7dAFEl6au+0wmEpTFChKwR6Vf1tp3jHcF+DY1TJ1Mnwx/x2kdYwIeLZ0lYcExquMsAJLtJadr
 kmg26Reuupk+hg2dxzZgOLpXUgF5kyCqvwa8wcaL6Ygdbensg//PlqZ7StpTlokDOx+AU5tR3H4
 ZDIvfCOUsS50eGvYRPFg5VpmOijT79kPE/ebFulpwVjgzf0q3qyx9wcBPkFEmlZFB/OLCMaBgB0
 WrzkA7eBe4q6HIdW/dqebAHcWWNWlGzHzsLlEtFyALjbiOfxqGkcHl9mENt1i8zCSTrcbb4K/rw
 SYLQJes+LXOB5gaQuWBuJ7lv+TznSUj08tMYXZyn2as9r1nSLzkdVmtNUOSkb33Sui1Dt9QE+Gp
 6qb2eUBjTGJb8orZ+aRx2qzCfol5FTwFWnveYHS+6ndC7pL980Z/yxrdrL/JHjqxZBGx7n60oW8 djz2xrdcYpQSK5A==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

zero_partial_compressed_page() has one caller and the next commit
will make changes to it that make it inelegant to split across two
functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/compress.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 76bd806b41ed..c904858dff3d 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -96,26 +96,6 @@ void free_compression_buffers(void)
 	mutex_unlock(&ntfs_cb_lock);
 }
 
-/*
- * zero_partial_compressed_page - zero out of bounds compressed page region
- * @page: page to zero
- * @initialized_size: initialized size of the attribute
- */
-static void zero_partial_compressed_page(struct page *page,
-		const s64 initialized_size)
-{
-	u8 *kp = page_address(page);
-	unsigned int kp_ofs;
-
-	ntfs_debug("Zeroing page region outside initialized size.");
-	if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
-		clear_page(kp);
-		return;
-	}
-	kp_ofs = initialized_size & ~PAGE_MASK;
-	memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
-}
-
 /*
  * handle_bounds_compressed_page - test for&handle out of bounds compressed page
  * @page: page to check and handle
@@ -126,8 +106,18 @@ static inline void handle_bounds_compressed_page(struct page *page,
 		const loff_t i_size, const s64 initialized_size)
 {
 	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
-			(initialized_size < i_size))
-		zero_partial_compressed_page(page, initialized_size);
+			(initialized_size < i_size)) {
+		u8 *kp = page_address(page);
+		unsigned int kp_ofs;
+
+		ntfs_debug("Zeroing page region outside initialized size.");
+		if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
+			clear_page(kp);
+			return;
+		}
+		kp_ofs = initialized_size & ~PAGE_MASK;
+		memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
+	}
 }
 
 /*

-- 
2.43.0

