Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A393DB300
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707059; cv=none; b=EsifXjtAEy3QCBhWVITbpP/QzblwqKzx8py8H3j0L496JN7iSaMT3+qQnKokcl7d8MJZKst9X5kVfDK99ku6LpZrslNO8AncDCTr7VERw7/Zge8JO3Fbc0qgK2iLgZpEuK8xfi6kYqIi1gK6hvXmr/Dal+FE0oWbGf7rQFrM0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707059; c=relaxed/simple;
	bh=Vu5yG++Fsun3z+ZBMGUo/vK8Cs0yE9PE0k63+S7J9So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STMwgfrdX0Fa68mvN6UCpa8SsTnZYkvoeSMNQ9atLQ/TfoV7yWrXScOYFKXay1+D6nESwEng945dwyojplNeTtnx+VkqdBIy9qI6cBOQw1FQ0JgQzZqZnrcVmyywj5Y7IUpO9zRaYB2LrnV8M+M0WOmXqbpN9xmYsZJE/SthvWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvc3AK9e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvc3AK9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781707057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YX043t9gPavpfU+MHUkAn7xO12mke7Fw7RKJtVvD+Xc=;
	b=hvc3AK9efGvdjakrg1RhOn9/AJEJXgj5J0ozqRAWH4JFqqnNRSWF/+BlF+mSYxhcsmSAqY
	X3hRDcWaBpNQUucsTVzPdTuBvzVwsBVpTZazfS9QJbu3pEFEQ3KEP2qcQmp+QYoWwFH6F7
	71a1XxBYJg1Vpyzpjt18RxxGRyEIBE4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-7Mz_reY3MU28mx4luDUPGw-1; Wed,
 17 Jun 2026 10:37:33 -0400
X-MC-Unique: 7Mz_reY3MU28mx4luDUPGw-1
X-Mimecast-MFC-AGG-ID: 7Mz_reY3MU28mx4luDUPGw_1781707051
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAEDA1800A34;
	Wed, 17 Jun 2026 14:37:30 +0000 (UTC)
Received: from fedora (unknown [10.44.33.75])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B78861955BC2;
	Wed, 17 Jun 2026 14:37:25 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 17 Jun 2026 16:37:30 +0200 (CEST)
Date: Wed, 17 Jun 2026 16:37:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, Josh Triplett <josh@joshtriplett.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk,
	kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajKxJM5k9U5L05AF@redhat.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com>
 <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 06/17, Mateusz Guzik wrote:
>
> There are trivial touch ups which can be done by adding a bunch of
> predicts and inlining kill_fasync if someone can be bothered.

I was thinking about another change, see below. It assumes that in the
likely case another writer won't steal the pages from ->tmp_page[]
before we take pipe->mutex.

I'm not sure this makes sense, and I have no idea how it would impact
performance in "real" workloads.

Oleg.
---

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec57..9f07f469830a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -131,7 +131,8 @@ struct anon_pipe_prealloc {
  * pipe->mutex hold-time being shrunk. Any shortfall is covered by the
  * in-lock alloc_page() fallback in anon_pipe_get_page().
  */
-static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
+static void anon_pipe_get_page_prealloc(struct pipe_inode_info *pipe,
+					struct anon_pipe_prealloc *prealloc,
 					size_t total_len)
 {
 	unsigned int want, i;
@@ -144,6 +145,11 @@ static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
 	want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
 		     PIPE_PREALLOC_MAX);
 
+	for (i = 0; i < ARRAY_SIZE(pipe->tmp_page); i++) {
+		if (pipe->tmp_page[i] && !--want)
+			return;
+	}
+
 	for (i = 0; i < want; i++) {
 		page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
 		if (!page)
@@ -548,7 +554,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	if (unlikely(total_len == 0))
 		return 0;
 
-	anon_pipe_get_page_prealloc(&prealloc, total_len);
+	anon_pipe_get_page_prealloc(pipe, &prealloc, total_len);
 
 	mutex_lock(&pipe->mutex);
 

