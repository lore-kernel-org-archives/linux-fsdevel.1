Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87642345750
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443205; cv=none; b=eNAyBq0HHbhQGNHF1nUA4Qo99420qeaSPWF5ua6C6+p9/Jl05u8JMmzQHJZrscnta4ikasF44zUM2z0TqaNQlERkYIUQFLI5GIGEFgzeflBStKJHP573v4ygBXpSwk6qxi6jKIUfi9Ey/Cf0jwtg/QKFBxHjM+XBmxx55tWJ2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443205; c=relaxed/simple;
	bh=pRjxSY2hK/P3m06NybehEmPkcEcTFuE9eeyU3AyZp7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLwT6MhgPBGW+vDaAfu/S7as2yrb4UrHbnh3Lmfl+r9qf8aYhOw1VCZ2Ze6mlRvzxKoieE/r2go0K2Tmw0Ea0e62TYZ6HhFiVhTLOz4rIPxDTCK4/cK9FhKvUAPuGvqCehOGBuarzYEGC9iuD2ICZDTE9YPbCnA3w2S6dINwlnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lunfIJZJ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lunfIJZJ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794f701a3e6so1828947b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 11:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771443203; x=1772048003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isj4uUQXBkvxAIQbP/qQhWrPSh6AxlVjOVunCf1FAu0=;
        b=lunfIJZJ7zquc3s+fv7MI+6zpSVSFGWsIb+sSlJsguHqFvlQ7NMW6qHRykeX256FYk
         X55vavfjaxeMktCaxWai/oZMZWrAkEYJa/+A7H5FSA0ZsecJNRudkyGa5ufE6LOmHmu4
         DbO905wmgCOB5xAXYvE6d5rlly+y+vE8rUCwI1R0cCUfc64c33Cp/9nAkmLzhUozuJYg
         ohfwYKWzSTzg5PKnwNsO8LsWC+i6iAM98rpxw78YGmuEhF6S4KLvIOctiK/08WGsVJj5
         Yjpcybd4ZE3mEW7YP7QqppG9UPe7L9d74QW8c0XqfT23FxfDQ8YKgyuXAcYCPaoYTsX2
         Uw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771443203; x=1772048003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isj4uUQXBkvxAIQbP/qQhWrPSh6AxlVjOVunCf1FAu0=;
        b=PCVYiqHZExcNhiJ5ZhTxmbCCj0l5Ff7bCo7f5RcBHdJd+skk6M61NWt5D3A1nhWIAD
         5V99Nv6NT+nkay5XkVzcYCcS52PNaPIIDgYdY6eOVr+Plx5ehX4PiBKO2V3eWVNMAFY1
         2VjZZvHlh0uNRf6qgG0knBM+N65RM6Fare4CwNKqlgBhKqWPmmo/mhlU4L3x7jwoakV0
         DvA+THQz+xubygX9oQ8Y/gHe4AzdJ+RIN/pdAL1/9ERuZgKYTFOwOc0ZQ2mmmBQsNfjs
         0nHS9FU4mqMWlZRwqjoWxIUo/7Uy17ee7BCPJDAs2tjPC/2A7We8tN4AWAHVj4c02FVR
         gLuQ==
X-Gm-Message-State: AOJu0Yzhhkcspk30WDE2tZnBKa7Cv1zw0qGNJHpUReB2jfBytTI/UFxe
	mhInbPGgE54FfWnt7CgMt18U1jCk+6odVhEBDApUBoDM2vwgZ79mKUn9
X-Gm-Gg: AZuq6aJ81IcRi7PYf5I1FQTijwpueovsftVHo4BraWN48xN6sAgW/YDM47nn3BwQNFu
	70tGOttHQAZXIhdujz31VqonRjm5Ws51dazCbPWJJ6nNZxi1go6EPCElPAC5Dw8w2G4DLzgMygU
	5a0yUqRbF6+vBCtLt5xxvFJDwaHyjUwE6ItHAhArnnoj+wk08eNoo17cG8LnUN3qMroO0lbNH81
	Mu+QGIvhB1a6glAai0KFIZ/4Fl87YsAqoRMchrDkl1pk4jRRJ0cnm8LFj6aDS0IZ1pYxKJJUv0q
	rMpvaAzV1HZB0n9kOe3oz9zEo3iP+YrMi154eA7a/dTEkly69PPX41zmUITC2NHoZFmfnoISv8m
	i3XOb3JsAti+SUe/hx372QNoUHEs1USmPIGq2YaUJLOqTS94Z/JkqJ7ck1vkf4xWwHFqgUmG6zm
	JjJdUDrmpuDJEC992cujjCP2ppXmr0wb9vZ3Amhp00DD5MmrHLa0P7P6uy8kPKiiOYLSKUdxrHc
	y9ddIBPmpnWlgAjqYDSvINX95uwFapU9g4QfofW5lwGZeG9jziVRw==
X-Received: by 2002:a05:690c:6c8b:b0:797:ab82:7521 with SMTP id 00721157ae682-79803c7bf5dmr4113457b3.34.1771443203551;
        Wed, 18 Feb 2026 11:33:23 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-797a5caf0e4sm63661217b3.27.2026.02.18.11.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 11:33:23 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] hfsplus: Fix error pointer dereference
Date: Wed, 18 Feb 2026 13:33:05 -0600
Message-ID: <20260218193305.11316-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function hfs_bnode_find() can return an error pointer and is not
checked for one. Add error pointer check.

Detected by Smatch:
fs/hfsplus/brec.c:441 hfs_brec_update_parent() error: 
'fd->bnode' dereferencing possible ERR_PTR()

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/hfsplus/brec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 6796c1a80e99..efe79a8f1d98 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -434,6 +434,9 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			new_node->parent = tree->root;
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
+		if (IS_ERR(fd->bnode))
+			return PTR_ERR(fd->bnode);
+
 		/* create index key and entry */
 		hfs_bnode_read_key(new_node, fd->search_key, 14);
 		cnid = cpu_to_be32(new_node->this);
-- 
2.53.0

