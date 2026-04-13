Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D23C873B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776083067; cv=none; b=EwUQEof36Nb4blIV7tOtOSJTDNGWQOTz0Fu9GuM0eThJmk1Wyk6Z0e763kO/nDCM+XYz+gdD0LSw4w9q8qeh28QEHq4Yt6CiYYBsOdM09T1Afke3n0y1L5DN2HKk5nndES10j4jc9ZM651PerRZRbRa96kHqzhdW/8ck3XTZbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776083067; c=relaxed/simple;
	bh=aIYCkkXQhEV7YD2MK2aXrwo7YFHm3qdBNt570xMTtEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTbVE3glJ52VB0YWaPaIrrKoehUjC3pAqzfubfGKs6FDr2rm7XoQYdR41uyeshqaGWSPdkSFw5POfz+ep7vW+cdqqyWN+v4xKu1PTHDa6yyGmODFZGK4FOFv6v82V2Enyg6j4DhyU3wsinTWmDYeESZj0WKmo5MXjJTX3y51+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d0245e24cso391407f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 05:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776083064; x=1776687864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T44lkLiB2OZlnKSWXBAk/krtQMxamGcLoTv0ViVPUmI=;
        b=H+QIiOcvDG6bMOkDYGR74Ny9B00xRb9YSiano64eph9nDu4COnAYJosGRfvXuh+6OC
         SMiCBV+ESwEgDruZRuG/VKWjUJjB83bSyrp4v4yyblPArpl/Uw2Z9kJedG4/22zyLTuf
         rqHADkk5OWnB0OhXgujXgyBCezjCvzlnViU7hfZUJDnjJw5Akkwwf36qkGKxa8+kxRKp
         WRG+D5czhDKmfNTtQaopi3mirkaHx4091VpKBu6A2KbWz92BSKZm2NipRmWbe6BwgM5A
         VKRbmG/TdilScDQCVyFtba9MQ0sJF9t2HhYWZB7+gqULYvY63f9ZUFghCzyE/cZDH3sj
         jwtw==
X-Gm-Message-State: AOJu0YwFUJJlO0sN3FqBOwQbflfxx+7di1oB9D9qNAFnt54LfpBvpJ18
	9DmHxHShURP6Pnbi6SBb5WYGABJP/cdwojm4VtQShAZLFwUn60klLOyhASkNdnk2OKw=
X-Gm-Gg: AeBDieuqOCbI1QPGZquuX01N++FYfq6KDge+m2qUA6gQglmZUb83EnzgUnfw7uPkbvU
	jDbtaubwN5iKcQiRP2PN/yV1bYlqYn/i//rcN+ghgR9YVn0pruNjczKsL8/SodhURsH2YJ4fD8u
	e/m0hmaJ3nOWog+2oxbX9K8Nmu99YBhh9e6McT+LDKuFsO9RZZ5kLqpTlm4HFAy564roY3R3erP
	CtQmCH1o/cJryL19qEUxJX6/tHj7JbumRlbIfnDA1lmx0DkCMomlnmX9OgQT5Je5ofIJBo0JwEZ
	9AJD+bFkRlWyEwXX5WYKFECaWoaENFMklJWazePYV2d02eSnFwHXBB7uHn276J74YsR8NSoiJYX
	4gIttFRkEkL3J3pbzLxH4zcU28H2Ht+e+OGZ5IfVDxaAZSccd5+xz1She6j9FMKLaiDjmK3uia+
	dpnI6hZ2SmsiIcF1Hj7vBpJ6+u1v0S5XD/iVlLHNoDl9oFiQseOYVkEq7Clp1k2r9HBA==
X-Received: by 2002:a05:600c:524a:b0:488:926e:3ccd with SMTP id 5b1f17b1804b1-488d7f24014mr94782785e9.4.1776083064297;
        Mon, 13 Apr 2026 05:24:24 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm278260915e9.4.2026.04.13.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 05:24:23 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	aurelien@hackers.camp
Subject: [RFC PATCH 10/10] MAINTAINERS: add entry for FTRFS filesystem
Date: Mon, 13 Apr 2026 16:23:56 +0200
Message-ID: <20260413142357.515792-11-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413142357.515792-1-aurelien@hackers.camp>
References: <20260413142357.515792-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aurélien DESBRIERES <aurelien@hackers.camp>

Signed-off-by: Aurélien DESBRIERES <aurelien@hackers.camp>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12f..f99e1219f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9610,6 +9610,12 @@ S:	Maintained
 F:	drivers/leds/leds-expresswire.c
 F:	include/linux/leds-expresswire.h
 
+FTRFS FILE SYSTEM
+M:	Aurélien DESBRIERES <aurelien@hackers.camp>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/ftrfs/
+
 EXT2 FILE SYSTEM
 M:	Jan Kara <jack@suse.com>
 L:	linux-ext4@vger.kernel.org
-- 
2.52.0

