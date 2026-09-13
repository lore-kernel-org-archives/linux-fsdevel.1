Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B603CCFAF
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789286141; cv=none; b=TOFx/eLZWiJ+1eOS2PfbSUQSvUPiNPGBssEMo2CJPluWBwgmMRrY0vVFRoSpYPsJcvgLDFKaZeZWYmGoR9SCBfhpT12wZu6c+ha2JiXi94LTCaDAhZHQbs6m1yH2G0tkcbvpCiFlmYDqcasVBMp80qSKMY/Qj+IWgQR8pQobgjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789286141; c=relaxed/simple;
	bh=d/rrqSIsoDYfp54Edi8J1HA0OoHKFTTgrSX2xFdknWA=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=FxaVbKBharZ/d5JKW/FausNsE+1DTOCXMmiSey6oIqpz0ZSMrH/F0HNRk7UyPfjtiUuUcZTU4fhNqCJkPuJzXDA/7dsWsCIk41dIeQFJnIFApQUEfeLwWLrrnTaxNglXTpxwU5UzhPHgTT05qO7p7yhqUtxUvJSJWlRWjM7LHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTCjltlN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTCjltlN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789286127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGuBKpvWtmH1jP4lq6atULuQBeyXSQiPQLWBHyqL+6w=;
	b=bTCjltlNTN+4wDBbJbKcxUEP34Ha5XAL2XQ+2KVQ0NAxKy3EpctE7pIB48+Iw177DXJG7L
	yd+WyTrVuD1HwkGideJ4zQC/Raw5+m03lId0oMvnKJB63RYuAFbjbqRrtSzu6uI/NQobsZ
	YuURzlJAV6hoKPyRmPPlQkbwsxcN0FU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-uI4LYe9oOUKo9uXkejPhWw-1; Sun,
 13 Sep 2026 03:55:21 -0400
X-MC-Unique: uI4LYe9oOUKo9uXkejPhWw-1
X-Mimecast-MFC-AGG-ID: uI4LYe9oOUKo9uXkejPhWw_1789286120
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 51EAB18007F1;
	Sun, 13 Sep 2026 07:55:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 493621956087;
	Sun, 13 Sep 2026 07:55:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aqUIEEvKad-o-zft@codewreck.org>
References: <aqUIEEvKad-o-zft@codewreck.org> <fbb9e395-1e07-4212-8f70-23f3cd498074@method-b.uk> <2226525.1789118704@warthog.procyon.org.uk>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: dhowells@redhat.com, Michael Mulqueen <mike@method-b.uk>,
    ericvh@kernel.org, lucho@ionkov.net, pc@manguebit.org,
    linux_oss@crudebyte.com, v9fs@lists.linux.dev, netfs@lists.linux.dev,
    linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: PROBLEM: [REGRESSION 7.1-rc4 -> 7.1-rc5] 9p: silent NUL corruption of file data on cache modes with CACHE_WRITEBACK
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2718781.1789286113.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 08:55:13 +0100
Message-ID: <2718782.1789286113@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Dominique Martinet <asmadeus@codewreck.org> wrote:

> When v9fs_issue_write() is re-entered, writing the remaining data at the
> original subreq->start offset rather than subreq->start + subreq->transf=
erred
> would overwrite previously written data.

Retry should now be resetting ->transferred to 0, so actually I should rem=
ove
adding ->transferred from other filesystems.

> > +		spin_lock(&inode->i_lock);
> > +
> > +		/* We can read the sizes directly as we hold i_lock. */
> > +		i_size =3D inode->i_size;
> Does reading and updating i_size from this asynchronous writeback path r=
ace
> with concurrent truncate operations?

Supposedly, you're not allowed to change i_size unless you hold
i_lock... which we do.

> Also, reading inode->i_size directly without i_size_read() bypasses
> i_size_seqcount, which can cause torn reads on 32-bit platforms.

Which should be irrelevant as we hold i_lock.

David

