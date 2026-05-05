Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655573B0AD3;
	Tue,  5 May 2026 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958694; cv=none; b=QVnr8CDw/G9cfUtaQoE1Z23ldaTQWFLRNbpk1ccU4546Dyx1fhbQlDbSdB7b3/HCjNmstYsnCx1DRGN5ykiOBpQkJj8oWufM7RLIlIhcV9rYKH7qIJrEvZqEbw73DFuPBQ418y9+zSFy43jw0jI0Wthg+nNc+VzthPU1oXnVbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958694; c=relaxed/simple;
	bh=UwpMp5xMo543DBsRVtyRED+i+b50fRc6MBRJ7qrJNFk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XepyWKvxMXHajiLsnkx2s8YHVFn5n5jlHCSWaYIhjSoWfpumRbmVf1kzqm5mStVZgPySZskWxjCQA13sHMXsKjiCNgsAW6KEfJ5B+f5C0wVnBTsSQJa4vGpLxv9TIUS13e6SssAx+G0oMISOB552ImLh11F8JygxN+xO4yCywYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjZu2jBR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjZu2jBR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091CAC2BCB4;
	Tue,  5 May 2026 05:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958694;
	bh=UwpMp5xMo543DBsRVtyRED+i+b50fRc6MBRJ7qrJNFk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fjZu2jBRtPwA45r3LUejl1JHCSPUle/izjeriDUw2F+BTuTCF/SJeci69hi5TUc7G
	 13NppybdCAbt5DJPLliZEQIynBip1xqtt4bbyGvP266s2z9qjyAH6oRhXAod7z55FF
	 6X9ene076yQEQMv98g6fEQzz/0GH7a0kwIQAmDjB6/cRJTqku1VcmU3tWzKVb+6RoO
	 mGGa/+ONFc5+/DiwTfaTCgepHLH+cnRvrGLOi2TUcuv31Io1gCA7LK29Red6ifOBvR
	 ph7pDZxejGn9Xao2cA1jsckc+BQwlBH7x21TbgKyh1K+r/CA7f+FmVoRO7lO5wTYZa
	 N3uGeVKz2UX3g==
Date: Mon, 04 May 2026 22:24:53 -0700
Subject: [PATCH 04/10] example/single_file: sync backing fd when statx wants
 us to fsync
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853757.1133612.6951380899522271929.stgit@frogsfrogsfrogs>
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

statx callers can tell the filesystem to fsync the file, so let's pass
that through to the backing fd.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)


diff --git a/example/single_file.c b/example/single_file.c
index aeceac83c517c1..e7da1f2933fc81 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -286,9 +286,18 @@ void single_file_ll_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
 	struct statx stx = { };
 	bool filled;
 
-	(void)flags;
 	(void)fi;
 
+	if ((flags & AT_STATX_FORCE_SYNC) && is_single_file_ino(ino) &&
+	    single_file.backing_fd >= 0) {
+		int ret = fsync(single_file.backing_fd);
+
+		if (ret) {
+			fuse_reply_err(req, errno);
+			return;
+		}
+	}
+
 	pthread_mutex_lock(&single_file.lock);
 	filled = sf_statx(ino, mask, &stx);
 	pthread_mutex_unlock(&single_file.lock);
@@ -301,13 +310,20 @@ void single_file_ll_statx(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
 int single_file_hl_statx(const char *path, int statx_flags, int statx_mask,
 			 struct statx *stx, struct fuse_file_info *fi)
 {
-	(void)statx_flags;
 	fuse_ino_t ino = single_open_file_path_to_ino(fi, path);
 	bool filled;
 
 	if (!ino)
 		return -ENOENT;
 
+	if ((statx_flags & AT_STATX_FORCE_SYNC) && is_single_file_ino(ino) &&
+	    single_file.backing_fd >= 0) {
+		int ret = fsync(single_file.backing_fd);
+
+		if (ret)
+			return -errno;
+	}
+
 	pthread_mutex_lock(&single_file.lock);
 	filled = sf_statx(ino, statx_mask, stx);
 	pthread_mutex_unlock(&single_file.lock);

