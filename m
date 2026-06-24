Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F42DB7B8
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299090; cv=none; b=Fjir/oVPGh7Q/wA+vlOBdcXhS9yx8CBePgT1e9C3uKt0BY/SPmQIszz0k1Owp8MLdFUyifrK9tP+zD6TQzk0lOhnrHETiXND5vHe0aM3k/VJTlMTgSVBIsQrvl5FjCyK9WeWvaGJ032xeUiF1dUZRsnAQUb84P/r6ZQCij7ykLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299090; c=relaxed/simple;
	bh=uFixHyb4UpUWgn/NikPVyCvAmb3Y7T+iANqPDA11hb8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=iazQogpJKGAs3v0v3C0mWSR+cemRRfKDDKOUKAmgfqYz5K9JPPOFyvYhpu+nYnsSA2z3CF9rXwR9DQU4drTPEOe0w0ozSZdyKpQrW0nLKNklJgHFB4K78hpNYtZF8AoOzMRH49Bfm75WsAsj+ceRLnnO3wFgenHxw8+UnsLtHyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KiZhfHC8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiZhfHC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782299088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NYqr3k4j+IPyfatkmC5Fm6mSWBEWm0Gdo4ZcWIlHjI=;
	b=KiZhfHC8MZ7lmCpivWTYMHFaheq2XJv71p35uMZj34Q6BZSvrUe0pUm+HM4CcCGs0W3hj2
	XkORedDZln6J561bBHmYWDigxCqIusschU0QFVvB7PRvNwQwhrNWG9UTJtFob8lZwo1qmo
	JJV3n+TyI/aWJrN3GuqjYKX5GKoea9Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665--cn2XYQCM52cW4-gfJEerA-1; Wed,
 24 Jun 2026 07:04:45 -0400
X-MC-Unique: -cn2XYQCM52cW4-gfJEerA-1
X-Mimecast-MFC-AGG-ID: -cn2XYQCM52cW4-gfJEerA_1782299084
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1031818005AB;
	Wed, 24 Jun 2026 11:04:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.49.152])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D73B36917;
	Wed, 24 Jun 2026 11:04:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6a19f098.abb04025.19af7b.0003.GAE@google.com>
References: <6a19f098.abb04025.19af7b.0003.GAE@google.com>
To: syzbot <syzbot+3c74b1f0c372e98efc32@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
    pc@manguebit.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in netfs_unbuffered_write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2961583.1782299080.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 12:04:40 +0100
Message-ID: <2961584.1782299080@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 8fde5d1d47f6

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 25f8ceb15fad..1ff1789016b8 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -190,12 +190,6 @@ static int netfs_unbuffered_write(struct netfs_io_req=
uest *wreq)
 			stream->prepare_write(subreq);
 			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 			netfs_stat(&netfs_n_wh_retry_write_subreq);
-		} else {
-			struct iov_iter source;
-
-			netfs_reset_iter(subreq);
-			source =3D subreq->io_iter;
-			netfs_reissue_write(stream, subreq, &source);
 		}
 	}
 =

