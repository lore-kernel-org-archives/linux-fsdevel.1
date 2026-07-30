Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E7639BFEC
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443744; cv=none; b=SvFJA/lLd+priaIfcepDIEDXQp5S4xOsROMbdnLbIdqprvWs6s4BTE8PLO8KrGmlshGlxVPmicxkQukkyLvWD8GJpOOfgEZAOz2M4YkV/Woz0ZNaah0JLz32Cgm2ILdCpqV94pq2ZyqbU20sOVFxCJBoEMpAIqMcfYuZNqmR6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443744; c=relaxed/simple;
	bh=zBCRRN2sWVo2r37jQBk4RKlk+khTg2FJPpvVcXxrxcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIV/apn9sMKf1xhsTPDz8M7w0Gc8trX6MpG4YbTcfgYrVuiiHkNrCsG60EFSs5Jq/MXWMRpYhijA4xaE+OhTiYDqLIkZQ/Bd5U+/FaYQHiqyFJmapAWR2bhChtxMhlRU6YuaAoMC1AvegYT4f1Etj3Yy7ypatHzJi0nZS0XtUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EXUba4QT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXUba4QT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785443738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBCRRN2sWVo2r37jQBk4RKlk+khTg2FJPpvVcXxrxcA=;
	b=EXUba4QT/SAsnJg8hEZPs2e/mG+L0sURGczDxfSA1xAw+Q4iW6Si8shQGSei88LWCUfDjT
	CFpTUcvF1aJO2QpxPv8YsZbhpS6x8V7xpWO6lyZdjd2k+6n+4WRC34qztDAJIood0USuEV
	twhQflXOzwKV3XmElVNs7pMhswX1DSc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-Z4Mu8WJZPSqgt6YfMC9tYg-1; Thu,
 30 Jul 2026 16:35:32 -0400
X-MC-Unique: Z4Mu8WJZPSqgt6YfMC9tYg-1
X-Mimecast-MFC-AGG-ID: Z4Mu8WJZPSqgt6YfMC9tYg_1785443729
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D75719560B6;
	Thu, 30 Jul 2026 20:35:29 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0584B1956089;
	Thu, 30 Jul 2026 20:35:24 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Jul 2026 22:35:29 +0200 (CEST)
Date: Thu, 30 Jul 2026 22:35:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amu1i8rzQ3hZ-vAu@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <amtbxpqJ3pZwyT8D@redhat.com>
 <amteY30qxRuPzFh3@gmail.com>
 <amth6owVUdVOmyAL@redhat.com>
 <CAGudoHE=GjMRKGbip8nRUm34VUud_YSqGZJrfr+Vz6Qu22Mdaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE=GjMRKGbip8nRUm34VUud_YSqGZJrfr+Vz6Qu22Mdaw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Mateusz, Breno,

thanks, I'll try to think about it later, but...

On 07/30, Mateusz Guzik wrote:
>
> On Thu, Jul 30, 2026 at 4:38 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > What exactly do you think the comment should say? I agree with anything in
> > advance. I thought that "edge-triggered" provides enough info, but I would
> > be happy to improve the docs.
> >
>
> how about: There is userspace depending on the extra wake up, see
> commit 3a34b13a88caeb28 ("pipe: make pipe writes always wake up
> readers") for details.

To me this looks confusing.

IMO, the comment like this (with the reference to the commit) would make
sense to document the unconditional/undocumented kill_fasync(fasync_readers)
in anon_pipe_write(), this SIGIO is even worse in some sense and I would like
to discuss it another time ;)

But as for poll_usage/poll_et... We have the established API, and (afaics) it
works as documented. It doesn't matter if EPOLLET behaviour is good or bad.
We only need to document what ->poll_et means for pipes.

> > And the helper's name? pipe_enable_poll_et() ?
>
> perhaps pipe_enable_epoll_semantics()?

Again, contrary to the current comments this is not Epoll-only...

Oleg.

