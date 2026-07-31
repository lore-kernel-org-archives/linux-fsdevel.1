Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5955242BE88
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506865; cv=none; b=M+3Q/m4dOL5DtIBZr9J5Jfcu3nmRaLCl1DrdiD9eiT6Qd5gq2Lxqv8WA1Kej287781EHGKU7s0QBmHGTaVLmzhpYVZ6NMxYv50wegL3qgQviAxaUIEzLyakplJaJqvBfnyrPdise6Ouk+n+RtO4dbqLzCNoYai+EMfB+l6O3s4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506865; c=relaxed/simple;
	bh=ZjvCaTm2EqthK1AMWFaApweT0SI1lxky39mY41z7+zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ8Dm/R7+dUMSaz5lHhKdLNQ6poJOXdf0yTN0NhOXFoVTa9TMqrim+JGIjalW+MBe7zYuVSNDcMntbvToFYLchIRQ2enRA0xDqKff6Cev8AgQ+FmN1yRQSN3Pmp5MG7uv8+cnTcNDwrhQhYJmBQT3qC/19U/awJeOdu2SXzUHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3he0FiI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3he0FiI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785506861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjvCaTm2EqthK1AMWFaApweT0SI1lxky39mY41z7+zM=;
	b=M3he0FiIgZZJDgjhxV8nBLev88JF4Nzotn22SuiNjCi2Vd0Jhzaecd/cuF81bOFcuQCUu/
	I8VHI0nvRXLH+5i7vNdOeB+nkJPVj/CfUWvtILusU+bWBozr3aN3QWzbI6jomZLst7rZiJ
	12JFb6pDBSqiUoCUqk1yIJRznm/nxw8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-sVugMoitNhKVUbEeoRwQUA-1; Fri,
 31 Jul 2026 10:07:35 -0400
X-MC-Unique: sVugMoitNhKVUbEeoRwQUA-1
X-Mimecast-MFC-AGG-ID: sVugMoitNhKVUbEeoRwQUA_1785506853
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AAE11194511F;
	Fri, 31 Jul 2026 14:07:32 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7C91441C;
	Fri, 31 Jul 2026 14:07:28 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 31 Jul 2026 16:07:32 +0200 (CEST)
Date: Fri, 31 Jul 2026 16:07:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Breno Leitao <leitao@debian.org>, Mateusz Guzik <mjguzik@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v3 0/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amysHlZp6f6q498X@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
 <amueLRM-DrYbnjLn@redhat.com>
 <20260731-blechnapf-arten-blasorchester-4e05dd1b2c58@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731-blechnapf-arten-blasorchester-4e05dd1b2c58@brauner>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 07/31, Christian Brauner wrote:
>
> > But then we should name it "epoll_or_io_uring_pseudo_edgetrigger".
> > See the test-cases, they demonstrate the same pattern.
>
> Wouldn't pseudo_edgetrigger be sufficient? I think the comment as you
> wrote it is ok.

I agree with any naming ;) even if I personally don't think that "pseudo"
make the purpose any clearer, but this is minor.

It seems that Linus doesn't really like this patch "in general", lets wait
for reply from him...

Oleg.

