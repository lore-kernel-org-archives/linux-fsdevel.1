Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F012372EE2
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183294; cv=none; b=VhTptDlsel9/xE09silZqlMRgrImmN/eFyvnbAHN7gr2e/hUdYJRMGMiWxV7Tg5DnCoclM8/NA4l+tEGnvHNwDEYOmkinXCelkiS9XC3D8mjO5Jb0SqJSf43QdqJ1Y6AM8AHappIwYkRAFjecr+fxtgYa8tkRQ5HkSWsIFDrnTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183294; c=relaxed/simple;
	bh=SOi1hRb7i/SFIuu1TRnSgGyZ0B0sBigIfWhXiCknJJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyC1asjNW2+3vJxOblCTnciflcDPcJsPLIAWDCeJx1ldYxU9+iap2ZU2UgHhy41OxMjyhRIFsgl4XJFy32A6R+y6Y33TzvJvJ2W4T55ViomuEkl8AYf3Y/rk8cbu7ASRx4rjHEO8qwnAYAS8gXpZtAK6AB/boGtO/OUNoDM34Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=oeT0pZtv; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="oeT0pZtv"
X-KPN-MessageId: 32848853-77c7-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 32848853-77c7-11f1-b2a8-005056abbe64;
	Sat, 04 Jul 2026 18:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=hinhVazh+P2rhKxj4kWTtHx78BM5i9joWic785ap8RA=;
	b=oeT0pZtv6MhCLoOcbeNHpUgmTJEM9A54it1TgEgJGcUfd1lrtkIVeL9DmWtPerG96LuPZMZyeOB+O
	 3g9qQ4cnx1yyAogtkWfePkWUpUHe9x8wkc3br0H3xGO7eU6eKWvHrqiqxQa62+K4eNmvPZEtGagST4
	 AQBzc4L9gHmu51hfQv/5VZACTwdUFPVMBm+rqf4BwhYfwq+uYl5qXvm74VXnvfuE1fBz3NPreoTin9
	 DfZbgkG/ApAwAF5N7+z7GADKtf1HUj1dxSGQG4gjYcQq04gRp6z9dAjmgEMp6tD7KiK4DDA4yNWdD5
	 RT+Kj5iIuIhz7qE8tI5VanK/Kojc1fA==
X-KPN-MID: 33|si4WScxBOPa1MumFaMYoYiniaFEl2EN7F+9vQ3AEyG0ERebg0wUp+dTjpFls8c7
 AWJf7yAEWmCxMcfifgLlSMdZGPaBKIZd6Y7AkErxKEeQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|PW0cytL/lrR9c9O26b/Ws/FDMU6om2VLG2Wm5TUPhyGX8Tl8y0S4uHBBEZLfwCq
 bee7qU7pI4igKbck7OVz+rg==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 32377546-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:25 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 13/14] selftest: fix headers in fclog.c
Date: Sat,  4 Jul 2026 18:41:47 +0200
Message-ID: <20260704164149.3480051-14-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 tools/testing/selftests/filesystems/fclog.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/filesystems/fclog.c b/tools/testing/selftests/filesystems/fclog.c
index 551c4a0f395a..593a5136e991 100644
--- a/tools/testing/selftests/filesystems/fclog.c
+++ b/tools/testing/selftests/filesystems/fclog.c
@@ -6,10 +6,8 @@
 
 #include <assert.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
 #include <unistd.h>
 #include <sys/mount.h>
 
-- 
2.55.0

