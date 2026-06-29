Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E504D3E5EF9
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747360; cv=none; b=iP2G+r6o1My02nzpG/Vuj93JbUQbaZvamiOFSJt8yKR2ZBb/G21tcjJEjNrY4Lvhc871FuM/WDaYJ2b1/NXliAWZesaJAful+8K5gPNCbceub8FOxDaswrx2q3lXKBgspu4HMhNZnBtHQ83RPQeHdw2kBj8sw2Z0iw43byZ9sew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747360; c=relaxed/simple;
	bh=Uxp9b8jKRD7Fly/xsL2xDwSMD+3PLPaiGNrvIuy1p1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3dRRB/jjObvUBENeczGIlKe0744YcKhx6hbBrpQ/qAED0r1mGGgYmLh9KEfc3QSd5xQCIGYz737V1o/QE3uwOtfC20EuhSMM2EQaWYNgGZQnBN7HCpe0PHvQ1WFqafGbo/PX+y2HYyl1sp7ksXb7ThdZsh4rbuLjZZDZt9MPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=kYj73EiM; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="kYj73EiM"
X-KPN-MessageId: 35dea42b-73d0-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 35dea42b-73d0-11f1-9e8e-005056999439;
	Mon, 29 Jun 2026 17:35:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=rtoKh6iimjuUGy6Qb6m04bH/VFAPE95rEZTFeuyZ2tE=;
	b=kYj73EiMbyOXpvjxpVPk5DFGquUwgsfRJibYkTwGTgA/yd9CpciWD3uinejiX/BK9J6nGIyVwMY/u
	 VYaWVppLmkEpwhQ1HiHR0fN036noevakMEGwDeywONR8tZ3D15as3s5jVYrSB8mDhEMjZ7NkkPD85f
	 up4KgJaw1b6KMvDQYpUao40oVczptWwUSqVv+ITlVpSvXbcz4Ry/fAy5Sr1mJlYxV0VeXeuqh5O+ZN
	 A8afi4A0q/kSyn/1OlkBY+u2PjiTb1w/LLsQGK4X9V8LuETGudIfDaVkAnltJzqFdb3P+MdbaJ0tLO
	 tWgXD9GAqXrrFmziGvQaTHoEpX9qy1g==
X-KPN-MID: 33|H/miYfFlJWQfvQjbhG/168PEohNvud01L52jqVoDAvvgehfPUk1VuiEx48lfEZ3
 tlfTUd4gdlHL/k8OPJsU5ZyTRAZjF+ljM40veSkVn1tU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|stVjIORKY4H/fd+XNDfSYjup1WHjjNP99ZzptUumpxHZ6sQaAKodQUMMnO5W2cB
 VtGAH/KY21BjDn7Dg/sgjqw==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 35a375b8-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:51 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 13/14] selftest: fix headers in fclog.c
Date: Mon, 29 Jun 2026 17:36:29 +0200
Message-ID: <20260629153630.2158649-14-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
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
2.54.0

