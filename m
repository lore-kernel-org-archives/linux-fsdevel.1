Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270365;
	b=1Ho2ZsTr1pAzAZhDY1tGhfwWTrIpyA2jOR93dL5QCWDYpVeI9H3Z5RFOhEeF3AhvUtdU
	 3Y0erv1qkq56kyhR2Tn6qzyb/sR7KpCRwfFcJ5j2x5KOZfBVHTkhbCxwcc59XuUaf5uZj
	 HR3cTuv1pcZpuilNGo25qgV98yykrJdDMu0Dm8Ch/105S4uD5qp+amWIfVDe6Dsj7sFpX
	 g4Q+S7XrgD7jK3KvB9fztNfzcnGDJUHMFm0/z//TwfP/vdA/qrJmq8z9DUmwr31MhRhBk
	 FWcdS6T8wyTsxGRsGdoMwwL4PMQbpl0c7tWFoEEow5uutRaaHKiZatNqlzOUUirkkhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270365;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IOabLZqit7N24WihDjnsU07Wy6C2IdsvojlsD2HIpZ0=;
	b=neo6XgNtQ47YovQfHS876h+1NMDDcfQHGJS1xp0/o7dtwmxgx0I3P1tmxaWzKyNvXNlC
	 GrhSajjr8+35KAm07VqMnbuL9a4yvNLSrIwCQ+I2jrLq03ufVDmTmuqIwsU0WuhzEoxgX
	 LkS+UruFZd4leWDhxZu9+cOu5YSXEzYLCBTPzEVAna9Nk22q4EHRb2PDveppVkS29isD2
	 nz8TnK0h7eW7MklU9hfauBWitwFohj7jz4QICYuByZieqzcG/YwQEEiFaMV9QRiXMEP5Q
	 FtOajFgFen0evAa1jsGkFJ2GnuhFbVm6bvAtrYspZxZCOjW1Hn8GBsigpLKbDbTfR1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="OFbmVOj/";
	arc=none smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3478D60A261A
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3478D60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OFbmVOj/
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4395d31228so301781166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270363; x=1793875163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IOabLZqit7N24WihDjnsU07Wy6C2IdsvojlsD2HIpZ0=;
        b=OFbmVOj/2l3qHfU29caOHgqvEOTx2nGr9asDSKFSaeBz4/MQa2tgP/AmbAWGbgQO7q
         t/UK9Fjp+P5QgRO55cMVXiGcNNy+VTSYhq3nay6kAN2hn7+2Uk8rzzN10osrY8sXu20A
         a2/3ww2eejoRMmb7ztgXKOllfha3W/1yNRcYe0jXo1PKe+YShM5Vjouori75CpesBULj
         KM67Bzd///MoiL2zAhZVoYs5uiWEbU//ziIz7agi+jaByzgoF1p5i1mHe3ejPmAY7ZDO
         kEvvzm98cVd3kAedRPdr9X01ETYNYxh1bFn/DjGaLL4DCR0Qyyr25JcLrGBhdIOhLcCv
         eTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270363; x=1793875163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IOabLZqit7N24WihDjnsU07Wy6C2IdsvojlsD2HIpZ0=;
        b=PKhGJR1GMLc8AiE9nrBERxQKnAXwc6UbrNxRjgNUZxrkVZaj/09TtrOEHtuc428jf7
         jYMeFZrwHAYy4QX4HpT3B1aggDcC6rj1tdMuHn3MiLCqPqqJ99lvECZTwnKLJ0gAZvqg
         tRtI2/XxRg6JOkNscr7AjPWT5MS7lpC+rKeG9fdto7CEHrO13rcX+M/0uoBGAQmL/urk
         ZlU+ZAeQOJWtww58ndA1Cg9O8ymrkJLZzukhwVK1EWtfSEk8LCFoh1Br66/aJZoXmoDT
         IYtxuTb3TiMRDDuDPODNJlZktxMTSdSpg9LCPeQ5Zcws1Uj9kgQxGeLaWchrDf8K6DJr
         +KeQ==
X-Gm-Message-State: AFq9FYJoAkyl07mYYocIroapN3uLodPtfyDVHi0h4zps8f7xPr8NeRtg
	uVFhVrwBBTVFOL/VrGCfj1qkxYi57znBkLN69TEuzeDLIO9MN3Veal6H
X-Gm-Gg: AYBFou2aQmlz+LDCFs42eCCMP8RvIkDR8uUKit8XMIkqLBUklybN8RN/0KXUBDpqZQP
	84A8nD7T+XVhqw/yHlMjZdtWYUcTky+nVhlIb0PMkRqBfomIBjUZ7ELRHB/mY1RysnkkuxI3zZQ
	C3yQ9OMJ9pUGpIamVVL7XWTj32uOC8DzuJYK77DeggWvFOxe+ulbqfVzsrfQsBQuOmEPavdhenI
	I9cefNQ31uDd15/d+BHDEOZM3ZN/elAEuUCyT1tyFWhNVMkbq/D4H0FESEuzTHwvP3nj9xeZA80
	1S0+948Hj9zhmBO8c+UpYk1h1ywVqb8PsFFPYI5/42g7hIjXjdDwLp39FVtAdc0hQBacjTjwY2Z
	0PNFCSV9/rBbCZW534IR8SwWlfBA3gXDNQoPjB1uFrHKJDA7qe+qDRTswq4OWDQJTt53zREiMqH
	HRRv8i+yUBPBBMm8cvZOXFRYJepzHIZPFsF8C1Qwxa+no/k3I4ydxy8VIvfoS7sfR2dugiA4Z+J
	i4Hm189nWNtynmBFKNMcUbiP1hyreRUY/qvchLL1smQwGbgSE1eoedQcVDa4hmCNd5dYPUsekT7
	orwiMj4qWeaB8FHEQz0tGfuBmoDL9rx/XXGJX21edQ8NSei+CtQ8V1DmnBR/bW1mztWDiu+G1Q=
	=
X-Received: by 2002:a17:907:980c:b0:c2e:2baa:a642 with SMTP id a640c23a62f3a-c49bdfb1ecemr433472266b.30.1793270363333;
        Thu, 29 Oct 2026 03:39:23 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e89e6sm719465866b.20.2026.10.29.03.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:23 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH 07/16] vfs: add try_take_dentry_name_snapshot()
Date: Thu, 29 Oct 2026 11:39:11 +0100
Message-ID: <20261029103913.2785828-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

take_dentry_name_snapshot() requires the caller to keep the dentry
alive. The external name of a dead dentry has a zero refcount that
never changes, so atomic_inc_not_zero() fails on every retry and the
function never returns.

A caller in RCU walk holds no reference on the dentry. Add a variant
that fails instead of retrying when it cannot get a reference on the
external name, so such a caller can return -ECHILD.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/dcache.c            | 29 ++++++++++++++++++++++++++---
 include/linux/dcache.h |  1 +
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f44c7b39c3b38..21ac036b31675 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -358,7 +358,8 @@ static inline int dname_external(const struct dentry *dentry)
 	return dentry->d_name.name != dentry->d_shortname.string;
 }
 
-void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
+static bool __take_dentry_name_snapshot(struct name_snapshot *name,
+					struct dentry *dentry, bool retry)
 {
 	unsigned seq;
 	const unsigned char *s;
@@ -375,8 +376,12 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
 		struct external_name *p;
 		p = container_of(s, struct external_name, name[0]);
 		// get a valid reference
-		if (unlikely(!atomic_inc_not_zero(&p->count)))
-			goto retry;
+		if (unlikely(!atomic_inc_not_zero(&p->count))) {
+			if (retry)
+				goto retry;
+			rcu_read_unlock();
+			return false;
+		}
 		name->name.name = s;
 	}
 	if (read_seqcount_retry(&dentry->d_seq, seq)) {
@@ -384,9 +389,27 @@ void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry
 		goto retry;
 	}
 	rcu_read_unlock();
+	return true;
+}
+
+void take_dentry_name_snapshot(struct name_snapshot *name, struct dentry *dentry)
+{
+	__take_dentry_name_snapshot(name, dentry, true);
 }
 EXPORT_SYMBOL(take_dentry_name_snapshot);
 
+/*
+ * For a caller that holds no reference on @dentry, e.g. in RCU walk.
+ * The external name of a dead dentry has a zero refcount forever, so
+ * take_dentry_name_snapshot() would retry without end.  Fail instead.
+ */
+bool try_take_dentry_name_snapshot(struct name_snapshot *name,
+				   struct dentry *dentry)
+{
+	return __take_dentry_name_snapshot(name, dentry, false);
+}
+EXPORT_SYMBOL(try_take_dentry_name_snapshot);
+
 void release_dentry_name_snapshot(struct name_snapshot *name)
 {
 	if (unlikely(name->name.name != name->inline_name.string)) {
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4b1ff99608e01..a4be11ca2df18 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -629,6 +629,7 @@ struct name_snapshot {
 	union shortname_store inline_name;
 };
 void take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
+bool try_take_dentry_name_snapshot(struct name_snapshot *, struct dentry *);
 void release_dentry_name_snapshot(struct name_snapshot *);
 
 static inline struct dentry *d_first_child(const struct dentry *dentry)
-- 
2.55.0

