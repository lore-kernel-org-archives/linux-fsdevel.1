Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3572D1913
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780497638; cv=none; b=GkKQ5HHsOydTCF2zfjOTIPq+UFtrc82C02gGCQv3JUMICqbTVpgskQqjzw2Qb4CaHgozETn9mjiDgLuzWVjkbhUvxDmnxTzH/08Ip3tnKinKwOhoXeXJ32N8Cektdh5nA+qnQSeA9n61AxF1JSIETe5H1BE+7Dj+e6dd8Sa0tk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780497638; c=relaxed/simple;
	bh=Cg9EsCocIkPUR/KkhAx+uRYcS4+DT0uSk1eL+oPe+18=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fKJ3DD/rfUToduQwtso/WqpSCBtIpC/3ofFpDWETG33iCkiD2EXCROLBzWMlDOuGyWLC4mdtZwTYiKNskanNJHnsApCOss/lSQs/vsNb5dnvV/DS3tMtIQ9olMUd0i/MjKi7dfHMkBV7Xa7BIHi0VN13jgDG98inb957BqWTHh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg5/YF7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg5/YF7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C7E1F00893;
	Wed,  3 Jun 2026 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780497636;
	bh=Lqb3GWwjJVzJEki6+tZd/cfnOcGoA3PXRaPg26wwNT4=;
	h=From:To:Cc:Subject:Date;
	b=gg5/YF7hW/Nmj0roKBBRmeuI4zQxf1s+DsaWus1rSUYceyio34ZBRHcaa1JAYUMII
	 1wgazb4o7iXrQN0XPirk+5I+jzgRm2qE8GTnYTuh8gSoVsBQv4UK1yFDqodVSVXIlE
	 sgipo2PtrEUIMI3qiegBA8ZlzuBspR0Ssao360NdQJyz5WWxSWOgWwIWZi5aV44cZ4
	 r2Zq2779Shp2jTzsFYwHDbmZYQAosZe83ZeHTByL50LvqULGGRFLJj4g+xx0RC/uUf
	 43+xRYT1yRESghTbJ4ewugoTqYkl7HvteVmfSXolXYKgH/Q3j/sBKynZa3tYby8ogY
	 saACZo4mG32vw==
From: Namjae Jeon <linkinjeon@kernel.org>
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] iomap: Add IOMAP_F_ZERO_TAIL flag to trace event strings
Date: Wed,  3 Jun 2026 23:40:31 +0900
Message-Id: <20260603144031.7370-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add IOMAP_F_ZERO_TAIL to the flag string mapping in iomap trace
events. This allows the new flag to be properly displayed in
ftrace output when iomap operations use it.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/iomap/trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 097773c6db80..93b3fa12de17 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -118,7 +118,8 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
 	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
 	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
 	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
-	{ IOMAP_F_STALE,	"STALE" }
+	{ IOMAP_F_STALE,	"STALE" }, \
+	{ IOMAP_F_ZERO_TAIL,	"ZERO TAIL" }
 
 
 #define IOMAP_DIO_STRINGS \
-- 
2.34.1

