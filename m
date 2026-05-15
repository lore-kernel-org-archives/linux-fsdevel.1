Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17B64ADDB8
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859325; cv=none; b=X9V/Q+AGpBfsol2s+IoYNw+yFcZZOXywFhPugyw7s41S9jKdg7iXqpjVBw3cAY9zuoeHVa+RM1tDrQy3sYy4KwmH5Kl/ZzrYKmMd9Lb3cnpbLipRqEaSGnQigcRkkGEcDxmkmQy65z/epQ5ECpsaVRiPU1wczWR6GvnZIy1O0fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859325; c=relaxed/simple;
	bh=B8595ymLk1AMk4M9BpbV8hbjE1Z1ca/9D7msACBHve4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CT7ySXwM1hPd4EXmFhDe6tyYL70uasltG6ZzIBasPJBC8709ryUBYxg0qSRIKzGmvuA92WkIprTkuALdzibWKJOiXNL+bs4wgmKTASYhkv7Y/2nMPhevyDN/UpoKS4f7CNJBu1Hr8aKkmzveQfLsGypsq6zsjNeOhcELwlB148s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg2p6XKr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg2p6XKr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E4AC2BCC7;
	Fri, 15 May 2026 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859324;
	bh=B8595ymLk1AMk4M9BpbV8hbjE1Z1ca/9D7msACBHve4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wg2p6XKrZ+eOlQI/hS5Lyx5yI435mJTIGz0HtN0XnizEgBL66ajJ4OjokaECKr35p
	 13Wy2Yja3VUtwMlEzBxayE/SQH6SH89gZqPLoK9DfATG67PiSJE2q3aVCbQKGw5azD
	 nADMHM0MHPWvwvWKXsTcgCV6E1izUuRC8WMRXywen7QlW9biAAz29Rhq/RV4WyXfRt
	 Kw4RZ7o19aexKUi57DmpOSOa3De+HwppESaL10S1KLzhyvoHlPJT+gFj9U5RhEheNR
	 LNco/jfxuRsKVKuivL7cGyIi5LiE9I7KvJcrrcZDhP/iug2QRwncP8v+CB2ra+s21Y
	 DJEeK/DaMF94A==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 2/7] nfs: Avoid transient zeroed case capability bits during probe
Date: Fri, 15 May 2026 11:35:10 -0400
Message-ID: <20260515153515.362266-3-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515153515.362266-1-cel@kernel.org>
References: <20260515153515.362266-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

nfs_probe_fsinfo() clears NFS_CAP_CASE_INSENSITIVE and
NFS_CAP_CASE_NONPRESERVING ahead of the synchronous pathconf RPC and
sets them again only after the reply arrives. The code path is gated
by clp->rpc_ops->version < 4 and is therefore reached on NFSv2/v3
remount via nfs_reconfigure(), which calls nfs_probe_server() against
a live mount. Concurrent readers walking server->caps can observe the
cleared state for the duration of the round-trip and report the wrong
case-sensitivity attributes.

Compute the post-probe capability mask on the stack and assign it to
server->caps in a single store so readers see either the stale value
or the freshly computed one, never an intermediate zero. Preserve the
original behaviour of dropping the bits when the pathconf RPC itself
fails.

The analogous transient zero on the NFSv4 path lives in
nfs4_server_capabilities() and is left for a separate fix.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com?part=10
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/client.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3db2f18315b8..28b66bb0dd33 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -937,20 +937,23 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 	pathinfo.fattr = fattr;
 	nfs_fattr_init(fattr);
 
-	/* Clear before probing so a failed RPC does not retain stale bits. */
-	if (clp->rpc_ops->version < 4)
-		server->caps &= ~(NFS_CAP_CASE_INSENSITIVE |
-				  NFS_CAP_CASE_NONPRESERVING);
-
 	if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0) {
 		if (server->namelen == 0)
 			server->namelen = pathinfo.max_namelen;
 		if (clp->rpc_ops->version < 4) {
+			unsigned int caps = server->caps;
+
+			caps &= ~(NFS_CAP_CASE_INSENSITIVE |
+				  NFS_CAP_CASE_NONPRESERVING);
 			if (pathinfo.case_insensitive)
-				server->caps |= NFS_CAP_CASE_INSENSITIVE;
+				caps |= NFS_CAP_CASE_INSENSITIVE;
 			if (!pathinfo.case_preserving)
-				server->caps |= NFS_CAP_CASE_NONPRESERVING;
+				caps |= NFS_CAP_CASE_NONPRESERVING;
+			server->caps = caps;
 		}
+	} else if (clp->rpc_ops->version < 4) {
+		server->caps &= ~(NFS_CAP_CASE_INSENSITIVE |
+				  NFS_CAP_CASE_NONPRESERVING);
 	}
 
 	if (clp->rpc_ops->discover_trunking != NULL &&
-- 
2.54.0

