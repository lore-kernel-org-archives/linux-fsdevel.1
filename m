Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140C42E9733
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574844; cv=none; b=NhrRqYVvQoyEma5MuXKRNZGcI7ExJX9UqjAsT+x0KciOm35Ls15DcZWfOWWSDh3vp8ZxKgqa8h2Yv7LVE2y408WdU7BPSpY9bBNglr8B1nlOWRguUkcRxYUjXMfqzf2bbQi67gFKw4/fJM8HXOgcS8j39gQaVaKWgRXn0HUUFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574844; c=relaxed/simple;
	bh=DaJGZCL0JxRXONy2bs3aA818gEDojuJKr/o9IsHcdSw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecE3lefTEbxMPQ+ogjLxixt0VnKe/C3YHRROUz44fb3Aw9KHIxdPona83kIrX3dMKXA46+PvYEgFgYTMzNMLA8i6JOI8qcCcKzh1RQl96WQNj4u8zm7kYGkU4RRxEJxw6tAIQVsfBunyCYNyeN8xpTBpF7IM/OwSV0/Xk4mRLnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN9AfpQP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN9AfpQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7688AC116C6;
	Fri, 27 Mar 2026 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574843;
	bh=DaJGZCL0JxRXONy2bs3aA818gEDojuJKr/o9IsHcdSw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DN9AfpQP0U9aEnNNaokxsA53IRwUp8xzdpw1oY8h0gu+ljg6BeBu/ixscbq/MlgmA
	 ESG8ZffnoMzJ8X1Sz2AANzzOpIgip4V05RbKgaI2dIodqlJxkG3i1gL9/AZYBXUf0p
	 gHmuF4EDZCuIhdcew8eruz5An9BP6Nq2hYdAAsRWs3Bw+xiWKwhQfdKSSpV7V0T4f2
	 EgIncf5F7o7y5oCGBagEZRSshbbkooO859Ks/e9HjSjz1scoSSx5/a9UaX+Itz5mnY
	 A2nYc9n+CeoZYyUpR1kqMrzQjtJ/2fDLv+62c8nTbj7pTjQ4+Z28gT9GYVZr9NKpaC
	 jgl4I8hI1KOSw==
Date: Thu, 26 Mar 2026 18:27:22 -0700
Subject: [PATCH 10/17] util: fix more checkpatch complaints in fuser_conf.[ch]
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, miklos@szeredi.hu,
 neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <177457463297.1008428.11950635302999951775.stgit@frogsfrogsfrogs>
In-Reply-To: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
References: <177457463048.1008428.11432672970504238251.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Fix the checkpatch complaints because we touched more code.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 util/fuser_conf.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)


diff --git a/util/fuser_conf.c b/util/fuser_conf.c
index 7d239a48671b5b..e4ad31f26951f8 100644
--- a/util/fuser_conf.c
+++ b/util/fuser_conf.c
@@ -298,6 +298,8 @@ int check_nonroot_dir_access(const char *progname, const char *origmnt,
 	return 0;
 }
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
 {
 	size_t i;
@@ -307,13 +309,15 @@ int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
 	 * able to just put anything we want there.
 	 * Luckily, without allow_other, we can't get other users to actually
 	 * use any fake information we try to put there anyway.
-	 * Use a whitelist to be safe. */
+	 * Use a whitelist to be safe.
+	 */
 
 	/* Define permitted filesystems for the mount target. This was
 	 * originally the same list as used by the ecryptfs mount helper
 	 * (https://bazaar.launchpad.net/~ecryptfs/ecryptfs/trunk/view/head:/src/utils/mount.ecryptfs_private.c#L225)
 	 * but got expanded as we found more filesystems that needed to be
-	 * overlaid. */
+	 * overlaid.
+	 */
 	typeof(fs_buf->f_type) f_type_whitelist[] = {
 		0x61756673 /* AUFS_SUPER_MAGIC */,
 		0x00000187 /* AUTOFS_SUPER_MAGIC */,
@@ -354,7 +358,7 @@ int check_nonroot_fstype(const char *progname, const struct statfs *fs_buf)
 		0x2FC12FC1 /* ZFS_SUPER_MAGIC */,
 		0x858458f6 /* RAMFS_MAGIC */,
 	};
-	for (i = 0; i < sizeof(f_type_whitelist)/sizeof(f_type_whitelist[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(f_type_whitelist); i++) {
 		if (f_type_whitelist[i] == fs_buf->f_type)
 			return 0;
 	}

