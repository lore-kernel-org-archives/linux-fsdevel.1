Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5E14DC552
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818312; cv=none; b=MrsxEYnR0XNoYzPr/cXfs7/xQunH3/Aw2bl41gWFN7Oo1DxMaNwzoiqv85EAE8DCvLs/v+mwD0Zr+lHF0eN8RVCIc4hPWJwCplC1COIuEeVA/mpc1y4s4RpVkRY1lwhl47dKX9safXnMJOUCYlYtMfZGLrLnHiO8cFThi3nu1Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818312; c=relaxed/simple;
	bh=RiYHdBAOUCPGodBTTOVTPPRqiYQwz245gjFO6kObSiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mWyO3waS8MY8a4Hdz/Yue6JsSo2n0JUutwxiFxnzdYIedJyPGNpkt9LqITene52x69eGa4vjDxwuGqyHPerzjWMu+6MJXcbY5QQgYgphYzflHdr/HxktMLsZK17R13htR0Lp+MB9er2+Xj2n+9BNO0sA9cEAA78Pxykk/oPhQEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzW5VIwA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzW5VIwA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784818310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=F1YNlhyY63AudvL4lGF36mOU7i7YhGfNHDDVIHqfgBs=;
	b=bzW5VIwA82ksn6ONxfIuiMg5rHX23R3oC2L+UcaplRf7BVi1c325gwqZICHQwvbzThm54l
	lf72MouLybyr6jjymGRxnVXVbVBMeb2NSOHrIusrylPARWmdEVJnxh36FhK18kAuOzXBm7
	kww5hMgGHq2qzJsEQp2l3zYNs8lpHs8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-xXq2uNY9Mp6mgpnCd63JKA-1; Thu,
 23 Jul 2026 10:51:46 -0400
X-MC-Unique: xXq2uNY9Mp6mgpnCd63JKA-1
X-Mimecast-MFC-AGG-ID: xXq2uNY9Mp6mgpnCd63JKA_1784818305
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED49B1977642;
	Thu, 23 Jul 2026 14:51:44 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4C2A9D75;
	Thu, 23 Jul 2026 14:51:41 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Jul 2026 16:51:44 +0200 (CEST)
Date: Thu, 23 Jul 2026 16:51:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when epoll
 is actually used
Message-ID: <amIqfCo25rLtM2U0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Breno, Christian, Mateusz,

To be honest, I am not sure this change makes a lot of sense.
But somehow the extra wakeup in anon_pipe_write() looks annoying to me.

Can you take a look?

Plus I'd like to know what sashiko.dev thinks.

I have no idea how to test it wrt performance...

Oleg.
---

 fs/pipe.c                 | 23 +++++++++++++++++++----
 include/linux/pipe_fs_i.h |  6 ++++--
 2 files changed, 23 insertions(+), 6 deletions(-)

