Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F42633BBAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819586; cv=none; b=UO/v+Kd74U4NVSXOi5zBZhBFoKcrRLEA7G8mQMlJZIqgXDr/2oiDCOE1HPxjRirMyvk4mZOouiFMfMFtMkPbl9SP/TrxRhr0qPMh0nAV2kRW8LNbCwb0JS9zjLbYkZGXgZ/3YANOeGd2loVW/hXzmxXrod0znTPsGzNBsbKVjIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819586; c=relaxed/simple;
	bh=2l2DLVa1PeXlyHJE1c7nWN3mmaGpOwkWkxtVnG11bXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5fWlHQmtQcAsjGANhMNbc4rLI6lVkkynLvA85uUzLyL+Dd2mrvC9Oe0jWUAsI+lYs6lSHfCaqHiLlzkyqvzhs/IS2ZXmbrU5huud8x9XoiBC2VIZdJYGqFbUUkuclJ5zd8schArYqk4/bHQC6XG9hFepGCvY9l1J/3/1YfIn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcZVQuTQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcZVQuTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791819584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yypxGPlx55QH0pYdP+VfNSAu253l74EUWhcjDK+UzYs=;
	b=ZcZVQuTQ1R5bAWXWBfWpz4PNSrIfXqpssAiJt6IJ++v6UnulLAAZyD2cE182xSY/E7G2q7
	VwpN5JzwO6crAdhz0fANPAmp46FKujv7VuZ4ttj0s3vro8cyzpT+5fN50Mh6BXgsMG+94f
	D/+CjIf/1boZPdLklPYSfef4f67p1IA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-PQrBu5JWOXG9XuxiLztMdQ-1; Mon,
 12 Oct 2026 15:39:40 +0000
X-MC-Unique: PQrBu5JWOXG9XuxiLztMdQ-1
X-Mimecast-MFC-AGG-ID: PQrBu5JWOXG9XuxiLztMdQ_1791819579
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7244118021F6;
	Mon, 12 Oct 2026 15:39:38 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 93A3D1956053;
	Mon, 12 Oct 2026 15:39:35 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Mon, 12 Oct 2026 17:39:38 +0200 (CEST)
Date: Mon, 12 Oct 2026 17:39:34 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: w15303746062@163.com, David Laight <david.laight.linux@gmail.com>,
	jlayton@kernel.org, chuck.lever@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, alex.aring@gmail.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync
 signaling
Message-ID: <asz_NnX9_KaJdaf_@redhat.com>
References: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
 <20260523135210.590928-1-w15303746062@163.com>
 <asI5Fn87_SoEd4G5@redhat.com>
 <asuxzwl4iWjjEjRD@redhat.com>
 <437297ff-1bb4-49a7-a979-abccdd1814f8@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437297ff-1bb4-49a7-a979-abccdd1814f8@stu.xidian.edu.cn>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Mingyu,

On 10/12, Mingyu Wang wrote:
>
> In the original report, the task triggering the warning was in process
> context, through a TTY ioctl. Here are the relevant excerpts; omissions
> are marked with [...].

Thanks... so according to lockdep we have the

	&dev->event_lock --> &f_owner->lock --> tasklist_lock

chain. At first glance this suggests that kill_fasync()->send_sigio() can
be called under input_dev->event_lock. But I know nothing about drivers/input,
so I can't find who does this...

And,

> input_inject_event+0xa4/0x3b0 drivers/input/input.c:419
...
> kbd_bh+0x23c/0x310 drivers/tty/vt/keyboard.c:1244
> tasklet_action_common+0x25c/0x3d0 kernel/softirq.c:925

means that ->event_lock can be acquired in softirq context.

That is all I can understand right now. Can you can send the full full
report without omissions? Not that I think this will help, at least to me ;)

Perhaps something like:

read_lock(tasklist)	lock(event_lock)
						write_lock(tasklist)
<Interrupt>
lock(event_lock)	// send_sigio()
			// ...
			read_lock(tasklist)
			
Oleg.

