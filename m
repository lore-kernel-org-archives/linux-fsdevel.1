Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50443BF66F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314929; cv=none; b=R17OM3QmsTEIC5dLwbhVazqKs5YgXGoGxm4Tf/QA9JOuGUgScauKdgvN8omppJboUbPlSDnV6qRU1THjDbaIFthFL61OW3UM2TxQKxnNAddbaFs8sWFDq7ELnjB5n/ZzBYuEGmH/AerCNnXUXVuYGkap00ZB30un5NbNjWXruT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314929; c=relaxed/simple;
	bh=lt/r6MXMYH8YpKX4OoRYvXc/lVnY6s/EQRrqUdvsvwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2hhISboGT+DbVOdB3dRMioc1GZaOe3Uh7PhJ78O78xrz8Tdb8Nf+MMWv1dAziFo6MluTWoFWI9Dk5+IfCxjaQq1Wutlt+ctXIJrvdux03pi/6e+Gzc+wwibZB2z9v3JgyZjcKJUEj40wP52GbZrZOEgXR3nACSh15dJFKDz2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=E2xuALVe; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="E2xuALVe"
X-KPN-MessageId: 9d2c3698-1e06-11f1-8a98-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9d2c3698-1e06-11f1-8a98-005056ab378f;
	Thu, 12 Mar 2026 12:28:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jvAYsc0JVs7m61kxcR/1TCveuyrIzgf82MvZGPDbG0Q=;
	b=E2xuALVe2JNvPFzVIkq7Ks1HdIydNAQguc2K6cLWwJ/MCDOnBYObtlQ1TiIB9o61u6nnskiNF104z
	 2Iw4BC52Z3I+N79XyE1NgbizO+xbOzbpXsmonwV1/nFIiXJwx3YLw043E27F5SFt7y5SLkC63oQrGG
	 ZTNew29tLDkQmU7xsWvAB/RR3thEgVgJuPgse4Qn7mS9olIKgZU9Wbpjo3B816EvxrJlDdu2ROAeWj
	 95T0oo/hq2CKxrd55uDK/gwJ2z2+jtYicX7HzfdJ3Rfqwp6PVaA7i3oWSB1+bgn7OiVJYa46GLV/aB
	 kCDaVCEqfhy7q5WLqklIVOBiyQvhrMg==
X-KPN-MID: 33|FxskGi+cEslV8S/DYtiQcOokUd9wG6pmCQeL+eqTFJI7JNeYJD8t3ydxBKAAoLO
 S+g2dn67uIa2Yzmk3GGzzY/N096p2JKqbUSlwc5/21kY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vuoznjx7yA8EWZFRnF5Y7krNJ9U2C/pPzAVBg3irXDFR8PbMej00tu7Yj5RI0ou
 VmcNYnUvzlwaFc6gxK0t8BA==
Received: from lt-jori.home (unknown [178.226.144.191])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 99a16004-1e06-11f1-a6cb-005056abf0db;
	Thu, 12 Mar 2026 12:28:37 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] vfs: fix docstring of hash_name()
Date: Thu, 12 Mar 2026 12:28:22 +0100
Message-ID: <20260312112823.2801-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The docstring of hash_name() is falsely reporting that it returns the
component length, whereas it returns a pointer to the terminating '/'
or NUL character in the pathname being resolved.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 58f715f7657e..d020b077591b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2437,8 +2437,13 @@ u64 hashlen_string(const void *salt, const char *name)
 EXPORT_SYMBOL(hashlen_string);
 
 /*
- * Calculate the length and hash of the path component, and
- * return the length as the result.
+ * hash_name - Calculate the length and hash of the path component
+ * @nd: the path resolution state
+ * @name: the pathname to read the component from
+ * @lastword: if the component fits in a single word, the component bytes,
+ * otherwise 0
+ *
+ * Returns: a pointer to the terminating '/' or NUL character in @name.
  */
 static inline const char *hash_name(struct nameidata *nd,
 				    const char *name,
-- 
2.53.0

