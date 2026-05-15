Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FF3F58E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859326; cv=none; b=kKoDwmroxjJLNBi8125MLnddGWzIWAFP6GMwLHu/atbYtoxDnc76lyub/zrbh2u3+bLX8vUHS8XUVzV/2FWdw4ge3effr5F7x8zV2ZoRY5KMMvmy0n7zwIp12l3FkUIqKCELmkbs5y3Pk80Sk5MK+yf3uetLtwe47lgY7DBOYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859326; c=relaxed/simple;
	bh=7BL7yP9x0YdYMZNLjm/Of5rS3Th6M134GANRY160fP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTX69sClyildo6nojfw7CZlAL3jNmzNMNfnBpIfhtqp0waasiwS6/wiJcFzw2XSsJdObOXrlWim3yhZOdOJ3kkOqiOUT6Q2bn4rKTvVE4Jt9cpKUrXg1/5iDv/lsl7sYJWWOtpRcWcUL86nslpZeH8I9+SvDznsUqZ/7iKZzqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtuRUDg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtuRUDg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EBAC2BCF6;
	Fri, 15 May 2026 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859326;
	bh=7BL7yP9x0YdYMZNLjm/Of5rS3Th6M134GANRY160fP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtuRUDg8Lq7D8FG4rcOkfsZnpyEmisUiJgeeYq9hBZRwnNa2a+PqkH5K+1I8NQaeE
	 8O4NPPgNgnvwraBLHwXvUes1JYRw3bDIBR5boZ7P8pNFdIHBFnK3ttpNU13cbZdqgG
	 0nfLHk4ObEyQNU/7fKf+EHGQl+YyYvXQRPMOgfXJ1zYlY3WON0rzT+khVfmsiZP4zz
	 QxxOlKLd1SOSNoEgp3HEVAKPjgA4vHQo+WR5jM7GYYlpyaIGcIXtM/bEorCR/O1Ia1
	 2v6G3w+l2qo5SGsloGGVTMYxCLUxImp3o/2U/Ee88YSv3kRqayY84pVZ8Xc7wUbzX7
	 Lqo5ue4Qau4Pg==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 6/7] nfsd: Map -ESTALE from case probe to NFS3ERR_STALE
Date: Fri, 15 May 2026 11:35:14 -0400
Message-ID: <20260515153515.362266-7-cel@kernel.org>
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

The PATHCONF switch in nfsd3_proc_pathconf() recognizes -EOPNOTSUPP
(filesystem does not expose case state) and maps -EACCES / -EPERM to
nfserr_stale, but lets every other errno fall through to
nfserr_serverfault. -ESTALE escapes the same way even though RFC 1813
lists NFS3ERR_STALE as a permitted PATHCONF status, so a probe of an
NFS-backed re-export whose parent dentry has been invalidated returns
SERVERFAULT and tells the client the server is broken when the handle
itself simply went stale.

Add an explicit -ESTALE arm that maps to nfserr_stale.

Fixes: a8de9c3b40e4 ("nfsd: Report export case-folding via NFSv3 PATHCONF")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com?part=13
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 12b9172c6be1..aeda7a802bdf 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -745,6 +745,9 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
 			 */
 			resp->status = nfserr_stale;
 			break;
+		case -ESTALE:
+			resp->status = nfserr_stale;
+			break;
 		default:
 			resp->status = nfserr_serverfault;
 			break;
-- 
2.54.0

