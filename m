Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6277719D065
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 02:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649498; cv=none; b=XNm6Gdo2TwsEzedsR33jztl/0AF5FwiFi5lXZBR5nStqb1XTEbdTIJjgIV6bIrI6VD/BqPMKyNFpOtG96VnK7s8etzlmSjv1cwZKyG8bWEsIw0AIYXL1UPJvO1GxcAS9/rlgqS7EDKWVAV46nqCqPJuj/qK8CQwLXgGpMUabJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649498; c=relaxed/simple;
	bh=WreOkf+pubCB2YPqHxKIYu9FitIBbawTqQnqjeNj3Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5nhQl2iNKasOj9BZFDw/z4u1FccAw6vMM4OdIo3TpgGUgmja+ItjxGIs2mLr/SoN6uDcZJAB222k6Kb3Om8Mo0PEgvFucm66VgPCZoQsw/ncZjeCxViQaUteJPVJXCYOiIIX6APnbCIRQNwMjW7M6E2f4n+TJJWApyBA6oPYX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Q/0Jhemb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ujzq8kR/; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Q/0Jhemb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ujzq8kR/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 71A5A1D000DE;
	Mon, 28 Sep 2026 22:38:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 28 Sep 2026 22:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790649496;
	 x=1790735896; bh=kSu31aocUzcYzaV1YdEEerwyVEPUaUyVfqAFCDz4HSA=; b=
	Q/0JhembRefueGxGsMXvccSzI20rh0AtH+sofa+MSiuSdjNOVI7NOk3hKgC8DnVl
	v+0+fWV8QLpU2Nqlj3VPwcIP6ZOwwtJImLjg5p9FH5SeKn9XEy1CaiNFcCrriyew
	4ic3ju04k3JOvr7YKHAWymGf8wuYnVoyii+p9wOd/utvtKPU15EZG2xe/rottlNW
	usR8N9es4slHEnBHPvajQ1TfqMDQDsG5pY+BB3j2Kzga4voNcf0A/1Bbfma5IV2I
	G7T63Uqx/q3YZ4K49yWsFVSz0vQ8hHIh7En17OjtEF1Pgo5AaNfy27zDi5GSKjeu
	UOjp8JhjqiyR9T1REde3fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790649496; x=1790735896; bh=k
	Su31aocUzcYzaV1YdEEerwyVEPUaUyVfqAFCDz4HSA=; b=Ujzq8kR/Zb6dgg1q3
	42E5Xsc3o+TYc5I5OGQZMa82NZMFzKBwCNPGMZrUhxgkDBgfw3SmScXtF4+0Pjn1
	GeYw3qNGJxBTURQ/JSZmrFqmi1jGhtZbJvttjOWQ283j8Q8KBAuujnTFip0dT3HM
	y5qvb0ML12wzEUpFBNjO7iLK2+zSWmtQeVV544dMxdaKTOLhGrEqeOawKa+/AawO
	7Aigrf8Jrg3gnzWLZFuqOXzuDkjfBUtV/Mf9HSQMZLCuPLg9DugUPGQcPNSWtLsP
	ZeLBjk/xmUHrRjHYh+Imlnqdq9FHA4vWocSzUj4fD4nT0OGTJhW9zjn6TNM4ssI8
	QCLXQ==
X-ME-Sender: <xms:mCS7ahW_CkoHRk-cCnsDn-F6hp1FKr3AhhQjk9QddK80yAf5_09ATQ>
    <xme:mCS7ako7Eby48F3l406CXA_7guvbb2AxPwTKw_NiJH12tTiaD5R6Q3hfPDWz9dDn9
    IXZc1qO7dSx422FgzzMNJdM9zM7xjYue0DUuy0LtJljVtcqfmI>
X-ME-Received: <xmr:mCS7aoCS8L5fOKT66k9lLXzbWK3oDoAFi_tEk1J6gsAG3ArHZipc1uxh37zmCZfZstfyR_22j87wFBMMbLPVR7SVMQGNp4k>
X-ME-Proxy-Cause: dmFkZTED42B6O0ikvpHyX11SdplSdF/MKlznI4RgKdNjrNL5OSHo2WAcel1uvOrQb7HKwN
    iUSoZ/dHU0XnkIgMPrlBDoc/dz/Roc6hCH2CkDY47bupdQoZGM+EfriuQu2xxLpulembG2
    oXegZ95JiFhef3KVY5GC9jdm7moyUTMlo9n7SmD+KbxiCecjgwVmD5WDXZpVvAJ156brZo
    u3m1JCHRrQapBIcMO9nnIjAFne4J/9x2Vz94GABPj7LGIOsvIud9s++Mtys2kaWrW3C/9G
    MXBaRyk80dDsoK1z+b/SVQmT3q1VdWzavyNnMwZxqjbK/FK3Een8o42JjE1CLP6MCZAUCZ
    Mh6r0ngykLCWCAp0ngR7o505q3faAghBzNWgnIrEvobW63Rap7aEcYmuk6afGJZa3cLAEv
    TKnNc3l34M/I8g8kcp7lVMghXsHnpdwIyVFOBFY/xsHKNW1JRxhaikarJrNj/aZAOV5/c/
    t3m+X4Rem93hIXhM93JP/hm+Thdj+U2JLy37bAjuNSIIRZDlkNkFtc3wtwmTuE8bUtcBYz
    WcQttnin+Ok35Bpj3yUxuleQ7sCc7UeabH9d6QeGIrPyiBqSZirFDEVzy8ddq3d9QpgWXp
    AJp7zaIsLxpN9HYhDtQM9oue/vIrDayvihVRx9ZWyeabuYIU5jIHUxr49CKg
X-ME-Proxy: <xmx:mCS7agjYD1dUYT5QW0YoTfESC0CC7eMnU_ngi5vvT0uU75ilj_dQ4Q>
    <xmx:mCS7amaU9vh8s5XUrHUALU0hwhbKWmTXeljGwZFTb42d7GOXO__tdA>
    <xmx:mCS7ahnkyo7FGSt2ImiYNUv_ANAj_PnJmxgSzhDB1_Tx90Hslacl2Q>
    <xmx:mCS7ashW2JMDVyCx0J4wxHKHbUIJtNWL7BUAgalubukI9ZG6Gd0P-g>
    <xmx:mCS7agPEuaDtTYOAh3itkIDqzmvKPinSdmsMDwuqfja-9XvggtsjJ5KN>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:38:13 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernl.org
Subject: [PATCH v2 5/5] afs: use d_duplicate()
Date: Tue, 29 Sep 2026 12:29:31 +1000
Message-ID: <20260929023223.1429201-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929023223.1429201-1-neilb@ownmail.net>
References: <20260929023223.1429201-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

To prepare for d_alloc_parallel() being permitted without a directory
lock, use d_duplicate() when duplicating a dentry in order to perform a
silly-rename.  This creates on in-lookup dentry which will contine to block
concurrent lookups after the original dentry is silly-renamed, and until
the final rename happens.

As the resulting dentry is in-lookup, we need to call d_lookup_done()
before d_put().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index b8773adc4e3e..dfd1930e2282 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -2075,7 +2075,10 @@ static void afs_rename_put(struct afs_operation *op)
 	store_release_wake_up(&op->dentry->d_flags,
 			      op->dentry->d_flags &~ DCACHE_BLOCKED);
 	spin_unlock(&op->dentry->d_lock);
-	dput(op->rename.tmp);
+	if (op->rename.tmp) {
+		d_lookup_done(op->rename.tmp);
+		dput(op->rename.tmp);
+	}
 }
 
 static const struct afs_operation_ops afs_rename_operation = {
@@ -2213,8 +2216,7 @@ static int afs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 			if (d_count(new_dentry) > 2) {
 				spin_unlock(&new_dentry->d_lock);
 				/* copy the target dentry's name */
-				op->rename.tmp = d_alloc(new_dentry->d_parent,
-							 &new_dentry->d_name);
+				op->rename.tmp = d_duplicate(new_dentry);
 				if (!op->rename.tmp) {
 					afs_op_nomem(op);
 					goto error;
-- 
2.50.0.107.gf914562f5916.dirty

