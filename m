Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B173F39D4
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155031; cv=none; b=BGjpZtancgUwsE5rZxVi/2py3gw3+O0hhz58pMdE/IYgFDE/aWshXHoASYrSSyd/iUchOtv5JyFeeqp050mzmgS9XR6Wqw62Q+HHlZHCidone/rC3pTqPyQeBtpJ44fcbdWPanIoMsa+MCm1rIptCRHejOWOo2QhDNKfL6MPbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155031; c=relaxed/simple;
	bh=DUUtSrPmvnC24rpmZ/lujXJpOLjCH18gyESzMsgcE7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MrxYco8hltKS99MP8956RbclS0QZUmjO/+T6RuYd6BgPes3g3Fzn/Gcs0rqG04Hnx1lzx+PvhnGCNFXWqiCgDx2AfxXfHSVmhNeUSA+9y36bC0mo7SbWx5sxWNxTGsnGc71P/aqKDoYrsJ6YOkFLAI73yTq9SQciMokD2SsTE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J15CI5ml; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J15CI5ml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785155028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=DUUtSrPmvnC24rpmZ/lujXJpOLjCH18gyESzMsgcE7c=;
	b=J15CI5mlC7o8SzCVBV5dqVCws6I/FpRvfIuCOryQsDBt45ITrHRolyX5Nsi2nxzzQbZlIu
	D8bTTeo6w6XFlkhj5tTJO+xQ24yiG2oXPKUGYSG0EqYQBnOofjclWObCPjYQR7XkmqpNQI
	2ZFjZJ+ZJkGXSrsbJy1Yy/dEt35Vw34=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-wFWNlJrFM7iDU5p8JYgBCQ-1; Mon,
 27 Jul 2026 08:23:44 -0400
X-MC-Unique: wFWNlJrFM7iDU5p8JYgBCQ-1
X-Mimecast-MFC-AGG-ID: wFWNlJrFM7iDU5p8JYgBCQ_1785155023
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C413E180ABF5;
	Mon, 27 Jul 2026 12:23:40 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 65E1B1800480;
	Mon, 27 Jul 2026 12:23:36 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 27 Jul 2026 14:23:40 +0200 (CEST)
Date: Mon, 27 Jul 2026 14:23:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [RFC PATCH v 0/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amdNxsTODR4MCl3R@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Again, I am not sure this makes a lot of sense. But I'd like to know
your opinion.

Plus I'd like to have the review from sashiko ;)

With or without this patch we need to update the comments to document
that io_uring depends on ->pipe_usage too. And probably rename it to
(say) ->et_poll.

tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c passes.

See also the test-cases in 1/1, they pass with this patch. And fail if
I remove WRITE_ONCE(pipe->poll_usage, true) in pipe_poll().

Oleg.
---

 fs/pipe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

