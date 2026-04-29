Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C12FD1B3;
	Wed, 29 Apr 2026 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474264; cv=none; b=fBlqPgl9I0DdtFASlzfXU3dP1bPIukDPQsT+O9Ay8Juage/vyzR7VJqQyLdPnc4uegoan1xwvErvXtDMv3MAmv6jUl1t3PzOJRa1WlKMAhUl/nt1/OthB7S0ntr1quE2xiIsmnYsxLo1eDcRjxM4YQvw7DfbB/QlRkgGbCVgy98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474264; c=relaxed/simple;
	bh=NoJ4UKkhsZ7hSTgxOM65tvHH3nHXwrsnsLBofGtE7To=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkcMs97J2WB2y1zCWjtHNT9Z/dDYd/W3pU2coS3rkhy+1CLws4UmPDc80NXNkmfILQmYmMNe1M5d/+VY2uw59koREGno3K0VGOBkCoTV8ALGKiQVKfWb4e2I3AWnoDg7sTTTKkngoBTHDuOdgalrih9Sbh004k061ihru1HV/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaGUg5WL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaGUg5WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E75C19425;
	Wed, 29 Apr 2026 14:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474264;
	bh=NoJ4UKkhsZ7hSTgxOM65tvHH3nHXwrsnsLBofGtE7To=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MaGUg5WLwT+wMJIat1TT68wWcUgJUas4jucs4j8I1f3FZKo7afkiVO7OhFD3qOKZp
	 7rA8pwIniJPS0NNwulEoquyQIDsriZ7HAWQOWHh70aXAsMFFFTFgKw7Ixj+dg+j3RC
	 LtZ6+8awM9a+whGPVbi2KgPPpv0nHrFtt7SL8y9OjqqkycID8aiAWtzXaS7/lxxK7I
	 6uWRjikr9GgrWIujwEKEZPX2Q6PxicBUHOWeR+jgdR18SfYwdFGkpNFSPirudkpYyD
	 cLTp/974suGcwSUa0wKTLcpeyqfk1jCBdLvhOUjn8K/3k9nqVAcoyT8T2RD+rS14EG
	 g2RTULXEDsesw==
Date: Wed, 29 Apr 2026 07:51:04 -0700
Subject: [PATCH 8/9] example/iomap_ow_ll: cache iomappings in the kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 fuse-devel@lists.linux.dev, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177747213389.4106384.10909199336417262406.stgit@frogsfrogsfrogs>
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
 example/iomap_ow_ll.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)


diff --git a/example/iomap_ow_ll.c b/example/iomap_ow_ll.c
index 926c25133a3a84..3df96581231dd2 100644
--- a/example/iomap_ow_ll.c
+++ b/example/iomap_ow_ll.c
@@ -475,6 +475,23 @@ static void ioow_ll_iomap_begin(fuse_req_t req, fuse_ino_t ino,
 		goto out_unlock;
 	}
 
+	/*
+	 * For real IO operations, cache the mapping in the kernel so that we
+	 * can reuse them for subsequent IO to the same regions.  Don't let
+	 * FIEMAP thrash the cache.
+	 */
+	if (!(opflags & FUSE_IOMAP_OP_REPORT) && single_file.iomap_cache) {
+		ret = fuse_lowlevel_iomap_upsert_mappings(ll.se, ino, ino,
+							  &read, &write);
+		if (ret) {
+			ret = -ret;
+			goto out_unlock;
+		}
+
+		fuse_file_iomap_retry_cache(&read);
+		fuse_file_iomap_retry_cache(&write);
+	}
+
 out_unlock:
 	pthread_mutex_unlock(&single_file.lock);
 out_reply:

