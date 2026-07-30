Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EA3451CE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 18:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437758; cv=none; b=HeR1+2DJA/8mdgBB2ZV9SP8gPL5q5nVLdYPDles/15c4uESqGsJnT0pZaZJ5qaD7JcPma3wLyVTMhu773pV3C4LSTMCfdH3iOiVnbDfWDEVz8GnmlAhqUXA2MXDKM9rXaRIptFBjwGtPqv8Ewsveite2vNYc9qMxNgAc5wGdXL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437758; c=relaxed/simple;
	bh=dl1rKl8N+PfRnV2OM93Q8FD6tKPbkYfGbZqm8os4mK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDVQZ7eY8PKniykXr5rwXhGO7pjAy4jjUTGz4x2kKKX52lWtmySDYZ8j7XTtrokQm/Ji8BcfmPAo2+G5Zwqggi1OwrHlN29+aRwABE1vBq8TlEd7K1Z39F7eLUeTkMU/cazW9CSXD8SdYixIL/Mj2/XOSt6DMODxoZo6vp3J/LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2Fh0JgK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2Fh0JgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785437756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dl1rKl8N+PfRnV2OM93Q8FD6tKPbkYfGbZqm8os4mK0=;
	b=T2Fh0JgKUnOm4UuNQD2BO7ghKmuU+x6jgs7NyJy/aSpzmoNVKC9Xv7LddG4JKuVnttRrhF
	d/7eTve0mAWuqHz8ORFXICB8jVO89TyW6l23JVfj3jl1wWIQrieOb7tr8UDZl1VmW9wN0v
	KIAXxF7it6qjsQDiWwxvdOSQkjnAUG0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-31ZFZ1xBNoaWe5ptHafRVQ-1; Thu,
 30 Jul 2026 14:55:51 -0400
X-MC-Unique: 31ZFZ1xBNoaWe5ptHafRVQ-1
X-Mimecast-MFC-AGG-ID: 31ZFZ1xBNoaWe5ptHafRVQ_1785437749
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 397C2195608E;
	Thu, 30 Jul 2026 18:55:48 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 60299423;
	Thu, 30 Jul 2026 18:55:42 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Jul 2026 20:55:47 +0200 (CEST)
Date: Thu, 30 Jul 2026 20:55:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v3 0/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amueLRM-DrYbnjLn@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 07/30, Linus Torvalds wrote:
>
> I like this patch mostly for the renaming, not because I think it
> matters. I think "poll usage" was a mistake in naming and doesn't
> explain the issue. That said, I'd go even further, and make it clear
> that it's not about "poll" itself - which is fine, it's about "epoll",
> which has that broken crazy bug where it calls something "edge
> triggered" but then actually wants effectively level-triggered
> behavior - wakeups when nothing actually changed, which is the
> *opposite* of an edge.

I am not sure this is a "crazy bug". To me, epoll with EPOLLET works
"as documented". Perhaps I am wrong, this predates the git history.

I'd say the very idea of EPOLLET was wrong, but this doesn't matter:
we have what we have.

And this patch (mostly) tries to document what we have.

> Pure garbage.
>
> So the real name should be something like "epoll_pseudo_edgetrigger".
> Because "et" isn't really helpful either.

I'd agree with "pseudo" simply because I can hardly say how could we
define "edgetrigger" in this particular case.

But then we should name it "epoll_or_io_uring_pseudo_edgetrigger".
See the test-cases, they demonstrate the same pattern.

Oleg.

