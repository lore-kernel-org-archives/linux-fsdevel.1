Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A12E62B4
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780850507; cv=none; b=hzecsKoFKPjHmpIxjJkgmo7tBQmKjF8KEdBduvKXOqzfNGBACYsa9jH5hMPlipz6LnrULynZpDLYtN8+kezw0loc9/nga7Xz7HIwaQAVwU61c77yon1CHE/Mik3xuLkdqJDGExkJvMrEB6rMv68qihN2tIRvBuo3juJhKdrHtEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780850507; c=relaxed/simple;
	bh=CCrO6o6I/44fGERYpw2G9jNquTJckifKwcNnAlTBN+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jtHYTPwbMi8L4/quGIIy+KuudbGuo8/APCLqd32+emCyTXMKV49mVeqTDaScTamnv+yt64dZHz0NHTgHjJUoRUDH77zsMzaq1CEPDv3R1PD7qfzfI7JMN8djN8Fp0ycabxb4aBaBorGONsK5Ue1vZvyVp9n+ZIBhHF3HqFWcOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nk6jgTy6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nk6jgTy6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780850505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WIHNhvJQiRboLg+AfNPP7AzlUEsSEyJ/NWlMKBexDIE=;
	b=Nk6jgTy6JfbeWeKaM6zb5TEpCDtAHWbtUcW+UW8bURLJQxCeRv2egu0f7B65G8Cs5lDnWy
	e5hoxnTnk3ZYeG0WYSZz7ByYYgXloulrY8LaXuhaX3G/QOUmtyxsMeaPLfsQAT4eTsdhw0
	Gw/1B2gHN9isrQ0o0FkwWdQSaxYhszk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-HW5hXfzyOZmGUPahOhUUZQ-1; Sun,
 07 Jun 2026 12:41:42 -0400
X-MC-Unique: HW5hXfzyOZmGUPahOhUUZQ-1
X-Mimecast-MFC-AGG-ID: HW5hXfzyOZmGUPahOhUUZQ_1780850501
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00643195608B;
	Sun,  7 Jun 2026 16:41:41 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.44.32.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8B1030001BE;
	Sun,  7 Jun 2026 16:41:37 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/3] file: add fd_except cleanup class
Date: Sun,  7 Jun 2026 18:41:34 +0200
Message-ID: <20260607164136.2948550-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

CLASS(fd_except, f)(fd, mask) allows to specify whether to accept or reject
O_PATH file descriptors by passing a mode value of 0 or FMODE_PATH rather than
using a specific cleanup class for each case (CLASS(fd, f)(fd) or CLASS(fd_raw,
f)(fd)).

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/file.c            | 5 +++++
 include/linux/file.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 2c81c0b162d0..c34049b36e6f 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1211,6 +1211,11 @@ struct fd fdget(unsigned int fd)
 }
 EXPORT_SYMBOL(fdget);
 
+struct fd fdget_except(unsigned int fd, fmode_t mask)
+{
+	return __fget_light(fd, mask);
+}
+
 struct fd fdget_raw(unsigned int fd)
 {
 	return __fget_light(fd, 0);
diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444d31..947765f064fe 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -70,6 +70,7 @@ extern struct file *fget_task_next(struct task_struct *task, unsigned int *fd);
 extern void __f_unlock_pos(struct file *);
 
 struct fd fdget(unsigned int fd);
+struct fd fdget_except(unsigned int fd, fmode_t mask);
 struct fd fdget_raw(unsigned int fd);
 struct fd fdget_pos(unsigned int fd);
 
@@ -81,6 +82,7 @@ static inline void fdput_pos(struct fd f)
 }
 
 DEFINE_CLASS(fd, struct fd, fdput(_T), fdget(fd), int fd)
+DEFINE_CLASS(fd_except, struct fd, fdput(_T), fdget_except(fd, mask), int fd, fmode_t mask)
 DEFINE_CLASS(fd_raw, struct fd, fdput(_T), fdget_raw(fd), int fd)
 DEFINE_CLASS(fd_pos, struct fd, fdput_pos(_T), fdget_pos(fd), int fd)
 
-- 
2.54.0

