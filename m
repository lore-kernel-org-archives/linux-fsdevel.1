Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FA039A049
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331041; cv=none; b=fN24OAVZ8gemYY06HMIfltqu0sSbcoVwOsFAyLSynEbNhwoIJLt0dcIgBUWLnwQ37Lh+Y6psG2+kUxsQ30YxjjapKaUcogguCG/cWEqAv+x4J+5vl11A/TXPX+F1hXhyzqMgBibWkhxr2+60v7k4g3oNT+3uCSlkIUeA08bcco4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331041; c=relaxed/simple;
	bh=CY45qDEWcR+0Y3mSqVSEOzwYND4TCQUSXJ2qk49u0rY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAxpXSz1t+J/6lhaPEwJnDhdHCPpuCjK9fBeWTLO6SthnYdZLZiF7egZAEuU9z5+QQ7hqqz/WNLgToGsaXCAq1t7smRPX9Dk+IqDSuNFbJcV/EJ3WRLcjD+RhyFVqceF8KNyVTIX6OFWhdZhkwIhBWDvMb6ABlmBrGb9wfCdpdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EblAvyY+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fAvDyXlI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EblAvyY+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAvDyXlI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkzO7m4jiYzlyojmiFJDVWvDhnuTG+0Vzpc4hhsZS3A=;
	b=EblAvyY+XdRyXRO7vsnOCcl/N5y623pZg81bpFG7Kac4mPK+x+shTuM3fmCUyqozgs1CNq
	RlIDN083Ot5SZ2lv6kRncAYTwHpfXRMgYqvNQX1oqWuNRw36lhUbNpW1uv44CttfF5vJl3
	UTY/JnDu/Ngd9sNCEsTRxaBA3n65Kds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-EUYQA84UOgW907TeC0XYdg-1; Thu, 16 Apr 2026 05:17:16 -0400
X-MC-Unique: EUYQA84UOgW907TeC0XYdg-1
X-Mimecast-MFC-AGG-ID: EUYQA84UOgW907TeC0XYdg_1776331035
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso39713435e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331035; x=1776935835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkzO7m4jiYzlyojmiFJDVWvDhnuTG+0Vzpc4hhsZS3A=;
        b=fAvDyXlIgHZ/t7Oa3huj4kC9reQebnOS2S6ZcgrtkwN+aE3qxlDPafgiPfHj2r+KfY
         YLw7ImLSfuOZIembG3omCxCOUvG6uOkzPykvBNupu/klxfIQn4iDYRxJxOB/gc99Y11w
         /PXA//gA4uPApozIeZxnamxiOt4qPFpe4cJ3SoUK8eMRyDoDrv7llKJVZFjgtr6Znnn0
         1ClVYdyB0M9sXrBRsZbdr8JMbpyeKwa6a4/H+WCvr50LrbawALA8LtaUbWXqKkdOyqso
         yB+ueR98iL6OCt6N/l/PsYjTHKl309cHPvWJBIDHiGQzz/ygKUnnx44B/Lfc0/KYtGz2
         T8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331035; x=1776935835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DkzO7m4jiYzlyojmiFJDVWvDhnuTG+0Vzpc4hhsZS3A=;
        b=Wz1kKYuZcAez0vciEEd9tUi5MMfots3r9a8L2xowyObcwxC5+0vLCUgGxzhfL0itTc
         yrSryfVbhr9EWLrSoAIRQX7XK2niY0uXRdrok7n529oHfe4TRRSrkDL0j/m18I0rV4Ru
         YoSNsbLyxZQKXxA1QfnpLJLss83+QPClW1j/Kcky1BCAr9u/vRIJdT0ntY0XbFQhR1Ag
         6mGXa7J+u6BLn0vHP/K31+L1Amq2YhLYMk/CQ3jVqLX3KZghNvejIYOl1sWN69dWYp1n
         VhAn77JQxcOKUQELd0mEJhGdBsoKvDgzdCTjpySHK21AN/WMcXhfR/gXpq0mnD+2f2Mk
         y0RQ==
X-Forwarded-Encrypted: i=1; AFNElJ/SmiEGl3QuzzyyrIvv+7xJ4HDENl9RbR0wRNzsUeH6QtVM+RFSqW5wyaA8KcSQSM/4xHlXx6Ai6fgwHE0q@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2bPnv4gAVwcSCVKbaY1S1kuYpflOtbAJYOsX7n3s9nFoIudt
	TUF3tBvajJIF6w7H79jmznUBMLagMHojrrQ87PwmpvlwLq9YRy3R0QytsKHMqzPyDIEinfu4KNw
	WI47qoJRS+7Xz6LcVG7SDJC6f+NDTAT/a69X4vDVY2d64EE8HjnS6Z1zvdGhgpbsM2mw=
X-Gm-Gg: AeBDiesvoCbHLOcouuS4awdvDDcsQA96gwjvgZLdJl+OokPy5t2n+GndhDW+iofRmAN
	fWiG0avlvIbxJ3LHKNJY2EQuDFsob8jNyIWvA3qIGEEx354eHmXvjpf27gpjp+d81oHZ+idsjlF
	lJKs6qbGGANgoIR1drPRF+z2hpu2YkqG1jiH8aPZW6be5HMStzhzEh654hE5G1HVb1GGAZSJdyz
	8q2P0h9FambmM9RUb16jZaDJnI1mw+FFMrYIGekzcB/7hEGbkrcKavDSfFcH6Yf6lLZ/x1BDH7g
	F/3tvPycUJNN2IsF2OtQWGpQG2HqwwW2pjlZmXIe0Gv3JXqkf5PjmZWznHVB0BKxIYRpSNEEE1q
	bjug+hWgxEgjZTWEzSC+Gg5AcBO/VhJDxdXO8geqLFDp4A0zh8fmF3CTLM03XRqD8XmxI5M8Ce7
	hBSzgytw==
X-Received: by 2002:a05:600c:c10f:b0:487:cd8:4c9 with SMTP id 5b1f17b1804b1-488d689ca8dmr239063345e9.27.1776331035273;
        Thu, 16 Apr 2026 02:17:15 -0700 (PDT)
X-Received: by 2002:a05:600c:c10f:b0:487:cd8:4c9 with SMTP id 5b1f17b1804b1-488d689ca8dmr239062945e9.27.1776331034791;
        Thu, 16 Apr 2026 02:17:14 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:13 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/32] fuse: move interrupt related members to fuse_chan
Date: Thu, 16 Apr 2026 11:16:33 +0200
Message-ID: <20260416091658.462783-10-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416091658.462783-1-mszeredi@redhat.com>
References: <20260416091658.462783-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move:

 - no_interrupt

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c        | 4 ++--
 fs/fuse/fuse_dev_i.h | 3 +++
 fs/fuse/fuse_i.h     | 3 ---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4d21e22301ed..34ef117daa3f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -607,7 +607,7 @@ static void request_wait_answer(struct fuse_req *req)
 	struct fuse_iqueue *fiq = &fc->chan->iq;
 	int err;
 
-	if (!fc->no_interrupt) {
+	if (!fc->chan->no_interrupt) {
 		/* Any signal may interrupt this */
 		err = wait_event_interruptible(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
@@ -2295,7 +2295,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		if (nbytes != sizeof(struct fuse_out_header))
 			err = -EINVAL;
 		else if (oh.error == -ENOSYS)
-			fc->no_interrupt = 1;
+			fc->chan->no_interrupt = true;
 		else if (oh.error == -EAGAIN)
 			err = queue_interrupt(req);
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index ff1c62297e01..bfd349b88097 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -129,6 +129,9 @@ struct fuse_chan {
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
+	/** Is interrupt not implemented by fs? */
+	bool no_interrupt;
+
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 701bb18dcb00..59bdabaf994b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -659,9 +659,6 @@ struct fuse_conn {
 	/** Is create not implemented by fs? */
 	unsigned no_create:1;
 
-	/** Is interrupt not implemented by fs? */
-	unsigned no_interrupt:1;
-
 	/** Is bmap not implemented by fs? */
 	unsigned no_bmap:1;
 
-- 
2.53.0

