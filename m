Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E45399032
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114396; cv=none; b=kCbexayXTn8hq3NahYuXE1JcFe0ijIrtrGpxcVO2dZkc9G+EQV3hX4KWSvwuEH+40e7Ul/8789QR417PIPpi9e/1lMhUw9HTbxwcH8dHLwd686HfKcQcHlF8sXncOr3UkPw8WJ7q7SpG78XyHhhFZJQIZBwWLr34JPrTXYYem04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114396; c=relaxed/simple;
	bh=gofNGxhmstUnqml+TbutIimfWDHAbpz1kCzS4nwkX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XikoN6N61bEzAgbkGvDPhi06nnJJUwwvNJ33An5RatSexMU2d2QHQkDfaBCFOVg51XMbKLmUEB6H8CA38QSYnREO2qdYXim0mndwEVR5ILa6jiGjkC9xLm8mwQH/NgPoOwuzePDcmyt57xkuA6uxVgAqhEyvIbb4Z4jhTuuOc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7dab87e1so69984f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776114390; x=1776719190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u6+sKOyLCVa1YoFPa9BtTOYsyUICssksqaNS8/FnLtE=;
        b=dxZ5aOgeAThsCorivqLzfEXPnnQQMKoeYgZZjDFJAztXLdmQR0ifnr5TU7BzWP97Mp
         kNZylAriU7KfggQ9y9ayAoWqhjXoMUYZJDK4xf5bQHR+omXPiqWcvR8fV1Av28GBez8j
         rrsUtTDOa0DcQLP/xXCrT25Cba00moVkobV816hcD+P761DqXkgEoDVqyfUK3MeAQLJ/
         UdpHlSgLwKHk08Jg+Py+pOsCBtg5MJUP+BAFqPDfL67gfS9UwF0LX4STLRty0EjCLZns
         p+XRguPbgvuWxWuu2H+c3WPx5Eg1hU39TYu1dJrXqLmOR6FxW2BelypKnIdH+WWP3vJg
         zO2Q==
X-Gm-Message-State: AOJu0Yx85Y7KFmilCSWb+ti4zcu7zZlTLtnYXNimtepF6ox9FhIsa5fe
	T+EoDUKnh5IUPzxqoMzd8bAyvux/626KI5uVa4alkG855xzx4FpjDnJUTlmyIDLGCbA=
X-Gm-Gg: AeBDiev0AopHz49ReMY4x3aWMUxNOBim8KPEVuaFyKtRserUZ8SBKlqdi7qW07z8P0b
	0IdcQY0QHruKOOWOVvwBSjD/PWniK+6BdGn+iB6YIaXDGfe+aJDL5izscUsHhc3/vsI5AXPdv75
	cqW2Khss0xjXRqxOeR4TmL9ZiTj5THA///sOk9smcmE1wCHiRrhOWtWcx2rVc6A1w/zr2m8hKFp
	kwvbzQZCdUt1m88NBp1AWptkWqVyoWgGEnmfsRLkNluv/nGSsFi3wREwpbf8oODtSYoMHjKnihX
	Pd0pMqUttiMK76BpLlCWOVUbobkzJrAQjORZiv6QNanOpmShlRbCCJoAxCsL1CAT0HI9ZblKy0U
	ubpgIgXeIQenKAgHwivkXcMs3lECPoc3DyTV8iaxhf5Hb5bkTNrYsvM5CFC66gKKwDGwK42TzCz
	1KgM7+PIo9hDomalTib4dJWrgzJlForQCBXqBpA5VB6CtOSdU8N7xQBxZ8+K907Kb+MlohK8rD9
	JA8
X-Received: by 2002:a5d:6e48:0:b0:43d:6a00:6275 with SMTP id ffacd0b85a97d-43d6a0062cemr5469388f8f.4.1776114390140;
        Mon, 13 Apr 2026 14:06:30 -0700 (PDT)
Received: from spartian-1.home ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c98fsm35130020f8f.35.2026.04.13.14.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 14:06:29 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	willy@infradead.org,
	djwong@kernel.org,
	adilger@dilger.ca,
	pfalcato@suse.de
Subject: [PATCH v2 10/11] MAINTAINERS: add entry for FTRFS filesystem
Date: Tue, 14 Apr 2026 01:05:51 +0200
Message-ID: <20260413230601.525400-11-aurelien@hackers.camp>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260413230601.525400-1-aurelien@hackers.camp>
References: <20260413230601.525400-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
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

