Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27733F7A98
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621869; cv=none; b=Lsgn1i91LKnqeeMlpyWlcIzt+CCt4joSM+994DWHLejmODtoBGeAM+hT9bRaGkcqQrsjGtd9MDF9+BIm0oC1UDnNJP3X/3kTgnVaXj3mVJwz9z4wLJwKgkY9KD1QliC/Gvvp0OGgKWjviH9WhV+4g4+Z0/h71kMcZwUiHgcuyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621869; c=relaxed/simple;
	bh=XPJZrzoUth9e1Uhf1SEbHsAGNz7j7+TSaqV/IyP+VGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KoxNvr7akHP3TOLpEFLolFOFzH6Nermx0UBprc6yp1amgboGMikLkB5+GDxqT35gNE0Wy5N5YAndwthjNG0WxgNAHEaX/4qMtSZEmA/93BC8fueipYxSYIIEwyFjv5WqYpw33Rzc/25qJR67fiAJSpg2Kz5I9aiXm3ww6fLZLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUqkxXkS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SR7t43YG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUqkxXkS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SR7t43YG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WPJ7OKYoLUXkftA3otWt91AKLSMPduHwj4ssYB6cRjE=;
	b=aUqkxXkSs6UnzvLZTCeFnn0ulMuAz0mhXuKuDgonMHvmS3ek2oCx+Ve4+bP7SvjBLsSaAS
	0340LmJ4C6kppHI/J2SxD2PGyBN/+D4JsJiFbIytlqWJANhKPG5tsGTe0t9jBnXWT4SkWV
	nAmkOf8j9RJbiloENw76sAZRbctYvuo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-z-t_cSFnMIGqrE475umvNg-1; Fri, 27 Mar 2026 10:31:05 -0400
X-MC-Unique: z-t_cSFnMIGqrE475umvNg-1
X-Mimecast-MFC-AGG-ID: z-t_cSFnMIGqrE475umvNg_1774621864
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cfbfac0e05so496467585a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621864; x=1775226664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPJ7OKYoLUXkftA3otWt91AKLSMPduHwj4ssYB6cRjE=;
        b=SR7t43YGHZ4RZAvtyQoJavjQayIB8YFmJFrmZ9QmmYzP65lbf4oUBH85N2m7mWJaFj
         tZFjMHhnZZGiZ0kBwYkGWNy4nXLr/HvfxCWlvAvN+ah8hMTIGOFyAqVtHdMyRrTMgLU0
         J2JDOdrwzTd3iaiBE9l8PC08Cre2s8pGMoBTzD+2LP1xLdA3TetFUBXxvW0Pq4++nBco
         I42khNDDr+xm06BrXI5DGGAo77H953KBS0Jdu2MuyzNwvjj9zglvtPhJNel9uXYPAnrk
         ZegAKwetQaRdnAkG342xA3Hk4LPlv8RTVIagY4q4+WDN3T3N4Gz38ol+AB1wZ6+8Hnum
         SklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621864; x=1775226664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WPJ7OKYoLUXkftA3otWt91AKLSMPduHwj4ssYB6cRjE=;
        b=LT473JgGbbrfpbcgBfvr0dADz65hhrr1iB4gpZtFNnWcAyUW3/Tw9FapH8Ydae1Uba
         v8Ib+Sr36h0LurkJEigzYf9NZ4aG5B3tr3IFqT1QBxji+KxeUa7Xc44VXd2g6W1/eXCo
         Qsyd2X+6ZynaY2ZmVh+xtXiDHWQ6gBTC10sn7DWedMqIGT0tq82dDd5VzYgx83mr2Q/n
         rD4paB4RJAAJwILRwAgxT88vN0ywGkSgUpiyY1rHaWlPbNNV8L2JG+Twvod5Wiot5fyz
         QFvOHMBf7z4Y+enArNS5pOfyPPRBa1k2jSpGe2EDaEX0xpnwwPfzwYCGVAFkU8QJ3+Mt
         dcig==
X-Forwarded-Encrypted: i=1; AJvYcCUs0EZNqXzSvAj0cAdsOsnTfkWFUIPtNl3/1D1BvDRlSCaj2sMu8zm/i5Jiqj6xQxcTzETr9iyxpXr412a1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7S5TdxTq5QH94x65RGEGaIGM71dAyTeBAxz1eKXePZZmyL893
	NAmfXSvWOg16tJsCH9w/myjX9Tqszc9VkjyGZfRschmttJ3s4InVLkPhu71xzDHUqCruZt5/EQz
	2hleau12ivS37x5ZcTqYZ1FKKrmQhn6/gEA+hxIiImux/Evx82DkpI7hIB03xLjcwoa8ECVK4uF
	JYDg==
X-Gm-Gg: ATEYQzxnwFluaQcTiAzOunmb0fj40L5P21BJuicKIkruN8EGQXUJEUGMtMq8Ozpkusa
	bX2nKUygzdKjY7wn6DAPdtuVXK+VLb3PT+GpA5CssbwqzI4QyW/rGLyZnDhDvpBefcZjk+886f+
	kTnVQxaDcvQxJrj0EfysTe7TwujTeXcVdDbrCVC1KWQIIqYDD9UJ/SndK6P7Z9KKc8qNtYURuB7
	aCI9j6z6pw9DXac+6Tm53P19zNe03uIZVxId/xBewEAWlGrdn5SUKKO7SvRXgD2Vq+oWYwQOkjR
	B3SMS4GJkbCXBeRcer/HymeoT9xv/5yFd/4MEY28X09mJCEcWWuqtmBEc8nO6tAoSw469yDWrvG
	JsWBhsPhVVmsOba4YCpfh5PcEXny/7yUYzz7QAIX4B8RIAHk6InePTD0=
X-Received: by 2002:a05:620a:458b:b0:8cf:dbf0:502b with SMTP id af79cd13be357-8d01ce8233cmr264893485a.31.1774621864003;
        Fri, 27 Mar 2026 07:31:04 -0700 (PDT)
X-Received: by 2002:a05:620a:458b:b0:8cf:dbf0:502b with SMTP id af79cd13be357-8d01ce8233cmr264886485a.31.1774621863305;
        Fri, 27 Mar 2026 07:31:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:31:02 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 06/10] ceph: replace reconnect with direct session teardown in manual reset
Date: Fri, 27 Mar 2026 14:30:42 +0000
Message-Id: <20260327143045.1393612-7-amarkuze@redhat.com>
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

Reconnect only works during the MDS reconnect window, so it cannot be the
recovery primitive for an operator-triggered reset against a live MDS.
Switch the reset path to discard local session state directly so the
client can break capability stalemates and rebuild clean state without
waiting for MDS-side reconnect support.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 84 +++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 5a2a9e473058..766744468dd6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5297,7 +5297,6 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	char reason[CEPH_CLIENT_RESET_REASON_LEN];
 	int max_sessions, i, n = 0;
 	bool inject_error;
-	u64 reset_gen;
 	int ret = 0;
 
 	spin_lock(&st->lock);
@@ -5305,7 +5304,6 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	inject_error = st->inject_error;
 	if (inject_error)
 		st->inject_error = false;
-	reset_gen = st->active_reset_gen;
 	spin_unlock(&st->lock);
 
 	if (inject_error) {
@@ -5341,9 +5339,8 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 		 * mdsc->mutex -> s_mutex, which would invert the
 		 * s_mutex -> mdsc->mutex order used by
 		 * cleanup_session_requests().  s_state is an int
-		 * so loads are atomic; send_mds_reconnect() will
-		 * reject sessions that transitioned to CLOSED or
-		 * REJECTED under s_mutex before proceeding.
+		 * so loads are atomic; the teardown loop below
+		 * handles races with concurrent state transitions.
 		 */
 		switch (READ_ONCE(session->s_state)) {
 		case CEPH_MDS_SESSION_OPEN:
@@ -5354,12 +5351,12 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 			break;
 		case CEPH_MDS_SESSION_RECONNECTING:
 			pr_info_client(cl,
-				       "mds%d already reconnecting, skipping\n",
+				       "mds%d already reconnecting, skipping reset\n",
 				       session->s_mds);
 			break;
 		default:
 			pr_info_client(cl,
-				       "mds%d in state %s, skipping reconnect\n",
+				       "mds%d in state %s, skipping reset\n",
 				       session->s_mds,
 				       ceph_session_state_name(session->s_state));
 			break;
@@ -5376,54 +5373,53 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 		goto out_complete;
 	}
 
-	/* Initialize completion tracking */
-	reinit_completion(&st->reconnect_done);
-	atomic_set(&st->pending_reconnects, n);
-
+	/*
+	 * Tear down each session: close the connection, remove all
+	 * caps, clean up requests, then kick pending requests so they
+	 * re-open a fresh session on the next attempt.
+	 *
+	 * This is modeled on the check_new_map() forced-close path
+	 * for stopped MDS ranks - a proven pattern for hard session
+	 * teardown.  We do NOT attempt send_mds_reconnect() because
+	 * the MDS only accepts reconnects during its own RECONNECT
+	 * phase (after MDS restart), not from an active client.
+	 */
 	for (i = 0; i < n; i++) {
-		int err;
+		int mds = sessions[i]->s_mds;
+
+		pr_info_client(cl, "mds%d resetting session\n", mds);
+
+		mutex_lock(&mdsc->mutex);
+		if (mds >= mdsc->max_sessions ||
+		    mdsc->sessions[mds] != sessions[i]) {
+			pr_info_client(cl,
+				       "mds%d session already torn down, skipping\n",
+				       mds);
+			mutex_unlock(&mdsc->mutex);
+			ceph_put_mds_session(sessions[i]);
+			continue;
+		}
+		sessions[i]->s_state = CEPH_MDS_SESSION_CLOSED;
+		__unregister_session(mdsc, sessions[i]);
+		__wake_requests(mdsc, &sessions[i]->s_waiting);
+		mutex_unlock(&mdsc->mutex);
 
 		mutex_lock(&sessions[i]->s_mutex);
-		sessions[i]->s_reset_gen = reset_gen;
+		cleanup_session_requests(mdsc, sessions[i]);
+		remove_session_caps(sessions[i]);
 		mutex_unlock(&sessions[i]->s_mutex);
 
-		err = send_mds_reconnect(mdsc, sessions[i], true);
-		if (err) {
-			bool skipped = (err == -ESTALE || err == -ENOENT);
+		ceph_put_mds_session(sessions[i]);
 
-			mutex_lock(&sessions[i]->s_mutex);
-			sessions[i]->s_reset_gen = 0;
-			mutex_unlock(&sessions[i]->s_mutex);
+		mutex_lock(&mdsc->mutex);
+		kick_requests(mdsc, mds);
+		mutex_unlock(&mdsc->mutex);
 
-			if (skipped) {
-				pr_info_client(cl,
-					       "mds%d reconnect skipped during reset: %d\n",
-					       sessions[i]->s_mds, err);
-			} else {
-				pr_err_client(cl,
-					      "mds%d reconnect failed: %d\n",
-					      sessions[i]->s_mds, err);
-				if (!ret)
-					ret = err;
-			}
-			if (atomic_dec_and_test(&st->pending_reconnects))
-				complete(&st->reconnect_done);
-		}
-		ceph_put_mds_session(sessions[i]);
+		pr_info_client(cl, "mds%d session reset complete\n", mds);
 	}
 
 	kfree(sessions);
 
-	/* Wait for all sessions to complete reconnection */
-	if (!wait_for_completion_timeout(&st->reconnect_done,
-					 CEPH_CLIENT_RESET_TIMEOUT_SEC * HZ)) {
-		pr_warn_client(cl,
-			       "reset timed out waiting for %d sessions\n",
-			       atomic_read(&st->pending_reconnects));
-		if (!ret)
-			ret = -ETIMEDOUT;
-	}
-
 out_complete:
 	ceph_mdsc_reset_complete(mdsc, ret);
 }
-- 
2.34.1

