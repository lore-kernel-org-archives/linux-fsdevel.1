Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3D47DD65
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 09:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983378; cv=none; b=X2h+mrt1DeyR1RrRZgkM0LYT74Qs7feWTfKzjGIRTh9wzVN4pVkTCjHOhFKGgQHp2s/a3TPRyNNQI5wX/mpY/onKr6+Hgrjj0AwPamCLfAOZsR6k32WA5tySW4nQpuA3483FjQBhTEHp+xy09jr6N9rxHate+Q78GsgYuiHtArQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983378; c=relaxed/simple;
	bh=/4H8fB5UmRZ6XOOyDDuG9rxihECf1pxl2PCJsBeCRKE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Nd+iGW2cUI4WlQ9Oemji8HCc0utM/vLHh1RysmiKImvtVfh/FhQOb+QOqytnfDXBbByEowWdmB5aUEL/Y758EgvtqHNrlrPLrGgOPy5SbRgU3Oz3GHI2g+5Zs6RButaheEfy3HLJQcGJMWDiPHdJaizDZ4ITibgedyadNBzNo+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G8wHW3Cn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8wHW3Cn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782983376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gtcifYcfR4fB1xFwNMQo5aJiOPVK1/D0m+96KdcNtC0=;
	b=G8wHW3CnfpjlMx8DZPTNop3r39qyU865q6lv+2dSsL3HFmONgjiRPYJtV19L54ge6HYOuW
	JDUxZ2mygu9wKNeLIdt4IiNx80Hme9F00He/pX50igubI5PRO7aRv/vEBzDJr2x11qB/at
	3GLk+UzW135aRzHPBMphqU+/GKz+o6k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-RkgkJoh6NEGf7u75AHquyg-1; Thu,
 02 Jul 2026 05:09:35 -0400
X-MC-Unique: RkgkJoh6NEGf7u75AHquyg-1
X-Mimecast-MFC-AGG-ID: RkgkJoh6NEGf7u75AHquyg_1782983374
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C68ED1856A5A;
	Thu,  2 Jul 2026 09:09:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.159])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0CE236F04;
	Thu,  2 Jul 2026 09:09:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260702020350.3403907-2-neilb@ownmail.net>
References: <20260702020350.3403907-2-neilb@ownmail.net> <20260702020350.3403907-1-neilb@ownmail.net>
To: NeilBrown <neil@brown.name>
Cc: dhowells@redhat.com, Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] afs: use d_time instead of d_fsdata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <140095.1782983370.1@warthog.procyon.org.uk>
Date: Thu, 02 Jul 2026 10:09:30 +0100
Message-ID: <140096.1782983370@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

NeilBrown <neilb@ownmail.net> wrote:

> afs uses ->d_fsdata to store version information for the parent
> directory.  ->d_time is arguably a better field to store this
> information as the version is like a time stamp, and ->d_time is an
> unsigned long, while ->d_fsdata is a void *.

Might it be better to rename ->d_time to ->d_version, since that would seem to
be more in line with how it's used?

> Interestingly the value stored in ->d_time or d_fsdata is u64 which does
> not fit in "unsigned long" or "void *" on 32 bit hosts.  Maybe that
> doesn't matter.

Hmmm...  It looks like NFS may have a bug here:

static int nfs_dentry_verify_change(struct inode *dir, struct dentry *dentry)
{
	if (nfs_server_capable(dir, NFS_CAP_CASE_INSENSITIVE) &&
	    d_really_is_negative(dentry))
		return dentry->d_time == inode_peek_iversion_raw(dir);
	return nfs_verify_change_attribute(dir, dentry->d_time);
}

dentry->d_time may be 32-bits, but inode_peek_iversion_raw() is always 64 bits
and i_version is set to the 64-bit fattr->change_attr.

David

