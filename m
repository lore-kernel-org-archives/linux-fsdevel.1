Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854092E8897
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784079531; cv=none; b=dONrfZYY2/S1MXEWh3EZip9h0L/n5LIksaTEue6SpD62zNgv1ON7PhfZvkAnB12eRwfVNsyPteZhnnj1vezw6vy7jvXuif65bbSIKeSRSHQ9rT1NWqeHWUktf31d9YzWDWsPwxaUrwGKX3C8bsRoSZQ+tPogcpSO4j5EFiQYhxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784079531; c=relaxed/simple;
	bh=F17rsBBuOWvCClxx/8Tf0zeDsKdA1cxNPr8LWCXZd3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8EZOpw3Cptq/IDBGmxaiwoRJ3ZnQV6E2lEzx0dRsw3r+VDSKxwU6hOly8BYyfO4ai3h7hZFR+cieeB4+JWhOE2xjfu6o/v28ByPXjhkPFJNDBPL9S1Lw+YKxo0QPNtmPpRtl5PFb+qPmhAeJGnHUcOB3zZS6j6B0+CMYwIdO5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbPGodtc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbPGodtc"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca7c1176317so3580485a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 18:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784079530; x=1784684330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kAnBQ4moZYAMbNlECesx6CSe5rVoQ3fX//k62FLjJ04=;
        b=lbPGodtcNjnTf/AMome8NONerEhzyrmeIW9cA96xLUZQRXH5r73CxtAOPFY+KnDjUE
         vFkWOla4Tatq+NR2NRZ2eqChP1my/zza4ujykFrgENWPbvt0l29P7KyHzdMpELTmSuUN
         f/j9uhvtgj8zZvtF0CP3TuEOAO76oOqu0R71XqkwNmLhYjjmu5InpDkY8o0rM6ofs39F
         QRF+kH/1mPjSC6djgztpZ7DxvSOtwbWVMx67x3zdDT7e+DKiuEbcsGH5xzxCv7Sk3S3A
         YkKIah8Dg+CK4/pvp8/dhYKyln2jJv7zOKILF62QLkha3lmbHF4nsCaj4M6J6hbbblsz
         Yyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784079530; x=1784684330;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAnBQ4moZYAMbNlECesx6CSe5rVoQ3fX//k62FLjJ04=;
        b=n+sONKD4siLba9ab92VrQ4hyUg+vMDIuKqaFOyzYxvYcEdjy44rFN8dUaIMSyS15w/
         VQTP0ndXmDNPTQmLfQ1ETKcuk1yh6hf3FKa1T16vtQY8I0mT7+Y2EPgZ+EfOAxUc+J7u
         l2LVdlar1cYbv/Ys63uUkWbMR/cxXUmgDbamvnlRqR2H8Dp5VhJ/QyjLSoiF+mjMaLIl
         NoVs1qCV/UphzQWmoPQS0oGcLc/ODq7HRA0SMwOUrmjW3aZM7JuvIKewGxijcZd/jnvg
         HtJMVPQiH6No1OQDEoIFyb470NLDpSJT8eulJa3YT+4bZF6IJ7oTZj4rljUnt3UfpSSa
         yLLg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8VbHF0E47WuNcZ99kx1tx/+/w5K9QlM2drk0mDDu9/xUb0RdBCj/Wm+1Hpd9bapxozx8xCF/J5oTuOdmk@vger.kernel.org
X-Gm-Message-State: AOJu0YxPt+u4gNtunNH7J4uxvvHCnZP7+uu5zupGhTLiX8ckVEwRR6GG
	5JxahHFikE+Iq5ypKvU3nMKSzxxT/8EQZkY4RfBjC179cHkK8frpVeT8
X-Gm-Gg: AfdE7cn7Tcb4qsMXPLUE8n7ihE/erjHNYH0DDJ7syQhK4f9+SXpxn0GwUsWjrYU0SKm
	AYpjyl9gcPnRTY/LPDyJ78cH31wJwKqkxUcAgwyCBhXZOrcS1L4T8Wc6tZckgVYLVE9kBM/uzwb
	gTu3hg0C9QE7gCbJyJH208QyA0NF9o3aigm2lcO2Zazbq9kI5xAXt9geNDzorWZ330yoB/qmOcN
	dpoMMABF8J8Gkx71fwJf7zJFYILbFxa9AGwY4uvGoE31Kat2dCEs05e3lFGl4d/Ez4eT75NStM0
	nBRDThibmBohqTo8yHAo6M1rVLPXEg9hgjR6XHXbuDsqREG2Cgwq8+qMjwgFZk2NFxeURfuWuFF
	Hik3T5nDZCRD30KEIBON/pkMyYqjIauSkVQ4gH+YBrJ+ItVmsNfIFYnDxmHkfOZBjPYpeKFRsdP
	GX+aGANhUhNaAvVXNOZiMl5Ws1wqlumw==
X-Received: by 2002:a05:6a21:a98:b0:3bf:a0e5:99a1 with SMTP id adf61e73a8af0-3c36c3c69f2mr928500637.51.1784079529800;
        Tue, 14 Jul 2026 18:38:49 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b3643399sm11080617a12.22.2026.07.14.18.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 18:38:49 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	ntfs@lists.linux.dev,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	usama.arif@linux.dev,
	lance.yang@linux.dev
Subject: [PATCH v3 2/4] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
Date: Wed, 15 Jul 2026 10:38:01 +0900
Message-ID: <20260715-review-matthew-v2-v3-2-3c996b687a5e@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1309; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=UVZV76zI7O9Usr7L3d4M66b1fjph8c3bYDu1XSTbLus=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqVuRuTJxTIJDzvnQ46JnDLPCUaf7VnFqqE8gUY
 XhWv16BWsWJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCalbkbgAKCRA08jD6945I
 04FQD/9rZw7URMEtu8i1HHpyVvD5/XlGvx3DXlX2KAO/a1Q8Bzhn8vWwGtKczdOXj72rWkPyK71
 qlZk4PPYs0zheKamACjwK5LYL9umsTkNRUf10xiqqwIipoLy/Cpi2GVywLRD/CdSQs2bmU5a+0R
 BwdMukdI414glGKaCQ/4l+lQpvDQOtXi6qkazFIQqqClmrw3rd88y1wHx2ejDsxtuqeljPlWlg1
 KA9SXteG3A8LXYObi//fjzm/+pd6cyQEOMEBjfG6A4LbUlGYJ+iN+l+tEwYrdo19GrcMM016hEc
 3KeancvJnOsJa386+n6GsSj3vpRwazCATEc9B8YqgXHpdjOAsuXqUhIEiVOGz4sN3i5/tHe6if6
 v12G9AVRxOPgGuzjjrRVcv8GBYDyxwKqnK7712eOhe5AcbkfZI7M2638gfgYVIajRyDrPpbxDOF
 3AIpO4Rse+iJQ05rEEwHKzOvnVm4efCYS5zp+1/fKsVtVeXE+DnlmR9DpPo8ZB7wzS50Xbyj7un
 H2p/Fd4sTeYcO8Ll3YQFeDpqlhDy/1GzV06BTazuJ8gC97IVJibOzbVWwK3d0FNRrd036bSfCZm
 Jep+oltMv56PA7crPOF7k9ZVn96xFbmqKFHvsgYjfMw4vNjn4sEjF8HYoj6Mr5GeykVMFxjS15R Vse/hXESsKzdo+g==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Nobody is supposed to use page->__folio_index.  Use page_offset()
instead, and simplify by working exclusively in loff_t instead of mixing
up loff_t and pgoff_t.

Link: https://lore.kernel.org/all/20260608210618.3437216-3-willy@infradead.org/
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Co-developed-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/compress.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index c904858dff3d..8078041b8796 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -105,13 +105,15 @@ void free_compression_buffers(void)
 static inline void handle_bounds_compressed_page(struct page *page,
 		const loff_t i_size, const s64 initialized_size)
 {
-	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
+	loff_t pos = page_offset(page);
+
+	if ((pos + PAGE_SIZE > initialized_size) &&
 			(initialized_size < i_size)) {
 		u8 *kp = page_address(page);
 		unsigned int kp_ofs;
 
 		ntfs_debug("Zeroing page region outside initialized size.");
-		if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
+		if (pos >= initialized_size) {
 			clear_page(kp);
 			return;
 		}

-- 
2.43.0

