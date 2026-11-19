Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057849;
	b=OGSXi1JKoQK017Bs97iYHYz75fiIaNntybwzjLOPQ/yDBZYwKBJF55eqlh026bHmleu3
	 TUPVvOUgpk3/MZMnI3/beKR0gCC2q2B/8UxU+ek1rDelJgHvudHunfP6NqS+65h2oKn9F
	 jfiHery2Rqkn9iW5og00sECG71fS38pJantc+DIepK4XTRXZHgFLnxSArJ0auyLbrdtbS
	 q97Wfa7QPE2d8N3KGGwrTroJOFNF2ZwEWh0xZ+3moKcKwJkHc8WctUTGhDtM+LLyh7sth
	 6XBUYLfheA1Btav0aNDD/jfwrPSd7cWKX9xWqEBOlc37iCziQrpGMxq3i0KWedUH4rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w1YOVY/Doh6e0864P1i6+EBgq5MNuINhZbLgi234zvI=;
	b=x81tqI6Q+XuDirpRLXc5fMOukq5VG6drKB4I1NZ7PXPKlgdP7yLMq7nYXRbKW0MtgeP1
	 auPYPKkvWKp8FLUZRCP0ZN94NYDOUEHLv54EuY3z2w9aLMRDc97pVeDorTnRAywhGQqHO
	 MITx7nqfQEln5NgLpzNymdEJup4gcs6+Nrql6dKI7g69L8pKSgqLxvYxWBc95tn/prtYw
	 IXuhyyuSDejh+9/z6KSN1V4FiLBkCi3F/j/wvIfJTYeDUp579idvY+eAqUqnc+E3MtzVu
	 mB7jeyFVWvonWRTXYdiIdUArzKcf4PhIEe85dwOrBr6vsottNm6EigTtDqftuVFJFrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OjMOQRNd;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FB860A2615
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1FB860A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OjMOQRNd
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-14394530ec6so2732942c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 19:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795057848; x=1795662648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w1YOVY/Doh6e0864P1i6+EBgq5MNuINhZbLgi234zvI=;
        b=OjMOQRNdJeLJg5azmRkBB5RW5pkDklRxxPZrFuCIDm7OU+S7G0Dg/yw0sCsiyypQOq
         g5xFwpHBQw+6l4NiCO7NbmKg6AneWrbRGdHARf8ZFk4QN5SLNKVuykO2/bTSXbM9n7wS
         PRlHLWhQK7XaCIYZ/4kT7Bzamg1H+6MXS4pSobmIYryDP/dTloLkTJ5ZIc58S5nTyGmD
         kq/s/VbhA0BvrG1n42/nx7ZjP+MPi06M/Uryt3Rvb+1niar2d2c/UA0gIDyK2IF5aI53
         +Rs8tq6Iobqrakn+myFQo+BV/UgeR9tZ16VpC9s5u0UeZYPoXW2jcFOwUO2O2jRhpEX9
         Mp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795057848; x=1795662648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w1YOVY/Doh6e0864P1i6+EBgq5MNuINhZbLgi234zvI=;
        b=0gIwaNCDPJTJLGSeOHSl7qwW/Bj1AFa7u8wkCPwcQfn74ulXXAn3SceAAOOrNQZuEx
         u6X19cN5zO2FsGHPUp3CYurXK/xvf/aqzHMpj3ViFwHc3nl8ZxnlkCwpGTiKdXy+5Wzh
         cG2FKlwXP+DHIqhoxhz5z7GBxdiJ7VQedjfbtFIQ2ooGEdsUPqIkLbUTNWbAHf9eEY4/
         0bvrTIi9lsHu3V2RbIAlsstKW6A+K585juYFJbqvyZ0Rhx3rDHYzZo7mii2aJPN/4nUs
         jICl+XSBu5yiDroaBthoVNGmBvEdKSsQxdoG4njC4O1560FB2KJhPpMI3pkHbIKKTV/i
         c9Fg==
X-Forwarded-Encrypted: i=1; AL+hErE/Kyl5Q2HV+6DzzC7OnxqEo9wrMyTfYmBJsR+23NOYiW9WpERXHv8KlDJRZkEfvToHaSerZ6U3oeJq18c8@vger.kernel.org
X-Gm-Message-State: APuU4Z+QIp4dkRZF5rbO/YpMhT1O1MPQdS9Pr9eEEz8RkO1naREX1+/q
	nYllYqcMo0CF2+oCqW+sS/AVjta//bG6926tZXkKDRtlh0TtneKNFZOz
X-Gm-Gg: AYBFou3/C6sCVOLDJ81yANA7I4dC3petg9p3rkEmZVTwPIXd8va/rdCoTw3Wfvi0E8g
	lf3AomQvMi9mDvl7iKLG8At4UkHdI9cTrt07CBlSUWR8IGZOol2G4KhAuSZDoJvWWS3iSiNxMVq
	yOB/Z+1OXFQuEztJsoU56vCLQ6gLjmBU7qv7emjjrXx0nkzGRZM7oeKzqRk7RIGXcQ06COanja5
	n2CtOfo8rOYXCRA2WKN9ulwuCrVzGJXRg3l7sp9usLFC3vqnl1n6TtXluz2zrrvFkMFggjKbKzg
	/pp+JAa/ue7IeGy55oxiIHDdnQc1W+D90F6eT4aAWDuggokZDJp0tdgk6aDj9hIjSgqatffPPF2
	OwVLDTgykH3s36K1QIMqOJNAlkkol/u9dDM+kwZZ3pmLJSmIGCN/clOQGl+6aKBg/ruNvixhOmA
	JcGwzm+drPWIiRCqdy3Q+xW/SXBR8fkjZKMWPFH+vyXRKW7rWe783AI1n6oWrirghAeD1QSqbX7
	i6quZr6ea5dvUIAsq/JV1O9Pld84kNmRYFokGZeqWNPPC4P5/bQ75Fhlp/4clO1a4E66EiUR8j3
	ZI7HcExOMGDAXpqUnEBzmFrJxX8eIIl26DiwwD4kjJM740UFMA==
X-Received: by 2002:a05:7022:4183:b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b543be5439mr5394453c88.30.1795057847918;
        Wed, 18 Nov 2026 19:10:47 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f4e19sm15028118c88.13.2026.11.18.19.10.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 19:10:47 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Ding Feng <dingf3ng@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in zonefs_write_check_limits()
Date: Thu, 19 Nov 2026 11:10:26 +0800
Message-ID: <20261119031026.7985-3-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261119031026.7985-1-dingf3ng@gmail.com>
References: <20261119031026.7985-1-dingf3ng@gmail.com>
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

zonefs_write_check_limits() follows generic_write_check_limits() and
has the same problem: it stores rlimit(RLIMIT_FSIZE), an unsigned long,
in a loff_t, so a soft limit between 2^63 and RLIM_INFINITY is negative
and every write fails with -EFBIG and raises SIGXFSZ.

Keep the limit unsigned and apply it only when it is at most LLONG_MAX,
as the generic helper now does.

Fixes: ebfd68cd0c1e ("zonefs: Fix O_APPEND async write handling")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---

Notes:
    v2: hold the limit in a u64, as in patch 1.

 fs/zonefs/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 319d950..c9293e3 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -399,15 +399,16 @@ static loff_t zonefs_write_check_limits(struct file *file, loff_t pos,
 {
 	struct inode *inode = file_inode(file);
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
-	loff_t limit = rlimit(RLIMIT_FSIZE);
+	u64 limit = rlimit(RLIMIT_FSIZE);
 	loff_t max_size = z->z_capacity;
 
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
+	/* No file position reaches a limit above LLONG_MAX. */
+	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {
+		if (pos >= (loff_t)limit) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		count = min(count, limit - pos);
+		count = min(count, (loff_t)limit - pos);
 	}
 
 	if (!(file->f_flags & O_LARGEFILE))
-- 
2.55.0

