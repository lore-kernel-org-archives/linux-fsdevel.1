Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90E4DA531
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859324; cv=none; b=pLX2gWbrcHQfaJ6V8KQe3wyVyOXvWMqz4IhG1WlrxGCor3M+hNlu2vGWsKWgjzj+ijnA+MhswyQDMl9H71cf+TDZO89DRHkvVYWH7W0UE3bqjLAZrBytG9LCrDeIv2IW9hzOQKHAKVh4uqPKY+K8Q5HhdJYOU7MfPBs91chCEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859324; c=relaxed/simple;
	bh=Qgb04QdIs719uy9K/j382nVx8v7agpLqO0+GHAqbkQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gfgv03r28czKD1NUTa5NMaqxj/siNZXBY9pZAmxtIXmejYMT7vp4XSUca0fcMyM4sZxKLNwV6Uqc3BCY+vhxvgy35jRz2q26nYNB8/+NlZwYzTp61jJ62nSIUej4oF90jlLWzC3Feu/jeMALA+k6+h14AlWgdvNi3tiAlo6ngdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3TFBjjy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3TFBjjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CEBC2BCB0;
	Fri, 15 May 2026 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859322;
	bh=Qgb04QdIs719uy9K/j382nVx8v7agpLqO0+GHAqbkQk=;
	h=From:To:Cc:Subject:Date:From;
	b=j3TFBjjyA/3HJ2D5lzxeQPAvyLO5zgK0hSV7ndpWfr8pWF4dvKisDM6eZbFxLecdc
	 Gd5iHLPEp3llEpbuVjbrP1A4SqLHZIDNEo7t6rB7pgiQHVJytXEopCwAav0pYKnENA
	 89q/bSgb6eIim30/f/cSZiT4zUE2xXTejUyjlRg/tneCIf3CvFt0RaR/O0RZwZFpaH
	 7JtYLJ/DZ7cvXJ18QcZUPabhQUjNmMc2mAc5ZpRnBO9bUodKgskefG8ZABSL7CZmgI
	 fKlD+Z+lw0i+OpgYlmjHAHZ4K+dHaF8FR8exQ4j0ZjPlqkMN4cU4jKXcQXfHXMDlhJ
	 6qkQ3/Oz9oa2Q==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 0/7] Fixes for vfs/vfs-7.2.casefold
Date: Fri, 15 May 2026 11:35:08 -0400
Message-ID: <20260515153515.362266-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Address review comments for the series in the vfs/vfs-7.2.casefold
branch.

Chuck Lever (7):
  tools headers UAPI: Sync case-sensitivity flags from linux/fs.h
  nfs: Avoid transient zeroed case capability bits during probe
  nfs: Skip pathconf probe when neither field is consumed
  fs: Clarify FS_CASEFOLD_FL semantics in UAPI header
  nfsd: Use kernel credentials for case-info probe
  nfsd: Map -ESTALE from case probe to NFS3ERR_STALE
  nfsd: Cap case-folding probe cost across READDIR entries

 fs/nfs/client.c                               | 29 ++++++----
 fs/nfsd/nfs3proc.c                            |  3 +
 fs/nfsd/nfs4xdr.c                             | 55 ++++++++++++++++---
 fs/nfsd/vfs.c                                 |  4 +-
 fs/nfsd/xdr4.h                                | 14 +++++
 include/uapi/linux/fs.h                       | 11 +++-
 .../perf/trace/beauty/include/uapi/linux/fs.h |  7 +++
 7 files changed, 98 insertions(+), 25 deletions(-)

-- 
2.54.0

