Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12AD4CF477
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792252170; cv=none; b=IPVVC+ahgbqyNbBxMK0WbjCfre1vJLMJ9sEf4Jj1FWEYWCLVIwXregOKgSFHkTXEUODyFUPAAVSNElsqIZkflmkJOX88mbsVlm5K/zIRbioqa1tULLj+iOHcuRJRF5Q11+wW91hwyN5T83+exCB7r6SweHx5oJp5aCWS/bhD/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792252170; c=relaxed/simple;
	bh=TsYyDauOj0q/EW5pxmxonBE+b3Sfq0x0+kwcBo3WqF0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=baZMhXwWHAqm1+hbaAq/Y+6+RyCtyivE9RH0zz8W2Xo2Kti/I9XZgiQcdBWxVc6JQ3o4dGaBaLcrFoa3CYT+IX10gG7+wtmcnCybenEn/W7Gytl9iYuNXZ1pWxlDukbnAbax37cQmLHdzi4sUKbJJhf6g4Bb9/HoiW/tOLgkrBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOXirwED; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOXirwED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792252167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=R69PGyadI6wjWvrcco2cOdeAx/AQ18vsIO4SG9pdEoM=;
	b=eOXirwEDYIDy3Y+2LZpKSl+ovBKE358xZv4A2nuc+7Ptg8x934dxxuARXCYuly72+xGrRQ
	yWMvsrrkr5vqkBInHc9x7A7uvf0jxdfSPamxx5o9N4Da0w/07AVB0lPosbzIMK39MLsptB
	J5q0L/unu1AkjJM82g0xO/WMsTlUnqg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-nYDyi_5AMBafLWPrOfTphw-1; Sat,
 17 Oct 2026 15:49:21 +0000
X-MC-Unique: nYDyi_5AMBafLWPrOfTphw-1
X-Mimecast-MFC-AGG-ID: nYDyi_5AMBafLWPrOfTphw_1792252160
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAA8C195604C;
	Sat, 17 Oct 2026 15:49:19 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B6C241803A40;
	Sat, 17 Oct 2026 15:49:16 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Sat, 17 Oct 2026 17:49:19 +0200 (CEST)
Date: Sat, 17 Oct 2026 17:49:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	David Laight <david.laight.linux@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: alex.aring@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] add pid::tasks_lock to fix send_sigio() and send_sigurg()
Message-ID: <atOY-5ZjqVTQw2JE@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Not for inclusion yet, just RFC. In particular, I'd like to have
a review from sashiko, I am sure I missed something ;)

Only compile tested, the changelog is obviously incomplete,
__change_pid() should die after this change, etc.

And. I am still not sure that the new lock should be per pid, perhaps
a simple global lock which aligns with tasklist makes more sense, it
should not be contended too much.

Please comment.

Oleg.

 fs/fcntl.c          |  4 ++++
 include/linux/pid.h |  1 +
 kernel/pid.c        | 24 +++++++++++++++++++-----
 3 files changed, 24 insertions(+), 5 deletions(-)

