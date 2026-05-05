Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323883B38BD;
	Tue,  5 May 2026 05:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958772; cv=none; b=mbdZdSRoUkVWE0wSgcGu7Qex7TDCSW4w2B3cFT4ae5ohCyiEi3gfrqAdTN6RZ6qOWjon+NgDBB/FIRiPEMhQPEI/CtDtHLeQaMrenuJGo0k7BWnajyFVXiQGHS5FEIGsD9jNE8D74iWdSMy8HMbItKnpyU7fasc5PnNa5dLCVmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958772; c=relaxed/simple;
	bh=vOE2yGGTCzEPqa/GFJHQcMGWYA6H90O5GCmCTMJ8ft4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TA27+tgPGwpDgIJdEB0UuvkJLC7ddfFOgwOBPyebzxEsXaF4neFGxtRzvRO2YkUDIM7M8P1+16pDFTNtgNvd4WqYS1mRv4+FzdJQt/kFL3W9NKdBeZmiqStJcD3mUcg4Sd2O2oc8JLJzLRH8vf9jzepvAQvb42nKIf+l4pHxCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIG3roMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIG3roMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABD3C2BCB4;
	Tue,  5 May 2026 05:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958772;
	bh=vOE2yGGTCzEPqa/GFJHQcMGWYA6H90O5GCmCTMJ8ft4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PIG3roMJj5j7hABy/qZg2DSpdSccQHH4/PrpBC2j5SwfQaZBq3kVvzPaqSZD6KcJN
	 xekENwA8ptwihfMyQAA15lljSTDo4Gi2icah5fbG/f8hAfyVm4vhNO9rNNQ14s344i
	 8PlX0C5TfCntEeNkxl/w8Ny3Gd2wYmIDl7aPC+A8PXNGesw8NkuGbF98UV48mObMmj
	 7H8fGZMnZvcW7GHoDWT44VkzzPjuDM66XHx7Y10mGNNwnqur2zRFAQkHmNvz98tRwy
	 N/tofckpwTz7DJiuwHRZWltvWUmgOnxY5Z/EDlzamm7vPQZddELc2e2SDrbXBki0cj
	 ra7bDe3bu/lUQ==
Date: Mon, 04 May 2026 22:26:11 -0700
Subject: [PATCH 09/10] fuser_conf: fix cppcheck complaints
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853846.1133612.14217758851409292892.stgit@frogsfrogsfrogs>
In-Reply-To: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
References: <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Since I touched this file recently, let's fix the cppcheck complaints.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/fuser_conf.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)


diff --git a/util/fuser_conf.c b/util/fuser_conf.c
index 2ce149cee38dcb..8203b145cceaca 100644
--- a/util/fuser_conf.c
+++ b/util/fuser_conf.c
@@ -103,16 +103,15 @@ static int count_fuse_fs_ls_mnt(const char *progname)
 	#define MNT_ID_LEN 128
 
 	int fuse_count = 0;
-	int n_mounts = 0;
-	int ret = 0;
 	uint64_t mnt_ids[MNT_ID_LEN];
 	unsigned char smbuf[SMBUF_SIZE];
 	struct mnt_id_req req = {
 		.size = sizeof(struct mnt_id_req),
 	};
-	struct statmount *sm;
 
 	for (;;) {
+		int n_mounts;
+
 		req.mnt_id = LSMT_ROOT;
 
 		n_mounts = syscall(SYS_listmount, &req, &mnt_ids, MNT_ID_LEN, 0);
@@ -125,6 +124,8 @@ static int count_fuse_fs_ls_mnt(const char *progname)
 		}
 
 		for (int i = 0; i < n_mounts; i++) {
+			int ret;
+
 			req.mnt_id = mnt_ids[i];
 			req.param = STATMOUNT_FS_TYPE;
 			ret = syscall(SYS_statmount, &req, &smbuf, SMBUF_SIZE, 0);
@@ -137,7 +138,7 @@ static int count_fuse_fs_ls_mnt(const char *progname)
 				return -1;
 			}
 
-			sm = (struct statmount *)smbuf;
+			const struct statmount *sm = (struct statmount *)smbuf;
 			if (sm->mask & STATMOUNT_FS_TYPE &&
 			    strcmp(&sm->str[sm->fs_type], "fuse") == 0)
 				fuse_count++;

