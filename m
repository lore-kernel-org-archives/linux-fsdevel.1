Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795394675;
	b=njmtPiOqD8h3qVZyaeRKs/heeSsu289EOUuMVGMMdVYs6NBYhj1NcTtTKagE5NL8T5V9
	 Ezh2sHrelDrYgXEFydMvM9vVoJnYSuUeHPskh7iU9zuzev03WEf5rfX1X1IW96mhVG1g0
	 vxHdlqmvsheKOeyIA/j9r/g4fBMzTId8qUefivAiiIwvKd/xwHUPhtx3EDW/YbBT5TFgB
	 1YbEvI3tUwij8285GPCUk4b3xR4VGEC7ugqQ4Hj0AEHm/cd+9BZnQdvSs74tcMZe62MOr
	 6O7F/UIz3OA/+TnhIrkL8OAC8eQkL2dZ9dOJfKdP8vh3452nX7tiE7vi+eWYL/0EnJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795394675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TN3atIghVemOlMWS6OdQtOm4gB9s02HY7cHrHMnNt1g=;
	b=dRGJS7A8eyYqj/A9XWtA/A3CKaQ5UDBlSUAaN8DUCw9QRAqV/5CphSSC+mTMJJgymtY5
	 cYCKP9B5+qPE0dcnf73wvZ78u8G2j8Ix05hwr+NdNcJBspBOH40+DxhjIglryfEcCDm4B
	 MoAolt+0bs3I5G8yWm3S4z17YnNOSwmHk08tA75llDm8QYHL0sbdG+l81ysNrw8BAErRP
	 beM+gJuRejqucD2mCC249ArnnJ6ZojuJeSHPUbI/SsMaLpdx2O6a/dWAnmE2J0LFwILS0
	 F21AVSBCWUWSUVAqf1pbJW1rnYa/HIzDv/Lo+MAt4G6DK378hOtqSPpC2NOYj9ETlMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z3ADhScw;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71B606A33B;
	Mon, 23 Nov 2026 00:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD71B606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Z3ADhScw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TN3atIghVemOlMWS6OdQtOm4gB9s02HY7cHrHMnNt1g=; b=Z3ADhScwMuC+uRls6/gs6Q/4nA
	MMFZuo0UX9R0GXb1cCxFJvko7rCzgYCmmBRUYJzCmF2ih1n/L5KvdYj+dvBWKpJbJcJbt2mC+EK5V
	1JgsOfz1mzzezHvHMP+068m5rFFXHENOmJFqovAFiUFdtLqtaOVP6WmywhcJacE21CmrZYOaikyTm
	1u8ZYA9lZ1V9okBI3x5H97qh1XrYuJShsDgDg9VWBt+mB0kchvwCRF6vil1pn+OrMzjy3Z7xR5LMW
	ZBWgr2XGHt6vWW9WbgvjhRRqe7eyYQoDMEWvrYBJqEfuNts0DoKFXgXIwWGxkYbQuUup3leshLl4j
	gpIvaIXQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVIAU-000000020Cs-35wA;
	Mon, 23 Nov 2026 00:44:26 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev
Subject: [PATCH] net/9p: client.h: clean up kernel-doc warnings
Date: Sun, 22 Nov 2026 16:44:25 -0800
Message-ID: <20261123004425.1770155-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Repair all kernel-doc warnings:

Warning: include/net/9p/client.h:52 Enum value 'BeginDisconnect' not described in enum 'p9_trans_status'
Warning: include/net/9p/client.h:90 struct member 'refcount' not described in 'p9_req_t'
Warning: include/net/9p/client.h:132 struct member 'fcall_cache' not described in 'p9_client'
Warning: include/net/9p/client.h:132 struct member 'trans_opts' not described in 'p9_client'
Warning: include/net/9p/client.h:147 expecting prototype for struct p9_fd_opts. Prototype was for struct p9_client_opts instead
Warning: include/net/9p/client.h:243 enum fid_source { FID_FROM_OTHER, FID_FROM_INODE, FID_FROM_DENTRY, }; error: Cannot parse struct or union!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev

 include/net/9p/client.h |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- linux-next-20261120.orig/include/net/9p/client.h
+++ linux-next-20261120/include/net/9p/client.h
@@ -38,6 +38,7 @@ enum p9_proto_versions {
 /**
  * enum p9_trans_status - different states of underlying transports
  * @Connected: transport is connected and healthy
+ * @BeginDisconnect: beginning transition to @Disconnected
  * @Disconnected: transport has been disconnected
  * @Hung: transport is connected by wedged
  *
@@ -75,6 +76,7 @@ enum p9_req_status_t {
  * struct p9_req_t - request slots
  * @status: status of this request slot
  * @t_err: transport error
+ * @refcount: request refcount
  * @wq: wait_queue for the client to block on for this request
  * @tc: the request fcall structure
  * @rc: the response fcall structure
@@ -98,6 +100,8 @@ struct p9_req_t {
  * @trans_mod: module API instantiated with this client
  * @status: connection state
  * @trans: transport instance state and API
+ * @fcall_cache: per-client fcall kmem cache
+ * @trans_opts: union of struct fd, struct tcp
  * @fids: All active FID handles
  * @reqs: All active requests.
  * @name: node name used as client id
@@ -137,9 +141,9 @@ struct p9_client {
 };
 
 /**
- * struct p9_fd_opts - holds client options during parsing
+ * struct p9_client_opts - holds client options during parsing
  * @msize: maximum data size negotiated by protocol
- * @prot-Oversion: 9P protocol version to use
+ * @proto_version: 9P protocol version to use
  * @trans_mod: module API instantiated with this client
  *
  * These parsed options get transferred into client in
@@ -228,25 +232,27 @@ struct v9fs_context {
 	struct p9_session_opts	session_opts;
 };
 
+enum fid_source {
+	FID_FROM_OTHER,
+	FID_FROM_INODE,
+	FID_FROM_DENTRY,
+};
+
 /**
  * struct p9_fid - file system entity handle
  * @clnt: back pointer to instantiating &p9_client
  * @fid: numeric identifier for this handle
+ * @count: reference counter
  * @mode: current mode of this fid (enum?)
  * @qid: the &p9_qid server identifier this handle points to
  * @iounit: the server reported maximum transaction size for this file
  * @uid: the numeric uid of the local user who owns this handle
  * @rdir: readdir accounting structure (allocated on demand)
  * @dlist: per-dentry fid tracking
+ * @ilist: inode list
  *
  * TODO: This needs lots of explanation.
  */
-enum fid_source {
-	FID_FROM_OTHER,
-	FID_FROM_INODE,
-	FID_FROM_DENTRY,
-};
-
 struct p9_fid {
 	struct p9_client *clnt;
 	u32 fid;
