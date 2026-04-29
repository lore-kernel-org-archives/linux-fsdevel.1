Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524935DA6A;
	Wed, 29 Apr 2026 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473170; cv=none; b=fBHFRD8qnFMDaumNuk9pk1GMJYCRk8kyVmVgFs1ur7lGzmIzZf4RaZW8sn/lIe2C5C/VD9qtt8+F17Zau7w1PpWysloNKRpQv/eVODIn+cWKFmUPwffLoZ3kqan/FYoND5ZI4ZefKRJ91npshXSijTanlPqpoUcu6+mSO482rnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473170; c=relaxed/simple;
	bh=4+A9pSHUOhLBxFxPoKWs630EgOZEXLCrG2C400OY4MU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWDxnyZEMRVLUhqbzxYQ5cUEBdow948iWRcSszGMH3rfg7b6jW1/hg9qs7nIGDzTmD2pVIxoH3RuNyYRUBEfWvR57/p5c0ZnMH16jyBLCNo4/W6EtHZS4Sbfu8rWoPc3SYhXgpJAR76GNK63ZscRZo+lK5b2SXfEa5Fynv1Cd9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPkZuU4G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPkZuU4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76A6C19425;
	Wed, 29 Apr 2026 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473169;
	bh=4+A9pSHUOhLBxFxPoKWs630EgOZEXLCrG2C400OY4MU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CPkZuU4G4veIaeRuW4cGHSZf4ab7fd+GunFhbSfhltK+9Ozki+W1nrm2cyWQekAL8
	 NTrsmKvXSfgxehrUQKHCa88QSLL6YUP2auC+jLEXTIUQ6AXgbUSfTuqcYqCSPYQgIP
	 uhFbSlnW9RcXd91E6Ub5o+ocfbNNOtGeFGJuJlGkt/rf4GQl8kATv/DBBt1GFGjRtK
	 m//aLo7Cr4RihA2sHdbB/1txL8LIk/FrT7KdO5nBIFoRU5BcHA5ri6sD9E8LfNTtGg
	 NnbcAQLfSsjYeS6xiURfJZ3bF2Q4yxRdgtMSk7j+tT5+nd5BiuZ2rSVJATHPp1Hw4H
	 mDot4klhH1C2g==
Date: Wed, 29 Apr 2026 07:32:49 -0700
Subject: [PATCH 2/3] fuse_trace: make the root nodeid dynamic
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206167.4103135.3497322993790350843.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
References: <177747206108.4103135.16385179491642925149.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enhance the iomap config tracepoint to report the node id of the root
directory.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_trace.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 63cc1496ee5ca1..0016242ff34f62 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1026,6 +1026,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_STRUCT__entry(
 		__field(dev_t,			connection)
+		__field(uint64_t,		root_nodeid)
 
 		__field(uint64_t,		flags)
 		__field(uint32_t,		blocksize)
@@ -1040,6 +1041,7 @@ TRACE_EVENT(fuse_iomap_config,
 
 	TP_fast_assign(
 		__entry->connection	=	fm->fc->dev;
+		__entry->root_nodeid	=	fm->fc->root_nodeid;
 		__entry->flags		=	outarg->flags;
 		__entry->blocksize	=	outarg->s_blocksize;
 		__entry->max_links	=	outarg->s_max_links;
@@ -1050,8 +1052,8 @@ TRACE_EVENT(fuse_iomap_config,
 		__entry->uuid_len	=	outarg->s_uuid_len;
 	),
 
-	TP_printk("connection %u flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
-		  __entry->connection,
+	TP_printk("connection %u root_ino 0x%llx flags (%s) blocksize 0x%x max_links %u time_gran %u time_min %lld time_max %lld maxbytes 0x%llx uuid_len %u",
+		  __entry->connection, __entry->root_nodeid,
 		  __print_flags(__entry->flags, "|", FUSE_IOMAP_CONFIG_STRINGS),
 		  __entry->blocksize, __entry->max_links, __entry->time_gran,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,

