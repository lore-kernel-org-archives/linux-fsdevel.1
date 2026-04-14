Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19023330D23
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176819; cv=none; b=GlXuDHXflk7QLILDebGraoPFy1mRSbYERU1Z121cl858UYaUBg3BkxKQdT0mNiyPILoFnH5PEdjC+PJZ3FWrN+iPzrw/ATL9PnlEbSPScAxy0WoJWJn44105iR7tGgg8gMc2RQ94SpFHhJveIMMP1e7U2uy0a/qUPDCnuq4hp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176819; c=relaxed/simple;
	bh=+H9mi7rjt0jbpNyeuoae40N7EuIzbnZ5ig1DD8SUa5U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=F9v/WjkdA3HEnMOZ/M5lL1tsPcg5r+57oBBK811PtOT8PuXifTCZj8Xy0XxLb5WR6Iz7iuDqK5dbmHaX+dz5p6H6kIavXrw46OH86CEQ3wttFwv8uzhJlt2AlxRsHJruEr64DODoIymFrOqL3sdFKRPNtB8PiEKkGCU+HpN4YVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=VeVkjaQy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E8LRRLJL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="VeVkjaQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E8LRRLJL"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 6AA60EC01AE;
	Tue, 14 Apr 2026 10:26:57 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Tue, 14 Apr 2026 10:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1776176817; x=1776263217; bh=+H
	9mi7rjt0jbpNyeuoae40N7EuIzbnZ5ig1DD8SUa5U=; b=VeVkjaQyP9cCVDn9mi
	nmyGCFzq+iWbXDAtb1yYdKud3gWO8OIJTGqL9RsqeJRT4Qb9VCaR6qJ+AIVkGDNZ
	jQq/LJ3kL7rFfYUZcgLPMUaUAVtyEYHv16FM4hkdyizsOOdEaVCIG8gUja66i1+e
	deUuqpilhl1vRWZf/VEF79Gf7OpAPT1IfedIgtkM2fMowW9OTowW9tZKX8M2R1lK
	xqowkXbcxdo/fSKPuM2CXlLwTCVZytvOWlaX/1DQsTeFPxQwqIWsO5CH3bnv+As7
	Svi1Qb+RsgFUERAuvRvVeUedgpJV0dnEs68dRyuOWjnQLzg/6vBZcO0ekM5otRm+
	dZVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1776176817; x=1776263217; bh=+H9mi7rjt0jbpNyeuoae40N7EuIz
	bnZ5ig1DD8SUa5U=; b=E8LRRLJLobfwjPCFcZ8jlhy4+d6KndbMj+xtyiJdFWg6
	upiir7UEdIcNMzq+7wdjoiEOLCxQVaZk8XDxiFFUpbuiAH2Sv45wINQbjYiRuEe3
	SyFpOZPQeeWbMVmfTQjrsoXSQBEoUZylXmxgkUQ4I81xYjORHfq5vmEY6+OnkDc1
	edZ31INY8TlfRYH2a7psMqaFsu3cqtKZrpILiZf4hP4r/1fpLN7e8Et8NGlcrkEk
	CUpZjGyd/GdrghLfeZJWLjs/IMYi5pbXQsVMc/YFRox1p5mmxij9pSG2tfgzq89r
	AMUhxxWoz32Q+pa0hZPaNLZtHeVm1y9IFEE0GQcBnw==
X-ME-Sender: <xms:sE7eaY-XL6FvIz35u-N1bXd32sd25loJKLEpMDQWhvPh_nZAR3uOPA>
    <xme:sE7eabjV0Pgb_UFMl6W2A06gYOrgV-8rBegrJhH7sSEqlNtuWGtssUcKCeiJxeJqB
    2g4-J_QM3iylkpONqzHNkyeOmYCkgpCxM5MX6c41_DCT9D7ryyzZPM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkffutgfgsehtjeertdertd
    dtnecuhfhrohhmpedfrfhivghrrhgvuceurghrrhgvfdcuoehpihgvrhhrvgessggrrhhr
    vgdrshhhqeenucggtffrrghtthgvrhhnpeejffeugffgueeihedtgeefudejkeetudfghf
    egudekgeefgefgleduhfetfefhkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpihgvrhhrvgessggrrhhrvgdrshhhpdhnsggprhgtphhtth
    hopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushestgho
    uggvfihrvggtkhdrohhrghdprhgtphhtthhopehlihhnuhigpghoshhssegtrhhuuggvsg
    ihthgvrdgtohhmpdhrtghpthhtoheplhhutghhohesihhonhhkohhvrdhnvghtpdhrtghp
    thhtohepvghrihgtvhhhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvlehfsheslh
    hishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sE7eaWfMKF2C6HqL0ZGJ6xlXuoGbaAakk-vItPljCwbSd9J7H7p03A>
    <xmx:sE7eabKwJ6LNcIZ6uTsMPESWsWjiJ6jlFLcW8cdMNYLFFsrxDPnrEA>
    <xmx:sE7eaWiexgGa32qxWHPKd7HRW8qh-ZNkXVNLFmZlXudCmog00NpCfg>
    <xmx:sE7eaZTmkGqr4LLpwXMaLouz7odIREkAo_cMfRpFOLs8yPhQtfpYUw>
    <xmx:sU7eaRI8j-fv-rc_3n2BSA9_9uLJDiAOZCcQiC4tWsDfLq1bVulgKSwl>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AC3ABB6006E; Tue, 14 Apr 2026 10:26:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Apr 2026 16:26:36 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 linux_oss@crudebyte.com
Message-Id: <c2c75b03-e95d-49f4-be9a-2429fde4b5fe@app.fastmail.com>
Subject: [RFC] net/9p: raise MAX_SOCK_BUF beyond 1 MiB for fd/tcp/unix transports?
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

MAX_SOCK_BUF in net/9p/trans_fd.c currently caps msize at 1 MiB for the fd/tcp/unix transports. The commit that introduced this ceiling (22bb3b79290e, "net/9p: increase tcp max msize to 1MB") noted that a further bump would need the allocator moved off contiguous slab chunks.

That prerequisite appears to be met now: p9_fcall_init() in net/9p/client.c uses kvmalloc() when the transport sets supports_vmalloc = true, which fd/tcp/unix all do. So the original slab fragmentation argument against raising the cap no longer applies to these transports.

Before I put together a patch, I wanted to check:

1. Are there other reasons that the 1 MiB cap should stay?
2. If a bump is welcome, is there a target value you'd prefer (e.g. 16 MiB, 32 MiB)?

Thanks,
Pierre
