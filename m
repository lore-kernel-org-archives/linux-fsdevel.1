Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C043DDDBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 12:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391868; cv=none; b=RNfAbsKddzEleyp9+opbLcIlhvXCpJJMcIQPPn9CKnJjh0Jbm4AtTHnyRpLakebqJQkDRMeyG1HGZKLxR/0Xd2HbbuZRTP5wc2Cdtg70zwS5rFuHjT+renwt/JdugAVcWF8NmJtTZtgvaN+yGDhJ5C6fDnk+7ocrFm7Yrqdkwkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391868; c=relaxed/simple;
	bh=P1GGlV0rYbqm+O8QFxt6L8lOqvgo23pRd4tHxoqW/JM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=sna82tDyN71TY3PRWPuhdwo1bHYJcAtvuQ9GemtjeQ/lRUgSCOvDPc/6f4HRoiWj17jDSlSl7yOdUM40i+2Tr0/JnGoKOR5T7JtwXmadgpJVh3ZJKXjInhJw8liYWO2oIkNH5wL+39N0lgFcViQyos41aok0ME76a3Uqleyvrgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BL1h+Jxx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BL1h+Jxx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782391865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1dQ9D7LGl7C7AzKpEv42B3bt9Qt3zJDQxQ5d+Jkyi8=;
	b=BL1h+JxxhmbRYVCoqohqo4M5yrCRTfsAduk9W7G3ZKuTqahMnQM0JJ87PX5AuBMmA/tlz3
	L+J6rp3nWar7m/eWQaTm72oesuyvSOhYjx9fJ1kS1iFuSBTsKySazONagI3mPgA+X7PqvP
	B6UU4gYKzWgAUzbK6kY4xkQHaEdVYvA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-5XCf2NW8MF-owCZnTcNd3A-1; Thu,
 25 Jun 2026 08:51:01 -0400
X-MC-Unique: 5XCf2NW8MF-owCZnTcNd3A-1
X-Mimecast-MFC-AGG-ID: 5XCf2NW8MF-owCZnTcNd3A_1782391860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4367A1977316;
	Thu, 25 Jun 2026 12:51:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.49.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3FFCD1956088;
	Thu, 25 Jun 2026 12:50:58 +0000 (UTC)
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
Content-ID: <3106405.1782391857.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 13:50:57 +0100
Message-ID: <3106406.1782391857@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t 8fde5d1d47f6

diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 25f8ceb15fad..c16fbad286a1 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -166,13 +166,16 @@ static int netfs_unbuffered_write(struct netfs_io_re=
quest *wreq)
 		 */
 		subreq->error =3D -EAGAIN;
 		trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
-		if (subreq->transferred > 0)
+		if (subreq->transferred > 0) {
 			iov_iter_advance(&wreq->buffer.iter, subreq->transferred);
+			wreq->transferred +=3D subreq->transferred;
+		}
 =

 		if (stream->source =3D=3D NETFS_UPLOAD_TO_SERVER &&
 		    wreq->netfs_ops->retry_request)
 			wreq->netfs_ops->retry_request(wreq, stream);
 =

+		__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 		__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
 		__clear_bit(NETFS_SREQ_BOUNDARY, &subreq->flags);
 		__clear_bit(NETFS_SREQ_FAILED, &subreq->flags);
@@ -186,17 +189,10 @@ static int netfs_unbuffered_write(struct netfs_io_re=
quest *wreq)
 =

 		netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
 =

-		if (stream->prepare_write) {
+		if (stream->prepare_write)
 			stream->prepare_write(subreq);
-			__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
-			netfs_stat(&netfs_n_wh_retry_write_subreq);
-		} else {
-			struct iov_iter source;
-
-			netfs_reset_iter(subreq);
-			source =3D subreq->io_iter;
-			netfs_reissue_write(stream, subreq, &source);
-		}
+		__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
+		netfs_stat(&netfs_n_wh_retry_write_subreq);
 	}
 =

 	netfs_unbuffered_write_done(wreq);

