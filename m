Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA0325485;
	Tue, 19 May 2026 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229982; cv=none; b=iCKyc1MM2qW8VsJTVgVmsLHtEosGCjh3d0AdpydnTS5nMupvGGCUO+RzKDjqmVCN8YyZx/kclhgFAeSNTwkGfMXwODOvcTDDlxR1tyRZf55Ga/H/O7LMNHi5nNixsiPEbwT7J5PjoINGpJNEZaWMVVTzMowauTMBd0WTY0w2gBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229982; c=relaxed/simple;
	bh=IeqYeZHzPr8SdFazKytTj1+3p2pywqw8laGumcgEKT8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/KBde6JbudWrscVGVZEB3i8jWPl+j7L/AHY3O3635+15AWTPJcvartFQtgxsCUj80nJ7Gp+3az+Pc1OvJCmDAtv4Jf4Wq24aIa8Np6rKJ5rV9h+2dAqB6xqctnPmIJNQrCDx0Hp7qO9APZQshs0xu0vZ+Li1dO0cWbHTBVkIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFe8l7V1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFe8l7V1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A26D41F000E9;
	Tue, 19 May 2026 22:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229980;
	bh=MDt4rfSsHjzmp+jsItcQYDgPoeaFNZmJMR2lNrpPT4Y=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=BFe8l7V1u2P+u1L5MVOZwNf+vVEIEXULrszJAMKEVo6EOn30yqJ71BnrYrY9jLrsj
	 6g3/j75ZRrLnURqsmx7esqe0eRZrFoc9MuzWh3VedntXp2eaIm419uRsOkhupy0MLA
	 yziwDSfo994ZIqbtrU64vLye7Cocu836JtEutlhvEmLX+7E46LW4CZdOlOHpmEwmhV
	 mY39vqtnDHQ6G75DL4nvASyJICf9HH0Zkx/O5WdQ+7SpFzWjKVrozh8cHhp0BnpSMu
	 HtXj+gpQ4wLf2cUfmYmExjY+EA0Iz8PDajAjl2G1jvbSz6XfjIAeXdCJoQ426+XrMy
	 4tOqB88R4ToAg==
Date: Tue, 19 May 2026 15:33:00 -0700
Subject: [PATCH 8/9] fuse_trace: invalidate ranges of block devices being used
 for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922946350.2439242.301945893658681167.stgit@frogsfrogsfrogs>
In-Reply-To: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
References: <177922946123.2439242.16666495969848656301.stgit@frogsfrogsfrogs>
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
index 38fa54e4af731d..8c0b691dfde703 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -1117,6 +1117,32 @@ TRACE_EVENT(fuse_iomap_config,
 		  __entry->time_min, __entry->time_max, __entry->maxbytes,
 		  __entry->uuid_len)
 );
+
+TRACE_EVENT(fuse_iomap_backing_inval,
+	TP_PROTO(const struct fuse_conn *fc,
+		 const struct fuse_iomap_backing_inval_out *arg),
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
index 8d259c8d239b07..ba54eb694dbbac 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -2399,6 +2399,8 @@ int fuse_iomap_backing_inval(struct fuse_conn *fc,
 	loff_t end;
 	int ret = 0;
 
+	trace_fuse_iomap_backing_inval(fc, arg);
+
 	if (!fc->iomap || arg->dev == FUSE_IOMAP_DEV_NULL)
 		return -EINVAL;
 

