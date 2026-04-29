Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF813254B3;
	Wed, 29 Apr 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473092; cv=none; b=re51cwk9BaGESFsR277gUZXDR4H/EA9xN5wlYi8xXzspepnjL8EatHlz68I233/vk6PweWFjjGKwp4dohe2AzLYcRH4MdWX7fMQElorLy/D5MLu3FYJiwRmGnUulXO1Jqonc0ASv9MFyMLo9xoa46KbjONUQ/JTQFvluwJCcR/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473092; c=relaxed/simple;
	bh=2HH6h4ijPSQ/x5iG/HFfKe3y5yxOjG3M+U3Mk0T4Pic=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9/K0KxQ/YL1RueBPaBwa56fTg2E2BJaDNbozjcj+NkpzEiN1zja1dwAc0gT4GNQUlYGy3Eco1lZ4t/FNdprDv0rAylcmPRpK2u+oELNl7UnkyaWKJSFlXPmEcrI+7Y7UjnVM8gsVDaxnBqssWS6f43cvq+R+tYyLrVnyow9BtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAHHkSE9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAHHkSE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD511C19425;
	Wed, 29 Apr 2026 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473091;
	bh=2HH6h4ijPSQ/x5iG/HFfKe3y5yxOjG3M+U3Mk0T4Pic=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LAHHkSE9MYOPynKYPrNls9Lhcn+8kblwbKTIirxHO0JXrC4Q/1oZYjJ8I/1xxuxpC
	 mJqu8ynK1JqNAQJp59iQLzYqi+O9RS/HbIGeNV/TAUT2v/37bLaXauRCdm2sn+lAFM
	 +mbsNd8XZMzNoKCdLbpYcanTmYoXFGxRUDb+ukjTOxvMBwTOuVFUKkKP9vOJzTmlfJ
	 z74vw5DqQX49LyXpYYbbVBTMZmdutEw0CgE3Sj7ndlhsv9d5apDICj4rt4YvROapPD
	 Kr2l7wfSLtnXdvlI2Zte13Ystpml2gzYpQNYq97jKdSmENkoHD2+fY9qwc1WeMNtlz
	 NnpB7xpNpGPsw==
Date: Wed, 29 Apr 2026 07:31:31 -0700
Subject: [PATCH 30/33] fuse_trace: support atomic writes with iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205792.4101881.525459216787331853.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add tracepoints for the previous patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index d3352e75fa6bdf..de7d483d4b0f34 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -330,6 +330,7 @@ TRACE_DEFINE_ENUM(FUSE_I_BTIME);
 TRACE_DEFINE_ENUM(FUSE_I_CACHE_IO_MODE);
 TRACE_DEFINE_ENUM(FUSE_I_EXCLUSIVE);
 TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
+TRACE_DEFINE_ENUM(FUSE_I_ATOMIC);
 
 #define FUSE_IFLAG_STRINGS \
 	{ 1 << FUSE_I_ADVISE_RDPLUS,		"advise_rdplus" }, \
@@ -339,7 +340,8 @@ TRACE_DEFINE_ENUM(FUSE_I_IOMAP);
 	{ 1 << FUSE_I_BTIME,			"btime" }, \
 	{ 1 << FUSE_I_CACHE_IO_MODE,		"cacheio" }, \
 	{ 1 << FUSE_I_EXCLUSIVE,		"excl" }, \
-	{ 1 << FUSE_I_IOMAP,			"iomap" }
+	{ 1 << FUSE_I_IOMAP,			"iomap" }, \
+	{ 1 << FUSE_I_ATOMIC,			"atomic" }
 
 #define IOMAP_IOEND_STRINGS \
 	{ IOMAP_IOEND_SHARED,			"shared" }, \

