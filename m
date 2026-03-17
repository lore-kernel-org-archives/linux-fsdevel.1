Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7601395256
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783611; cv=none; b=m07WqHTfSdjQaHFOY3eamzCQi6PsVaYIZh2q6IeWuHn4fcCMtMePtrImias4+4kO791nwH5rjIaXNQe/9J/H/hWzJAXpQ1audsCggFSo8xnP/g3sc8F8yd8dqbeCNlspyhN0Lv3kNZ8ad2Urjc5ym3LMD5p68ui9iV5vkGE2oPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783611; c=relaxed/simple;
	bh=9239N7F1ux6YHvgN4osMP3w6IaeFva0SE8JuYoWDSvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ury4t4ikCIlLLAS7jew4S8GZ8y99Ll2y6l2fybE3jBOXoCiJoFAmP1pEcUoEq5ezl852VKcvtN8JvDfTo5tkfvRMwWzF6i80WXO6NlOyVWUrQMyYwXs6iue2by83kWydeso56uA6HzIZ4YTvc+l1sbKKB08OxNVY8VKYjq0Vv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=G8i2xKxm; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="G8i2xKxm"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so273496f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773783608; x=1774388408; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y24X/WaXxoAC0wpC8m89VlGTE8Q7cW9EOKhjAlW1CVg=;
        b=G8i2xKxmFz/gGP0zugf1VPZRRu09xJ6AiaiOqd2vdGAfbdnTd2hHKKMosYPCMLorLA
         6BkiEr7Qzq9wwUd6VcqOKqO+uwBy+9hy/BilN84XZK7uKgImiPrcmdnHRLIM67M4SdLa
         eUeZzKUwUrKyYCEi7ZQyIuHDG9P4su7fkbQ5ymZyc7Rd6qIS34wYTweqiD1fE/L2D1V3
         epL7oQNDRt4akyAwbGY2dTEimekbiArVC5oZRQuzaeJDpk6K2SLYJEO4q7pooWSQ9MnZ
         u/EqdmD1hn7s8tkq7QoEj+ZVS4QUh+xPAd60SEs6TobiwvQsjl9iyLqB/2ujqMzXjaJ+
         hVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773783608; x=1774388408;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y24X/WaXxoAC0wpC8m89VlGTE8Q7cW9EOKhjAlW1CVg=;
        b=SfUE3C1bLYZbjgUt+2xzqvP3B2T+XtcUxuLPOqbunbigIOWfcusMExL5S/B+GNBc+9
         jqbGpBz4cEDHsIQu2U9Jk17H9+HZBAMY4lcnj0JSXwEoyclF+uDtoYCCjq/O+QJB6DEE
         Rl8PShHRuAM4dTeA+fXQlGyEnyT6FaT3WWLxitBDuCF4yYOUkPWu+cNHChRNUoAy14Zz
         885xxe/AV6FuxsuTZgC26DRDDUKWaO1ffJxRwVpW9jaBElMT8BhQyFPql4wXKAIypLpM
         GqC4TeQraavn+MS8ecIFvSduBoSMSO36ViCgYk+dubezYS3or5Xq0UW2m8s5o5/4Bojn
         onwg==
X-Forwarded-Encrypted: i=1; AJvYcCVuxQqwuMg+2SwQQtdnEGKJjZ4T5/XBC8f6DC056Ze30l6S1JWYVHyk/oofkPS33kuAd/QYok73rKR23WvS@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKFxCCfVRhpjx4mKmYD6N4cDypLMjiihNMort8/1+isY3jBvo
	Q77kykJq5X80BUUiSfSr9959BHNd10ykzlUyaYB9gPpy4DBv539ib1Lm
X-Gm-Gg: ATEYQzzqdZVx1z/l9ihxgfFD+sNI18BVHgcGJPq05UlBqyLOi2z9CPwc57oKvSAm6n0
	VL80AqJEHilym+eRsfjqvk14h6oVAgedjJoViN1sjuZNm/luLP89/85fphpvbZnrwzB3uXQ0hyv
	WXhqqyIQ9b/t4QHLo5ULKSpdO2DXnVn0EFwMEni2E2UU5hIUbNmXKjF2a8rKYGLAuGm9MDt8+pM
	Mp3J8CralfbTqXVBcsBWFwXo6R7QP985aUnb/j2c40IYLYVy+FPlu3EQbtv7NvB5JWOLSm4JzgX
	IjfhxmYCA8W5rPjHMz/TtFJJHgUc6BAatqqoQBU49h1b7aUguJy7Vos1STq5eG1f3lwvwPFWxj0
	ZrHvnZbsJ1ZzZYxEBdgW5B/rZ0os7R0Vzbc0T4Yp+QHXxsQA6wlYKUbDN20h9TTGeiJOdpNjG3X
	pk+D1STLsbDJq8JwDW97Q=
X-Received: by 2002:a05:6000:2303:b0:43b:4312:2cbb with SMTP id ffacd0b85a97d-43b5195694emr2051681f8f.17.1773783607879;
        Tue, 17 Mar 2026 14:40:07 -0700 (PDT)
Received: from [192.168.0.108] ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b51899622sm2479963f8f.28.2026.03.17.14.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:40:07 -0700 (PDT)
From: Marc Buerg <buermarc@googlemail.com>
Date: Tue, 17 Mar 2026 22:39:32 +0100
Subject: [PATCH v2] sysctl: fix check against uninitialized variable in
 proc_do_large_bitmap
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-fix-uninitialized-variable-in-proc_do_large_bitmap-v2-1-6dfb1aefa287@googlemail.com>
X-B4-Tracking: v=1; b=H4sIABPKuWkC/6WOQQ6CMBBFr2K6dgwtwsKV9zCEDO1QJiktabFRC
 Xe3cgWX7+fn/b+JRJEpidtpE5EyJw6+gDqfhJ7QWwI2hYWqVFvVUsHIL3h69rwyOv6QgYyRcXC
 l6WGJQfcm9A6jpX7gdcYF6kq3NF5RS92IIl4iFcsx+ugKT5zWEN/Hhyx/6V9zWYKEukGjjDE4K
 nm3IVhHM7K76DCLbt/3L+tX4WP5AAAA
X-Change-ID: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30c6ef4ac1c5
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Octavian Purdila <opurdila@ixiacom.com>, WANG Cong <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Elias Oezcan <elias.rw2@gmail.com>, Peter Seiderer <ps.report@gmx.net>, 
 Marc Buerg <buermarc@googlemail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773783606; l=1689;
 i=buermarc@googlemail.com; s=20260312; h=from:subject:message-id;
 bh=9239N7F1ux6YHvgN4osMP3w6IaeFva0SE8JuYoWDSvo=;
 b=6QGig6XTTBH1VJmGj0uuZu+dkyo6IuuK2rsSLZyknaYiRGucmEC4+VWOaHZBn/gwD05EOHYkq
 yIAI1yuULTyCjSTCjAASHNx/qFfrUb0rxfY1Y5JzARcjyB20IR/STe6
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
Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
Signed-off-by: Marc Buerg <buermarc@googlemail.com>
---
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

