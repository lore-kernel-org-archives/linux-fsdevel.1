Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299DB345CDA;
	Wed, 29 Apr 2026 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473013; cv=none; b=EosD46ixCaKjAvDW+wlTjyNzBc9y5n8/w10vJGjboiW2ChQlhXd+en0lbdfjV8SgUiN0Oa6t1KdHCZXyVeObrGYSG/tHV07ZaOubw3af7IMpsD8JeZUnPhRjANxLcH4c+WsqjeY+j7OIwq8GVZ5cq1L6/sBqPcudH1nnuqoJ7nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473013; c=relaxed/simple;
	bh=wpRp/Zs7e+kDu8bk3scre6diXdpBCZ/AnxPQSemra+w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXXTfUfse0uMv2CsBDEd7SizC82Qe2NzGFenkkNDaV/sVya+oPVGqYBOQwUdQjJhK/bInCQkdkPOpuVJGJVGrU1y8rzkizWR9D9As0Od/URfW8dBCYyZoQLm+sYIXamkwVOcNwux6E0GGaWUfd1BUOGWfB4/eKRwVBGWN47nUag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhYwPno5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhYwPno5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB86C19425;
	Wed, 29 Apr 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473012;
	bh=wpRp/Zs7e+kDu8bk3scre6diXdpBCZ/AnxPQSemra+w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FhYwPno5klyOF9CyhXX/pkc6814uEuCWfC95htWYB7mmd1T2bkoaYd72I9SnGVSL2
	 zPZfPCU4+AC8c+k6YuLxxUOXTqjcMsLX4Z/aSGBQ6uhKF+02DxM90H2/YOsKuWlvzX
	 tcIf7bZzo0zoDai+GHeha5/liW6Azx2d8mRaj8Fh29+jMS7uYwavePaHLdtWR4FIsM
	 mkiLco+fqF3aPiqt4PaO1WpuXQz4b3Sh7kNl2D/yW8cWFe90f1QB5HS7olWI7/Ukph
	 eumMJ0l0/MNSYkCxsqF7TBGmkl24+PThxVX9phXopAkVwRsvcR2LoUm2RGcl2GUqtl
	 0BfQ0uGd9ULZA==
Date: Wed, 29 Apr 2026 07:30:12 -0700
Subject: [PATCH 25/33] fuse_trace: invalidate ranges of block devices being
 used for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205686.4101881.15070448740182729142.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   26 ++++++++++++++++++++++++++
 fs/fuse/fuse_iomap.c |    2 ++
 2 files changed, 28 insertions(+)


diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 96c4db84c7106a..0e4be645802055 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1053,6 +1053,32 @@ TRACE_EVENT(fuse_iomap_config,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,
 		  __entry->uuid_len)
 );
+
+TRACE_EVENT(fuse_iomap_dev_inval,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_iomap_dev_inval_out *arg),
+	TP_ARGS(fc, arg),
+
+	TP_STRUCT__entry(
+		__field(dev_t,			connection)
+		__field(int,			dev)
+		__field(unsigned long long,	offset)
+		__field(unsigned long long,	length)
+	),
+
+	TP_fast_assign(
+		__entry->connection	=	fc->dev;
+		__entry->dev		=	arg->dev;
+		__entry->offset		=	arg->range.offset;
+		__entry->length		=	arg->range.length;
+	),
+
+	TP_printk("connection %u dev %d offset 0x%llx length 0x%llx",
+		  __entry->connection,
+		  __entry->dev,
+		  __entry->offset,
+		  __entry->length)
+);
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _TRACE_FUSE_H */
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index fe937529543b0c..807d84a2139362 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2011,6 +2011,8 @@ int fuse_iomap_dev_inval(struct fuse_conn *fc,
 	loff_t end;
 	int ret = 0;
 
+	trace_fuse_iomap_dev_inval(fc, arg);
+
 	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
 		return -EINVAL;
 

