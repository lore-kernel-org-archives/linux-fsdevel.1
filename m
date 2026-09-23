Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB66377AAD
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177344; cv=none; b=Rdj8HeDVBEFV3BC0kBNGjgtiH+36EsWDivqkQaL+eM6ndJ/nanD9ZdJNBr7NdkaHxMST6Z2lrTKYrVnEytG0WHRsXUnI3/QxJ8wMwsdLT95UDRVEJCzSnG5q2TeAzQ+dvh8b4RWSz7ec0BDoFlNIugmfVIX9w7o+5nUMZrHdEO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177344; c=relaxed/simple;
	bh=tOJkLq+HNuS6juPkhoS8yqU3aY80j4xcVNaxJOcp8iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOrKCb2VQbKWfuFqDJWTgyLicDTsEalqECer/Gq9rs314PNh8If7y5erQow8GPRY5hbVXeqFD0xi3BweSHCXZuEtOSsk3tEYHhpKJBTInc0beS7/m9EfAmAVmRKWBRf5OQ1QADoF883jI53bQqEf2Mmnhc63/Ukx9tqmHFzp3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaTursMw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaTursMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790177338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tOJkLq+HNuS6juPkhoS8yqU3aY80j4xcVNaxJOcp8iI=;
	b=OaTursMwWwhJ0fgJlqcmI5Ou27q+DV9Mf5rRPcCZ9srzCCwX9NcN1s7m5USeW7PeU02OV8
	pcwrQHVl50Wj5j6RJVMVB8xRrw2HrECkvzvHerIB8hUPWdJyOk9jRho/2ra1KxqNUQeN4s
	wIuG/8dmCRe7R8YNBTRfPwcFJgukp8s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-_-Zu3YKzNASVrQj6Hy_zfQ-1; Wed,
 23 Sep 2026 11:28:56 -0400
X-MC-Unique: _-Zu3YKzNASVrQj6Hy_zfQ-1
X-Mimecast-MFC-AGG-ID: _-Zu3YKzNASVrQj6Hy_zfQ_1790177335
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8538B180215C;
	Wed, 23 Sep 2026 15:28:54 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6EB0E18004D4;
	Wed, 23 Sep 2026 15:28:51 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 17:28:54 +0200 (CEST)
Date: Wed, 23 Sep 2026 17:28:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	NeilBrown <neilb@ownmail.net>
Subject: Re: [PATCH RFC v4 12/18] coredump: replace the startup completion
 with a thread count
Message-ID: <arPwMkaWVPLAnlPW@redhat.com>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
 <20260910-work-coredump-unlock-self-v4-12-a5c1800dc930@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-work-coredump-unlock-self-v4-12-a5c1800dc930@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/10, Christian Brauner wrote:
>
> coredump_wait() sets core_state->nr_threads to the number of tasks
> killed and waits for the last thread to enter coredump_task_exit() to
> signal completion. Let's just wait on the count directly. The exiting
> tasks can use atomic_dec_and_wake_up() and the dumping task sleeps in
> wait_var_event_state().
>
> The dumping task must remain freezable since commit f5d39b020809
> ("freezer,sched: Rewrite core freezer logic"). So keep the wait
> TASK_UNINTERRUPTIBLE|TASK_FREEZABLE.
>
> Drop the completion and rename nr_threads to threads_remaining.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

