Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793533116;
	b=gJy5ug6UfF3V95ACwbESiw7yTJ19VH2A8m07Pm7mAmzAkIxO2op8RIdInbGbALDLO7hG
	 tDNqb+fleWpX9NNq/B+DctuG/Zz0hv7tSnGY1Tf4JGl0ybzg/khnOfJGfQIOVsEInKiIB
	 dJp9W6uOifsJ8ICW6IkqMR4HJMhqmmwAxt/rZAL4jjOQNfZSmBGSTQWr+Q/9zL3aPL1pS
	 VJdH0aWDoAeMEJRxdsygH+z+oMWbWt/k1m8lIUbx8+JsuVkI554rgsW0vu+NovjRcsbcc
	 ZYuEZ6BMiAK0mUzVSYgAViMJvhdseuUXMarqbi9IvgwXWQVPEzZ4/nCQZiSdehNS3zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793533116;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Wi28ZO61b9JIXVOR3091FD6X0ybjO5St+FAJ9rvXmeI=;
	b=3HtfdPWj34APaTrJI/W3yQRlRcgxiMoM1Oth7SD2sNSfIW26FiRfk4aHnIOEdIw9ihJ2
	 /uuEgxHB5HR36RVlodomdkdnVS8WZKg9IZh2nSp4dB8JPuPxeUzVGxY1ybVYSPjID3NeL
	 QjWsUl1ZpHNKvmGfUtOa5/KsjKvp+xMwRHyQkgwNuzpsVpSao4+7QTPvvHWULZxIiiVyh
	 fk0CweeSZJWWRDbUBHtJfWOoOLE5cMQnkcCAXOJS7Gp+W9KBCJHCAuXQ/Jbcl4tCLGALy
	 TZ23yiBzcviRbjn+l2GLncQdnRW8duNSy6X5sTrrKW+OZFTHQ7KvZ8M0lR4aknKiVvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAw1YES+;
	arc=none smtp.remote-ip=74.125.229.8
Received: from mail-dy2-f8.google.com (mail-dy2-f8.google.com [74.125.229.8])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62325606A325
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 11:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62325606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aAw1YES+
Received: by mail-dy2-f8.google.com with SMTP id 5a478bee46e88-369fd8abd71so2255586eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 03:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793533115; x=1794137915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wi28ZO61b9JIXVOR3091FD6X0ybjO5St+FAJ9rvXmeI=;
        b=aAw1YES+jNGnRe6vmpDq/uw6N/gZSOXQunDBHap+IsV87lKnZddbSruz9OKeDauD1H
         AbMitBsJNkn6tkZTY64diqDhaYg48fy/q8PvqFSf6mrg+HVTj2drgo5yuU8gYf3t23Vk
         uzZKqIUUBpRuzRAJRMtq5dACTSfnJbEeLodtkoRFdgEKIhxSE9sICQog693qNrqN8IxD
         EbhKf+SOJg8WMLT6DhCGKitiHIsJJyAQXZxGfnHpYFKK3wK2oJVb//2H4ElK8eyy2Azn
         ZTPCPxYepJMmlbljajbGuTWDiE4pCEZmAPA5hd265HbC9ddvcXEQwm3SSz6iO3UARvdR
         YjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793533115; x=1794137915;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wi28ZO61b9JIXVOR3091FD6X0ybjO5St+FAJ9rvXmeI=;
        b=GJn8bUeeS8zZOUsGYvO9uIcDllP79rpDO6pnTt4mbrfNGsy9QJYXgIMRmcVntEFNNh
         XsBmbTjYyE95tASfm/V/0X8v1NeFSenCJLmfcIYCmTz8pIlv+ilIOzfzY5sM1YDeagoM
         bhGxhXu3zDoQY3MBzBqdWIdyWygRvxsIzXqsOnXka+1dpvUBorPKIfEvHEUk0mR3LcaR
         wUCnZjwoiztwrMSZAQEVRBvSuUoaB9X1lwy4xd9Q7eYZiu9zE8iTKlrsoVtsTlPEsxsy
         WSOXU88ajdi7gXyAY822yS2P9cdj92jsYJDdwspnKRIF+cxZLnV2svhJiObv2T50oHmK
         2Peg==
X-Forwarded-Encrypted: i=1; AKwUvBy0kzXFtdZKDKEoRCf2aP9b9SuIMakVYJgoaaMEkJRd9cVL8oDRJ8H9AYHxTpWEx9jguXN11KFLtIJYZsHD@vger.kernel.org
X-Gm-Message-State: AFq9FYK3ERmXNyYRYjkez33Hvdh29h32b2rq3bk7PzF254oK0zAuVCKN
	q4JhNg4Y9bz/xJCqqAbVeWpfjcCBf4aglN7z80PurFNNskgJuZMB/n7D
X-Gm-Gg: AYBFou310PC44nq3YEZjcnVKXQ4dn082lD9wN36KFQTYeBjEX4MMnb7Zfu6uI+xriSg
	Ev4zJZhWhek0jkUVDsiuAPw6wK/i/e2Up0lzWTNrhkUlN80/nS1OoSzCQ+M61r3NIfv7IYhfexx
	H7Hs/VUOvaZw9gpmCukqtVeOmVgCw5kpjsHrpJpiM4/ilHt3Yx0Kor8lJrYLGllIvc84xJ65WRH
	Pgp5cXN+y9rNzHZeFnrEZLk7MKYjjoIjR7yXNxkPOC3n5aTZDKIEzMOnBfGaVKK4qf6ww587m3x
	0VCV6wKPrdc/rciuCYcR+xS+I8P6mGmHgGFXYE4IdktJSz3GDk1RJEBPcVX54RASxaLD0NS7T5l
	9OJsmJcKuu+HwGyEBvK1mKMyUNrXtnLoVvd/fD8JiSutR0C0rDD9VlbzwURwXJ7YFpkTi7MNIXr
	dnOHcj/jP8mdp9vWmafIwmj7/lO8dnWBTKEKjAvtgNZ+RjSp6eZtBmvKZymvh7w61nHiq4eKVaJ
	NixEjzgptbyp0l9IRGWQiS/8CbvT2XFNcSDcgPmnSFL+ZsEdw5DE0wpJsdFDg1ZwVcHlocz7fej
	MqMA9tNf60Kr9MN+tLygv26Ufjj+50t7lRkqi4/bIKAhGZSaWtM0JMl5
X-Received: by 2002:a05:7022:f107:b0:1ab:fe29:5081 with SMTP id a92af1059eb24-1ac5ac4ded4mr10636078c88.20.1793533115322;
        Sun, 01 Nov 2026 03:38:35 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1aed79b3dfcsm20393851c88.12.2026.11.01.03.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 03:38:34 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Deepa Dinamani <deepa.kernel@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] vfs: preserve subsecond timestamps at filesystem time limits
Date: Sun,  1 Nov 2026 11:38:15 +0000
Message-ID: <20261101113815.52911-1-dennylin0707@gmail.com>
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

timestamp_truncate() clears tv_nsec whenever the clamped seconds equal
either filesystem time limit. This also drops the fractional part of
timestamps whose seconds were already within the supported range.

For example, setting a JFS mtime to 0.123456789 produces 0.000000000,
although the filesystem can store the requested value. Utilities such
as touch and cp -p consequently lose valid subsecond timestamps when
preserving these endpoint values. Timestamps strictly between the
filesystem limits are unaffected.

Only clear tv_nsec when clamping actually changes tv_sec. Continue to
truncate in-range nanoseconds to the filesystem's timestamp granularity,
including when the seconds equal either endpoint.

Ben Hutchings suggested comparing clamped and original seconds in the
2019 utimes review. That caller was switched to timestamp_truncate(),
but the helper retained its endpoint equality check.

Link: https://lore.kernel.org/lkml/12c095e595836a7ff7f2c7b2a32cb5544dd29b55.camel@codethink.co.uk/
Fixes: 50e17c000c46 ("vfs: Add timestamp_truncate() api")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1cb6293b237a..7f8e8feec4db 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2847,9 +2847,10 @@ struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	unsigned int gran = sb->s_time_gran;
+	time64_t seconds = t.tv_sec;
 
 	t.tv_sec = clamp(t.tv_sec, sb->s_time_min, sb->s_time_max);
-	if (unlikely(t.tv_sec == sb->s_time_max || t.tv_sec == sb->s_time_min))
+	if (unlikely(t.tv_sec != seconds))
 		t.tv_nsec = 0;
 
 	/* Avoid division in the common cases 1 ns and 1 s. */
-- 
2.43.0

