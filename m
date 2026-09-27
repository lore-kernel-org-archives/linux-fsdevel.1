Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2238236E
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549404; cv=none; b=fYJTYwpZ2JM19lppUDn3sUx6Woj2EfbWks9OKyu7Vu8X+5s9nDdppP1Jmj5WLl5J//z7QbHz+84wcwB6n3sNZQxHQ0xzqKKuIi9ZTiAbs6YKkxkohCxYqLIRkoa7GxkC3fMS77cUQtbVKf3aKz33wLIl1hh9xoZNBnhFQP0QsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549404; c=relaxed/simple;
	bh=CPBoCXuji0HCs+npGcNAjkg4D0lxWLPFivqKavuEncQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6+ImTdI9XqD4lvnWPPN8XqegtiW5erdjHTWawfM6nO93A3F37DSCP4XDS1Xteh1C6OsfRYkSoJUxsx65Hv9vLFS2fEpIWouNKDFyTBf9XgRcn3oSizsBgq1KWm2bTZo6n0x8CS30guEhmsckhz4czX0WhFptbiQYRByvcUBV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rU9oFutO; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rU9oFutO"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so1268824a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 15:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790549402; x=1791154202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9eIatuVEBgbUOC7aadx8tcbBVKVDmPDXKTSaTvp6c0E=;
        b=rU9oFutOobOtNxXBl+rLiOx2xDO8l4K4aFYMrColMRKpvFcv9hTP/b96cTovwJClnp
         Rs0d/26tQwyJn4/7PlxV7T8QUG5KDQNKvr9tNr3zdyXMq0xTX7upgyqr1QGTut9neMYV
         1kxXKX0SbfEE3l12SKib1K0PzAj+IM5K0ZoCCHxFMS8zLKZIbGXDNdbZX9o8pifVnbMq
         m8p0NSwZ8WAqb6cDiMIDVttxd/uP8LZrIyA73KAQtebTEd4D5Ns5jIg6nMUS5spk0j0F
         e8rSXy0qa5ZOaJmZ+fg/MsMCcYf45DxByV+wjxbmxue8STpwMM/DLA4UbTy6NQkSdi3c
         d/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549402; x=1791154202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9eIatuVEBgbUOC7aadx8tcbBVKVDmPDXKTSaTvp6c0E=;
        b=yt4/4rrolW+KSJew6i7YybBmE9sSaQk+xKNoJRRYk1N6QzNTcRlbjIqSTnLXFX6Nsg
         KXiflNBIgpbPTTNbZYYornYxCwj6TQcCKUZGGtiY5RW0x7p5kzGqKlo+6y0VRws7S+Si
         UPzVtYwNe6PYZJRpKWTj/eZVdQiCKdnwVIb5Dj/1vVBpx5LOwaxMXVSjo5Db645R6PB4
         4ogVp9g6xZZfXtJpMLt+C3JTqxxsqnnhNZfDYVMfrE9QqIehFlR+6QtMKEWeM/75RsAZ
         C3TMb4jTv0NZgeI4kmvEWSwrqM7SNykkyMtLCl/lU/DPkKJf/KxbPPnZAXMR8NnT4bma
         B5Lg==
X-Forwarded-Encrypted: i=1; AKwUvBztGjOlm/+af6OaLTI7IHPPldjq1xihL2mQKrVMenVxiXj5JNGIKgi4njhhZbxa89g5KT2HMZVWg79Ji//5@vger.kernel.org
X-Gm-Message-State: AFq9FYKbZoTkhSFXEaJrOEg0qDYa67iIKc7k/sIQ37a4MK5CVseeb0Uy
	grZmd3mi4pfYGKWvEg+NADydFtwscUWYiaDeEf4vtAtWdYnkzvl3WelkbuD/Kw76lYbaOQ==
X-Gm-Gg: AYBFou1aBihhOFGC6ETLvelCbJcICKQIqZbG0OS8jEqmkwamFxNm/e/doL8psAGc3az
	+IR0TF0TdtrUU2rzwZXi06V1vKba6p8d55ghC8RCh3rhjrSvrXpeoFm5Ekn+CEBhP+RBjH5qrO1
	1vOWD9JvGGc/2IivOAZhtprtdaO4yWFt8HGjQB5MU281mrE+gjrv/Pu/or5Ajy2nYxJo5hJBpC3
	GOjFLsVehGBK44BFrjo6bpQgT2etcxpCBvDruiPl6r+l1LrQ3E6vR2reGuHOUd0jK02RWEmEyqp
	yf/Iy09NGn85DmHi9Q/71U1CnYRQqb9zKdy0eBNu499cESkO0fUiea08p5c9rFQKezmILnlZd7J
	POpAyppfFpztH6hZKwaiVvln8c57/yT143oqgzKvtT8ACmaN7e/+ndBwR84msjPjuY8TKPMYIa3
	XXYNdvibo2J7TEAG2Iwb2UXx2JMeM31QeS+PRaLoWzCsohVBdkV4J3kzlKnVxzLh8Co85oXf47M
	P3ecsLsF8Jv7pBFNl3GGCNW11fd7GvnTfs+oOUAtm16uU5fUXNxH2NMuW+3XrM2HodROv6S7a+y
	dsKGd31dSh/4NFBAulsj81GagIzWeXr7yFiBW+aDYSF8nNJ+nCNa+vqecTY=
X-Received: by 2002:a17:90b:55d0:b0:398:9bd5:490b with SMTP id 98e67ed59e1d1-3a098cdbb1fmr9472000a91.18.1790549402130;
        Sun, 27 Sep 2026 15:50:02 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0ca127237sm5596551a91.4.2026.09.27.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:50:01 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kdev_t: shift in dev_t in MKDEV()
Date: Mon, 28 Sep 2026 06:49:58 +0800
Message-ID: <20260927224958.508964-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MKDEV(ma, mi) evaluates ((ma) << MINORBITS) in whatever type the
caller passes, usually int.  For majors >= 2048 (legal: majors go up
to 4095) the result exceeds INT_MAX, which C11 leaves undefined for
a signed left shift; shifting a negative ma is undefined regardless
of the major's value.  In practice, on the compilers and two's
complement targets the kernel supports, both cases wrap to the
intended bit pattern; this patch makes the macro well defined
regardless by casting the major to dev_t before shifting.  For major and
minor numbers in range, the device number it produces is unchanged.

isofs feeds the Rock Ridge 'PN' entry's dev_high and dev_low into
MKDEV() while holding them in int variables (fs/isofs/rock.c), so a
crafted image can drive this exact shift.  Fixing the macro covers
every caller instead of just that one.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 include/linux/kdev_t.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
index 4856706fbfeb..2dbbd47f1e68 100644
--- a/include/linux/kdev_t.h
+++ b/include/linux/kdev_t.h
@@ -9,7 +9,7 @@
 
 #define MAJOR(dev)	((unsigned int) ((dev) >> MINORBITS))
 #define MINOR(dev)	((unsigned int) ((dev) & MINORMASK))
-#define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
+#define MKDEV(ma, mi)	(((dev_t)(ma) << MINORBITS) | (mi))
 
 #define print_dev_t(buffer, dev)					\
 	sprintf((buffer), "%u:%u\n", MAJOR(dev), MINOR(dev))
-- 
2.55.0

