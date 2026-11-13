Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570277;
	b=WAx1cwBX6JzX/4myYo2+NS2lF0VqzRlTcBZlN6lQv1DsAoc8QCB0DPadoOFyB39/Q7VK
	 PlnH01ufDUPY9/+oEKyY7nobrNJbu0tLhK8AMrsoFu+0gii9qoMVWw9cQgS9ujjtP+ld/
	 4yn+PkfeA7gk3iNAfhGrHVuq2XCzuzlf17IyWNORanRkUoy3Np0g6jBqYb6dVQMCLLE/6
	 eOhVfH8lHM3xUgaHu6s/Y4RTTUClX+FfzX2hM4Xb/8NzEdqO6LbRI3zhK3c7IFLr1yvrA
	 o/07aWtNdoHenL4m84Zj1Rxk1oArlN88LYWbKV8DLfBfKBPFKJTgx2aC66hmzlgVCFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6FQtbu1IeNWQL+nRxPR7Un1AFMuLEx5nRaWh0Cnhh7U=;
	b=ZBO8rrA8fIizBt1jCwCoQoFg1GBHTMEPcSpF9A2NiHh/K+FneZTTSk0zmwSDPxuJgcrg
	 2a6wlOU5VluCmEefewYU3G3SWpKxkMES4gRo8R7mC2wEIM1SSWrToYwQfTPijE2ieUR6o
	 MgTnp0X0iKB49ZRYrQZKSF+iUYo0f0D5ZuT/ZKBHp2Fr/lXM4+RUtgmzY+n97ex1cng3i
	 0pxwpOHBtL6YldCiEuCF4Kb3vLMRlp1nZ5m/vo3KASdTXxk74Lkx9AyDi84kMXFLhgdCW
	 BEjTIQut6qFqm0WGcBybhVlNmrFZF4zdNsx8B2Hhod3+82rTq5sKT+TPpDOd305hTUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=GwdwQBnK;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E481606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 11:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E481606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=GwdwQBnK
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so13919115e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 03:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794570274; x=1795175074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FQtbu1IeNWQL+nRxPR7Un1AFMuLEx5nRaWh0Cnhh7U=;
        b=GwdwQBnKqkp6TTNZ9OmiXiyE2jPX8cmna7duS+fz2q3bZliFxpVnGlm66PGJ9QENFh
         Usm6o+Xsyc7zAXRVHuERpqOj+/DtryKyrGooKt13RfSPlcNWF8IicTMcP7ycxDUjc3BX
         V0Jcc4l9My/LL2WmSI76jcYSb6GdhF3zMro+R8qQfoTTPf+AlHyl2kg2o9dsclj/A8Me
         1zp4aQ9l9n4HFtkKyiRgzF+TLT7o8eDHvSJM2dfXwnGspshgrV/WHz0Fx43A4/C3Ftub
         heuYTKscKK3WtwL6jWeiAu8wwApYDfgzPF8pYZRDBCbHP3vDE580IhT/08oj75jLCGYa
         RCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794570274; x=1795175074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FQtbu1IeNWQL+nRxPR7Un1AFMuLEx5nRaWh0Cnhh7U=;
        b=1BUqu8WE6my6TzFhVFd775a6n6cCM5pJz8STBZJB7L/xNXpJlXxUy3nEcCflD147h+
         /WUgIWXygpkSRdS/t9CE5ModubPOFkCGyFYhczLx4kZ8N4Y7jf6bovmYFdQTFmwwnQYi
         S1BXtaQvKonD3qbmkecQ8bKUyYO/VmX5espi6JKbh41fEMvfCuyanbo5dkKI/MzNr9Xv
         5uTHYcJQmwJHjKsdVP4vPgYzKgYZwDzcLYTZHD2sz0acHwwSMVlzDr6qfgh/rCZAaJGx
         jRNAyoM2csjabXn6ldulC+UJV8k52lpoLjMblHwxXcuX5r0NDOuLjySFZw5LSR+dAT5A
         /TYA==
X-Forwarded-Encrypted: i=1; AL+hErHOPGEclgXilwEM4HY522DSivvmzigp0PVJ+3QLTCvlkycfUOhzdSKTlqg832lX7wganECdaHu2QUSip9fj@vger.kernel.org
X-Gm-Message-State: APuU4Z8b7aQ3CT5xN7TgWR6VTw9esGr1LJ0oc8CoV4eVG6hKXD8miAZf
	/Y99CZABV6WAw+OZtQS6tayRulkAxdPmoVDGXsp8kk6awuZuqoornhWgTk3a7u3TbKk=
X-Gm-Gg: AYBFou2ohsR8+sQGOxUbtNsvfqPKfXAJDUaYcgrNro0HnhffXCCC4sCHkCOXQD2a/zL
	8ZTmEGXLxIoU451sjq4ipHhjQXGV/TC+UCqmW+NuejwP98SzyF2VT86IiUSy1PGwu9VW3EcQAdk
	8H0ZLZAM/h9ueCgOdD79sAziJ0OeXwL3IS4rJDIU17y7SGzeRRnbdtPI6mH418wxnxtrawTX5IM
	ZVn7yTuiQqP7jvQOzTMnWj28pG2yRvqtAoDEq2k/tcH1NC2/jINa3GdMlqd82gxGiEOQoDXRVet
	0SOyjiZ3glXxvhLRDqnlO0QpNOr1OLsysYo7O+WnYOtLWjlEbyjf1xOlO3/gOUbbRJTPcTFbj7H
	rLSH1vXmGj8bzOEOmUYQSS/53OreO81Nwr6BRZJw+XA4o56STs1p8jD9pfsDiuT8241YwdtW03a
	YiYhBDXx9zZEusasmS9V0rReH4E4QeD8f04IPrq+tptNkU8RwoT08OyYRM+ywH6LAwpt5iU0Jeq
	L0Lzvh4hjUUMokW/IcXch5YJmBrfKSiflt1DKNdFODbAa4fIkHVsG0awj4GhPBx2AMObBoie02m
	1P6fcqvYWW6zaUrGjxFy8sq8jtZCEGFy62c0OtbL82HUWyACjp5RvJFnBYhPp1eMbe+9iIxgw6/
	t9i3CgHYrZUewbXuE+oOH7Ukp7GSUr0/TzH7YZ9oJJuu2lwDItwCA
X-Received: by 2002:a05:600c:512:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4bb55a5aa47mr33165155e9.19.1794570274477;
        Fri, 13 Nov 2026 03:44:34 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm5505806f8f.0.2026.11.13.03.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:44:34 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: pack fields `i_state` and `i_fsnotify_mask`
Date: Fri, 13 Nov 2026 12:44:26 +0100
Message-ID: <20261113114427.1845888-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both were 32 bit fields followed by a 32 bit hole.  This reduces size
of `struct inode` by 8 bytes.

Moving `i_fsnotify_marks` there as well so they can be in the same
cacheline.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: move `i_fsnotify_marks` up as well because "should better be
  in the same cacheline because these two are accessed on some
  performance sensitive paths" (Jan Kara)
---
 include/linux/fs.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77..fec047cc3327 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -813,7 +813,13 @@ struct inode {
 
 	/* Misc */
 	struct inode_state_flags i_state;
-	/* 32-bit hole */
+
+#ifdef CONFIG_FSNOTIFY
+	__u32			i_fsnotify_mask; /* all events this inode cares about */
+
+	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
+#endif
+
 	struct rw_semaphore	i_rwsem;
 
 	/* Timestamp for writeback list ordering and age checks (jiffies). */
@@ -863,13 +869,6 @@ struct inode {
 		unsigned		i_dir_seq;
 	};
 
-
-#ifdef CONFIG_FSNOTIFY
-	__u32			i_fsnotify_mask; /* all events this inode cares about */
-	/* 32-bit hole reserved for expanding i_fsnotify_mask */
-	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
-#endif
-
 	void			*i_private; /* fs or device private pointer */
 } __randomize_layout;
 
-- 
2.53.0

