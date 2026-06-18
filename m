Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A5352C3F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790802; cv=none; b=Cf+sa6fDid1TRBuvZJEkVzoGDKePxaSX217KaRCNODWOgBdjrpSEC1BJ5GR+vaP4sHrtDHdk9cSG+V6aT4AFpLGrXs2Wt+Rp98mL/zSjYY9/+DcIYbowA8br/1LOKyLNOQwvWZooOfbXJd4rC+LrU1lfZtip11skHai7jY5asgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790802; c=relaxed/simple;
	bh=llnUkOB8c3AhUoXVlzPMWxmyXX0YAOA7nC5Tun6ogeM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Nx22jUIzA4aR8V7RFxZXswu/9GYWtNRXbepjCtiRfGxBE2eB+eWgvRMK/0x2iu/7eXN8YMpwvwGS5Rvt2IoWtOnjr34Q/3zyRsD7MVSMx0Aa+plGeRjl5+htfUhX/FiNOEnLonyzw3IL7vcPxfziyzK/7uspuDhaWExBIwcYA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSAK/fs8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSAK/fs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781790800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HnMreEndcThYANyo4TEmKtceGFIH7FXqNuydUEyvoc=;
	b=gSAK/fs8hd6WDXyujcDQD/XukqxbefSHzxCyEwU0KK6tkHwjro6rIxozB0RPs6gGtJ31/O
	y0HIvbEr2zDL6b9lwfYf8YUEhh2izF64tcBEAoSAWIRaswGPLcoHvz+Z6xyOkVsegUT4f6
	MxXG0MQud17+UOmd7V5aMGriA+S1Hq0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-oy4zQXAZNX6Q46QE8yMqKA-1; Thu,
 18 Jun 2026 09:53:17 -0400
X-MC-Unique: oy4zQXAZNX6Q46QE8yMqKA-1
X-Mimecast-MFC-AGG-ID: oy4zQXAZNX6Q46QE8yMqKA_1781790796
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09B7D18004D4;
	Thu, 18 Jun 2026 13:53:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.50.44])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7221B1956044;
	Thu, 18 Jun 2026 13:53:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ajOrcnnqTp6210YC@redhat.com>
References: <ajOrcnnqTp6210YC@redhat.com> <20260618074903.2374756-1-dhowells@redhat.com> <20260618074903.2374756-15-dhowells@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Marc Dionne <marc.dionne@auristor.com>,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, Li RongQing <lirongqing@baidu.com>
Subject: Re: [PATCH v2 14/17] afs: Remove erroneous seq |= 1 in volume lookup loop
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2478529.1781790791.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 14:53:11 +0100
Message-ID: <2478530.1781790791@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Oleg Nesterov <oleg@redhat.com> wrote:

> Thanks, but
> =

> > --- a/fs/afs/internal.h
> > +++ b/fs/afs/internal.h
> > @@ -750,8 +750,6 @@ static inline void afs_vnode_set_cache(struct afs_=
vnode *vnode,
> >  {
> >  #ifdef CONFIG_AFS_FSCACHE
> >  	vnode->netfs.cache =3D cookie;
> > -	if (cookie)
> > -		mapping_set_release_always(vnode->netfs.inode.i_mapping);
> >  #endif
> =

> This change looks unrelated...

If I remove that bit, can I add your R-b?

David

