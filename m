Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A73366051
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 23:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295708; cv=none; b=tTqI3yfkhv6aIyOAHAnwXekfmJpbEoSB1LYEBzeKyMp2iC2x9pK6D4WDR6KBkH7Wyycy/zNhQBfMbe7aAc5wlg5VUcFkv6Th+fPXuuClREtke5A+YwSwdeFoFLDyjIdy8Bw3fcFULk34yzSju4NfFJl9TnjZvJhuSP/HUdCiy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295708; c=relaxed/simple;
	bh=CUv0EeTa8PtFsvYtx90Y7pAVu2UFGx5kcHIX8BQ77Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=al6w63MSEM8DWK98MG0GtUXODT8qXb3bllVpUGOy4lxKY8CIftv61qz8wb69e/F38EHBIjcm3TqNHLAUShne2AwTxznR4kgWRO4B3DFEnqIv6Ala/G2ku94t70AWWVwl6KGWY2SxJu4Mv0hgwgUEVRiu46QdX5jcCqLWDdxqKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=OAc1TtpL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AjpnBPuX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="OAc1TtpL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AjpnBPuX"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 54725140008D;
	Sun,  5 Jul 2026 19:55:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 19:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1783295705; x=1783382105; bh=Hb9oW5AHYQ
	Ip7cA8kv5+3Z06L9whgpisofR/kYf8qZA=; b=OAc1TtpLOVvQ6ZOY/zWD33vNYF
	S+sg4TDTxVndbZ8g/1Q3/DFYY7vecIdl5FhpUnBDWMtoAO75fca7jAVxIaAdEj1j
	3Z2RT+NuXOBPT1QMfA2W0wxWGHY4vCQ6NxrtCwsBYJkqArWNLOK8orSc0P2a7QNy
	GlOlzedfx125jdtWFdAJ1DyRqHmfX6jB9UloVlzxxflLwSOrh6XTJjGMdGnNpYHz
	0y3ddVcmwkZY/clilTpA8Cu+sWgAn2cvMbUC42q1W2zJkj9IbWWzFuzISI3lwotA
	p15ZiRrYhIAymms8vS2xwiHM2aWh+A/UOqeMtlrWpXzqfmaujEemz7X0Yo2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783295705; x=1783382105; bh=Hb9oW5AHYQIp7cA8kv5+3Z06L9wh
	gpisofR/kYf8qZA=; b=AjpnBPuXNQbgQN85sjNXQ4qVY7YjIENkGKfiI+5IzMye
	KI3Oqr8YNIZ9eX46qXaWHpLfxNz4aYsuijNcfZUc7mzBJpVh7bLPbY+0m0h5EeTg
	7Y8hqfxvrMvZxk9di6+UBPUhqmAI5+aihaFKpc0db/aAez/N8tXsIj+FBHVXUjXU
	2J+LADSdR6jqeAjbAPEoxNKSa1lrgemrxzkNBYe+Lk+QJiS8lT70Gq75tSG4V5RE
	NzBOdGnXNges8XhAcwcZxBnsm4Kjrnz69lKeVV40iO4i3Wsa4mjBXBjFdd9NTBFh
	ZQzd9XTea/MpmAo8EN5yCM2PAKtXEDIFwrxN1aWIGg==
X-ME-Sender: <xms:2O5KaqhBU239T6CvvnswvMWlOha7BvO4gIy3A3d_s0yGz74Tj6XZpA>
    <xme:2O5Kaj8-TJSuR7u1v1WR68LV1cZo8ab2VVrKQRiL0A8OXKLNpafkUznI7TcaThh6v
    Usou-Q1tfvVCm3eKK0WOCTmYSEFfHOmH1IvgdOcOXzE0sgobA>
X-ME-Received: <xmr:2O5KatpisP5-Z4Jkx_WgDbYajUxuPFdoilK3sRBi5RRGAEcArjqonDAh-_AtihU-XuvMsF6DoIeI-p2w6yZ39TrZ7jGRx3I>
X-ME-Proxy-Cause: dmFkZTGbLhne1dq5ZmgoETVV2k1YZ6CJDBNBBTDuEs6brh029h5VLyGLaBBUMvFVzJqTny
    mQWshgHjVlZeX5cRkEKDSvnMp/hyvd/Njd0Kw4yE7Xo+HsFIjxkyVZN6RunwvGJRky9Gf/
    /tiGIH83Qd/HFXffMjXf5QjhTdyJ5+ASSQSe7wM+8ntT9ZyhqQnpeETrts2U6+ndep/Ut6
    7qkwwUaykBUYRaW+ndrsJmRVCbHXN9rlbE08iRUB/sRiLox+0q+kOGwBXPW1uPnKHIv1sz
    qP4G0nITEtfgPFpBdqpOSO5q46LFI/16rOeHK/mrU+vb7W4vAHRUKEFlpQGmf41IRAXchz
    1hcDOM5LLQIECWie8/PfT1lvjP4PgsK7DfEcvnVoulQj91XoIxEWx5UffUhOtDbrLC46jo
    sNqsHjf4O4rdqJzJ4mJH8ojsAYaZP+1ZMmsupdgClQcbl3ruy9SPWw+vUBvHYkiJQdlOlz
    oKOCwhWr2mMOgWuO8SYCP4YJIkc3vuAhoeaMz8l6TFJF+crZL7/mEm8kXDBcw/lE/plnrG
    46RL/blRI5VsoIEANZu0nqf7R5zfW1wjmL0BEKCpwFcEepSapFZMCTeKcUiZ38lYV5EHAA
    ZGqKBmfzff1sZYt3oNvB4UygsfW74YfkDS6Xk1AetQFs1ugPVjqlc0pAsR9g
X-ME-Proxy: <xmx:2O5KajU0Uw6xNS_WrI7zb_5qs_48gK_LPEot85WiNOCy2M48dUO8RA>
    <xmx:2O5KakAz9DkQNoARaK9vvDUhU4tVKRl0a1rlEttHGN8E7wEZsOe7iA>
    <xmx:2O5Kav3B8rX86X9pOEr7VyWVVKbFO9ypfv_0qbtwimzVM6OkPvXcbA>
    <xmx:2O5Kau21VzRS3y8JoGyhIC03LB72_N0iTjlTzwKC_R5EWB8VNvGgbA>
    <xmx:2e5KaofIyjfiBf1bM9S7pHDVHl_enoTXVpPtIqykE1C-4cDIN5gkr-97>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 19:55:00 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 0/3] VFS: refactor lookup_open and add vfs_lookup()
Date: Mon,  6 Jul 2026 09:45:59 +1000
Message-ID: <20260705235447.1322365-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this v2 I have:
  - added reviewed-bys to 1/3 and 2/3
  - added EXPORT_SYMBOL and WARN_ONCE to 3/3 as suggested
  - changed vfs_lookup_open() to open non-regular files as O_PATH.
    This allows the caller to see what was found and to return an
    appropriate error code (different NFS versions have subtley different
    error code requirements).  Because of this change I didn't include
    any Reviewed-by in 3/3

The series that prepares NFSd to use this is at
  https://lore.kernel.org/linux-nfs/20260705222032.1240057-1-neilb@ownmail.net/T/#t

If this can land in a stable branch, I can ask nfsd maintainer to merge
that branch and connect the two series together to hopefully land in the
next merge window.

Original series description:

My recent proposal for inverting the order between inode_lock() on a
parent dir and d_alloc_parallel() missed that fact that atomic_open()
has two callers, and would have resulted in easy deadlocks from nfsd
when re-exporting and NFS filesystem.

I think the best way to fix this is to provide a richer interface for
nfsd to use, which includes all the locking as well as inode_operations
calls.  This allows the nfsd behaviour to share more code with the
system-call behaviour.

This series refactors code between lookup_open() and
open_last_lookups(), and uses the new lookup_open() to provide
vfs_lookup_open().

 [PATCH v2 1/3] VFS: move mnt_want_write() and locking into
 [PATCH v2 2/3] VFS: move delegated_inode retry loop into
 [PATCH v2 3/3] VFS: add vfs_lookup_open() for nfsd

Thanks,
NeilBrown
