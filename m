Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959B53793CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773960682; cv=none; b=Oez6e07fZlUCXDNUYFyb+skq0xmZBBnDMF6rgG5F5RwsrFG8+ZuGBa/lrKf5vXTbmgDpA6iTRqiYy9UyOOOosZBTKkAZECEB/uiapaTawcHjlgxBAaK5RVgD/W5AZgZKQe9FSjQmU77Fmt0tGZO0hMa4aU+Di5cF2OzUXl7jTuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773960682; c=relaxed/simple;
	bh=6AfcReJcrJu9WhnO3qul4fSvdhivE/F/gIelzT+OOp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eWCS6PtwXHVj2lxF9zKOMxrs63AnXDEFr/pr72sF+ZzMKtyQ1KlGJ/ZhqGZnwIk7YOK/jxSwErh0p3bGATroI3pgsEzxtVc0GVw7No5zafQBNegJU8eKqBhqlN984itI4/3cqv+n7A0wRJNNvamGQ2RlDDYMFKPC6lqZ0r2mfSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lZB4XDab; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lZB4XDab"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486b96760easo15917045e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773960679; x=1774565479; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUdTNDItYvJjqtgNeFm2LVISlCQh8R6BtBr2HsIhkJ8=;
        b=lZB4XDabbMIu6AZkaJv2d0lzXbBUEu0VsaxclFKiMIVhNZ1GsNMI1YmLADflY6EpLU
         nEeYNn2sTvOBcmknhUvJ7nE0FtKKf0hizm+/SVt5GllKEQ6+NadsPXIKnr1fpwhhmBkW
         cHKI6Dp9CBHBYnHA5dl+Sxs3nkgcu3fnV45ZiuiDROsJZJ/QrrZ3pkLgYvSPWsMYDueU
         SUIlr6Ek6IO8IoZDuW1I+riuXji5TQvj7u4868LCJTo4IBzFYaWvukeWlqS7qQ8x2AfW
         CHLH9MMZEeNGWQh0vX4AbSlb/R93w/N4K9Hx8uYhRLirWpsOhPLUawCtnYPuEiOqQI1A
         AZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773960679; x=1774565479;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUdTNDItYvJjqtgNeFm2LVISlCQh8R6BtBr2HsIhkJ8=;
        b=PxBLNXSBhsbWF2XFQhhkDw8B/rTTUAPUHu88/Q0/LfofdJZlbyFho/AyRJ3MkZ79b0
         DNZHbq7e8UFR1pUGKPyKEbtnXYFfTZHISxw6pJ1JFLzHIgygsdGB92Crr7RrQtcKB76X
         DdLbKbqpImWSIcGEUXo94UO9QoB1BqEhdI164ZnRq1tBrcBnRhiFf4kHJHn7d8q/kcyH
         lEFJfvIKQweuoPhwbP23tm9aAktQrq20JrGRqZp5/cvYPz02KMTvZ17G36DcBNJeNsON
         /8STytRa7Fx5CdVPH2kfX8n/ZpEYuNbOuCDdcGw7bt228H2UaTWbl0Np39RRsYLRKhFg
         hXuA==
X-Forwarded-Encrypted: i=1; AJvYcCXgUZXEWD6KZfI/wT6MlASL/w0Ldo5tQSy7g13QEE8eqG52L+w5oR+ePaLE7NIss8HEDsaRhTd0nDSIMx/f@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Hgsau8Z7rscJTBwmz4xQ2rOo0MrUoUbyOU6FF7a/JbGfJmwC
	ZQkPrCJxZJKJpPDMR2lNhxeDR16VkBZ+4tIHO7AjlKov9N4dbd5PP5Bt
X-Gm-Gg: ATEYQzxjOK+SCL4FaeXIGbyOJSPYpSsitSHdNWhujXeI0EF/vzEaK1UGiHLKDlGaa6t
	At9yeHN+Ww8rCX3n19/n1jiyhqhtS+FbmPCHJpgIMSVyga32QEes0AgpPB/FiuiNqPfj8ENyr7+
	KmXy5iVNbs3Ks3rX8SRxtToPgtmODNu/ggsFigXsCXPhNE64+Mi22odQwi5t32gMUorBbHaHisC
	xsOoU56By8ikBCkCoGmku1qzwguLA+sJXd0sVz4WNajTJTSBXaxQ1f+fsbLhaKrIiQ2RzH0zR4h
	M7MNMJdzWzffVuzCncojw9zcl7d+7MyVNVhUw+F3Dr1bcdu0lXrjN9JI1huToWuY0fwZc/YGOiG
	wl8vHf+aIqD//e6obkTjJ/u3bENRgdO+B3Q0m+78dezHNuojj9oHxKVaOpq48s3ppaUsWlhGtg4
	lveqIBXCZqnra/faAgifbLolKWOqtx8g==
X-Received: by 2002:a05:600c:8b66:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-486fee0f835mr10675735e9.18.1773960678806;
        Thu, 19 Mar 2026 15:51:18 -0700 (PDT)
Received: from [192.168.0.108] ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm1939156f8f.18.2026.03.19.15.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 15:51:18 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
Date: Thu, 19 Mar 2026 23:50:50 +0100
Subject: [PATCH v3] sysctl: fix check against uninitialized variable in
 proc_do_large_bitmap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-fix-uninitialized-variable-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09@googlemail.com>
X-B4-Tracking: v=1; b=H4sIAMl9vGkC/6XOQQ6CMBAF0KuYrq2hRcC48h7GkKGdwiSlJQUbl
 XB3CysTd7r8P5P/ZmYjBsKRnXczCxhpJO9SyPc7pjpwLXLSKTOZyTLLheSGHvzuyNFEYOmFmkc
 IBI1Nl44Pwata+9pCaLFuaOph4HmmSjRHUEIVLA0PAdPKhl5vKXc0Tj48tx+iWNu/uCi44HkBW
 mqtwUhxab1vLfZA9qB8z1Yzyk+n+smRySm1aQSgAXmqvpxlWd6MTwHDYQEAAA==
X-Change-ID: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Octavian Purdila <opurdila@ixiacom.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Elias Oezcan <elias.rw2@gmail.com>, Peter Seiderer <ps.report@gmx.net>, 
 Marc Buerg <buermarc@googlemail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773960677; l=3294;
 i=buermarc@googlemail.com; s=20260312; h=from:subject:message-id;
 bh=6AfcReJcrJu9WhnO3qul4fSvdhivE/F/gIelzT+OOp8=;
 b=ImgvJ6Afc9p3uliV3Aeh619/GJK7s2SFbVzkHeiK5D6PGb3oiKxJNUvLo9eEhGin6Gq7dUnUB
 swsDwJt+CweCKqvVtEy/stfLP2he1SdO26mr+xUHTM7vxs6bwAtE2KO
X-Developer-Key: i=buermarc@googlemail.com; a=ed25519;
 pk=kBZIEGh9yNUzqCz87kygF7XqwPxTWvwm4+HUrOuckyM=

proc_do_large_bitmap() does not initialize variable c, which is expected
to be set to a trailing character by proc_get_long().

However, proc_get_long() only sets c when the input buffer contains a
trailing character after the parsed value.

If c is not initialized it may happen to contain a '-'. If this is the
case proc_do_large_bitmap() expects to be able to parse a second part of
the input buffer. If there is no second part an unjustified -EINVAL will
be returned.

Add check that left is non-zero before checking c, as proc_get_long()
ensures that the passed left is non-zero, if a trailing character
exists.

---
When writing to /proc/sys/net/ipv4/ip_local_reserved_ports it is
possible to receive an -EINVAL for a valid value.

This happens due to a check of a potentially uninitialized variable in
the proc_do_large_bitmap() function, namely char c. To trigger this
behavior the variable has to contain the later explicitly checked '-'
char by chance.

In proc_do_large_bitmap() it is expected that the variable might be
filled by the proc_get_long() function with the trailing character of
the given input. But only if a trailing character exists within the
passed size of the buffer.

If no trailing character is present we still do a c == '-' check. If the
uninitialized variable contains this char the function continues
parsing. It will now set err to -EINVAL in the next proc_get_long()
call, as there is nothing more to parse.

proc_do_large_bitmap() passes left to the proc_get_long() call. left
will only be non-zero, if a trailing character has been written.
Therefore, checking that left is non-zero before accessing c fixes this
problem.

The problem will only arise sporadically, as the variable must contain
'-' by chance. On the affected system CONFIG_INIT_STACK_NONE=y was
enabled. Further, when enabling eBPF tracing to dump contents of the
stack the issue disappeared.

Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
Signed-off-by: Marc Buerg <buermarc@googlemail.com>
Reviewed-by: Peter Seiderer <ps.report@gmx.net>
---
Changes in v3:
- Add Reviewed-by: Peter Seiderer <ps.report@gmx.net>
- Re-include bug context into cover letter
- Link to v2: https://lore.kernel.org/r/20260317-fix-uninitialized-variable-in-proc_do_large_bitmap-v2-1-6dfb1aefa287@googlemail.com

Changes in v2:
- Drop initialization of c to 0
- Include checking that left is non-zero before checking against c
- Link to v1: https://lore.kernel.org/r/20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9d3a666ffde1..dd337a63da41 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1171,7 +1171,7 @@ int proc_do_large_bitmap(const struct ctl_table *table, int dir,
 				left--;
 			}
 
-			if (c == '-') {
+			if (left && c == '-') {
 				err = proc_get_long(&p, &left, &val_b,
 						     &neg, tr_b, sizeof(tr_b),
 						     &c);

---
base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5

Best regards,
-- 
buermarc <buermarc@googlemail.com>

