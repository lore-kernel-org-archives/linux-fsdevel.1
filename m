Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292D3F7A8E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621873; cv=none; b=f4FXc6vM30KSlKDgd+8wk7zZjqgRm2ZtM68+4ylJtSeJ/hyuIyxhWRPBtcWGZLZYVeBEqPGcACDm/npD0yUCZknuOSP8hk2miUVpGgAg3RQg0Wjqj8g8poafMKPLmNCe+c8ChxHWTApfHS9FAaxU2o3bDpjDGu1NKnzGH8xjbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621873; c=relaxed/simple;
	bh=EkfkQ+B7x5sRll9rfUza1vy0VfOIANzotdV3yf+l2Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G1aBxDgoB67x+dsW/pHviRNk2bASFGKflaZNSK+TgPJuHjEuCJK79frl5w8aQ0IqmO65OHfFT5TPq/bvV8vxr9FJKLykevaEmTX1JN+Rn9NsxJ9bG0DGYS8V4eCcBjCXMWY/7O2EwNcvVETlT91092mmwFOejpcUsOFaA9waQ5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2jSiipa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ljz89hw+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2jSiipa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ljz89hw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JOlsTnwrp0NSbV+2c+o5QMBqiaEd47EO/LWfmDfIOE=;
	b=S2jSiipaPYmBaLNyaarbJJX+sK4B3B+yZCxIbx5RLaRqFPbgQesQSEXZAuNSetC5ybtc+R
	0ufLNUSy4EDdkFmMpGWvjLrcL7SZa9J/MplhlnDV9Rg5stEuiELeXdmFlgCeSUu/a1VpwJ
	EOmc6qooJz4UGQ83AEtF4oJfx3XYbxk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-4fbHAW2YOyGLAt73PLeT0A-1; Fri, 27 Mar 2026 10:31:09 -0400
X-MC-Unique: 4fbHAW2YOyGLAt73PLeT0A-1
X-Mimecast-MFC-AGG-ID: 4fbHAW2YOyGLAt73PLeT0A_1774621869
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7d7eb8cf3d6so6249753a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621869; x=1775226669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JOlsTnwrp0NSbV+2c+o5QMBqiaEd47EO/LWfmDfIOE=;
        b=Ljz89hw+pTuAUTfQ7gkyFYPrQHQaAhMTMuA7as6RcAVNlizCYLA07wkRtcOmruQjvW
         901FDPh9Rld00BBv24aToC4WczCChfhFqG5IGLlPEdJGvtGtaHj8n5dkvSP5TcfjQmHi
         aUWYGrJITCiDlJ7n4QeU57askCN0l6vy65v/NqLdsvpYO7R1oCYb3ijzdWoIx/PWo8n7
         kql8iknK/ChN7DDkDUEMUOCNTE2wVlG3fOFneL8ODd8CSOHoqu0whmdcKq2H84al4tr5
         ANWJxl96TQHDnTJ04lRK2vL+TzCWDzgIatfXALCVR+Q1w+0FCIjVjir1KAmr6qNM7+vk
         8dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621869; x=1775226669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JOlsTnwrp0NSbV+2c+o5QMBqiaEd47EO/LWfmDfIOE=;
        b=XA18ZZA8e9ynwqE6qvhRSwS9qBCuxz+joBPe2YkgvyQUhn7TiUwdIwWMpuXJoS9Hc3
         5IGkWRKIQ3FcdyL7xX12JrHe5tjZAMsfXyRNVvGkvpK/3xtQBkQft6M+oB50cYiIn+pX
         rJTPbXF0vPkBSgIJYEF88F1+i3FTgORopn+StfgwMNpOaFC//5qEgUpSE0otB0fddILh
         y0hrhuJd3ATFkqw94IVD6Sr9RIc5T8CZSfDRSOJ4raJtYOtQks4foVrBpAs/6oMTLWe9
         JRNV+gZSEyuXI7RGsoQdn041SErDlGE1zzECMg2Dt9L4EId5MVKf4mxZFH1AnBN/rcTa
         Prog==
X-Forwarded-Encrypted: i=1; AJvYcCUSJKA1SoB7bNM/MoObk68BhE7XRSi31k/FxrlNFsT9yiTJP1gtfmXnwFr4jeJbWgwilyWzdH7yWXXDAIEp@vger.kernel.org
X-Gm-Message-State: AOJu0YwkGSteQrMGgnvcTVtyFOViKRKOk+6POisJOVzD88IKJ1Hb6IX3
	6BlFpTbkw3dIX0RpWEZMjPVTKO/rNIZC3ftEmI2AUAGpAMcGvBmZF4+MS5EHpaCnoTulGI7bCLu
	SwBHRvy4+imHEE2DDjGfffpstjOYQcQ+pvUH3dUNT2iFzFuKJeeN6Xq3rtN4lhXy63uw=
X-Gm-Gg: ATEYQzzVK2qh3RL0Gywy/K1IzSs15BJfHWuXehEkrZJfbuEtHWWIluotJRkErS3pyF1
	HSFNla4ZeBDDKQk0U6ZRIGOOHwmhNt0lwFuOuOMBTEs8lFNHvqNDelrVTszJUzUh7htjNs35c8K
	TQPv8LLDf68Wc014cntZH3J1JfznS6Bm49yNmKTDPlXHcQtc+5P89n2J26kkAin6EZO67XVZxn8
	f/3GWfBbqauDcI8oynPO52o2LuQFrEWXqk/9zQCVdYrr9fxb4808iwsih0paVikr/ET4IxNGp/j
	FrnIZXG2A/hLa2/97S+7nKui52+2Cu8hlnPrvkkfprLNDH2ZW9sA598adQ/qWePPwIB/T5xjc7Q
	7gWnEKFTnUSGNvepgoGkHUkZCprvZ7HamFwMOuqXuKII/+RiLGgCWHPY=
X-Received: by 2002:a05:6820:f029:b0:67e:1dee:db5 with SMTP id 006d021491bc7-67e1dee127bmr734265eaf.12.1774621869033;
        Fri, 27 Mar 2026 07:31:09 -0700 (PDT)
X-Received: by 2002:a05:6820:f029:b0:67e:1dee:db5 with SMTP id 006d021491bc7-67e1dee127bmr734236eaf.12.1774621868522;
        Fri, 27 Mar 2026 07:31:08 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:31:07 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 09/10] ceph: send SESSION_REQUEST_CLOSE before forced teardown in manual reset
Date: Fri, 27 Mar 2026 14:30:45 +0000
Message-Id: <20260327143045.1393612-10-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327143045.1393612-1-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue SESSION_REQUEST_CLOSE through the normal close-session path before
forced teardown so the MDS can release state immediately and racing
sequence updates still retransmit the close request correctly.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8b86c577c127..864c35c6f55f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
+#include <linux/delay.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/ratelimit.h>
@@ -5391,6 +5392,33 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	st->phase = CEPH_CLIENT_RESET_TEARDOWN;
 	spin_unlock(&st->lock);
 
+	/*
+	 * Ask each MDS to close the session before we tear it down
+	 * locally.  Without this the MDS sees only a connection drop and
+	 * waits for the client to reconnect (up to session_autoclose
+	 * seconds) before evicting the session and releasing locks.
+	 *
+	 * Reuse the normal close machinery so the session state/sequence
+	 * snapshot is serialized under s_mutex and a racing s_seq bump
+	 * retransmits REQUEST_CLOSE while the session remains CLOSING.
+	 * We send all close requests first, then yield briefly to let the
+	 * network stack transmit them before __unregister_session()
+	 * closes the connections.
+	 */
+	for (i = 0; i < n; i++) {
+		int err;
+
+		mutex_lock(&sessions[i]->s_mutex);
+		err = __close_session(mdsc, sessions[i]);
+		mutex_unlock(&sessions[i]->s_mutex);
+		if (err < 0)
+			pr_warn_client(cl,
+				       "mds%d failed to queue close request before reset: %d\n",
+				       sessions[i]->s_mds, err);
+	}
+	if (n > 0)
+		msleep(100);
+
 	/*
 	 * Tear down each session: close the connection, remove all
 	 * caps, clean up requests, then kick pending requests so they
-- 
2.34.1

