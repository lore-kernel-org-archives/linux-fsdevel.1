Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF34DB548
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859325; cv=none; b=sgzijdHT7HkSl/lyfI4nCVYcxpur0MaG90u/g0xW8iJzA9IK4ClEqFFN6UFVu0uEDHtyB0XZxZEL+4AUlavdLv1k1iw9VFHvWYKO8LSmg4V/HXG4qWXYk6fXDdnrZ7/dwCcCsJKa0WG0h2+yh6QuaiDoTZRP4jBSvA+bBKhXstE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859325; c=relaxed/simple;
	bh=N/amKIVni9VFeA81TTBCpWIsgVR5SHQInopSHzHjY0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fo8aGtZmygHphfDMrPb9QfCXCmfd0sGZbc7SrD7hdecK1r0rvtL26cbeczHkZWsz2x2pBCIYvSY5wcenuZL1bu6fpVvbb2gCxTDJF+U+qEDFpY2tmHSkolqRwQ57g/XV6YScE801O1FlwMemgQgyd9tM8x2T+xaN5U9ea52B1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxBqArFF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxBqArFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5F7C2BCC9;
	Fri, 15 May 2026 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859324;
	bh=N/amKIVni9VFeA81TTBCpWIsgVR5SHQInopSHzHjY0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mxBqArFFH5Vld7ooBv1aUkEn8GhEXwAL6kmQYLsKIli89cRu7Qsis7vKwJYoAgo7P
	 g0KWbnsHOwSRshhsj6xP1ZxGEP8FRzDbWnRb6RpaVA3DrshLTk4GvfJX1p2nWM2Nac
	 2FNO0Sv+SZMjEAkG5gS4MtZARf9aimg2Y/lstvZaiHi6zTfLh37Gs+tDxYJcidlzbR
	 gp8rI8pKvnL52U7f6BbeOgkYw4VebEog2hJOB6dqiD80AnPwfrWsU1F1D9cMJAjRuo
	 VTpY3YgXHtjNZhC/gzLGV8F+YXzBUT6Ql/WRinz01tjzOQO1Nf0lSnkFQa0UfO8ZWz
	 ECXuCA5GN/pIQ==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 3/7] nfs: Skip pathconf probe when neither field is consumed
Date: Fri, 15 May 2026 11:35:11 -0400
Message-ID: <20260515153515.362266-4-cel@kernel.org>
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

The PATHCONF RPC issued from nfs_probe_fsinfo() supplies two pieces of
information: max_namelen, used only when server->namelen has not been
pinned by mount options, and the case_insensitive / case_preserving
fields, used only by the NFSv2/NFSv3 path. NFSv4 receives its case
sensitivity caps from the FATTR4_CASE_* attributes during the
set_capabilities probe, and a non-zero server->namelen short-circuits
the only other field of interest.

When both conditions hold (NFSv4 with namelen pinned), the pathconf
reply is discarded in full but the round-trip is still on the mount
critical path. Gate the call on version < 4 || namelen == 0 so that
mounts which cannot benefit from the reply do not pay for it.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com?part=10
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/client.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 28b66bb0dd33..73b95318ba48 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -937,23 +937,25 @@ static int nfs_probe_fsinfo(struct nfs_server *server, struct nfs_fh *mntfh, str
 	pathinfo.fattr = fattr;
 	nfs_fattr_init(fattr);
 
-	if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0) {
-		if (server->namelen == 0)
-			server->namelen = pathinfo.max_namelen;
-		if (clp->rpc_ops->version < 4) {
-			unsigned int caps = server->caps;
+	if (clp->rpc_ops->version < 4 || server->namelen == 0) {
+		if (clp->rpc_ops->pathconf(server, mntfh, &pathinfo) >= 0) {
+			if (server->namelen == 0)
+				server->namelen = pathinfo.max_namelen;
+			if (clp->rpc_ops->version < 4) {
+				unsigned int caps = server->caps;
 
-			caps &= ~(NFS_CAP_CASE_INSENSITIVE |
-				  NFS_CAP_CASE_NONPRESERVING);
-			if (pathinfo.case_insensitive)
-				caps |= NFS_CAP_CASE_INSENSITIVE;
-			if (!pathinfo.case_preserving)
-				caps |= NFS_CAP_CASE_NONPRESERVING;
-			server->caps = caps;
+				caps &= ~(NFS_CAP_CASE_INSENSITIVE |
+					  NFS_CAP_CASE_NONPRESERVING);
+				if (pathinfo.case_insensitive)
+					caps |= NFS_CAP_CASE_INSENSITIVE;
+				if (!pathinfo.case_preserving)
+					caps |= NFS_CAP_CASE_NONPRESERVING;
+				server->caps = caps;
+			}
+		} else if (clp->rpc_ops->version < 4) {
+			server->caps &= ~(NFS_CAP_CASE_INSENSITIVE |
+					  NFS_CAP_CASE_NONPRESERVING);
 		}
-	} else if (clp->rpc_ops->version < 4) {
-		server->caps &= ~(NFS_CAP_CASE_INSENSITIVE |
-				  NFS_CAP_CASE_NONPRESERVING);
 	}
 
 	if (clp->rpc_ops->discover_trunking != NULL &&
-- 
2.54.0

