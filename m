Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D449482E
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177316; cv=none; b=Tjwfvdb8pRX6sTarRGgx77MQH4+7dDlqFVJw0619UYS7j7PMU5Z8lzuWmYHC3FXPzGcXzqcXzzG8tB9p4H7hgpjt4Rcg5y4H+MS4KqQ2WKwyf4iZlry5OkANzoVnZQy6HtMJn58W9dkzfHwR9elZUIW9BkdWxwjKWKor/ShGMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177316; c=relaxed/simple;
	bh=kDU0KbwGcrQyU2gGwC2oBjSbqccjfGYEpiCDQ9VE3KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tB6rbOUGxKI+Wsx4AaiAjtL7j5/eWxCcp21fe6zH2i9l+HU8dANIzKYXTQ1j1EYBO97rhkDTOmrtYc7IkQeFAPU0+dZxCFUhrcwFYykSWbftlgoAF1tUfXKfR6EknUuPw6+k15tNNlCnmZ+Zj8uVNHjMJfcRarXhp9n9Akk88nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyEbNXyF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyEbNXyF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790177306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26iSn0X6DJ1DpDUEDDA5n63OQs+odsYTWpH/6dEjNJ8=;
	b=XyEbNXyFex9AqqrwQwsD+dDw6BdA5K+BO0Clzs+DfqFk7UWrM+TCPjnVmPeyvuR/8h+80M
	ejXIjs15WcGRBIO8hxyh2LLxPYT4UaMbwXmWvM9dXhZKnhxppO2gtZ+Hr84Jld5vkfr8pX
	ikvr+6E2+jJCpsMiY4X7RzbGwgzV0X4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-aFsPcT6mNrWqbKFW4G4wsw-1; Wed,
 23 Sep 2026 11:28:22 -0400
X-MC-Unique: aFsPcT6mNrWqbKFW4G4wsw-1
X-Mimecast-MFC-AGG-ID: aFsPcT6mNrWqbKFW4G4wsw_1790177300
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6D58196C401;
	Wed, 23 Sep 2026 15:28:19 +0000 (UTC)
Received: from fedora (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B59683000218;
	Wed, 23 Sep 2026 15:28:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 23 Sep 2026 17:28:19 +0200 (CEST)
Date: Wed, 23 Sep 2026 17:28:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC v4 11/18] sched: add wait_var_event_state()
Message-ID: <arPwD-0mnc30xmT7@redhat.com>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
 <20260910-work-coredump-unlock-self-v4-11-a5c1800dc930@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-work-coredump-unlock-self-v4-11-a5c1800dc930@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 09/10, Christian Brauner wrote:
>
> All wait_var_event() sleep in a fixed task state. For coredumps we need
> a variant that takes the state from the caller the way
> wait_event_state() does. This allows us to continue sleeping with
> TASK_FREEZABLE. That's certainly also a useful addition for other places.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  include/linux/wait_bit.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

