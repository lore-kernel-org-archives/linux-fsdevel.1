Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052632BF24;
	Wed, 29 Apr 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474234; cv=none; b=WlF6XBRXCdb7Ke32NhITfAEQMTaVh9ysdAb1d4deA03X6vU2WV9OX/zDmOBOV/4JL/leK0Xig+N+7WgLAm/B2WdskrR2cTq0iI4XGib19yzwxcXqhEKlbk2caACQRBYK1WtkRFlB3OApHlzeDXR9IOxqdIeHOW/qohsF/0PVwUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474234; c=relaxed/simple;
	bh=C7TxFtB6zIIjXEurNpl44XWNiEaL4PkwIR+R+yifjhI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E974B5jGTV2rHgJblgg9BGEn+s+ALamV/3gHccQTwmqGgJ0ZyaTjEKl5HZBbJ4E0B7DCRNfrD1fn08Tp8ivu111rQgK18VKM+mF20CpPdr0clw9zfGeKy6oPTun5pmHd7qCSSYYmNtM4NF8E+bLFXJDVAUQf3P6tXTqWipjwrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zbu6LTXt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zbu6LTXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D547C19425;
	Wed, 29 Apr 2026 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474233;
	bh=C7TxFtB6zIIjXEurNpl44XWNiEaL4PkwIR+R+yifjhI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Zbu6LTXtIQsQzU5LebukmLCOAh7lagHZ3KoAwJMGlRiB6s4a8c2BFOcrFkMxiF077
	 unEJ11KzKPwmktj7jQSe0lO2iWittvdHAD4Vj4r952PiG8/BHsv0YmEb+2LcINiMvq
	 w1sBZvlivuT6dIhO19NOylVgYnz5sM3Pz7bh9mA3bzrrb5H96eifz4hz8NecoZ1yKR
	 PGDYpOWHeo5fp+CSJgGD68T4iYyhw6wwz0mV1VIU4eZ9LlLkKq8X+oulHXT/nskg9p
	 WpiNCPEJV+HpU3kSvIWJjtJ8RWRLIoIjFkb/uJbGLJFwtfJlAKitht0mUtk7rzT/li
	 8HUGZ+tUiOTUg==
Date: Wed, 29 Apr 2026 07:50:33 -0700
Subject: [PATCH 6/9] example/iomap_ll: cache mappings for later
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213354.4106384.2081219291651974847.stgit@frogsfrogsfrogs>
In-Reply-To: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
References: <177747213211.4106384.5167047581302637277.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Cache the iomappings in the kernel for better performance.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/single_file.h |    7 ++++++-
 example/iomap_ll.c    |   16 ++++++++++++++++
 example/single_file.c |    7 +++++++
 3 files changed, 29 insertions(+), 1 deletion(-)


diff --git a/example/single_file.h b/example/single_file.h
index edf8a424d02ec6..96cda5be59d77a 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -59,6 +59,7 @@ struct single_file {
 	bool require_bdev;
 	bool uses_iomap;
 	bool fixed_size;
+	bool iomap_cache;
 
 	int awu_min, awu_max;
 	unsigned int blocksize;
@@ -103,6 +104,8 @@ enum single_file_opt_keys {
 	SINGLE_FILE_NOSYNC,
 	SINGLE_FILE_SIZE,
 	SINGLE_FILE_BLOCKSIZE,
+	SINGLE_FILE_IOMAP_CACHE,
+	SINGLE_FILE_NOIOMAP_CACHE,
 
 	SINGLE_FILE_NR_KEYS,
 };
@@ -116,7 +119,9 @@ enum single_file_opt_keys {
 	FUSE_OPT_KEY("sync",		SINGLE_FILE_SYNC), \
 	FUSE_OPT_KEY("nosync",		SINGLE_FILE_NOSYNC), \
 	FUSE_OPT_KEY("size=%s",		SINGLE_FILE_SIZE), \
-	FUSE_OPT_KEY("blocksize=%s",	SINGLE_FILE_BLOCKSIZE)
+	FUSE_OPT_KEY("blocksize=%s",	SINGLE_FILE_BLOCKSIZE), \
+	FUSE_OPT_KEY("iomap_cache",	SINGLE_FILE_IOMAP_CACHE), \
+	FUSE_OPT_KEY("noiomap_cache",	SINGLE_FILE_NOIOMAP_CACHE)
 
 int single_file_opt_proc(void *data, const char *arg, int key,
 			 struct fuse_args *outargs);
diff --git a/example/iomap_ll.c b/example/iomap_ll.c
index 9824172be4afa4..ff0a21db46d2c2 100644
--- a/example/iomap_ll.c
+++ b/example/iomap_ll.c
@@ -362,6 +362,22 @@ static void iomap_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
 		goto out_unlock;
 	}
 
+	/*
+	 * For real IO operations, cache the mapping in the kernel so that we
+	 * can reuse them for subsequent IO to the same regions.  Don't let
+	 * FIEMAP thrash the cache.
+	 */
+	if (!(opflags & FUSE_IOMAP_OP_REPORT) && single_file.iomap_cache) {
+		ret = fuse_lowlevel_iomap_upsert_mappings(ll.se, ino, ino,
+							  &read, NULL);
+		if (ret) {
+			ret = -ret;
+			goto out_unlock;
+		}
+
+		fuse_file_iomap_retry_cache(&read);
+	}
+
 out_unlock:
 	pthread_mutex_unlock(&single_file.lock);
 out_reply:
diff --git a/example/single_file.c b/example/single_file.c
index 49c3e857b130f8..d669f81bc309c9 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -68,6 +68,7 @@ struct single_file single_file = {
 	.mode = S_IFREG | 0444,
 	.lock = PTHREAD_MUTEX_INITIALIZER,
 	.fixed_size = true,
+	.iomap_cache = true,
 };
 
 static fuse_ino_t single_file_path_to_ino(const char *path)
@@ -800,6 +801,12 @@ int single_file_opt_proc(void *data, const char *arg, int key,
 	case SINGLE_FILE_NOSYNC:
 		single_file.sync = false;
 		return 0;
+	case SINGLE_FILE_IOMAP_CACHE:
+		single_file.iomap_cache = true;
+		return 0;
+	case SINGLE_FILE_NOIOMAP_CACHE:
+		single_file.iomap_cache = false;
+		return 0;
 	case SINGLE_FILE_BLOCKSIZE:
 		return single_file_set_blocksize(arg + 10);
 	case SINGLE_FILE_SIZE:

