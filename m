Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB513A382A
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426829; cv=none; b=KQfTYtQFRg+uc1tgtbCdzpv2WIVURBYIZa/DnUJf2TX0KI/DdgIQJSPqcQvYRYHYIuc0Zi2rvGbGXmP6iq+ERHfqr9hv3aDkb0DM5ZhVV+cF66z8mHGZKE00xN+tIbelpYTqhyz5Ahut1WX7oNj69IXGP3/FQSrd/6mKndyeOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426829; c=relaxed/simple;
	bh=JPs8zjOIDKhksGxr1OYwN9iALV0ED4kckfb0k3JaPeo=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=F7JKybTCSgHqrYH1meW5YpCViZBGSl0T8REBXvS7W6M/7+0Qw/FO6lXDCdP5tJtyy7M8yWs/lxb3rr1OCnsz8WQ4WHUyRm/PpvB9cUWYNZisnyQlTAlfAI8SgE8yQWDPpRo+oCZbJN8xGgCZDF0AM7o1wDFXLrdrpIUU99Klzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GkU5hoi1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkU5hoi1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774426826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nph8AC0CZUvFb5vgsUeI+eDFcppn/MxgPbHPARMSgdc=;
	b=GkU5hoi1c5aHM/7pobmejaCPodvWgXoLoRmMj7JxdqJXPQG4WaXmOCQ5ZzV8Cfd9bQ3SoC
	7jTTUF6eVAyUuNJ86HIYoBH3/5v0TqKfhHM2KuuNvcHnbSG59E+QTz8DUHgo64e8RXN5vq
	F/uaTmK0saFVd0KTyxBDcvAdXNAquzg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-JAXTgc5dPWOrVNwpyb0Kww-1; Wed,
 25 Mar 2026 04:20:22 -0400
X-MC-Unique: JAXTgc5dPWOrVNwpyb0Kww-1
X-Mimecast-MFC-AGG-ID: JAXTgc5dPWOrVNwpyb0Kww_1774426821
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4996B195608A;
	Wed, 25 Mar 2026 08:20:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4417E300019F;
	Wed, 25 Mar 2026 08:20:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <brauner@kernel.org>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.org>,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix the handling of stream->front by removing it
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4158598.1774426817.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Mar 2026 08:20:17 +0000
Message-ID: <4158599.1774426817@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The netfs_io_stream::front member is meant to point to the subrequest
currently being collected on a stream, but it isn't actually used this way
by direct write (which mostly ignores it).  However, there's a tracepoint
which looks at it.  Further, stream->front is actually redundant with
stream->subrequests.next.

Fix the potential problem in the direct code by just removing the member
and using stream->subrequests.next instead, thereby also simplifying the
code.

Fixes: a0b4c7a49137 ("netfs: Fix unbuffered/DIO writes to dispatch subrequ=
ests in strict sequence")
Reported-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/buffered_read.c     |    3 +--
 fs/netfs/direct_read.c       |    3 +--
 fs/netfs/direct_write.c      |    1 -
 fs/netfs/read_collect.c      |    4 ++--
 fs/netfs/read_single.c       |    1 -
 fs/netfs/write_collect.c     |    4 ++--
 fs/netfs/write_issue.c       |    3 +--
 include/linux/netfs.h        |    1 -
 include/trace/events/netfs.h |    8 ++++----
 9 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 88a0d801525f..a8c0d86118c5 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -171,9 +171,8 @@ static void netfs_queue_read(struct netfs_io_request *=
rreq,
 	spin_lock(&rreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		stream->front =3D subreq;
 		if (!stream->active) {
-			stream->collected_to =3D stream->front->start;
+			stream->collected_to =3D subreq->start;
 			/* Store list pointers before active flag */
 			smp_store_release(&stream->active, true);
 		}
diff --git a/fs/netfs/direct_read.c b/fs/netfs/direct_read.c
index a498ee8d6674..f72e6da88cca 100644
--- a/fs/netfs/direct_read.c
+++ b/fs/netfs/direct_read.c
@@ -71,9 +71,8 @@ static int netfs_dispatch_unbuffered_reads(struct netfs_=
io_request *rreq)
 		spin_lock(&rreq->lock);
 		list_add_tail(&subreq->rreq_link, &stream->subrequests);
 		if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-			stream->front =3D subreq;
 			if (!stream->active) {
-				stream->collected_to =3D stream->front->start;
+				stream->collected_to =3D subreq->start;
 				/* Store list pointers before active flag */
 				smp_store_release(&stream->active, true);
 			}
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
index 4d9760e36c11..f9ab69de3e29 100644
--- a/fs/netfs/direct_write.c
+++ b/fs/netfs/direct_write.c
@@ -111,7 +111,6 @@ static int netfs_unbuffered_write(struct netfs_io_requ=
est *wreq)
 			netfs_prepare_write(wreq, stream, wreq->start + wreq->transferred);
 			subreq =3D stream->construct;
 			stream->construct =3D NULL;
-			stream->front =3D NULL;
 		}
 =

 		/* Check if (re-)preparation failed. */
diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 137f0e28a44c..e5f6665b3341 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -205,7 +205,8 @@ static void netfs_collect_read_results(struct netfs_io=
_request *rreq)
 	 * in progress.  The issuer thread may be adding stuff to the tail
 	 * whilst we're doing this.
 	 */
-	front =3D READ_ONCE(stream->front);
+	front =3D list_first_entry_or_null(&stream->subrequests,
+					 struct netfs_io_subrequest, rreq_link);
 	while (front) {
 		size_t transferred;
 =

@@ -301,7 +302,6 @@ static void netfs_collect_read_results(struct netfs_io=
_request *rreq)
 		list_del_init(&front->rreq_link);
 		front =3D list_first_entry_or_null(&stream->subrequests,
 						 struct netfs_io_subrequest, rreq_link);
-		stream->front =3D front;
 		spin_unlock(&rreq->lock);
 		netfs_put_subrequest(remove,
 				     notes & ABANDON_SREQ ?
diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index 8e6264f62a8f..d0e23bc42445 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -107,7 +107,6 @@ static int netfs_single_dispatch_read(struct netfs_io_=
request *rreq)
 	spin_lock(&rreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	trace_netfs_sreq(subreq, netfs_sreq_trace_added);
-	stream->front =3D subreq;
 	/* Store list pointers before active flag */
 	smp_store_release(&stream->active, true);
 	spin_unlock(&rreq->lock);
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 83eb3dc1adf8..b194447f4b11 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -228,7 +228,8 @@ static void netfs_collect_write_results(struct netfs_i=
o_request *wreq)
 		if (!smp_load_acquire(&stream->active))
 			continue;
 =

-		front =3D stream->front;
+		front =3D list_first_entry_or_null(&stream->subrequests,
+						 struct netfs_io_subrequest, rreq_link);
 		while (front) {
 			trace_netfs_collect_sreq(wreq, front);
 			//_debug("sreq [%x] %llx %zx/%zx",
@@ -279,7 +280,6 @@ static void netfs_collect_write_results(struct netfs_i=
o_request *wreq)
 			list_del_init(&front->rreq_link);
 			front =3D list_first_entry_or_null(&stream->subrequests,
 							 struct netfs_io_subrequest, rreq_link);
-			stream->front =3D front;
 			spin_unlock(&wreq->lock);
 			netfs_put_subrequest(remove,
 					     notes & SAW_FAILURE ?
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 437268f65640..2db688f94125 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -206,9 +206,8 @@ void netfs_prepare_write(struct netfs_io_request *wreq=
,
 	spin_lock(&wreq->lock);
 	list_add_tail(&subreq->rreq_link, &stream->subrequests);
 	if (list_is_first(&subreq->rreq_link, &stream->subrequests)) {
-		stream->front =3D subreq;
 		if (!stream->active) {
-			stream->collected_to =3D stream->front->start;
+			stream->collected_to =3D subreq->start;
 			/* Write list pointers before active flag */
 			smp_store_release(&stream->active, true);
 		}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 72ee7d210a74..ba17ac5bf356 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -140,7 +140,6 @@ struct netfs_io_stream {
 	void (*issue_write)(struct netfs_io_subrequest *subreq);
 	/* Collection tracking */
 	struct list_head	subrequests;	/* Contributory I/O operations */
-	struct netfs_io_subrequest *front;	/* Op being collected */
 	unsigned long long	collected_to;	/* Position we've collected results to =
*/
 	size_t			transferred;	/* The amount transferred from this stream */
 	unsigned short		error;		/* Aggregate error for the stream */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 2d366be46a1c..cbe28211106c 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -740,19 +740,19 @@ TRACE_EVENT(netfs_collect_stream,
 		    __field(unsigned int,	wreq)
 		    __field(unsigned char,	stream)
 		    __field(unsigned long long,	collected_to)
-		    __field(unsigned long long,	front)
+		    __field(unsigned long long,	issued_to)
 			     ),
 =

 	    TP_fast_assign(
 		    __entry->wreq	=3D wreq->debug_id;
 		    __entry->stream	=3D stream->stream_nr;
 		    __entry->collected_to =3D stream->collected_to;
-		    __entry->front	=3D stream->front ? stream->front->start : UINT_MAX;
+		    __entry->issued_to	=3D atomic64_read(&wreq->issued_to);
 			   ),
 =

-	    TP_printk("R=3D%08x[%x:] cto=3D%llx frn=3D%llx",
+	    TP_printk("R=3D%08x[%x:] cto=3D%llx ito=3D%llx",
 		      __entry->wreq, __entry->stream,
-		      __entry->collected_to, __entry->front)
+		      __entry->collected_to, __entry->issued_to)
 	    );
 =

 TRACE_EVENT(netfs_folioq,

