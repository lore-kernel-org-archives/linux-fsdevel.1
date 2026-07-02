Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF83C2BBA
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989593; cv=none; b=OrGYHli+p6KuT+xow42XWbnrR2TlkJdB4FrdOhXXDNshjc2LtqdhNEaRTQExGb4yq2uFwSxQQvAsLjeJj2jE5IM5J1is6w4WFeVkJ7CR9HKQW9DhQsN1/oth1CpPcav8JUijKDEKU1bqSq2x4tMNu9YG5E9qq89yQ7RC3Xf4CTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989593; c=relaxed/simple;
	bh=3GNYGTq3g6XfFrNHfdyV2L8+0yt+Ly6z8cR0PSjf7Ys=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=usvMfMZ03tHabfDhuii55OUZ2VNLPhjUI4rZPcR3TKQ9wviDyoKeR810S6pLRkGWkH9hIxwTMivWhAnWhqUi5HV7snvU+fpMVeN4CzLD7IDaGXVbQ5vVk73LxDgb6HjwJ5mdjBc3vgvFaYNsITZb8k+NBDjleEiZpF+dX5+HzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bjh3AiV9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bjh3AiV9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782989591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OssW+OIhDRDW2McjI78EYY6PJ6YD3e4PpEmMt7XWt04=;
	b=Bjh3AiV9oTOpLy9i50Fnk7xwJHXStyQoX8AQBRyS288NXgV5in9PLP3YvuMFm4xTlHjXFA
	QYFjcT3zcrSDBbWKwUR1+Xgn+xrEwob5jOCbx8GIZvc0fj1tUTLybn3jmX2+0yjPNoleDO
	FDlzJX2M84ou5d+NtjjRud7yadfjUvc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-b47kW8qDPreW1ASKi-uEUg-1; Thu,
 02 Jul 2026 06:53:08 -0400
X-MC-Unique: b47kW8qDPreW1ASKi-uEUg-1
X-Mimecast-MFC-AGG-ID: b47kW8qDPreW1ASKi-uEUg_1782989587
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44A43194510B;
	Thu,  2 Jul 2026 10:53:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E40A718007F5;
	Thu,  2 Jul 2026 10:53:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <178298805168.27465.937804342736897811@noble.neil.brown.name>
References: <178298805168.27465.937804342736897811@noble.neil.brown.name> <20260702020350.3403907-2-neilb@ownmail.net> <20260702020350.3403907-1-neilb@ownmail.net> <140096.1782983370@warthog.procyon.org.uk>
To: NeilBrown <neil@brown.name>,
    Alexander Viro <viro@zeniv.linux.org.uk>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] afs: use d_time instead of d_fsdata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <147548.1782989582.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 11:53:02 +0100
Message-ID: <147549.1782989582@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

NeilBrown <neilb@ownmail.net> wrote:

> > > Interestingly the value stored in ->d_time or d_fsdata is u64 which =
does
> > > not fit in "unsigned long" or "void *" on 32 bit hosts.  Maybe that
> > > doesn't matter.
> > =

> > Hmmm...  It looks like NFS may have a bug here:
> > =

> > static int nfs_dentry_verify_change(struct inode *dir, struct dentry *=
dentry)
> > {
> > 	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE) &&
> > 	    d_really_is_negative(dentry))
> > 		return dentry->d_time =3D=3D inode_peek_iversion_raw(dir);
> > 	return nfs_verify_change_attribute(dir, dentry->d_time);
> > }
> > =

> > dentry->d_time may be 32-bits, but inode_peek_iversion_raw() is always=
 64 bits
> > and i_version is set to the 64-bit fattr->change_attr.
> =

> I wonder if there would be any appetite for making d_time (or d_version)
> always 64bit, much like i_ino was recently changed to u64.

I suspect Al wouldn't be happy about that.  He counts the bits in struct
dentry very carefully.

David

