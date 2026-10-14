Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6CD4DE725
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979297; cv=none; b=jacp1oD31gMaLfPsV3i0VhfZZErklJMuRFyBMRSi408Xeq/m1HCVHrN9cgmCe8mEU3V7X29Oq9Wr6ZM7VyLOOpOMuSg+jUqXCSC/osKAq5SFlomJo/TIzkUBsWnlmrtxaUhWVwc9ZtwKUzaX5YIMWYiBtU8sJYS+C6ouEra714E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979297; c=relaxed/simple;
	bh=Zwn256Ky/WnnhO/fkv1WyvwNXZkV0GXvgW7t9VZ79nY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7ypLzqhED7n7jN+iICUjc/Y7dfwKAMT6c2VZP6AbZxnrZ4TDsiI1LLKHf/1XoDekjODzSBOaq/fPdUnfYeX5q0eSgjCT3NbgLOXwAJyo/oGumeVRNbloZaajF/H+e8+/xTn5W/XNisFl+YCW2qyYqXtpxLw6cNmaMpKB9LK3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YONBzkld; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YONBzkld"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791979294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zwn256Ky/WnnhO/fkv1WyvwNXZkV0GXvgW7t9VZ79nY=;
	b=YONBzkldUALfuS0IJ+yzUE9K2sA67IoOaQYMFb0CZVW2QKbmnyZfTPDI2es7sortmibRa0
	Snfz6EsZ9VIfEsA9Mu25blIc6lnTUDggDnTaJblTpusewc/U588YiNAncSNM/5VCasEN7P
	Ji/yjT8+ceHAucljGes7DKIFFTkjsQs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-9hsYaD-GMH6E9s7OscVXwQ-1; Wed,
 14 Oct 2026 12:01:31 +0000
X-MC-Unique: 9hsYaD-GMH6E9s7OscVXwQ-1
X-Mimecast-MFC-AGG-ID: 9hsYaD-GMH6E9s7OscVXwQ_1791979289
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C6A61955F14;
	Wed, 14 Oct 2026 12:01:28 +0000 (UTC)
Received: from onestero-thinkpadp1gen7.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 83756362;
	Wed, 14 Oct 2026 12:01:24 +0000 (UTC)
Received: by onestero-thinkpadp1gen7.tpbc.csb (nbSMTP-1.00) for uid 13628
	oleg@redhat.com; Wed, 14 Oct 2026 14:01:28 +0200 (CEST)
Date: Wed, 14 Oct 2026 14:01:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: w15303746062@163.com, David Laight <david.laight.linux@gmail.com>,
	jlayton@kernel.org, chuck.lever@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, alex.aring@gmail.com, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs/fcntl: fix SOFTIRQ-unsafe lock order in fasync
 signaling
Message-ID: <as9vE0quEcL3_5Ke@redhat.com>
References: <d15a25fe784b5d4449c7ce4e56f1428d7ff28885.camel@kernel.org>
 <20260523135210.590928-1-w15303746062@163.com>
 <asI5Fn87_SoEd4G5@redhat.com>
 <asuxzwl4iWjjEjRD@redhat.com>
 <437297ff-1bb4-49a7-a979-abccdd1814f8@stu.xidian.edu.cn>
 <asz_NnX9_KaJdaf_@redhat.com>
 <dbf95fb6-1685-463c-a533-79024d7a0a18@stu.xidian.edu.cn>
 <as0K5CT8IIaCWsfR@redhat.com>
 <as0Z302oRQpI7rgX@redhat.com>
 <94ee706b-f7b7-4d7c-b094-a6fc9b9174b4@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94ee706b-f7b7-4d7c-b094-a6fc9b9174b4@stu.xidian.edu.cn>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 10/13, Mingyu Wang wrote:
>
> Hi Oleg,
>
> In the scenario you described, the tasklist_lock reader holding
> dev->event_lock is in process context. That explains why the
> interrupt-reader handling does not rule out the possible deadlock.
>
>
> > perhaps it is time to add pid->tasks_lock or abuse pid->lock we already
> > have (we would need to make it irq-safe) but this doesn't look nice...
>
> A fix also needs to preserve the synchronization required for process
> group traversal.

Yes sure. send_sigio() (and other users of do_each_pid_xxx) should take
the new lock instead of tasklist.

OTOH. It would be really nice to not send signals from irq. This will
probably allow to take signal->siglock without disabling irqs. Same for
write_lock(tasklist). So _perhaps_ it makes sense to change send_sigio()
to offload the actual work to workqueues.

But this is the more distant goal, we need something simple for stable.
I am a bit busy right now, will send the patch in a couple of days.

Oleg.

