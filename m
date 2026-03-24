Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CC3C5558
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392616; cv=none; b=h25749hblHPlL1gl8lrrrSo5p9fn8FqZquyCbd5K/K7SeS2ZXmxcE4DwUZNxUn5KnICEGPoXrZZUo5g6qsU1aH+kw9HOlTH2S+mxiqV4jtxL5F+4oC2jCteKg4KkioEIu8+wRNzpZoQmSxiepZavlbAUPAkSM7Q161T6eZBYn2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392616; c=relaxed/simple;
	bh=HyqwP1p3Oltngr7ctRk7FpAahxCim1sFqspZEOgflco=;
	h=From:In-Reply-To:References:Cc:Subject:MIME-Version:Content-Type:
	 Date:Message-ID; b=kTU1oUTUWMylN6Wu8yIeDFTQH8dQV3gJdaltUyh26+wjsOY6+pUHitrzF/i764HG9iVzQaDD9mRcxUFSZZnoeG08TBA6T7VFl6bAwSO+khT1rFWNOIRTyykUUy+doWJMJSBGXiBjGe4GktBIB+6BNtXQyzjaEC9l8UVmUipBsTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Obx2RWbm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Obx2RWbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774392613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyqwP1p3Oltngr7ctRk7FpAahxCim1sFqspZEOgflco=;
	b=Obx2RWbm9skc0+hCi897aAPKaeZHQjrNOkK/30a2i6V26gN6OyY2pbtKkQaEJWL8/MEvsg
	GIpVNXjjyUtTvPG3KgLGuEEybRNaMC7QU28svUrrW4ulwviovXw8UWnu2z+JqbK+dGxqb1
	K8jbI/6g5vgTpuYVtvn7fRbOI6xsdbo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-3j87R5rqPU6c6bEF0vYXQw-1; Tue,
 24 Mar 2026 18:50:10 -0400
X-MC-Unique: 3j87R5rqPU6c6bEF0vYXQw-1
X-Mimecast-MFC-AGG-ID: 3j87R5rqPU6c6bEF0vYXQw_1774392609
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F9761944F05;
	Tue, 24 Mar 2026 22:50:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E06E319539A0;
	Tue, 24 Mar 2026 22:50:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4001609.1774391729@warthog.procyon.org.uk>
References: <4001609.1774391729@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, NeilBrown <neil@brown.name>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.org>,
    Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cachefiles: Fix excess dput() after end_removing()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4002224.1774392603.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Mar 2026 22:50:03 +0000
Message-ID: <4002225.1774392603@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

David Howells <dhowells@redhat.com> wrote:

> Fixes: 7bb1eb45e43c ("VFS: introduce start_removing_dentry()")

Actually, this should probably be:

Fixes: bd6ede8a06e8 ("VFS/nfsd/cachefiles/ovl: introduce start_removing() =
and end_removing()")

