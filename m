Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22C836BCC2
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070260; cv=none; b=MFuG9aW88lCDfXFyzTtGdNGwmCLyzJ17Mc6D2ZnSiVUegKaRWIyrrcFBsQEkcuBt1C2uj0p3EaRxWEVHWMjG+frsr2ymyxd1J/x52HptTgUGSEoEheJ7zUf4n7wzAjoEgmhgLl/NkM+zpKMpTLeOw6c2eTvkrXGB590shKUEcHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070260; c=relaxed/simple;
	bh=pqFri5VkDvyO7q8ZaTFm+3zve13RTKgavV0qIrdZWoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l9Dxirlj/3AnFLp9x0/jdVnGpYO1VAtLJpwaSzx9ApPLrE2Famwo/e8oqLIFGJINEiy4XZTJVaDlwT0KHeFJuJdnCRbCxaO8+YmCepHC1l8zEMFWIkD9ntZOXZSsSXFhnygDFR1ZQV2eh7SEPLaPjSANw+0a72Ei3iLmg/4NKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLRnheZt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLRnheZt"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-364eef1891dso3533618a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778070259; x=1778675059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AG48vQGF89Wp3oiv3qeQlyHb/SVpouFehHB4gYw7kkU=;
        b=SLRnheZt70l4na3fR3ZYTK9OIazO5SaRQAx13+nCCILNqaipB+NVUQX0hqS9EKU3G5
         JCKAiMi49Ai+7uHDrmdPCD6lVN6hSmvJZqRCbA+8+olMYmVniVn+H5OKOEVJbmF5b5Es
         dKhBBlZ5qZHjHNk5VDhv0SA5ltJnrm3HbkKmRzGgW0U+dS+gueEhadEujVQlpnHkcIZP
         v52UhYRUp/pO3FHT+d4p5Eo2ys30MIIdBeNOVL1MAb9rheumrT7V8MG0N4TxGA7CXGI3
         ETaWGoYFP+h2H63TwP7NkcWRMUlU1gNyCP+HCx8Tye5G+P6hxWFcHeSGMg0uH1UYBRNC
         h+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778070259; x=1778675059;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG48vQGF89Wp3oiv3qeQlyHb/SVpouFehHB4gYw7kkU=;
        b=qYHf0W4Jqwqb79w3Wn3USZIBEYeothAWUPIWRPZ7oKfwjSLq5xZqYBBdpYRo+bg4Zk
         jOZWILzb86bPcMI6wLPy8EviNva93D5ZgwMKQ3ZyBNIr0kRrrqfOaYFHdKxx7EPOud5i
         v3bhGsvA4/KwXSu8QLNc3CkuJ7Jf29Ot8URqVVDujcXpXktKsSIaCTTkFOCEK4dsfuYv
         9lqRMMFz4dzIN1GTyLV/GyMisPC8Xt2R00Ut5z92HClh6xaKYo9m4UWZss5EvHr8yOd1
         Ip9keFhPBzi23I+kkqdIIU+L8uGgAjbWZOnQdhHYYJiNB//YFfBoQP4F4PhqidPglLVF
         1PkQ==
X-Gm-Message-State: AOJu0YzIddDRWglcb4NM5IEugVgm1bxDIQ+O8biqEVao+m649KhGBlCd
	u0aiUEERWODR3ojrO4YVUAhAPGr/yUHrFBs9jrtF7ou9tXkYSd6p5n8vjxubZXsAcc0=
X-Gm-Gg: AeBDieu3fbBZBAiK+pip5f128XcJ+dMD8cGr6cJBVDq5i1ehNk/ZdLM9KnYX7tBcpdj
	uzP7abAa94yrsfwZD7Gg+8M+WwDFi5V69WpWbS4wZ+SVdq32Kog+gp2okT/OFsBGurO5N7kZebV
	ucM01HtF46OPATNLxZwzsizHtvJTsu6GREtw1J7NEVVOLXWqhUcPPjfseTMKrb0DNslnnaTKUP0
	mkbu6VPIYo7Ea0uHR3vFc37ckbLeiT4SIGmdn7GympZWk/MPKGnGCEuLbXAPy4JSvZFcr03DApV
	dOrcJnJj5IToQU7KZb3l0FCLCt9F/scp659Or9aD5BqYNsTRemWNX1msIni08tO+y05bsslzwCm
	/AWj1ONFEmddPFD25yAOwp9zXtcwLSD19PrO7uba013RStD/yziw31+8KTFJDo+mM6w/zUQKf9l
	YVyYv6JyZrr8ZkzZbDZ8RpGn1QiBbprYohNP5WxN6XBgRkZaZZdqrD++dI
X-Received: by 2002:a17:90b:314e:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-365ac472124mr3210181a91.23.1778070258844;
        Wed, 06 May 2026 05:24:18 -0700 (PDT)
Received: from localhost.tail66efb9.ts.net ([14.218.2.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b06b6f12sm1105584a91.5.2026.05.06.05.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 05:24:18 -0700 (PDT)
From: Junxi Qian <qjx1298677004@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Greg KH <gregkh@linuxfoundation.org>,
	Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH] fuse: fix writeback array overflow when max_pages is one
Date: Wed,  6 May 2026 20:24:15 +0800
Message-Id: <20260506122415.205340-1-qjx1298677004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_iomap_writeback_range() appends one folio pointer and one
fuse_folio_desc for every dirty range that is merged into the current
writeback request.  The merge decision checks the byte budget against
fc->max_pages and fc->max_write, but it does not check whether the folio
and descriptor arrays still have another free slot.

This is not sufficient for fuseblk, where the filesystem block size can
be smaller than PAGE_SIZE.  With writeback cache enabled and max_pages
negotiated as one, contiguous sub-page dirty ranges can fit within the
byte budget while spanning more than one folio.  The next append can then
write past the one-slot folios and descs arrays.

Split the request when the number of already attached folios has reached
fc->max_pages.  This keeps the folio/descriptor slot accounting in sync
with the send decision.

Fixes: ef7e7cbb323f ("fuse: use iomap for writeback")
Cc: stable@vger.kernel.org
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
---
 fs/fuse/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c59452d60..f94f3dc08 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2176,7 +2176,10 @@ static bool fuse_folios_need_send(struct fuse_conn *fc, loff_t pos,
 
 	WARN_ON(!ap->num_folios);
 
-	/* Reached max pages */
+	/* Reached max pages or max folio slots */
+	if (ap->num_folios >= fc->max_pages)
+		return true;
+
 	if (DIV_ROUND_UP(bytes, PAGE_SIZE) > fc->max_pages)
 		return true;
 
-- 
2.43.0
