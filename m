Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1143090E8;
	Sat,  1 Aug 2026 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785552666; cv=pass; b=Fs7vAYcC8yJc2nIZDoyGvMDcdNIlC1id8HldE47kBoOFpQ6135cbjH3nTgk1piOR7KwACD++lnZydhiq02yg1t2YoVdVbEQynmUIlKNRrVL4Gcg2kb396kH3bkmiAFpTiYuHG2QAeG1NLmLOyqhMD7yECwOM/E9hqqsRrL5avj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785552666; c=relaxed/simple;
	bh=r1M1FxcctBouXW6XAYoMWKhJvwjLnaF9nmZDUPN+xM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t04j1sLWTjveAISIvQbtxQoNBRc+fJcXl6iFmdOtbHL6ZrYaj31+qGuWlYpBDzHtRbQ0YhlakE/CkhPuvKnRczVbTFP4Ku39xsBkswARvgw/XrPcFcFrO0eoEC2mF5hWB9C4nVUkPrya6aMGmwzhsCKgwqhU0pR5aMmZT6bqonU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=nYI8R7Tv; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="nYI8R7Tv"
ARC-Seal: i=1; a=rsa-sha256; t=1785552642; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VzigXvUegvGCgFrsn8XOy6BKqGj//BMqiAMjF49tiplzIiv6GILvAfn+VcOF2UjVC4uGAPLAfEu+JIXao3RKRtq2wCfr97wGz2bVbTIE8xP6QMTJri3tCn97k4BzZC9HD6c2TKRXY/Y0Vr/ssCiRnlfNZQ2mmwVb/4SNwFDo/R4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785552642; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pFYzQoJ70F9cPhhLd/To/eTwGiRr4eeQhveIzBM8Oxs=; 
	b=eX6MAj0jsRjkrYqmWialPMveqVeosqVDVjTaAbmB71jv3fCayWB7ehlY1UgjTO0mvAVPsZyWZcAua6atfnBqY6IZHxg0kcSgzTyFg0R16bCYSlzAtaQTiMbmjnf+/2aS3oT80juI671XMezoLUnNo09iAR0uF0m7vdW2/kL8+l0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785552642;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pFYzQoJ70F9cPhhLd/To/eTwGiRr4eeQhveIzBM8Oxs=;
	b=nYI8R7Tv+LsnwROyYmaxEbXLQ/kBtkpLnIvwPUGf6O/wEe++Ap5DvMfsWZTFQmrF
	gi9Yg8+Vkbp/2OY0P9wMf7S27Mv9Gtp00XLZdSJZrZmHBDQ0f+NXBPXiLqQoHq64DKW
	awFGo1aOdaRAc4URZUsgJZd5TxUbxEI8xvVeF4t8=
Received: by mx.zoho.eu with SMTPS id 1785552640703434.37395696965416;
	Sat, 1 Aug 2026 04:50:40 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add myself as UFS filesystem maintainer
Date: Sat,  1 Aug 2026 05:50:15 +0300
Message-ID: <20260801025030.14178-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

fs/ufs has no MAINTAINERS entry. get_maintainer.pl returns only the open
lists, so patches for it have no clear reviewer and tend to sit
unanswered. The archives show the cost of this: a truncate path memory
leak fix was posted in 2018 with a stable tag and was never applied [1],
and recent mount path hardening patches went weeks without a maintainer
to review or apply them [2][3].

The code needs attention. It parses on-disk BSD and Solaris layouts with
very little validation, so several crafted-image mount crashes are still
open. I have been reading it and fixing real bugs in the normal paths as
well, including the 2018 leak above and an rmdir path that treated an
unreadable directory block as empty and could drop a non-empty directory
[4].

I am willing to take responsibility for fs/ufs: review incoming patches,
carry the pending fixes, and keep it building and correct. Add a
Maintained entry to reflect that.

Link: https://lore.kernel.org/all/20180705150415.25070-1-lhenriques@suse.com/ [1]
Link: https://lore.kernel.org/all/20260717104033.38574-1-david.lee@trailofbits.com/ [2]
Link: https://lore.kernel.org/all/20260701215700.822003-1-kudo3228@gmail.com/ [3]
Link: https://lore.kernel.org/all/20260801013942.279992-1-ali@iusegentoo.com/ [4]
Signed-off-by: Ali Ahmet Memis <ali@iusegentoo.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 62d53465e..8a1dc78f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27663,6 +27663,12 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-udraw-ps3.c
 
+UFS FILESYSTEM
+M:	Ali Ahmet Memis <ali@iusegentoo.com>
+L:	linux-fsdevel@vger.kernel.org
+S:	Maintained
+F:	fs/ufs/
+
 UHID USERSPACE HID IO DRIVER
 M:	David Rheinsberg <david@readahead.eu>
 L:	linux-input@vger.kernel.org
-- 
2.54.0

