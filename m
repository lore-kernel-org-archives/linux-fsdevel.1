Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792787987;
	b=rV4ELNwDczFXtxZUWNEb1soxOjwwO5+pEN2YFzC6nxPEWxAHI0FxsQZIeBdT87odcDTL
	 dm9bVL4SPOVoGaPi4IxbPC49ZEW2/brFHJagdeZ9BQb9Jz9A8RGTQYkYNCgLAJ/aY8Nkj
	 RwTMdhTDeqJeaPDshZEayHwib1SJclHQW78HoXvLlx+ugA52Tzld2N2HQNEwNHTDIJ3nk
	 dQvdTnpSsNN8CmrsFlnaVOucKbehb2E/dbs3Q/8I3WkE5P+d44/J9ZZqr8xmaYTK/a0d0
	 TYHypMIhmiwoW1IN4aRDNX1puNC/WbIirmU7C8FYxMxUxteFg/av47Mr6wYSXIIGN6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792787987;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=AMBk2ozAsAYSDGmMrImtFK9mVXu59cpgop+gTFr58yw=;
	b=EiLx25ffLLVC/vHTBmIyyQaEJZAG4jH+sJt+P6/Q4u6cd4tew6NqsBy3MO7J4fp0hfs+
	 utU7OFBi6/iJuSupi3PPFjFgfvUH1iJBQpKStrXV7jYju5xIcA8RW1m32RiU6itGbvHnR
	 y5BKZTuWuCRfO0gIwnUCVWYZfQlclbTh5YW9aI/7wLyan77CzOegvXbvtGcS/r9IKTxKg
	 N0WIOpVWe0aeed0vEJNnDYT2j8M1OpfNpPePU39W9hF1mSjTd+S1aOTjxNhNC2ITa4EaT
	 CviSSLf6oLb0BKobxM1nY6/7eJbYcmMJ8W0y2iDot8Oaj5s/5XbjvH018/dipLoJ3MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dorkq65b;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F77606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 20:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F77606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=dorkq65b
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917a707f37eso14163726d6.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792787986; x=1793392786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMBk2ozAsAYSDGmMrImtFK9mVXu59cpgop+gTFr58yw=;
        b=dorkq65b3wraiMrQF1f4TW1yqOA/DjhkOsK5YN4lzW+lfg4wsvk/fOSHcLO0feyWNL
         QOR5EzYwmCtuZeEsIBRggy7gYQoWg21a8qOUutRMXd1JtzBglV0Tg+LJO+oCnyrZBKVl
         rz++C+xKmDK2w4rJsL5PkVkYoULzM5g9l29C9N3ePm1kSrO/fk54o5+JmLnCObOAsFuc
         bqObcGekz6g9SXOWlE3zWuyZr2n1tnHLd3B7hvQa3xrwENO5xZiUKYb2y3Bycqf/qfoZ
         WjSKadYyhwdtm+ZzBvrQpvAxgFED/krMmMOV762+0IwCvObpFk7tY1qtk3luN6J0ZqlD
         bi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792787986; x=1793392786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AMBk2ozAsAYSDGmMrImtFK9mVXu59cpgop+gTFr58yw=;
        b=D0aeTPflxRpYclliwlJLO2rMDUWu7JNAUE42aSS5/60gw2G176gozRXQj/BbBE53oz
         ByiMXRD1CVpIJd/W+kwRSEEEc1aOPd/8IYi3kY7GluW39vszFCbGC2td7jThXvl+u3K1
         HX9hOSDaiYri9fHN5ZQFxXoOtGTct2Ty8q2+twaAb5h1D885mtDNQsTiP/Ibcm1tu2K8
         90F4h6rfwAJtYp48Ip0EH/vUSHOIsmBVNkBWNQwTtBn4GZ/OMQiJtETD/mT3ODlaqOcn
         CFTb4k3R7xwFsa0USDpLWQCQgSLPon8iVkrLlvDw7emxmD9QBU4TjQny/cIARNRevOZP
         upEw==
X-Gm-Message-State: AFq9FYJBrSqfnHw2JyG726/dpEoWRUD8sReburnNQhOoEn0UDR9HN/DV
	RmabE0aMNW2xFPYmh9UYA+vl0SXM9Cn1CvUXU0NyxemOZgDGlkQ+6A8oB699pgn/OjU=
X-Gm-Gg: AYBFou0eZwjHspJtXyWmnO0hRbw1yjv/6oqWnswkxd0jZP43/l3/N4VkB7uLugjAoQU
	SGtvSePnmSXbtQ4zB7ZNHNj6wQFOPjJ07L+P7+nofuxC23aaESD4oxN4xJyc59FSq9t1Nq1UIOJ
	DZbz3Wkes4ClOli4UlJsuEMdongRtZWEYj/i/UWTgPDg83WLlNbCAq4agJMoXjGN/oZpxnvyVjM
	ERDWcJh8xlOUzr+zVs/h/HPciCD38KF+6PXjfgV/yHw0jH/vD2a8LzqWjr/JnP/m1MpuLT3QDtZ
	d5AiFk5veWtcGpb9hcGZBfWQbBuQ83WEim8s/xv72iXIYR/QAeDNDHTqnXq2unxUSdCCLALl37c
	pbtIm+t4T74Icqme8ZiERdHdKYVMljjbLjDonrbDYhwhooYT6hnOfONJndY1zau0e0TLRamxyKR
	k5cE7M5PVq9KRqWut+YqJKMmvz2KNhK8qY4NZBRpySFoXT5R281vVwOisfPA9iLnvWUWLQJEtJE
	FoodJgJjsuEK0DMsy/yHBcLmvt0VKH+NGLt8p7NKMx63XvbKAio3ZNQYgYApIVu18rp1lC9
X-Received: by 2002:ad4:5c88:0:b0:91b:5d3b:4abf with SMTP id 6a1803df08f44-91c48eb3cbbmr2918536d6.52.1792787986400;
        Fri, 23 Oct 2026 13:39:46 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd1d42sm4059876d6.12.2026.10.23.13.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 13:39:45 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 20:39:31 +0000
Subject: [PATCH 2/5] quota: make quotactl_fd(2) killable on s_umount
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
Message-Id: <20261023-b4-s-umount-killable-v1-2-844a341ff1df@toxicpanda.com>
References: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
In-Reply-To: <20261023-b4-s-umount-killable-v1-0-844a341ff1df@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792787980; l=1587;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=y9KAa5l0YqYGEQZOMGAdty5zYtWUqx4lSAJyffrFhPI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHBDw973e0WCTK2eaNm4OEDb3Uuc1sI/uVtNgOAEEl2j3Y2dir4EpfZpCCxcn1nCnUY72HJ3k5q
 9be+I8FIwJwM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

quotactl_fd(2) takes s_umount of the filesystem the file descriptor is on,
exclusively to turn quota on or off and shared for everything else.  If
the lock is held for a long time, by a syncfs(2) on a device which doesn't
answer say, the caller sits in D state and can't be killed.  For the
commands which write it does so holding write access to the mount.

quotactl(2) with a device can already be killed at this point, it gets the
lock from user_get_super().

All that has been done by the time the lock is taken is getting that write
access.  Use the killable variants, and drop it on the way out.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/quota/quota.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index f906e4fd3f0f..94e6407734c7 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -997,9 +997,11 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
 
 	sb = fd_file(f)->f_path.mnt->mnt_sb;
 	if (quotactl_cmd_onoff(cmds))
-		down_write(&sb->s_umount);
+		ret = down_write_killable(&sb->s_umount);
 	else
-		down_read(&sb->s_umount);
+		ret = down_read_killable(&sb->s_umount);
+	if (ret)
+		goto out;
 
 	ret = do_quotactl(sb, type, cmds, id, addr, ERR_PTR(-EINVAL));
 
@@ -1007,7 +1009,7 @@ SYSCALL_DEFINE4(quotactl_fd, unsigned int, fd, unsigned int, cmd,
 		up_write(&sb->s_umount);
 	else
 		up_read(&sb->s_umount);
-
+out:
 	if (quotactl_cmd_write(cmds))
 		mnt_drop_write(fd_file(f)->f_path.mnt);
 	return ret;

-- 
2.55.0

