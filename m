Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346283B9DA9;
	Tue,  5 May 2026 05:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958788; cv=none; b=CeGxTyMaFQz4il3bIepclo8OdeEtfIFzeb+opVcj2GGWdN0C+2UiLT8bCb4M0xK++uHVDHEftm4mOk8g/48YwoaCevC5WtcdEb+Wu7M4OWo7MH5QnH/sifVjntxPAYoTu2Pt4yH0oyL8XGu8JucKNin/BULnzUNELpR70t0y40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958788; c=relaxed/simple;
	bh=z7bIZCz0mOLfJGX/frQcVaRhRrhVf0fPVSg6B6hqx20=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ge+WjaJGPh3HEEOKgEa/KdFhkjS0I/066BevXT3qkCHnr5zDRdxlG6SVWwtuBwc5HtnxBo0/15GC+Kx94OGF2j9vzh7C8Gu07B9iv9TZhK1weDipNHvwuTjOFFa7/K9yhTIm+ktHBcF8yaGeUqaHAM3OGDtuXYtOEs6N3I/RMCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFnGWhuE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFnGWhuE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D49C2BCB4;
	Tue,  5 May 2026 05:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777958787;
	bh=z7bIZCz0mOLfJGX/frQcVaRhRrhVf0fPVSg6B6hqx20=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oFnGWhuExEg1LLt3ak4z6G3QDJcdzmOY3ZtuCoVZtDodWIWkXyS5W2GGBr9TWqLzU
	 lUoTb8f33Sv35JreRWhGPstpMEcQSVuzY1eSzvMNqjsvEXdfFl1FSE23bktJnUnu0P
	 xEPG/kFK0JMkzAvlntgwJmzDlNVBxl3AgSyLfZAHP9sDA81zlmY6VDce7gj/XgS9om
	 V095XjvQRwxfafBQEODCbXpv54JQDwaaPjqrxBkifxQYmLfE86FaxFq8+yybTMtSZo
	 ufoHDpuQFqjUK2bByU69KivzrQiokFbvKwi+YKmoELr+trHz8kW5hNPoNsA9koxIgz
	 zsompOJRJfM8g==
Date: Mon, 04 May 2026 22:26:27 -0700
Subject: [PATCH 10/10] example: fix cppcheck complaints about constifying
 pointers
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bernd@bsbernd.com
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Message-ID: <177795853864.1133612.18090173501884630291.stgit@frogsfrogsfrogs>
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

Fix various cppcheck complaints about pointers that could be const
pointers instead.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 example/single_file.h |    2 +-
 example/single_file.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/example/single_file.h b/example/single_file.h
index 290dd6051ed6f5..6ca536a70cf682 100644
--- a/example/single_file.h
+++ b/example/single_file.h
@@ -114,7 +114,7 @@ int single_file_opt_proc(void *data, const char *arg, int key,
 unsigned long long parse_num_blocks(const char *arg, int log_block_size);
 
 struct fuse_service;
-int single_file_service_open(struct fuse_service *sf, const char *path);
+int single_file_service_open(const struct fuse_service *sf, const char *path);
 
 void single_file_check_read(off_t pos, size_t *count);
 int single_file_check_write(off_t pos, size_t *count);
diff --git a/example/single_file.c b/example/single_file.c
index a962232d576e17..59dbc6bbac5e77 100644
--- a/example/single_file.c
+++ b/example/single_file.c
@@ -756,7 +756,7 @@ int single_file_opt_proc(void *data, const char *arg, int key,
 	return 1;
 }
 
-int single_file_service_open(struct fuse_service *sf, const char *path)
+int single_file_service_open(const struct fuse_service *sf, const char *path)
 {
 	int open_flags = single_file.ro ? O_RDONLY : O_RDWR;
 	int fd;

