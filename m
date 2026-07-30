Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6635C688
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420727; cv=none; b=aq0nlW0hnYtDwTW9o/540M5d52NU2hiFmIKtQz7hvcZL9BLiJ9kYYaLKatFMNtDuFTioNV6wMCZ+41ey51BzOA/uXyqF/sQWIikN1DLmD7k4DGRF2JUsYk2ZliUj2TU2230jNAk4k3xFXNg6AJI86Vn72TogthivYSDDlMjqGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420727; c=relaxed/simple;
	bh=e0VdA06TjsVmax3Jqb13K3p5iSoDmpml5LluYvEAqzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nAj7+BtRQm5lQR4XMEE/AznyeM3qvlPPO6j9CNnn35QJb8ZcY2ADmcirirAmuDlbJM83C2ue4dy4ihY/l6nt89l2ZfnqCcVAjhxLD0+GGhQouxAGfkM1keuMviwUyzd9MIlpnDrKFx4EpROzevR7qellG1FqM2mqagbPGYzcI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7ZZet2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7ZZet2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785420725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5y4bQQi1jrzPqBlmyy5MgPN2WYUMYMqghCZfVFVwEMI=;
	b=F7ZZet2LPSlasn4KuBaVTxl6eOvB1Kge/qbjLZj0YgHUhEAGkq9nxtKqdcPSoNxJ7Ls7uq
	K4F2GEDhCnosITyVFqgoouUjvrFPS7X766IPdU7+PxK4Dv6RZ7acJsZajRcdYNnCliUwDw
	/WuHy4QgO6ElNdG0RpAd2lHa/Q0E04U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-woOGO1jNMPCIrsycvHt-bQ-1; Thu,
 30 Jul 2026 10:12:01 -0400
X-MC-Unique: woOGO1jNMPCIrsycvHt-bQ-1
X-Mimecast-MFC-AGG-ID: woOGO1jNMPCIrsycvHt-bQ_1785420718
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78498180029F;
	Thu, 30 Jul 2026 14:11:57 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 03CD4180044F;
	Thu, 30 Jul 2026 14:11:52 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Jul 2026 16:11:57 +0200 (CEST)
Date: Thu, 30 Jul 2026 16:11:51 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 0/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amtbpwrhlNGJ9OK6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Let me repeat, I do not think this patch can improve performance. In fact
I only hope that none of (micro)benchmarks will suffer, they are often
very sensitive to any changes in pipe.c

And yes, even if this patch is correct (I hope) it can expose the latent
bugs that were hidden by the extra wakeup, like it happened in the past.

But at least the comments should be updated: io_uring depends on poll_usage
"nasty semantics" too and this is not obvious at all. And IMO, the EPOLLET
check added by this patch acts as a documentation too.

And if this patch does cause a regression... I think we need to learn who
else depends on the extra wakeup and how; this is something we should know
anyway.

Changes since v2: renamed ->poll_usage to ->poll_et, and updated comments.

See the tests in 1/1, both pass. And both fail if I remove
WRITE_ONCE(pipe->poll_usage) in pipe_poll().

Oleg.
---

 fs/pipe.c                 | 15 ++++++++-------
 include/linux/pipe_fs_i.h |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

