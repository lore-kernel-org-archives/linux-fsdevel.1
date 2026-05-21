Received: from e3i421.smtp2go.com (e3i421.smtp2go.com [158.120.85.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3237DE91
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.85.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357777; cv=none; b=eM+dGJP/7DBtIvGBDvMUXP8eLjDqj+k3Vt/R5YwmgVEm4kN99h22H/Rn/q7WoSw/f37VwH3TvdoGgieUCvRuua/mniZMEDk/pO2umzfI8/TT+xc2rx/K17BaXB+go1kU8GqKJ5wc/GCSE0w0h85JOY6vLimi7/AXxIDygic7rAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357777; c=relaxed/simple;
	bh=vodvvcswZRlbDFXfFUiY4r5AdgWfA3xto6hrwuObiOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Miv4sovhLZ0IjCeqP7CcDalRMA7Cu7Q34hkID9FEppBPB9y+XbBrM5rqhXTVagClrWmz3HsGDwwvTYwK0Ub8vjtTElaXHgn7z+NEiXuPL57aIbw2PZf/ht/nmFwcuAKXvI/YasYsge0aR0VOfj51p8ZdHG/Dg/QXeaV1sWLzjfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=LjrZXx5l; arc=none smtp.client-ip=158.120.85.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="LjrZXx5l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1779357773; h=from : subject
 : to : message-id : date;
 bh=uCNwpibAseSDNQ68UeAV3DI4drw37VIBam9jpljEa7M=;
 b=LjrZXx5lkmNN3sOWXPB0eIFhKCWGCIDZeHAIRoWEdNV0Gx75P04H+oMh06zBbjCC6ISD+
 TcVq5tn1eLQnjvQO7X2YKRzOMm4vBlCYb3qNzBUFxwBaW3rn7c7f7pKswz8QGsZ9BZM5hxF
 JaeL+EBc2nyivdLAd1GeXcJgThsYpBnSC7MAsDQTloq047g0oRP5Tdr2RC3OADpoa5znmza
 ECV32+VsLl0YZPK7Yq9EtpCujs4lncfjqxQ3j0EYpNsnZO713Caje67nMnG+4gCWr9+97uG
 9LJKTxViG79iPdCODi5QplAUjJEi04dqhR5nNpYxXbn5xg5YG0A7c72l/WRw==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.2-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1wQ0Eq-FnQW0hPzify-nxIq;
	Thu, 21 May 2026 10:02:49 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v7 3/4] 9p: Set default negative dentry retention time for cache=loose
Date: Thu, 21 May 2026 11:40:31 +0200
Message-ID: <b5beca3e70890ab8a4f0b9e99bd69cb97f5cb9eb.1779355927.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1779355927.git.repk@triplefau.lt>
References: <cover.1779355927.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616skA0ZlBRBB
X-smtpcorp-track: s4VrkuW9RdxJ.lhfJS_YkskF7.NWABjw6A9Qs

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

