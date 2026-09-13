Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D802DCF4C
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311009; cv=none; b=gyVHgiXJKgwRiHzPJaNiPrctXx4pj4Vba7HI7K1FKFQ4Elr74Ud00LAOF6N9u2CsPyqSzEJwjZoYNcK3RqEMKHd77ibms4a5KlIUWPRjCa2Vjy7hW4fvFuqQBh2V7zMwv5gnMz767QG+iZrLkjNNuC9hwX2bhirfF9Su9hfsKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311009; c=relaxed/simple;
	bh=Clj/Ouwd0dLN04eWZNySPzYuAllNrDtuMX3q2A156eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMQNM3lvWMBjKcpjH4oa0DCm3V3waB/aUqykajdNbmAv1y+IteHUlEgw2ZJKfw3x3JhOy54BPPfvAbI5SSJSZ8oS1A+rZIBtMk7CW7WPcdAMBNqCaH1uwdbY8ZS9sYUfWJYQJcFwImFnp0CEIOsU0Rv2cjYcaeng6/sVPS10CY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qCdfVcVT; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qCdfVcVT"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so4065185e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311003; x=1789915803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=81asV8b/fnkXYfig/nnujoqba+Y5BqtppTUW9bEFFN4=;
        b=qCdfVcVTppuEsLa+D676p/InGo3GNUkXfxB5IiFS/bsc4OiyX3YrE7yNOu0oBaHHjg
         MpoT7aJXUMv/SCbTnFV0mloEu61Mmxh7VRC4TwA7x8X4B/vAyHsFcvQ+CVEtD1jdYTlJ
         dtaVZyyg7gkOZ7eGCkeANG4FZwAj410y3LDCHUrHYMcs491oc5P4qvW8OKXJGufH5zh9
         TWJx71rPCw3/7rhbDIIeQdUOLPIkQj6wZDdmfht9+5/CfWpXcZFrmbXwvvUC8/WgoMJe
         X0XMyGcpFEYHzl3szcIGZM06rc33z6G1kz8nPbcqLEResblNzIQHaYYCz3bB/zLO+11B
         UqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311003; x=1789915803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=81asV8b/fnkXYfig/nnujoqba+Y5BqtppTUW9bEFFN4=;
        b=IKYIf9UAjA0RTlPB/mOLK8FIJ+enlwWGe/LZXoGGFh986Z9fBg7v83tlMuC7DIduam
         PotUPF4yRioaOvnEz3AaXJCArq9K6P5FLo7cSKc3l/3Bulz5+iTLO6MIyCFcxwT0Yo1a
         P5HCMCJdMRUzZR9bYpXHhxcpbBprF/KglVg0ANEIZRTYJ3ZLTVwP+LlQSbdHVOAgE3n1
         4E5d3osWQUCIc1nU++3sYrrz6CBAaIBHtGbhOTTFWxKBj5KUaSsZRY4RtqsFiiDkx7XI
         WFVPxFOkEeCpoq26hnfc9S8jIXS7g1poyyZpRFcvMFsDWp9j+sceeflKZYOjv+jeCSLx
         30MQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWiMGlTuEP+TqYVt8L5N/sOJk3bfQpqJ7DgwgkUz27h55f5Xz/ldwlD6Y55Fal9DIR+lkq5Pbn3eTbyxWR@vger.kernel.org
X-Gm-Message-State: AFuF++mVNbOJYJoOukBdizQho5+gwfm28NFIZ278l6m/5Xj8PCclpOSm
	FBj4zLrRDehGTrKvUoth6cotAr/XVcS07/aroafnnIaLyqf0ZXyomAcmTZ6S4A==
X-Gm-Gg: AYBFou1LiM3GNuXJ6pnEAF61OzbbDx8PbBLBx+avlnfw82shmJWdQsMt/w+MWmYYeW3
	j5Ryanw9a3TI6rfbKvX6b78kbrmcG8v6u3EkqVJ8pJhOul3+mkAaCjGudeUB0IcQKL1NEPPHw1k
	/6ER7TkvlqSaelhkRLgsKcJtnxiDxWr/NO62azx9SS7au1gf0EZYChjauztlfzleIBzweg52fVl
	PNLBk2hYHaiSOpZqEp5tmazkMywcNES+8OtluPvprOCSdCGJhcdMUc3cUcf2syfvE5R+KfVg3v1
	vcVSpMB4xL9moBpETwhF+kQFHMmFiFXsaXLScfD8o4QawVc3zST3eZ+wafWv7Vawpifd2Z/excn
	PIw14VSK+5M+5GPTG/yKKnjGRjPD11pdb9xVpza58aFHv/IdZLwpVpEFLJJ7JveHFAR7KFz1BlH
	2bnZ0wsSuYhk2J4fXE9VyChXLg4rEGfMHp9XmQpE1Zp18EmwKjHA8aBE2UkBLfP6r4oRgm4b8qR
	VOop+7ObUwt9gtAr89ngz7j9X3uEBHnGIDlckWrqTI=
X-Received: by 2002:a05:600c:5489:b0:49d:16dc:e721 with SMTP id 5b1f17b1804b1-49e6cc0ab17mr57452735e9.24.1789311003081;
        Sun, 13 Sep 2026 07:50:03 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:50:02 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 08/10] fsnotify: use path_clone()
Date: Sun, 13 Sep 2026 16:49:15 +0200
Message-ID: <20260913144918.1606123-9-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913144918.1606123-1-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a208a7ec1692..84b4c505dbe3 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -559,9 +559,8 @@ static struct fanotify_event *fanotify_alloc_path_event(const struct path *path,
 		return NULL;
 
 	pevent->fae.type = FANOTIFY_EVENT_TYPE_PATH;
-	pevent->path = *path;
 	*hash ^= fanotify_hash_path(path);
-	path_get(path);
+	path_clone(path, &pevent->path);
 
 	return &pevent->fae;
 }
@@ -600,10 +599,9 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
 	pevent->hdr.len = 0;
 	pevent->state = FAN_EVENT_INIT;
 	pevent->watchdog_cnt = 0;
-	pevent->path = *path;
 	pevent->pos = range ? range->pos : FANOTIFY_NO_RANGE;
 	pevent->count = range ? range->count : 0;
-	path_get(path);
+	path_clone(path, &pevent->path);
 
 	return &pevent->fae;
 }
-- 
2.53.0

