Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDE1E7660;
	Thu, 11 Jun 2026 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781140389; cv=none; b=XHmxiRcrKu7AmnK95VQHu1E/dsjBQ84JisgSrY3ZvjBwLnhtwXzXvk/jNeUt94E2ORJ9brsnCvtDwR1J7f+clEln+vpnSGahmbrROWm1N4aVzzM47yV+eUtaoJzbtMMRigJml3Hyk4lYtDCBqB7KCs75cyCVSSG6XIAkuuhBaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781140389; c=relaxed/simple;
	bh=q+GXB4YFU+Ves/ohGBjn85csHrcElJ5/of3CrCQxcIs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oed1DIfA7ZE0xGNh8Glvqz/dgNPaqY9ywvrT0U/XY0H1higOtAaNq1OxcXK2yDjqnATjmKsc/FUlH514tEFLeUr7/q72R95dJyuNKaSeyKpUWqIUVnMHMryOQSM9eUFX6mGTqLGs8/w3Zi/VNVk9eXGZNdH92ArrWfzcgCs2Q9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drOi5VaD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drOi5VaD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 208051F00893;
	Thu, 11 Jun 2026 01:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781140388;
	bh=uXzoepltqwTzkdpIX75akA/7kBGMYxHMevN6xEBL0zQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=drOi5VaD7gf7FvdDRCLNz3jIhMULnr2ATG+pOKBmX1KWmOOSs01sX2emH9zDyd7UJ
	 QgUOJUEOjesxnD0cb46l2q2LvgGYGKmnFBaJTZugJkEdVWoE5dLOzqZm2FvLBduiis
	 KUI5j0x/rcymU5I3Ro6gOfDJEXPHspw8FhoU+n+sJE3nPZ0O3xlBzlrdBMrFmp6j7k
	 cJbJ81GYsaWaGDCcxmnK/HL7FiegLMF6cbZ6vKuZHSatWtEFBJkLTFI/OAIuY4iETJ
	 ao4E6LvokLPlGa2+JXnBZPK4CI3FQ3gQ/AUsNFKYHRrwFjUl8MX8YyCeAh+mvxdWXk
	 gTbnSNgd5Z9vg==
Date: Wed, 10 Jun 2026 18:13:07 -0700
Subject: [PATCH 3/7] mount_service: call the new fsmount ms_flags helpers in
 the right order
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <178114032626.139936.458879206064194950.stgit@frogsfrogsfrogs>
In-Reply-To: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
References: <178114032546.139936.4052263259025005657.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Codex noticed a discrepancy between the new fsmount code that Bernd
wrote and my port of the even newer mount service code to use the
helpers that Bernd wrote.  Specifically, set_fsconfig_ms_flags only
clears bits from MS_FLAGS if there's no corresponding MOUNT_ATTR_ flag,
whereas ms_flags_to_mount_attrs always clears them.

In other words, set_fsconfig_ms_flags MUST be called before
ms_flags_to_mount_attrs or we can lose the 'ro' option.  Fix this.

Fixes: 7211953256526f ("mount_service: use the fsmount API helpers from mount_fsmount.c")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount_fsmount.c  |    2 ++
 util/mount_service.c |    5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)


diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
index 83768f0b8d193b..89f5b1a112a9b7 100644
--- a/lib/mount_fsmount.c
+++ b/lib/mount_fsmount.c
@@ -35,6 +35,7 @@
 #define MOUNT_ATTR_NOSYMFOLLOW  0x00200000
 #endif
 
+/* Must be called after set_fsconfig_ms_flags */
 unsigned long ms_flags_to_mount_attrs(unsigned long ms_flags,
 				      unsigned int *mount_attrs)
 {
@@ -93,6 +94,7 @@ void log_fsconfig_kmsg(int fd)
 	errno = err;
 }
 
+/* Must be called before ms_flags_to_mount_attrs */
 int set_fsconfig_ms_flags(int fsfd, unsigned long *ms_flags)
 {
 	unsigned long flags = *ms_flags;
diff --git a/util/mount_service.c b/util/mount_service.c
index 360a78bab3bd3d..9890d6cbf028cf 100644
--- a/util/mount_service.c
+++ b/util/mount_service.c
@@ -1410,14 +1410,12 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 				      const struct stat *stbuf)
 {
 	char tmp[64];
-	unsigned long ms_flags;
+	unsigned long ms_flags = ntohl(oc->ms_flags);
 	unsigned int attr_flags;
 	int mfd;
 	int error;
 	int ret;
 
-	ms_flags = ms_flags_to_mount_attrs(ntohl(oc->ms_flags), &attr_flags);
-
 	ret = set_fsconfig_ms_flags(mo->fsopenfd, &ms_flags);
 	if (ret) {
 		error = errno;
@@ -1429,6 +1427,7 @@ static int mount_service_fsopen_mount(struct mount_service *mo,
 	 * or string flags!  Return a magic code so the caller will fall back
 	 * to regular mount(2).
 	 */
+	ms_flags = ms_flags_to_mount_attrs(ms_flags, &attr_flags);
 	if (ms_flags)
 		return FUSE_MOUNT_FALLBACK_NEEDED;
 

