Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8035CB71
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866421; cv=none; b=gzeoqpczLGr3IswQzoRTpqtmQJBLdg2mKdZdRBgqZ9LLqYrocLvh2ET5I+XiAv/38Bf212t6m1gdcA7VQHbdghycR6jldT1QHW9CC+v37s9FytF9gKcvWegm1cJ6wQ3iVMvR4QopWCAP7p+Ddj+fqVO6a4QyxmR35DicSNCbUpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866421; c=relaxed/simple;
	bh=ZoyxDuefzezxaK3G4IXbJtZDtmV6o3pfuMp/iOUdYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nfjvv/QtWW5a1Pgjef4i+eGpdsONDYYToh16ia1wGtTNv21K8SNuS0G3LfQJCs7x+l6xKjRjUfHqudr4+gHtQ2TF/8Heaeh9m3QLgH3QMA7oZN5+YY+fOEa3Cd5UKoYAt8wlrdcnl6BerOOuIk3zc7Qd6OcwgpLQcmG6VanFPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Cd+vJQ5/; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Cd+vJQ5/"
X-KPN-MessageId: a88e6a48-230a-11f1-92a5-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a88e6a48-230a-11f1-92a5-005056aba152;
	Wed, 18 Mar 2026 21:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=gP8BHBsdn4bo/pAT4CFnj8XGHEo7gaOw5PSw3Qn03pk=;
	b=Cd+vJQ5/cVAlU1Ygmi4AWuO48byN8gHUYxDwoZy24c2etX8y5kMgdJY/61RxVOSX0W4cYYBoq48fx
	 yqNJqaQQlbap2aPDI/S6rA+fC2N/Ue5OQ8tHupfXj+QSX1xLpY4fxi9Y+Xds0HoCEGVKfjr8Xhy0HX
	 tBZvvYam/08zDygo4Y+3atagtdnb/7vY2Ft2uC5sMbW0DufFv56Td3sxuFRtz7ir1ZGMOAMSLqferY
	 vQn3bq7vnhuZwzviFJF07OgLI5LUpHhRhupJadMu7o7b2pOhUVkNT8SwheTO+4pfukUUISV/FB0ttl
	 phHxZ6NFlRofptTIpfpbpaeJ0T+lgAA==
X-KPN-MID: 33|Fg4EMN8y+0G9465CiScujpR/J0WlA+Z93ejc1BtaWJiOHdgupf+BcrMHiddEB4N
 +NA3xFGUMT4KcB/VPCTFFtKzCY+SV1PbOngkLce8e0xA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|w3fVWSIoW53pLPYaXkZjRggGyWaFSApBqwEq1wosusO8WyAeR4if3GTbxcewd1S
 xjPeu8sbB9SUVCQj52pQ2ig==
Received: from lt-jori.home (unknown [178.226.144.191])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a3dcd05d-230a-11f1-a6cb-005056abf0db;
	Wed, 18 Mar 2026 21:40:10 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] vfs: fix docstring of hash_name()
Date: Wed, 18 Mar 2026 21:39:52 +0100
Message-ID: <20260318203953.5770-1-jkoolstra@xs4all.nl>
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
 fs/namei.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 58f715f7657e..9e5500dad14f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2437,8 +2437,14 @@ u64 hashlen_string(const void *salt, const char *name)
 EXPORT_SYMBOL(hashlen_string);
 
 /*
- * Calculate the length and hash of the path component, and
- * return the length as the result.
+ * hash_name - Calculate the length and hash of the path component
+ * @nd: the path resolution state
+ * @name: the pathname to read the component from
+ * @lastword: if the component fits in a single word, LAST_WORD_IS_DOT,
+ * LAST_WORD_IS_DOTDOT, or some other value depending on whether the
+ * component is '.', '..', or something else. Otherwise, @lastword is 0.
+ *
+ * Returns: a pointer to the terminating '/' or NUL character in @name.
  */
 static inline const char *hash_name(struct nameidata *nd,
 				    const char *name,
-- 
2.53.0

