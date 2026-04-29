Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B019D093;
	Wed, 29 Apr 2026 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473467; cv=none; b=FU4zAiaGP4FmLFVnUyB+DWmZTLmo27hBfZ4+qLgP7rLIgVroYu3vPXps22d83/ZPSrc0oZ3OFgDG4YBittBIpb2OOCTPZLh2Q9Z2ibi2gowF3ymY/i75pl87m6321nGe2WgjNKD/huv+bqDLjqkvJzT+avAwEh6P0tqHyzQp7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473467; c=relaxed/simple;
	bh=EFEJlrdJhGBJ95UEGaq8j27+PMsTkUoj5eDlcnVqAO8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4u6rN8Ih8vXBHwO+ToQJwq3wx6DFd6cgXqQvzqaSKmedzBeoD/rmC3kKHs5L45LC7jClr8jwMZDzQKvqC0UPok1/JqgttCqY6z/tjbKopGJWQFa/nNqgdcw8IwhF7LeTSJUSzaop8su/5JBq6LkNH63H3p/dwat2WDwOnlWhQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh9zKIKh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh9zKIKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2EAC19425;
	Wed, 29 Apr 2026 14:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473467;
	bh=EFEJlrdJhGBJ95UEGaq8j27+PMsTkUoj5eDlcnVqAO8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qh9zKIKhFMVeQy87N2i5cEsjJctbH5vxlO1quJv9vWFtHJ9sVSa6Ijgh+dnq18knn
	 Vj6h8kqe67fRxvmxGwtNnpZP66ce+iiDcWbqLVLMQGWxlxD6T7MQn1qqSADvYpa0aG
	 Fst5nklgX4bBNFjOmT0sooIl7bgwuGmPxBIiRfa3j4c9acdMTlDRdYci71rX3GDDfm
	 FL01S2w4OsH+SrPlUpd+dbirAX+6YxfSEXiTSNz7HmA/y+q+sFQd2uEmsNdi9zadhv
	 lOinMIzMSii5iKucntQ4DkciiUFmtMCANXyggARsh+ZR9hkvJPd+lR1lOlpIqyTnjD
	 /+LdOMo4IRAlg==
Date: Wed, 29 Apr 2026 07:37:46 -0700
Subject: [PATCH 09/12] fuse: overlay iomap inode info in struct fuse_inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207191.4103699.9258306494086144653.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

It's not possible for a regular file to use iomap mode and writeback
caching at the same time, so we can save some memory in struct
fuse_inode by overlaying them in the union.  This is a separate patch
because C unions are rather unsafe and I prefer any errors to be
bisectable to this patch.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1bf5dd373153e5..c6a7ca4f1df76c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -188,8 +188,11 @@ struct fuse_inode {
 
 			/* waitq for direct-io completion */
 			wait_queue_head_t direct_io_waitq;
+		};
 
 #ifdef CONFIG_FUSE_IOMAP
+		/* regular file iomap mode */
+		struct {
 			/* file size as reported by fuse server */
 			loff_t i_disk_size;
 
@@ -200,8 +203,8 @@ struct fuse_inode {
 
 			/* cached iomap mappings */
 			struct fuse_iomap_cache *cache;
-#endif
 		};
+#endif
 
 		/* readdir cache (directory only) */
 		struct {

