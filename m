Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1AB392C5F
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 04:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781239273; cv=none; b=OcyYBK0RPkhFumpt41mWA6Rxp9BJvKYw/xEXVrNwG09EK3vFfPahrzo/c1qyY9Vkg4iqow4LQm2Xq+B9eDzDDPGFm3coD4JB9rlsxzbseGXYlDMoAWQSB2Yu7Em0KfhkqOA3mV/9PC1Cu1LbftZg0h/Tnst7bY72ygDVOb8JOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781239273; c=relaxed/simple;
	bh=x81kxixyE+xfArgekk12Kg6ymX9cZeMqj5X4nnIgs4k=;
	h=Cc:Subject:Message-Id:Content-Type:To:Date:From:Mime-Version; b=GpyKkiPw7i66LUt2EC2/qVJ1B1BZW9jeh1+I7UlyxQrGXdsX6SFkU2Uhs4P9fzAoIQzz0ypZLpr8BbxjhQrhmGLF5myxsMeaH5Wtw7rGq+/dAoImOda8i49nqeUnAMJrfjs9zKqYyTkW6Qal6IhM1XJ1aTaojHNWAZyoZ+EZXbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=p5od5RRy; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="p5od5RRy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781239265; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pMFfVfOeHzF23fXRpBnoi8xUiqMDnfd7vCQsVj93Pwo=;
 b=p5od5RRywAG4KY+u+BFlF59KxE0rjzq/QuQiNT3k3dnuW3b8vT45uNVjXtbvH5HcHVMa3F
 vzymNI7rAGzAr745WnZBjknQNwzhxnJdTmW6NFNh6Z95xSF0yE9ysIT4yAQ1imi1pBNFRB
 XmEKMELzXwI+3d5mIpiY3yHk7DtB1bhpi3p3RObwiI8WrDB8EZ0O/4heLtslacDYcij7EM
 044sSvsSh+HMvrADFc3CkRRqI6swmLwZ10JMtJv1z6lTcEHetjg6AdbzdZspLsmeQz7npv
 fk3U9M3sdch6SNL/ZaWLUggCQu8QydgBATxhPMf8fbjjdD685kC5Xkx+SxFW9w==
Cc: "Fengnan Chang" <changfengnan@bytedance.com>
Subject: [PATCH v1] iomap: release pages on atomic dio size mismatch
Message-Id: <20260612044041.10677-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset=UTF-8
To: <brauner@kernel.org>, <djwong@kernel.org>, <hch@lst.de>, 
	<linux-xfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
X-Original-From: Fengnan Chang <changfengnan@bytedance.com>
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jun 2026 12:40:41 +0800
X-Lms-Return-Path: <lba+26a2b8ddf+9c9c63+vger.kernel.org+changfengnan@bytedance.com>
From: "Fengnan Chang" <changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

If bio_iov_iter_get_pages() or the bounce helper succeeds but builds a
short bio, the REQ_ATOMIC size check rejects it before submission.  The
old error path only dropped the bio reference, leaving any pages already
attached to the bio unreleased.

Release or unbounce the pages before falling through to out_put_bio on
this error path.

This bug was reported by sashiko:
https://sashiko.dev/#/patchset/20260608073134.95964-1-changfengnan%40bytedance.com

Fixes: 9e0933c21c12 ("fs: iomap: Atomic write support")
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 fs/iomap/direct-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index b36ee619cdcdd..9fedf367c3ebe 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -369,7 +369,7 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	 */
 	if ((op & REQ_ATOMIC) && WARN_ON_ONCE(ret != iomap_length(iter))) {
 		ret = -EINVAL;
-		goto out_put_bio;
+		goto out_bio_release_pages;
 	}
 
 	if (iter->iomap.flags & IOMAP_F_INTEGRITY) {
@@ -393,6 +393,11 @@ static ssize_t iomap_dio_bio_iter_one(struct iomap_iter *iter,
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 	return ret;
 
+out_bio_release_pages:
+	if (dio->flags & IOMAP_DIO_BOUNCE)
+		bio_iov_iter_unbounce(bio, true, false);
+	else
+		bio_release_pages(bio, false);
 out_put_bio:
 	bio_put(bio);
 	return ret;
-- 
2.39.5 (Apple Git-154)
