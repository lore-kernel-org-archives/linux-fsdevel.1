Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B63C76AF;
	Mon,  1 Jun 2026 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322269; cv=none; b=K2mO8WRnqqlovH/rvPLs5yIftiKMpq4nWJrStB12O8cYwC+rLdrRb9n3IReUvyQAMHPLVsBW66ky6pO7dt00S0k4VHX5WoczInlbpHnYTpUGsmnIfiyFrHD6pQ7TXnF68g1wVNpKpO9f8H71YkuiO1uzzShbE4AMPCh8BnPrqSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322269; c=relaxed/simple;
	bh=sn8qllQ/wpBPV+ePlA052oUxAgDJSLN+73Nwsjn+gKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NtOQUuWrxu33BLtoNqTaXE9cCPgR4wTIQDPCyUL9/VYBDfl2ihtxGi82Lp+nKhFzcJb3T05iEOMG3hnf/DIlA/EEQOOOxVDEoFv6HbedENayxOF2a+zgPXZ7PYt/ziLXKCAw2nmw//XkahRBnYgbHF0MyNhS0UwtiUhsq5fVTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAO8KSrO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAO8KSrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2841F00893;
	Mon,  1 Jun 2026 13:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322268;
	bh=sSGh8eNmcUD2krYJq0u8p/Vp1I9djexDviu6/d8OQPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HAO8KSrOroOAFcf1eVVsSlipnqrxT2P0MdLc8k6BIjnFf8DZyZkPRyN+zhqgkZW95
	 XrC3vO/LHgbX9FGBLS+meQyBRXMDLJtT9d4hPqnPnF8VwsaUT/D78WNTzA9klUypHw
	 d9y4lFH+R5PMtQa6fa+BSDV1mvUKz12jMAqC2juMWzpFUYnGACwp/h4vYdfIUelFkg
	 D7Yr+99gvrQMZjFnG8fBJYgOR/ToUgLBU5px+fH+K0klt8Wh/fYOm39cKKb3j78RIH
	 DhhYCJcj9ippmqPfBxFEDKMFMXQe8nEGsdHvQwmPWpaCVLYHehnLKG4jSHhTM/bGWc
	 jZnS2mRQObqSw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:57 +0200
Subject: [PATCH RFC v4 24/25] fs: stop rewriting kthread fs structs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-24-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=683; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sn8qllQ/wpBPV+ePlA052oUxAgDJSLN+73Nwsjn+gKE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i9nW9d18yTv1HDtvUXb5FIv3CnafDrRyVmMoSPNT
 5z/6B35jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInYxjL803W3XvI4ouQtT36G
 KvfbeYtmrxBe2iGflfD4X+Tl9a1uFowM1x+arRP8aW2m8vrbAoNyiQf7Ga6+rmUL4mp15wnU4tn
 NDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we isolated kthreads filesystem state completely from userspace
stop rewriting their state.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_struct.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index f44e43ce6d93..2a98cfbedd32 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -61,6 +61,10 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
+		/* leave kthreads alone */
+		if (p->flags & PF_KTHREAD)
+			continue;
+
 		task_lock(p);
 		fs = p->real_fs;
 		if (fs) {

-- 
2.47.3

