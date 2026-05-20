Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB21C3233E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304454; cv=none; b=F76IgNq8zPYonyJ8shXc9HTv8MzVWdA2EJS2r0KBIpNAbgcdZrO3Glf+sAchDim+1b2uHVP6e0V54PVFxQMDA/s1lzFR/s1aNm5pqC4s4U1PWqthlWN7L6PQCCKsk2ibBKiNqAj1ih3NSjQDJopT4gVwH53qs2q5QVplJVM99ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304454; c=relaxed/simple;
	bh=vodvvcswZRlbDFXfFUiY4r5AdgWfA3xto6hrwuObiOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BjWgU0j21aSQ4m6a3Um/ABiCTr8a0rvrYOijW+PxG/x3V+nO8MbmeH6wbxMnlQN1nK/cT7UhpwS1yTsryMubdKAk3dn2w14puaOSNSC07vjwutaPQsn6nuciYQzasdvl0DspMKB1XgYvYhRaT2JhLZ2Qn1H9Lqgwgw9SFGRQrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=bZh2tdYs; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="bZh2tdYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779303833; h=from : subject
 : to : message-id : date;
 bh=uCNwpibAseSDNQ68UeAV3DI4drw37VIBam9jpljEa7M=;
 b=bZh2tdYsK0yVirKcpKf24rw2mhrLtiHT8PTbpFYOThjn2ftkSwqwoo/GlC4NlkqF6KQ+E
 LuuP6sEGuzoID8uNY0ie01CYC+nLUoSVh44yFPuKlcuVSpxRpdhcCxxMsxpTQe0tN7xbIrb
 VVeCGOmWUObZq0WiQHQpQWSHw4lH0EJVNGFKPrR7X6sSLe49THD0kUZRatV/K3e5LlzzJYr
 40bdUM7/siSGee8eu6Q1sNQbpWulr7su7QTGPbSE5o1Oydc4bdgzdzriH9xVi/Aaa8MQdIe
 zFF+h4LrXuIy3r29WO7ldPd2cNh6GPSfby8288/gt41mCEtPn7/QcYXeM01Q==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2)
	(envelope-from <repk@triplefau.lt>)
	id 1wPmCw-AIkwcC8nAYK-KwqD;
	Wed, 20 May 2026 19:03:55 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v6 3/4] 9p: Set default negative dentry retention time for cache=loose
Date: Wed, 20 May 2026 20:41:39 +0200
Message-ID: <ca093dce1237b902fc8968672c16ecb952147192.1779302002.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779302002.git.repk@triplefau.lt>
References: <cover.1779302002.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616sfrOXB0SBC
X-smtpcorp-track: mSLkfTPyWcG3.yay5_axXdy9j.DcceYQdF9cF

For cache=loose mounts, set the default negative dentry cache retention
time to 24 hours.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/v9fs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 3e758b66fefa..274c5157135d 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -24,6 +24,9 @@
 #include "v9fs_vfs.h"
 #include "cache.h"
 
+/* cache=loose default negative dentry retention time is 24hours */
+#define CACHE_LOOSE_NDENTRY_TIMEOUT_DEFAULT (24 * 60 * 60 * 1000)
+
 static DEFINE_SPINLOCK(v9fs_sessionlist_lock);
 static LIST_HEAD(v9fs_sessionlist);
 struct kmem_cache *v9fs_inode_cache;
@@ -441,6 +444,13 @@ static void v9fs_apply_options(struct v9fs_session_info *v9ses,
 	v9ses->uid = ctx->session_opts.uid;
 	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
 	v9ses->ndentry_timeout_ms = ctx->session_opts.ndentry_timeout_ms;
+
+	/* If negative dentry timeout has not been overridden set default for
+	 * cache=loose
+	 */
+	if (!(v9ses->flags & V9FS_NDENTRY_TIMEOUT_SET) &&
+	    (v9ses->cache & CACHE_LOOSE))
+		v9ses->ndentry_timeout_ms = CACHE_LOOSE_NDENTRY_TIMEOUT_DEFAULT;
 }
 
 /**
-- 
2.52.0

