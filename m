Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792948313;
	b=FhgmPvpNywHHnxyc5uDdoHWfMZ4ne6J74yYHwxxVXqUm0nP7XUAq4yN89kWf+qGEyTdQ
	 bzmdPC7KviFlCnpUbNEFWpXBW/RrkVoGVwFjYIA8ebKyCKjIL/1PyjcjAVHDy2dP3Yfy2
	 BE6nWOx9E5BlLs9xKgK6EEGuo/jwJ6LBhODLgH0qyEsg/66N2cBXqIaoqARUsLybvsO3w
	 WBzACnrZh0xiuwgQibbCZrzLYJOu3AvVSMkuGdlWi3GSfYrXCLm1s1W/Q4Dq6rvA1v4sH
	 Sc++EdZBZe9Q5fjeHS27Cc18hhKDSAMOy4hsizVoMS5LCT8ejofO6xuLfeiyny6uTKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792948313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kaazuBYoFlNi01fHJWSjX0ZrC024FOWcAqZVtF/rwIM=;
	b=gT0FVDDpO7f0UjDGykDFSJoNH08zppXVBAarHhTE4tjP4PttK+wEpf4HT+lwI4Omgu8d
	 TbrPnU7A1kjkBSX7BTWb+t89wT7K9rJjeFouYcSrLBc9X15H4KL1QFAgL43I3FTUwbuNs
	 dYz4tPQWYiufTTEt8N7j0fNCZf2VDvLXYG8O2CgCyEkEjKCxxsiOm4IV8acF+QcyaSqvW
	 EHoNuN/FmUCoyXcMC5hZ2tmORj3L+uBEhV6zJwSitXJtirhUrUIyJDPHSLjS96GwDj0qL
	 ibD9x0ETLVlU8ApCwPkkqZPeB6BDP8jtdW97smmRPwkRP5cUdAkwFuj70B0LWxgT1Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d1crgSwR;
	arc=none smtp.remote-ip=74.125.82.195
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E7E606A31D
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 17:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E7E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d1crgSwR
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-369f3e9e431so217725eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 10:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792948311; x=1793553111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kaazuBYoFlNi01fHJWSjX0ZrC024FOWcAqZVtF/rwIM=;
        b=d1crgSwRNAX8pcAiY9hJctAMXtQlVms7wbaULTZ21mEbK4effAqJ0lIajzsC9XpvQt
         Fr7ujXbZ9AyfVmQQRCObEMTHTLQ/Gj3VvN80mGyjsahf5b1lgQ5Jdlmq8Rddh4rqCdN+
         ATsStbP9vZCv/Y+zm73kbrEvXmn/7SA99GWNkcs7lf5stwtkU+wLrfNu6zGIxdNclhJi
         hn685tJayEUUAl57b3vKbtNiRocD63gBcpZvD424L22laZ1FOQb0Flq+wK98ZRo/YHVU
         nyys2UNgMCmT/j+uz1mWoN0tByIjFNCx6UxzNGGH64uB/FqzKEgW7RxlvpiVPvzUXG3I
         pQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792948311; x=1793553111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kaazuBYoFlNi01fHJWSjX0ZrC024FOWcAqZVtF/rwIM=;
        b=Q4FVJNOJWyntt2TIHlG+2lINaM8N/raAzzw4GoW2/voXoDihi6+cSOgFtMHQMOSG6L
         pkoCzKuZ2jBcYN41K5TAsFo5r4a1kC4+A8mYPP39eVgYP5IJv0HZC0Yj/Odz00F/uxaJ
         DxDPUMg9CFgowdxWi0QaxpbbwsiliE+G6b8miS0DzBbnZRrrVg953m2DIvMhVQkHyjIX
         uML4WtjU3SB9xf18HMVO/089rbMlWhqsmV05tPJZ/6zyUfza36L1dXqfFLcuuaHEWOlK
         r+LWq8LAeJb1TAHpXsguf+Qoyr9x7KdubHzW0o8ZRZanpxZswQte8OeKB6O3feHogDqi
         SGtg==
X-Forwarded-Encrypted: i=1; AKwUvBzu+W7XiR+yVzizx01wovGYwL+FWhzj1JlyDCJWQsQmsAKha/PhegxvAdZn6tZA1kC0UCV2SEseV3ixWtSJ@vger.kernel.org
X-Gm-Message-State: AFq9FYI7mJhx2LfaSXE+MSYKmqyokvVSGB5lmNPBDZLXkN1Z1rJX7CYZ
	wRCsoVg1oaUUcLuXCzPTcsHqPg5B6zziqHgQc1u3GDvVYi4ZqP7Gagkl7GZy+jGW
X-Gm-Gg: AYBFou3J6FEz+SQRMvG6zdad2WvSqmA/uw4GSHhi95YZtnJxBr566dfWFOxguzGyAo3
	avHhSd77PCyDjOOpeHCxjkbae/TL4rUvthx/tVyfgCOsnVI434QicD8vcv3oaA9m8WgmzgNgvCM
	abiccNgd14jgistSylpAfoDpgesU5aFBRnIdk+xqJfuSqee/QhLxjc9aUSaEy6TeaftZSkpw3yw
	7JttN1I0fXuk4khf7TKV029jDLrTVP5+4fYPDWuD7Ccon5CcCaodOnY8vyX1APREilVb1UQCzNl
	s+HZ/QT9XjQ5+Miq5l+/vYhRzDQ/VF2kB0zJuP5vLvhI+Ra7ag6MM3zslAG5aFstafZXL7VtC3e
	+VnQbIinCOYWAMbB4uyR2pZxoRKOqTrPHsiOnOAmod+JeOTWNA9tcs7u7kqkViw2VByEHJMbLJo
	feY8bBr8Luhk7/wndBm3SzQbkywJ0c9rrSCO6BYYNAC62qPDz2IXHoBf78XnNREgo9px1KfLYhM
	LmhfFfskB0oWO6xK9r7KO8hb3YnHUbkv6lozERDqqAoODXY/5SyK51ViZ0Xc9NbFYpwxPHsjatB
	e6xIUYI8rdMGNFjJ95UE02WAR6GnRw==
X-Received: by 2002:a05:693c:88ca:b0:366:6c79:212b with SMTP id 5a478bee46e88-369e85043a7mr5516718eec.25.1792948311310;
        Sun, 25 Oct 2026 10:11:51 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c576ebsm17670582eec.3.2026.10.25.10.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:11:46 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	dave.hansen@linux.intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] libfs: do not extend i_size when no data was copied
Date: Sun, 25 Oct 2026 17:11:30 +0000
Message-ID: <20261025171130.16115-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

simple_write_end() updates i_size to pos + copied even when copied is
zero. A failed buffered write past EOF can therefore extend a ramfs file
without writing any data.

Since prefaulting was moved to the slow write path, this is reproducible
with a one-byte pwrite() at offset 4096 into an empty ramfs file using an
unreadable source buffer. The call fails with EFAULT but leaves the file
size at 4096. generic_perform_write() calls ->write_end() with copied == 0
before trying to fault in the source buffer.

Only extend i_size when data was copied. Keep the existing folio handling
so that zero-progress retries and successful writes retain their current
behavior.

Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/libfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 8e2cc627bc7f..d889a4a14f41 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1007,7 +1007,7 @@ static int simple_write_end(const struct kiocb *iocb,
 	 * No need to use i_size_read() here, the i_size
 	 * cannot change under us because we hold the i_rwsem.
 	 */
-	if (last_pos > inode->i_size)
+	if (copied && last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
 
 	folio_mark_dirty(folio);
-- 
2.43.0

