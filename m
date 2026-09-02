Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F03AA4E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349268; cv=none; b=CQ52TycGTbA9aW/dQPJ581Q1FhVXcfF+NEmeHWPmvj9hbvg8uX9oOhgKZm+7D34jGMvuJKW3Gq9GTjpEdMx8Del1xD3o3aPrZvRfhFmhD3FBrKq/4o686xt3Z5yEExAQDpW3ruIqzL5ThB3Hhe3GnGCs2nPvT9PPAjvmjXU0oWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349268; c=relaxed/simple;
	bh=tZ8WZ/k6Zoo6yaDvlogrLn1UO8xKN1zl5srsQ+7hiaw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Hwu+19AaTD9Lhumlbhco0BUhjVeC7wcjTvkWyRlRxInQWHV9l2OyV+vKiewoyyxNSY6nr2tH8zC6TfMpf14HS9yF7EJv6IksBOidq2Hl0ZgPY99vPRaiHDr1ZbxRRRRpp+fAWvNYeB/uvBKZx4x3tNuNY27rcqiXr4Vu5ekQ8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1PlowTe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1PlowTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788349265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOqiKlICWLLyhRYARpnrqwN5Xk/vEKKktncz0koYWnM=;
	b=W1PlowTeukICne5/oMO8T/bFuhXZU40numImrAlQuJmNnQusokR7nPBqac32udlIuICSvt
	dKV9x1JeK14EerzB6vuirrAvwtZVSEQc0evYjzKnc5cNGyuyq8eRw9mBDM6jdfo7VWQ1Vn
	XrLaDPT1Zi/fViwqB2VD7YzvkX2DFIo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-q1CL-CErMOSCxWOW00Yk5g-1; Wed,
 02 Sept 2026 07:41:01 -0400
X-MC-Unique: q1CL-CErMOSCxWOW00Yk5g-1
X-Mimecast-MFC-AGG-ID: q1CL-CErMOSCxWOW00Yk5g_1788349260
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5BB81954216;
	Wed,  2 Sep 2026 11:40:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.158])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4CC0418005BB;
	Wed,  2 Sep 2026 11:40:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+0ovChcGF2nsf0iJNGXM79iGv2fKEqYi4DGQ55aygBcKg2NGQ@mail.gmail.com>
References: <CA+0ovChcGF2nsf0iJNGXM79iGv2fKEqYi4DGQ55aygBcKg2NGQ@mail.gmail.com>
To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    falemi@asu.edu, linux-afs@lists.infradead.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] afs: ERR_PTR dereference in afs_lookup_server() error path
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3266509.1788349255.1@warthog.procyon.org.uk>
Date: Wed, 02 Sep 2026 12:40:55 +0100
Message-ID: <3266510.1788349255@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Farhad,

> While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
> SEFCOM lab, we hit the crash below. Crash reports can be found here:

Have you tried it with 7.3-rc1?

>   BUG: unable to handle page fault for address: ffffffffffffff9f
>   RIP: 0010:afs_put_addrlist+0x43/0x250 fs/afs/addr_list.c:38
>   afs_lookup_server+0xd3f/0x1020 fs/afs/server.c:243
>   afs_alloc_server_list+0x800/0x11a0 fs/afs/server_list.c:82
>   afs_create_volume+0x995/0x1290 fs/afs/volume.c:227
>   afs_get_tree+0x955/0x10b0 fs/afs/super.c:555

It looks like alist is 0xffffffffffffff9f, but it's not immediately obvious
how it could be anything other than a valid pointer at that point.

> Our reproducer.c is available upon request.

If I could have that, please?

Thanks,
David

