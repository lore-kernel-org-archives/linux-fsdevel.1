Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF884AB3DF;
	Wed, 16 Sep 2026 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573990; cv=none; b=WDWCM2BTh9MvYREyt6ljAqttfQ+WxxfiB0iBsizOx51+H/KTaTcUcPb31MWwDtKpi/I63zZ4NPL5wVwy7QoAXfm/hINsy30F9j17UGiGFd7wbfak277a9DJh4IrV+YXeBAF3T+eCVJbdJ1XicW2H0UqnSXBYZ91Wyae+uDkQE2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573990; c=relaxed/simple;
	bh=dataTan/ZXK5BwZivXrAZme5lbqY0TVdliRvlvdywFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=psncD3jn0oUavVkVx6HDUO/EtjndDO583N2QSIKvrI1nrFOr8CxSTO6FkLoe9x/yKbOp5E38RZzdsp9xkGFATcOFPJ4sq3xBFotS98H4krg6YXUqKGS1lLElqL5Dtfrocf20IUKxX+aWa80o0eZOsYF47NVn7VNF8AZkGGgvsGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VifcbxNy; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VifcbxNy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=jW3EbuhQ9iZIHmNBC87FNoVwi6iyoQcMLiW7EUWxFww=; b=VifcbxNyGWbunNuYnrn0caisFm
	smWTwAuo5gkP12+INmGZ80i5mq1Rp8MXF2yTL/teQ0iRTrakUedv4BKazS4wgadjERv0nElms+2z6
	OAklmn4YlC+5/ShBtYDKQf7pumDg88tcJRfJt++YxyGWHlhaiRPLGePjhH6KP09UwWCLUT9qR8N/x
	3Md2uc+j2bDDgzaJOU4DOKpLCnwt3CDOzX80+QHOS2B6AiaFNkZC+V6/5X5GvhgC5NafoiBxyGigz
	7/9zZwibf/6w5bPwLXWrrbZzNQR8+7TWwnjL7QNiK48PtAi+rnSkTjyBDe1LmI7sxN6v/caGVAbnr
	tQWHZA6A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6rwR-005HHv-22;
	Wed, 16 Sep 2026 15:53:00 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Sep 2026 08:51:02 -0700
Subject: [PATCH v2] splice: pass a poll key when waking pipe readers and
 writers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-b4-splice-poll-key-v2-1-da9ff83469c3@debian.org>
X-B4-Tracking: v=1; b=H4sIAOW6qmoC/22Nyw6CMBBFf4XM2jEtL8GV/2FY0HaAUUJJi0RC+
 HcLxp3Lk9x7zgqeHJOHa7SCo5k92yFAfIpAd/XQErIJDLGIc1HKDFWKfuxZE4627/FJCyp9MZk
 RRjR5AeE4Omr4fUjv1Zf9Sz1IT7tpX3TsJ+uWozrLffcL5P8Cs0SJaVLUskwySY26GVJcD2frW
 qi2bfsA4awsBMcAAAA=
X-Change-ID: 20260915-b4-splice-poll-key-bc7d5d0d0f68
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: mjguzik@gmail.com, oleg@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173; i=leitao@debian.org;
 h=from:subject:message-id; bh=dataTan/ZXK5BwZivXrAZme5lbqY0TVdliRvlvdywFM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqqrtX73Ed3WFzwAeUU78TPui5Ecu6XlT5bGZmV
 Atu9D2naQCJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqq7VwAKCRA1o5Of/Hh3
 beTyEACm0JQJZzhE1jkmPsFN/BSz1iwkDtk4C6LrtO1KfyNWr0MwKB8zuMPmX8LESWPbC96Fd73
 FhMqhlLddNhuY/Y5PSTWVsmBE+qznJrmIm7rktFYdYcArHmjnpXRB7oxmOwifhXXpCIiSFgOx6J
 Kvp4K5pS7GwtqbICmgiPcOP+BVatardgv3n69CSYVf6iiXEwpuW2YpgolFTJ5IClQf5AT97RFss
 4ybXiquG3KXfzmDc1DcU5za7iE3YnsdRUW4OapFwO0/hZvdgrVAMVqsGnY5KCK+6UspB8TqhYUQ
 6e8bzaCL7WQUGEA/GRkIOMgicAK4pSElqW7hWv+N3K7knwFfcCbIgLnxlCf6KTM9PLqHXIFk+Ax
 WBAbjbh18P9kSmBTSsixCZRJBoNS7S/bbyxQbFerZyP/GThK5WLe+WC6sVi8V4VKB9nhdkdqMXR
 iGrRFBMRRiAocxfY5NZGse0KNkHP+nctqGOCMhI/Umb/78tliI/kwUuZn4p2/6bnrhsfMPU1TOn
 /OwLHP2EWyRjWBMnlPGT1QudlVRf/N1yIBiRFdPVHqU1Kg2IpTMLCkH8SoLxan5j8vHnsltuDGH
 GI1DUadzVM9nHrCsRikFEbSgMOFmyndqqvCalWlEODsO3YZ26oPs3BQjGA6AY3Bg4dPQEH8dsIc
 57mDtTRYVS3yoDA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

wakeup_pipe_readers() and wakeup_pipe_writers() wake the pipe wait queues
with a NULL key.  ep_poll_callback() and pollwake() only filter on the
registered event mask when a key is supplied, so every epoll, poll() and
select() waiter on the pipe is woken, whether or not it asked for the
event that occurred.

anon_pipe_read() and anon_pipe_write() already pass EPOLLIN | EPOLLRDNORM
and EPOLLOUT | EPOLLWRNORM when waking the same wait queues.  Do the same
here.

This is not visible in common pipe use: ordinary pipelines move data with
read()/write(), which already passes the key.

While here, both helpers open-code wq_has_sleeper(); use it instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Oleg Nesterov <oleg@redhat.com>
---
Changes in v2:
- Use wq_has_sleeper() helper, as suggested by Oleg Nesterov
- Link to v1: https://patch.msgid.link/20260916-b4-splice-poll-key-v1-1-438a19351efb@debian.org
---
 fs/splice.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1ab..65f9090c3438c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -177,9 +177,9 @@ static const struct pipe_buf_operations user_page_pipe_buf_ops = {
 
 static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
 {
-	smp_mb();
-	if (waitqueue_active(&pipe->rd_wait))
-		wake_up_interruptible(&pipe->rd_wait);
+	if (wq_has_sleeper(&pipe->rd_wait))
+		wake_up_interruptible_poll(&pipe->rd_wait,
+					   EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 }
 
@@ -413,9 +413,9 @@ EXPORT_SYMBOL(nosteal_pipe_buf_ops);
 
 static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
 {
-	smp_mb();
-	if (waitqueue_active(&pipe->wr_wait))
-		wake_up_interruptible(&pipe->wr_wait);
+	if (wq_has_sleeper(&pipe->wr_wait))
+		wake_up_interruptible_poll(&pipe->wr_wait,
+					   EPOLLOUT | EPOLLWRNORM);
 	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
 }
 

---
base-commit: 587858367581b9c55c3690f4e63382ad622719d4
change-id: 20260915-b4-splice-poll-key-bc7d5d0d0f68

Best regards,
--  
Breno Leitao <leitao@debian.org>

