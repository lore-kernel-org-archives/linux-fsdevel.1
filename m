Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6862727FD;
	Wed, 29 Apr 2026 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474280; cv=none; b=ixBYoGPG8NCgFPswJ9keJTeh5BIH9peS5VJgM6l5/L6YoXUwUUIXuPOGtREURfLllK+Vw+7yPqnzeHozaO4jDgoF+BBIlhmBWY6Xwcp6v/FqYDuifKarzy78TLu6g9CuKAFvkyV0ADr1OG/xNGXDotigDjcH7J92m7F5cPdPLq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474280; c=relaxed/simple;
	bh=HuwpxKedUZcIYrNsue8cA0bsF8RWN0MSa3EDt9DMSaw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw2I6AqGPIHrgh56CknGqs0QX969r81SwsKknWEyhpDT82zA9SrUJ81O83naBa0O5MN3ijkjWJilCBQB5xgIxZfgznQHszmz3ePaXjkQszogz1JO464uTeyEgRA2eUJZnErFdGOLr2OMwa7qqs8sbw3eFMXxvpA5r6aC1lZFlzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFhDjc3J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFhDjc3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6D4C19425;
	Wed, 29 Apr 2026 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474280;
	bh=HuwpxKedUZcIYrNsue8cA0bsF8RWN0MSa3EDt9DMSaw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=fFhDjc3JCGNnqVo62dTmCxK9gPvJB4+U8gUGZNw7gAtWYDa1lOwbNODCfiQ3UhIkf
	 b9fwY5ztKvgZ/iJJmCAKMRWOrBDEqlpExGgtgQBtCaMz9QJFu2L/vhkk8R/UEuW0Z+
	 Oa0Lo2TWXRg5wHJHV0EkN+bJT1Yzveo6SSUZNCNu/aRBF6PQpCfBXFy4uxWjyF+70k
	 1dxtn1QCSUkE41+8UuyVeZDIVp1QwKZoh1tISeSpB9+JOLe9Xc1DKm4c8YbYZIj6Uq
	 6sUtMoP0EM9BQYIKSQry7V1G5gSoayZ8Q/UnuLsy8xXwUXIusfGGS2O4UpQY0zzF7a
	 gVb4uWe2H+/GQ==
Date: Wed, 29 Apr 2026 07:51:19 -0700
Subject: [PATCH 9/9] example/iomap_service_ll: cache iomappings in the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213407.4106384.11315875001988831105.stgit@frogsfrogsfrogs>
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

Cache iomappings in the kernel.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 example/iomap_service_ll.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)


diff --git a/example/iomap_service_ll.c b/example/iomap_service_ll.c
index c7b9e9c064a32d..021a22ae13388d 100644
--- a/example/iomap_service_ll.c
+++ b/example/iomap_service_ll.c
@@ -212,6 +212,22 @@ static void ioservice_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
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

