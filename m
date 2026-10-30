Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339565;
	b=LZYj/z0HNHMPphpqKj0wG8n7lfK8nlcUeTQaXyYILzrQhQ7wJc88oMLptZpGvZQhvEsc
	 EPpGRh30QDIXdbSLW0/HkPeQzr+Gm+9Yx7M1CUw4GDlCQpFt/Ezmr3o8aedGdLKWlUs+A
	 RxBZFmTgGK9CEn7hn7jupwetLfMycrYyvU6dV94N7nBNExnfngrScmDaHmbrtAE1CAqPd
	 gBwJp5Qy2HJIzd+9GQw5e9W1PlwWLTIzIxoHGOfIpLcIHGzVfcTx6MDmqtNZ92d60TjaW
	 LnmgvRxU1LLRvv5duLSqJlE2s9Gz+/584c8GLxPePZS8uqQiZUFI1CJcvf7DQg1D3iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:To:Cc:X-Mailer;
	bh=VbRiuv1zzZPpsXqO5zwHM0e9x6dnlvGPnhrO6rm2E7A=;
	b=wwavlWjTogrC/RGx83UWSLD6ZgGgANb5ACaeReLQTQ6pEagjmHHbOlJEhHvem67vXcmX
	 5bYpGvcas2rP7K1bJzjwnu11Wo5A3E1YowevSE4xH9w0qMQe0sqQAu94ZOIZf7ZwiIBny
	 Fs11ogc25gTNmpTZ+QY1YjNLzmx6dQgdKqkGJrmoDRaH7fDiQtxJoMMBPz/m1mPHvuYqE
	 E8qr2QVRhF1SK/QVDbRE7JU9mjOvMi0WOEioes/L1M+a2S8YUUYbPCQ8XaO7fxDSD90Xl
	 0Ur9Dd3mbD9Q2biGoR12X802wVbFWOlEn59+CGgOjERxY50UM60xrqgQBlY34lGxzIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kL+rJ5ml;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439A1606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 05:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 439A1606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kL+rJ5ml
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-185fd3a4ca3so297450c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 22:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793339564; x=1793944364; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VbRiuv1zzZPpsXqO5zwHM0e9x6dnlvGPnhrO6rm2E7A=;
        b=kL+rJ5mlhDTdElNXQpMNmC+lFFdeCCCvkIJjS+DDV40iDQZXyTs3SBB2eGEOCQJOtF
         i4Ok80Jl/dyQnnLRATG4Td3Gswm32YCiQT8xqghaBRcVa79OSoHGtQs2R39LFX/jwnL/
         /eRKmGGBw20AnqFQjZpcJKJVmMlLF8NZCpZrgKuz/yAZJ9dEl3egS2lv0Or/2b7DKW7a
         qXzLrrXoXBoNE9m+gfyzTCmLd4rfN5+NfgwLmiILLhjUsj+Z7v94MyQ+kpgOX99nNCHT
         XK5KIuplK8Vg0uRrjpY/hvMdogmx0CcLjeSgG/Td/Ogx7syKS3dPouQ6FzDUyXuhj/cE
         2ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793339564; x=1793944364;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VbRiuv1zzZPpsXqO5zwHM0e9x6dnlvGPnhrO6rm2E7A=;
        b=kGOUmd2B1sfi4M+R90bYUO0M+iSandgUFrCqXc1hSoFOK9FCn8xtH3f8FIRxMan/sU
         j/MQlP/+HCYJ9Gizg/EeE0DcAcAB9DvgBYPSQQc6ODSpy8xnW1xS3YH+Mutd1tVkSAwU
         /FzJ3lx8EuKXRjTHFXiayZuY19eh9wz8vaE1khAUmXyut+V2yen4a1/tKfGw3GNZyXi4
         cvcnwW95fRgcNFZ1kFmTc7X8pQnIOG2blmjRiT3Np5/Tpq2jMFl7YnoolhOSgCPcxzym
         M+oygSWULjGYuamZSvSsJxRK0Bw5ceWpVZG+UVcnAzAN60HRb+motEm9t1YhHth3I3+B
         dWog==
X-Gm-Message-State: AFq9FYK33eWqP/9G/kViqxzjvxdU9XNQNs2c6OWjWmyw8KR9b1RgTwr3
	cqYWsb2IxJHVtrpbyPxXC29giEWzq0ISo/eONa35NzSuL07QoJoVGL9Oh6RkMzj7
X-Gm-Gg: AYBFou0d5RpiYamfAlt7woi+4xZZM0th6K9GuHgm61rZ2m/VorhR+670Bsr5DWukIqE
	gMJlHspyHJwr2xnmtuu4cj9P95iqmQoRW8ja2B8fdy3N1sZNAZO4/MgmVEoEt8TmHhTjoOkrqyf
	lzaO/DJ+jLzsw9Umw6un4xMCh3Irb1PU2I+iWqINzzeAMciVCsqbYME6vn904XR3LG+S6msB9vu
	ApgldhmWJsGIPIUgwChMbcLNiearBwijpErupaobkhn8rPkL2XM6bu6MFJJ95SJ1ZeJtvQniemh
	s+4eTXF5p71KWg+SwQrzYuX6eivi64PRjBOze01sQ8x3MrijPTDakQKV1VcY7t44wdUTwdDCN5t
	0WT72e+IkcpCmkLyJdzA8PhIgl0dFiqxUUY6JL9UIMk8zFqEFF6tV0ccZ5BzwQ6oP2ZhFntH6FB
	0Oe2qQKwi3YeHWFD6eIIYQdaND4A70P9ZvpKGwIHY4Upqdg8FpEdIjEEJX+vv99wiRQZeE1mFc3
	HBFWb1YOtY8tsGkbz+vRGcjqNWj0DDA6AGaolodFSLtf8Q+tft3zeQDfak8cqkn4nL7tr/w6L8Z
	mn12JCcAwh96Jdg2jDrEyMp3
X-Received: by 2002:a05:701b:2411:b0:1ac:75b9:f82c with SMTP id a92af1059eb24-1ac75b9f892mr1448025c88.34.1793339564232;
        Thu, 29 Oct 2026 22:52:44 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1b0a628bsm3675448c88.22.2026.10.29.22.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 22:52:43 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 01:52:38 -0400
Subject: [PATCH] mm/filemap: clear page cache marks once when removing a
 folio
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
Message-Id: <20261030-bug-mm-filemap-init-marks-once-v1-1-699835fc6690@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKUw5GoC/x3NQQ5AMBBA0avIrE1SJCWuIhbTGkxoSYtIxN01l
 m/z/wORg3CENnsg8CVRNp9Q5BnYmfzEKEMylKrUhaoUmnNC53CUlR3tKF4OdBSWiJu3jKaprCb
 StSEDKbIHHuX+B13/vh+gfW5ecAAAAA==
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

xas_store() clears the marks of an entry before it replaces the entry
with NULL.

page_cache_delete() calls xas_init_marks() after xas_store() whether it
stored a shadow entry or NULL, so a folio removed without a shadow, as
POSIX_FADV_DONTNEED and drop_caches do, has its marks cleared twice.
With 4K folios that is about 6% of the time it takes to drop clean page
cache.

Call xas_init_marks() only after storing a shadow entry, whose marks
xas_store() leaves alone. Dropping 8 GiB of 4K folios, median of five
runs, averaged over two boots of each kernel, in a 32 vCPU VM:

                          before    after
  POSIX_FADV_DONTNEED    1517 ms  1423 ms
  drop_caches            1515 ms  1422 ms

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 mm/filemap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c6..a0c959e74533e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -140,7 +140,8 @@ static void page_cache_delete(struct address_space *mapping,
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	xas_store(&xas, shadow);
-	xas_init_marks(&xas);
+	if (shadow)
+		xas_init_marks(&xas);
 
 	folio->mapping = NULL;
 	/* Leave folio->index set: truncation lookup relies upon it */

---
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
change-id: 20261030-bug-mm-filemap-init-marks-once-b83c6aa67bab

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

