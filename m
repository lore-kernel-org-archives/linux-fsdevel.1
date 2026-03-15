Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E958236F42A
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773594585; cv=none; b=EnePzTuIwaVsK3FZ726JrpH+2kKJrPL/pu+U8J2S+7ZUnzr0AMawX2GDdkl7uwsXGsHrYqmsC5O1dsbzk2fzpdrrdGONZDy6o+478FySVCTdX89ngB+P6F+ywb2cxhpTlB1V/mBSSYvnS8ZEOj2no0JQxjl66vtlOamdqysrHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773594585; c=relaxed/simple;
	bh=+eLZiyrmLdVJwIszLkGl0niOrk/VQn7/kBZuBFzu/FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UwUUiDZwk81B09RGpoEm//Xs02jmAC0d016Oy/KVy3XsZb4uuVn1Z5h3yUGcgnc/7uo70h1NK8Rc6QPqmGoatJcxmo8FIsb0b+hxgrLfJOnPfTlmCBvrsXwzDvzXyyTdCmxjzT9onb5oLPqzOgKl56fZdwTlnnaVtX9eOZ3CiP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dR05qjb5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR05qjb5"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48541edecf9so40899405e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773594582; x=1774199382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56xRGOQ2uh7f3oMNdQQVj98xTX35v/V8pWKpoUvaask=;
        b=dR05qjb5bgzrq3bdRQTq6NIuzV9M9DtzRZ9bI0mRx1LiJKCNvZhACV5w59nuDL9hZv
         f4dFbGya+jj2y4NhjdCWZkXhMscWTDuvDngEy63n3YLkMOZG2piTF7In2yv7QIITJuSE
         srnM5VAmXD3fvpKjE0EeVI5gtb46pb9wFtwBvA4/pWOH+t4rZID2HY6ImWahgUNlPiIY
         Ag3gf2eAQWnnNwp6sbH+1KObeEAe5WdbjTLZhnTREu/SBnOqKKenxcQzNzk71CJRuYYS
         DeOQ+nhj6DxDn2qbIIJdkpEHgXn55gC+9z8yaQL+OTMjmlih/mHiXz8LU9FSwU3fKcGm
         Mdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773594582; x=1774199382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56xRGOQ2uh7f3oMNdQQVj98xTX35v/V8pWKpoUvaask=;
        b=hLFqCCtMZVDpsOfYLjs5vGZEWte+jUdc5godrQMhiubvCHvexnW4VyxrPVXajWa8GD
         2qCA4Ma0cibA463yzdGsPjhJ/Tbc2J05I06JkKBJc6oL7VJxNZIKcEeydKdF/bCjUG2o
         iDY1VA1Opjo2PRXmMaBJ2HITvGg3tGAX6wLRxBwywREVDP81m28jVkY2YdJNFlCQqRZZ
         lejNxs3Jgw1n0PwTrJOLvQLy21t9II7t0Sz42cIHoEXfBifMc6MxV9CUqTBprSipW38u
         SKprccG6R1WtsOC0K5gyZBgD8T2ZfYCQYMUu1Cg4jpU+td28vU4rwuHT9ODDYmf6bKng
         qiiQ==
X-Gm-Message-State: AOJu0YzzcHr3S7N8/p0qnThzP7xrC7/VsARWWFu3m2iThplM20fo5b8Q
	pQ6l1t7Owg7WLLUoGuWhJWC7QmaqwiXClq73iY8gm6/BHBK5/vU5va7p
X-Gm-Gg: ATEYQzwB/5FqRuujJI3HFv1yCEFLFFHULFW6HCdKO5uFfqCv66ASi5WoNSt4JNO+dcR
	WMfnpzh2KquY0wKtnWC2R7OWMUOY1roQkXvTReJjwMdukAVOA5BhgJJvVMbP0Dbi9GDTFxd2Rwd
	95aen5sdkvr4zBnn1T7PPkt2KLDjECYEdWasHKo5nE3u18gvsD+gCS8eJAAVG/yOD/HaQTWWROB
	jsun61ML8HIvUNg6zw/gdtf6ASHMQO59Q9hEX5iOiWObsLO67EuuiZQTCB1Aic3CKSMQ/w0ZRlT
	pBwwxUo3xI51s9Lk+z8Rq3jJWpw6En+RrYy4aBgvv7/MLaTNUv7+939FLTBnh4J9F7FExM2uFXn
	icTFynUzxnaNIZNjydbCkrnnvmAIno0WQVdTrRURi5l8NWwio8II+BIBRHTTP0Sn+gQbx1ypbCk
	0msyWJotfzatUwMyKW2PkfEH4PbetHUpNre2lAvN2hHswP3n0wg4/v+RlXb6NYtebmxngyKK0EA
	CGnDCC9dbz8Gef8UkEh2xlLxPXExw==
X-Received: by 2002:a05:600c:37cc:b0:485:5812:27bc with SMTP id 5b1f17b1804b1-48558122839mr149991665e9.5.1773594582309;
        Sun, 15 Mar 2026 10:09:42 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20c473sm36638366f8f.24.2026.03.15.10.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:09:41 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] writeback: fix kernel-doc function name mismatch for wb_put_many()
Date: Sun, 15 Mar 2026 18:09:31 +0100
Message-ID: <20260315170931.65852-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc comment says wb_put but the actual function is
wb_put_many. Fix the name to match.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 include/linux/backing-dev-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index c88fd4d37d1f..a06b93446d10 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -237,7 +237,7 @@ static inline void wb_get(struct bdi_writeback *wb)
 }
 
 /**
- * wb_put - decrement a wb's refcount
+ * wb_put_many - decrement a wb's refcount
  * @wb: bdi_writeback to put
  * @nr: number of references to put
  */
-- 
2.53.0

