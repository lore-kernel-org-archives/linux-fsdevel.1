Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD0B476CD2;
	Wed, 16 Sep 2026 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789547893; cv=none; b=qh51nH2LmXyEA7XUJFWJw7811Vm6P+UaMXdwG8yoybKGVrNRDL3DZ2R63/pcPNjwoAr5XYcnb36PAmsxll+CKxbDbV5mrjHC8bE7KVE6jR5p/N/AsU1mQ0xXmlrMsJyz/o+nUG0g5W7bZ3/UFP1KVLwDlay+0l9mxsLx0E7B2fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789547893; c=relaxed/simple;
	bh=1P6BcVTjsa9hD38aaby1HdGhOKx9VU6Mn+xrQ2vBZZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gvaeijHx9H4bkH5PupPHlDrEfnbWHUiQC96jkWLfhH1dMJRfpOcKnmTbC54kTUlnDlkGV0vIfFllNGGBhwPSQOrVkugrFHicoXVM1VdMDXR/7FIhSmBuGW+5/Ao7WyAZ1wTwtDR9LvMmZkm4ywoeX+N5e1mjhGJsYQiejyR/pqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=m3W77v29; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="m3W77v29"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=ZxTEjD838HejWjewRG4roQBMhM3Naoy/Z6g4rRdYtfU=; b=m3W77v29NpPllDh+6IVF6VVMLr
	x57nZfZGED76Ox6yKf9Hecpj8lSZa9x0HzjqZBVgdfMcSn3qZOXl/TKBg2w/5SfEhqQilDx10AKbU
	B9tLTy250h6XTszGqKrQtViHBSjfp1S5CieMS1qmpO2r3TR7oNswbXb9IFrlcurdV+a8La9ee8164
	iI7klTAg4xDF+ruzm//75TbU3SgGeQWKlPmtZmvB4PqwrTAU2/jdR5Zus514j4MxS49TAkUFwdVM6
	9JLIK56HjEZq54s2DUhyYp1ObVma3dkjmIMCGSarGWuAqghkcWgayhrApKnQhNP6FnCnQ2cdcO/EG
	R+K+ji8w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6l9P-0052jD-2g;
	Wed, 16 Sep 2026 08:37:56 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Sep 2026 01:37:44 -0700
Subject: [PATCH] splice: pass a poll key when waking pipe readers and
 writers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-b4-splice-poll-key-v1-1-438a19351efb@debian.org>
X-B4-Tracking: v=1; b=H4sIAFdVqmoC/yXMTQqDMBBA4avIrDsQxb/2KsVFk4w6GjRkrLSId
 zfq8lu8t4FQYBJ4JRsEWll4niLSRwKm/0wdIdtoyFRWqmdaoM5RvGND6GfncKQ/alPZwiqr2rK
 GGPpALf+u6bu5LV89kFnOE+z7AWW1Kbd2AAAA
X-Change-ID: 20260915-b4-splice-poll-key-bc7d5d0d0f68
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: mjguzik@gmail.com, oleg@redhat.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=leitao@debian.org;
 h=from:subject:message-id; bh=1P6BcVTjsa9hD38aaby1HdGhOKx9VU6Mn+xrQ2vBZZU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqqlVgB9GJVLPI6NZC/aO3sdG4D12zaboZUk8XM
 lxctJgJtlGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqpVYAAKCRA1o5Of/Hh3
 bQTjD/9Mt3Tp8PpQhJKSni28lLQgSBD8XyryXSN+9DR6/lB5Lz82OA+/k9Q6q8fVhrHmCvctOZi
 JjsUnB3g95OOY326/MutIx/ZXMH9wjjrNbWsEKzyfO8wo725ide7vJA7nrFmL84YazyPqEJKVjx
 brZjs2CADxKsryWNP3CN3FMgEdjX3pFux5T2FldDwMZtDFYD9+iRjHAAeObvG3XKQ6BsLumVsyC
 uf6WJrwV/vZH91P6mcbmA65gPcoB0SjrOWDQpGr2ZSpwDuIPf0/39vUBR0tUv08im0lgRxuJrGz
 C5fHNkaCXGwOz1bj/teDZgg86ZF0SMFG92PnRefC51zeXKVAFhI2Myh+zGtcR98Y16eQACdalhR
 nj/apnkCCk4dLVWXTMz4To703Ywp8OCMZXfllj5LVxj9nUXw8IAUB7MffVZ54wPJTOgI7ZKvCD+
 0tD/03QwqVRsYFmf9McB2o/Z3sT+MXCTv1ycjqd9GCTxDTABR/CysKg1XhnPTrtKD+iIL4hz5VX
 WV05Zx0c+zJxWb+cgX5Kja2pU6Axth3Fg4t+i7D5Cw4JqLolrdVY8B9F3lWyWc6Vwv4tksY2xof
 A1cyuLstWn/nblJUdhjKAdcT11tbQ+sqiIYUcXeqsz4sVr2vfomXGNzvqokxLzJCM4CeIJxOZhT
 xCkKbcIuFTtMn3A==
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

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/splice.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 9d8f63e2fd1ab..c048183215343 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -179,7 +179,8 @@ static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
 {
 	smp_mb();
 	if (waitqueue_active(&pipe->rd_wait))
-		wake_up_interruptible(&pipe->rd_wait);
+		wake_up_interruptible_poll(&pipe->rd_wait,
+					   EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 }
 
@@ -415,7 +416,8 @@ static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
 {
 	smp_mb();
 	if (waitqueue_active(&pipe->wr_wait))
-		wake_up_interruptible(&pipe->wr_wait);
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

