Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787986;
	b=TtQ+8kGaZc563AOArOVgS0LLKJAHednMmxiJQV0Sr0QS9PAiKoTAcHgdAhs26PAXgAFj
	 Vcn9pM7GSQOzN8nh+4oYakhi7LL7dtgpFfOFKMdPxzPN3L26sX4JWq9uWCGysUYgS4C/V
	 Uqqxt0uZQQF3V2ItW/qNt+aAWI9qlDKPKiYCbKM2ryUgBgYL9dVj7W8hvS4LEZE5tZLs4
	 reCb3KFQ1V9hbUkzh4hP414I7+ABoxgQHcDc4de5ybKekqkHvdMmGq94HhRfQS4Zh4Jp7
	 lubAFUUXABGxYjoG7UPxioMCaUx5ryeGVfg+4v8PHAdbtN3RCUUvAjneXpvez+wvLlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787986;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=V7bVxjxfNJMJ9ikA6qreYHkI8rZ5PEd2tPNtK+tsbm4=;
	b=QCwEOd7bw63+I22nrafmyO4tDuiBH2jbH9koHlgJzes2eA3WsaOTAiHC7Pj5aBQpGST0
	 JDVT1D6ru3c1o8yAWe7ukxDGQ587t1lauLBkjTUl8w8zt8uVeFj+Dbqe1SFpKR9jix7sk
	 ukxNXkd4Yogp6L6v7PUz5730LsrrtXlg/fuZ4gNzvMN1Z9azG594MT/DilMniMRLSvuzh
	 UCZgVqKC6uXntt7quOP7wLSJzGC2zZ7GF5azg5cxJ/nipowW4f6s9LwrIjM4uwK0FGlgz
	 Mctz53hQjewfqvX8YuoaXGLYQrgeEo+fq8s/bZk5nmEK3G3ub7PbXqIVnQDS/EkbZWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Pi1jAnCQ;
	arc=none smtp.remote-ip=209.85.222.176
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D646C606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 20:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D646C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Pi1jAnCQ
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-93f2ed2541aso100101385a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792787985; x=1793392785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V7bVxjxfNJMJ9ikA6qreYHkI8rZ5PEd2tPNtK+tsbm4=;
        b=Pi1jAnCQp/bNBCDhhH8yUcJx9fE5XrYU4vuPxRlJv9rxDppk0ltamiAzl7JDuUiIX1
         qkFAin9hMxWGsUEafR3iZkWYwKQdvogopSv09S8uZiu3di0UOv5I23nt9xI/kK7jm4rN
         hYTulHmunI4CtSdYI34rbrz3h6Bz+gt8Lku52dr517dvo+PwWb940nPI7q2/vR9EPusV
         sGxUnE4OM1H1c1+YZpCyOxANrxfy4/hSjSQeGjHErrth4P/dgdou0vubBAPGQ7KBuPSX
         o6hWFSz+nFCoy2q86y13p32RlrmqCKTZhqUexO5eavtrUteqotE2iIelqbY8rSIXfICq
         2O4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787985; x=1793392785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V7bVxjxfNJMJ9ikA6qreYHkI8rZ5PEd2tPNtK+tsbm4=;
        b=lQv1K7H6MixjZgfY+JT9uAUi6XPT/YlPpg43sT63YasIXPG+bSB4QmyXjpXMMQwl4I
         VFi9qUTyNfanY096FbvNac4dYKHxnv6w48C/KfJgSloiPc4jF+aX1LDaP3biQA9jdp+s
         rFtEGgkyofkzAoliyMF56MsOKIOGNFECOMNzFyPlb5sScaFMgs0mYicEABsohxdJbYZA
         6/fkqLULWotqi0onj5xiaKKBGWGIn993JP/G04K+GpZiMB8ZvfW2WhDMx7Gihz+0MU1c
         grr9gRW49LMMr02l9FixnwsnGdJlVQTSvJapvZn70CYFI0qAFV3aDluBqjzQs0VWqLOT
         keoQ==
X-Gm-Message-State: AFq9FYLIU1VLfTgHam1bYtmBSv3Gc08AK8O0+7+XiYJAtXg/ZrPae91r
	ozdZ+ioA7Rraix0zsbxcwQ1o88p30eeJR0Gkf1h5h0JrmtHxNix6wns/j22OeRl7DOQ=
X-Gm-Gg: AYBFou30WpSNxWaUkE3DGPI8SeGK3E8F3TgWIukUmd1eizRa9BqbI8fYKIDOpzYX+1J
	eWcet9BYjYy3A3dCyywH5uae2FwJ7yrOvYZvMu7mIz/wvbV8kzaKGEtQUkPXWQIMHSHBgUtHRz7
	K5AATQDSs9Hk19v2gZUM4c133MXLSzVsrq0AcsWguYrDxZw/MNmfTBxWKHoo78IZ4MQ3WJaK8WW
	alMtWTMt2XKZw3GZzVu9YErDU0Znl24rcFCe1mipLHd2gR7DxYCy9jW4fgNxj1edn9+hx6WaiYw
	BlzJp+sUQsfHs9Mkm0oHIW9bpk1UOItD1ggTTc0k24zG0GjlmDCvbdHtFzGSevSNNc3GiS3nxIO
	mUDm+Wuyg3N+lv1KMhL0YVzF7/cayl1ItJAo8ePBxBD+wJmgYJgs14yrADA3jk2+cPIDVCVhMkU
	7T1VX/LrIps7PI/Yv6vNX2+ewnbeVcPcULGPL3+iQ6F7vMC6dhqKuNOjf0tXbjCHamDyqw6vrAH
	f7NWspG0Z2W0wpyQ+o7PtiGIsPPyo6eS1H3IqvTmhKIjc4Fdcl7VyMic89ugPOmNcvwVdht
X-Received: by 2002:a05:620a:2b83:b0:93f:1600:481a with SMTP id af79cd13be357-940efa11fefmr22310885a.5.1792787984882;
        Fri, 23 Oct 2026 13:39:44 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a912d5sm2143785a.40.2026.10.23.13.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:39:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 20:39:30 +0000
Subject: [PATCH 1/5] fs: make syncfs(2) killable on s_umount
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-b4-s-umount-killable-v1-1-844a341ff1df@toxicpanda.com>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
In-Reply-To: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792787980; l=1241;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=9tTHvzdIGkeCZRT40x/w5oXKIY3j5URO5x0Y7DuGFv0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDNM2h9XGKfC52ZUUVpGP87Zjrw09KIERumqmEPJ8TNlGZLvunsB/mC+Y3PnmmAU9T443/8lscB
 46rwKu2/DRQY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A syncfs(2) which has to wait for s_umount sits in D state and can't be
killed, for as long as whoever has the lock takes.

That can be very long.  Another syncfs(2) holds s_umount shared while it
writes the filesystem out, which on a slow or dead device takes forever.
That alone doesn't keep other readers out, but as soon as somebody wants
the lock exclusively, a remount say, that writer queues up, and every
reader which comes after it queues up behind the writer.

Taking the lock is the first thing syncfs(2) does and it can return an
error, so use down_read_killable().

This only covers the wait for the lock.  Once syncfs(2) has it, it still
waits for the writeback uninterruptibly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/sync.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/sync.c b/fs/sync.c
index 0681bfcb2da6..ea54af59cf4a 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -156,7 +156,9 @@ SYSCALL_DEFINE1(syncfs, int, fd)
 		return -EBADF;
 	sb = fd_file(f)->f_path.dentry->d_sb;
 
-	down_read(&sb->s_umount);
+	ret = down_read_killable(&sb->s_umount);
+	if (ret)
+		return ret;
 	ret = sync_filesystem(sb);
 	up_read(&sb->s_umount);
 

-- 
2.55.0

