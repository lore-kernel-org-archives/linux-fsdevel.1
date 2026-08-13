Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC8473C8C
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786628340; cv=none; b=mG67BW1WPL9bt3nIG73LgI5VZKF6a2Gha9vnkvWD0TvrChVClkuKQIoMaE1OOZh0WmczaFceWaUDfCy0lmRkOZntJkJM0JSKstkASduwfMKF5ESk+mhRy3xtG+zeuydrBM9sY/j1J/5p14/lBJDjg/oBQ0LhDRgl5rCT1AwRrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786628340; c=relaxed/simple;
	bh=IVA4PnY1Zr29q/abnNB/XGGpoMYb+1RRhpB2XE7q/iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRxW7SHL8KTtfw3NmoIpEk2/IqYB4pxdPmII+qXs7+6oZ878JCfwv7at+B7HR4/td4K9DCN5n3r/d9Ddgw9jRgfUmQ6JEhDwStdWYQT2wP0DOMZVe35vGYbFyxn+6TtbsnF8M616201diay0LkHLf0OWnNkWoLtzepV9CGos+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Glt0eJ78; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Glt0eJ78"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1912060a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786628338; x=1787233138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cr9H9LdtxT2Z/rLHgl1Kyq8OxZYrKX/vRWeV8VtNQOg=;
        b=Glt0eJ78IQlzTSPhjbVHDoliJa3olvKuzAioxJ1RWazOTSc1KJhcNfighm2kN9JLAJ
         CV8qDzmmbZY+JNdl6dhP654Moynli6peXlRMNM5eCqEaNdCdAORev7Gvc2eJ/GHNEOR1
         hyP/iYbgv+nYTG9H+KTbQuVAUdpw3VGjQTWWRKYrJpNpTM/h4SXWpr6vp28hrxWOxb4Z
         ADEoJdVOvCWjb5sxxxGKFWxWzswBRkeFURdbEJ664YkbJXdrOJlFkkkUrxqNtMZPxx5x
         PIVVnDKtwTPz5x14zrDlzSfQlOLtkC1QP4C4q8Nh8rqZX1lSapDPTgGbZiSaDQjXbrdD
         uiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786628338; x=1787233138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cr9H9LdtxT2Z/rLHgl1Kyq8OxZYrKX/vRWeV8VtNQOg=;
        b=T8ap4iYGQvVRXcQmh5ULnhvf3ZGJe6643KU6Pt6Eac8dK7Z8K/AHeh78B21yfQQ6ny
         08dFesE/awmnkh+Macgp5QBfz6XEHZ3n0QIDUUGGRWjrupnH5oW0cosxWVxFfuhfVn5Y
         ATFHUYk2r1lzABiDEFIf+8noN9HO2wdXtE6lEZAdzk01sn0LD9WeYSobo6LqV5vqf9Ln
         FZFCDJQ9k7o6W1Qk/6mGIVyCJ5x6/PBmkMTmK4FzM/ujyoJSbarr92psXBeq9NlK9ftd
         U8wyeDhX8h5L4Cmi46Ky4kqJMv4yfSq8MXGmzuayq/MEbA8hTFqjBtqXvRWxV/aV6GRv
         htww==
X-Forwarded-Encrypted: i=1; AHgh+RqJyfnBBBsL56X5TW1kWS8kBKnMQKsARnvDTxJ8pqzwENaeg5vMr2CDt4hpYxInmM+XInHdZ1cQKkFLk0Jx@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiknRP7OJ+4s4CT7GMm/oJyp10mAhmPtl40a+qxnT+7gcTZzM
	6uOHj7eLiskHttj22Uqhx2iergJSy0faPJ8GRZPV3+uWQmQQooDELT3A
X-Gm-Gg: AR+sD12tbdHQeJ3YfjKB3zofxkqAta6kQtK7yjPP9ykd3hxRjLPeCIHThFyjE+GNUss
	wxQ6QQRdA3cEXbpjKU5UnA4b3g7bGcuDfynK/qRNSPyovO5X4YlFYUGtgTXx2QCKgTZuRaVUDIl
	5jE3/lyqvdu0QJyybEjVk4iFLnuQ1F+p1GaL0sYriUCro+Y5d1Tj63lT6jssUaVCTE5cX1x1hcF
	N9v5DrRW96Ib7CDa7crd0rqlGDcbtiJE9hK6kxMWj8Wy5cHEQs650L4wNi+xsmc3O5PGPvT6lE2
	GyAoVlTSYC0t0u+jtnlRfehWbQOH8B/IhGWTDdjl5rOcSwvPvFTxPHPqX7VRgGed+Da9YeDHcDX
	rmh10AenKT/SU3dyozsXLPNFv0KxMvU4YzOoQpG0wdEFmZtsibNCMtvdOa+PzLTpczEXg/HClGa
	G1SSejpu1FggSjKyeRTO6q3GP5KlXU2HDCnbbQ51awlWDRixUpNdsY9t9gIWg1mdND/dgtXou9
X-Received: by 2002:a17:90b:52cf:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-3931e29780bmr6383848a91.14.1786628337839;
        Thu, 13 Aug 2026 06:38:57 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f44ddf3sm3319475a91.14.2026.08.13.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:38:57 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Benjamin LaHaise <bcrl@kvack.org>,
	linux-aio@kvack.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH] aio: prevent eventfd/epoll recursion on poll
Date: Thu, 13 Aug 2026 22:38:43 +0900
Message-ID: <20260813133843.2933127-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aio_poll_wake() can complete a keyed poll request inline while the
provider waitqueue lock is held.  If the polled file is an epoll instance
and the AIO result eventfd is watched by that same instance, signaling the
result can feed back into epoll and try to take the provider waitqueue lock
again.

For example, a timerfd wake can follow this path:

  timerfd -> ep_poll_callback -> aio_poll_wake -> aio_complete
          -> eventfd_signal -> ep_poll_callback -> ep_poll_safewake

The second ep_poll_safewake() recursively acquires ep->poll_wait.lock.
eventfd_signal_allowed() does not prevent this because the wake chain did
not begin in eventfd, so the task's eventfd recursion bit is still clear
when aio_poll_wake() decides to complete inline.

An unprivileged process can construct this graph and make a CPU spin on the
recursive lock.  DEBUG_SPINLOCK reports "BUG: spinlock recursion", and
lockdep reports the same epoll waitqueue lock as both held and requested.

Always defer eventfd-backed poll completions through the existing
aio_poll_put_work() path.  At this point the request has already been
detached from the waitqueue and active request list, so the work item can
publish the completion after the provider callback releases its lock.
Poll completions without a result eventfd remain inline.

Fixes: e8693bcfa0b4 ("aio: allow direct aio poll comletions for keyed wakeups")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 fs/aio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index f57fa21a250353..ef801781da08c0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1869,7 +1869,12 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del_init(&req->wait.entry);
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
-		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
+		/*
+		 * We hold an arbitrary provider waitqueue lock here.  Signaling a
+		 * result eventfd can feed back through epoll and try to take the same
+		 * lock again.  Defer all eventfd-backed poll completions.
+		 */
+		if (iocb->ki_eventfd) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
-- 
2.54.0

