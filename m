Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD88312815
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904887; cv=none; b=rk94CZ1b8yDci5Vh+eR2aWiEgEaO8RpEMqovH3heTf25/KHY3td3bzZ5G+3/f17OZ6fCrVHjU4Z2MjeeH35tk8qHHvXrKVzpjIyqhL2V+Gj0Za0XApS/ln9exPaEMPjjepbtC1O7G1lVT2HkoS9NAaBSrQCttG1JFAQOP+PNONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904887; c=relaxed/simple;
	bh=ws7pPM5pomNPXyeBV7gKA1VAwCIgldyhmLgZX26cbaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBr/RnXTeKPVQjcEhwulEznbo+AT8mSMsZSHk2XTRQoW2V09mO12Xgib6kk+yU96PVhGGlGuion6a8588nfIj0cQ3xC0SOd6dGsCNfjAJbvZgWo7AaHlwmvIuz9CR8gjOQ3JA5AU6RVFN0aDfoim6s1W4YnOMdDO8m9KB3tPP2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTbvACnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTbvACnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784904880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ws7pPM5pomNPXyeBV7gKA1VAwCIgldyhmLgZX26cbaM=;
	b=TTbvACnB1CmVpsPOoJfETpGUiZV4TQ1Zj5/cbQQQdH0gkLo+BEGV9ktYsRD4XWo4mKNvWe
	Rs7yJhOnBsXuHzMcCkgXXOFiODI1nhIPUQ4qOr5bWCNYXqGVXdKfYU0UzJpzNvIV+eEu3M
	Xd0S/7q4tn8+LklNs8HUFq/UDe1CRwQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-g4KwqMnTNcaYHYrg7zyxwA-1; Fri,
 24 Jul 2026 10:54:38 -0400
X-MC-Unique: g4KwqMnTNcaYHYrg7zyxwA-1
X-Mimecast-MFC-AGG-ID: g4KwqMnTNcaYHYrg7zyxwA_1784904877
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 399B1180ABE6;
	Fri, 24 Jul 2026 14:54:36 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 35E0215AB;
	Fri, 24 Jul 2026 14:54:31 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Jul 2026 16:54:35 +0200 (CEST)
Date: Fri, 24 Jul 2026 16:54:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
Message-ID: <amN8ppPXRiUdiVKM@redhat.com>
References: <amIqfCo25rLtM2U0@redhat.com>
 <amIu5WWgTNkdvqIz@redhat.com>
 <amNvebqiG2fH0W_L@redhat.com>
 <CAGudoHGiKYfF6L1yFy+QZgQaTt5ULnp6rgRaZE=6BANkpjrb7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGiKYfF6L1yFy+QZgQaTt5ULnp6rgRaZE=6BANkpjrb7g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 07/24, Mateusz Guzik wrote:
>
> On Fri, Jul 24, 2026 at 3:58 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > This means that io_uring depends on the "nasty semantics" too, io_poll_wake()
> > path should add the task work which calls io_req_post_cqe() every time the new
> > data arrives, even if the pipe was not empty.
> >
>
> well io_uring could set the flag as well in that case? it does not
> inherently mean random select and poll consumers definitely need this.

How? I don't think io_uring can do this. It doesn't even know if the file
is pipe or not. Only file_operations->poll() does know...

__Perhaps__ pipe_poll() could check something like wait->_key & EPOLLET to
detect both epoll/io_uring... Not sure, probably not, I'll try to check later.

Oleg.

