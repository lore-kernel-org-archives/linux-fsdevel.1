Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D203D75AB
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785495900; cv=none; b=butyW5tl6QiKNYpStdbjDKQ8WQNEH9HPctCXweKzifJ7ydR3Byp2th2AVHQ6f0jowsqT1/N7mNud3Z71iUQkO/nCpb7FzMhVOmYGkUJckz1rc/0eUI1J68RtaTsQQsEU+FuT7K/9dmqv/St5ap0bEmHgu3QyjD5J6tb/J8Tj7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785495900; c=relaxed/simple;
	bh=MMABK9mRgLJTa2/meeGDQJpIYoVKbZ21HTSr9Q6Tlug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOhPco4A6h45ZbVR36srqKIrBUF4/3NYYJQyWsLwu11XUBciytaWlYubpbO/w62RweEaDmqzBN7OKxz2xDr/sTeOZuOKE4//L4en7oE/WbHEd3x9CrI5v8WoHm4JyGLXO103R3byJRbZ8ORIKOSkek7Nw6bnBrwgCwgBd5H92eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQvYLv3R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQvYLv3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785495898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MMABK9mRgLJTa2/meeGDQJpIYoVKbZ21HTSr9Q6Tlug=;
	b=eQvYLv3R2kLPwW+2gzsATKY60orq4pQhy79RW2twCYiLed7PKIm1SPyYx1X28Qe5F8w5UO
	c0BSBnIFyFAPK2R2Eel2BeiASwbvgLEGR0nraLndSDb/O12caMImf/VI0sXlvTnb46rRpO
	T1MgXTMUMMtUJyuiCutKpro4pDW6pOo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-icc34zekMa-ByLClSQ11GA-1; Fri,
 31 Jul 2026 07:04:54 -0400
X-MC-Unique: icc34zekMa-ByLClSQ11GA-1
X-Mimecast-MFC-AGG-ID: icc34zekMa-ByLClSQ11GA_1785495893
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2923D1956096;
	Fri, 31 Jul 2026 11:04:52 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0AEA619560AB;
	Fri, 31 Jul 2026 11:04:47 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 31 Jul 2026 13:04:51 +0200 (CEST)
Date: Fri, 31 Jul 2026 13:04:46 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amyBTv5Qm3-5iAGC@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <amtbxpqJ3pZwyT8D@redhat.com>
 <amteY30qxRuPzFh3@gmail.com>
 <amth6owVUdVOmyAL@redhat.com>
 <CAGudoHE=GjMRKGbip8nRUm34VUud_YSqGZJrfr+Vz6Qu22Mdaw@mail.gmail.com>
 <amu1i8rzQ3hZ-vAu@redhat.com>
 <CAHk-=wiUWQdiHbH9s4XKnYZwRs5vR1Azq83V4scN+N-w-VFRng@mail.gmail.com>
 <amx81MSmqiWfagRY@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amx81MSmqiWfagRY@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sorry for noise, forgot to mention...

> The only reason that ugly hack exists is because we did have that
> break user space. If we can get rid of th eugly hack for io_uring,
> that would only be a good thing.

Perhaps, I can't really comment. But it seems to me that in this case
it would make more sense to change the logic in io_uring/ rather than
in pipe_poll(). And this needs a separate change.

Oleg.

