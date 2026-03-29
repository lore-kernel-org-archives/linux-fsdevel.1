Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F829ACDD
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 05:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848533; cv=none; b=LR3XA0J/7w7Zl2Wy/dAf2ZJjjzTvlMeGjecjC7Ihc9uOc6f/42h+Xg3MNQSd4Fw7bpE31LY7BqhUVJDqxfW5rfgsS2QYcFqWn+4R2eI53BeRkBVSdQVRtgUtWNd3hJRdmn9H1NunYbFVoCEAfqGwR2xEyKWxueiLYqo64YTMs2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848533; c=relaxed/simple;
	bh=UHg74fPUE60i0m7SgJiXk6HCfOyT+f+6rfYMSXrYrbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/pzbqIoxVjA8eq8WXu4RnuAm2lru2fQDCdaVk9pFuS+2ZCLEjmUh/PquXQEbk1Z0OMYWNqqPS/0zanCNu4dXJe8It3/uvk1fVtSeSLpTFAev9QxoS0J9xel4kWu+c6rjWW5xgrpQUE9Xqfl9TgPAoMfxRIf4+FnsfXA/eQXf/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Wps2ELDK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sbduDEwi; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Wps2ELDK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sbduDEwi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C5241D00259;
	Mon, 30 Mar 2026 01:28:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 01:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1774848530; x=1774934930; bh=EBFI6r5Qkt
	4nZRfWDzwHI/Ixh90ZB4dkuoo4cQQg8EM=; b=Wps2ELDKpitkkxO3C1eaqXRrh7
	THB330Pg+5sD7oKULoSi43ZBRZzuANlOQrUwiWIus1vbh9VpEZv6ERpJLnH0Haja
	2YcPfmsqd6KdRakJ3DAd4egWFN4OXBJy6O5eMhKyl9ZEDRh0fGoqmzk3r2Nkq7PT
	y/hkk84okSe9UV1ukGMfLrLHT9L5LVm61Wgvqm8p15KSnk3lQas+kV6SOjIe0hxw
	giARGnw0wgQ3nFxdKGa8edolz4QrtQy7Ek1Y5kG0BrPO3weZYfZFsFVbOR1AKapd
	ewZZ9kPhbvHzA0DsV/zuviSBiaj1NZXpUsRUBrRprPj96pR6Od5GM7A3MfRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1774848530; x=1774934930; bh=EBFI6r5Qkt4nZRfWDzwHI/Ixh90Z
	B4dkuoo4cQQg8EM=; b=sbduDEwieUL501ggYxFLSP8occ7bp7+hieoUu8IT2brw
	tVTclEYcG25YQd/E28puLfQyoZDn18sntW3s789LLUJab5npb+ihX0a0lVqX25gK
	4invROXpJuCzK9uOyHD78g79HEffhGFvcnB3RseLmhCu/oKZjWCIf1vZxfCkHwWG
	3lTMTmJY7MirYcBJPME+kLQlA8YHHBSbiz9NhKvPI1I1NeVffg0lDzJgNSrRXK1f
	ub9fw+gQ/v3N6uMU/h69WyYefC1hvac18P8xpgxS6niXHJ9dGAQaOR2GWRH4MmfR
	1F9eUcScgIhYBDJbGGljb0JI80YAmOLvz6uxr+iUzA==
X-ME-Sender: <xms:EQrKaQ37rgLTSH5U5JuBafhO59HzfX46-4bN5_Nmd8XKvMJH3t5h6w>
    <xme:EQrKaWjgoF5vfXcgm8kV70iEe-aqLmDAXyjkainhdTJtEnke1dkZvsnfd284Qyq1-
    XjBkRrpfSr5B1PUUgMU4YSFuPnbGWadIIL2yWC1Pa9h5PX0>
X-ME-Received: <xmr:EQrKacYP6Gu0RoZn50347EYshjirvbCL7t5zCVCLnuUhpBZZ89AwF80XbZzv9A4df_DcUKm4IrO3NbWQKbzuvgJEIZry9jE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeekudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepge
    etfeegtddtvdeigfegueevfeelleelgfejueefueektdelieeikeevtdelveelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtph
    htthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepsghrrghunhgvrheskh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EQrKaeSBr8kE2tw86O3NEHZKTlGhAgNRKD3vmRcwLTZHDtsViUozXg>
    <xmx:EQrKafS4r6cApE6xE-9Bz2lI6PA41i-CgrR1gojaBlyNp6w_jPU5Kw>
    <xmx:EQrKaSQijuQEhdxIbKo-O4rsYFw1T50Icm2gvqmcKBrTQ7dyug2zNA>
    <xmx:EQrKaU6edun4uO6wooVEuRUUcyapfXdks881v4sL9OPZFj47iA9WHw>
    <xmx:EgrKaTmXY3m7gJDnodu0URWuC40YzkGJUFo4JBvFk-vuY4VDsXi2GXXZ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 01:28:48 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/4] VFS: clean ups and simplifications related to name lookup
Date: Mon, 30 Mar 2026 09:46:35 +1100
Message-ID: <20260329225603.2177730-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

 while we wait for Al to have time to look at my previous large patch
 set, I wonder if there is any change these first 4 could be considered
 for the next merge window.  That would then allow me to work with other
 filesystem developers to get the simple cleanups done.
 
 I think these are all valuable in themselves even if the larger changes
 I want need significant revision.

 [PATCH 1/4] VFS: fix various typos in documentation for

   Simple documentation fixes - nothing new.

 [PATCH 2/4] VFS: enhance d_splice_alias() to handle in-lookup

   When I submitted this some months ago Al didn't like the fact that it
   transparently handled various sorts of dentries and wanted
   d_splice_alias_hashed() or similar.  After some consideration I think
   this concern doesn't match current VFS behaviour.

   As outlined the in the patch description there are various
   circumstances where an inode_operation might be called with one of a
   selection of dentry types.  For example ->atomic_open might be called
   with hashed-negative or in-lookup.  For an atomic_open handler to be
   able to work with this it is best served by an interface which will
   accept either, rather than being required to pick an interface after
   testing what it has been given.

 [PATCH 3/4] VFS: allow d_alloc_name() to be used with ->d_hash

   This is a minor improvement and will only allow one other uses to
   make use of d_alloc_name().  However I believe that improves
   uniformity and will ultimately lead to simpler clearer interfaces.

 [PATCH 4/4] VFS: use global wait-queue table for d_alloc_parallel()

   This simplifies an interface.

Thanks,
NeilBrown
