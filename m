Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32B3A0EB8
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856770; cv=none; b=PUkuMJnEwwMfFumJ2svWc/MqpH++QgYEC8kPaWNkorIHUu/Al2VvlGl36jZ57hgZ7LUtbyskTngAgvrQFbZRuRB1PjF8oNwsJx/S0LCLiuJ1cZxuSyeTot71JPlQwBmlrKbqIcXgVdXopUutq9qIL55+hltz+bDG5H+XYmIUsIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856770; c=relaxed/simple;
	bh=ynDCyRyx0YRpfYn7EZwrTZMMdTMxmFqgMrh96xitSRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=twyJHRAyE8D8xu4CdP3PUqiAYoQAXxsjcPZYQzli/x/uzAhKkweXRkzrLqLIzd0RJNI2uVAXH+cHPSxisz/a/+T+8ts+zXP6XMpbet+ff7NRaCQ5Zb7dkv/NMRC8DBAurgEUF2dVaQHnqWrim+w1bLtH46e5rhLSQVJyQPJdDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3zUN0KA; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3zUN0KA"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca06a25so12655865ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856768; x=1790461568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhVtdGz2dTM2a2C4ypaH/vqNyNg6K2RZqdkAXsZ+5po=;
        b=U3zUN0KAzuyV9bLFAHZJ3Oje3kt8QjTYTxwBYIvxQWvwCk66nRTYSLbfKJdT3WuEtx
         +ZWFqCSM0rkrAPhaQhILO1PE3jvI5m9qSRrNU7/C5V8du/ZAXVaabWm+OXmLOl4FNCkl
         QIpyZuEwHlRClA/OQAc86RiaoLQv6GIoPLUePsgb65bKXLhwanBNoDXZmiu3tZK7MTTn
         8Sie1xqRRZo6+hcxrxm3HfGh3xbwnX+Al3IMGWB8ExIpN/4vO2SwJFm7bvAc+gM7xp8q
         b7XgPjcO+vV8pdUY38wsIcNDUy10jpJ4rP2USCOUJ59aw1gkEd/j56kUtbUab7EZzNfA
         eghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856768; x=1790461568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhVtdGz2dTM2a2C4ypaH/vqNyNg6K2RZqdkAXsZ+5po=;
        b=ivbA67h1vY+UlEM5tfb5bcjmzdj+d4owzQtAIOeKhIeRRx5nlqznOY7rRiMcMn4K8o
         2NJFno/A3Fx4K2JelcpmwMq3vAGY6LXC3T1MTVsyAVa77UTz9azMjt0bFgPSPYV46SrN
         KfeE7B1DwyZiIF2LGgQgFr/21afmLAijMR9LC7U+rdFYeiplsCbPhPZyChQwMV0H8mLv
         hVC0fanjmrkAWmFyeq+2mrSL8G8PGywshRGSHXT6eJk2BHMpCmicslpHnrpH7oSyfmYi
         5FcO9O2tqeYpnRiICTcOOl/DN8jc4vtn+N4VCoCfy+EsGlQ0XCx+79Khj6bi0IThWs+4
         9smA==
X-Gm-Message-State: AFuF++mAnjq8bRXL7nbeEOjtBF/xOzfQTCPAAKNxqVK9IB6Ow9+618aG
	nTX8moNofOWJpcOQMLb05Tpty/m7Ddrpeiv6Q4MrGwYct4bKYqkmYzEq
X-Gm-Gg: AYBFou3togDjRj11vscu15oL8dc6cvGtr2JWRTkunu4ROKpacHYb/rsrzxkOydBWiBB
	fuPq7Ykr6Qje3AQcw3QQC0OwsUnqyOKwXiCaWruX6smrpm8YQregtGkskCdnYq1gSlK3hYB1MqR
	trR/gfqyeBpFtFCNPvi16xQdvsxfAYTN1kz9dws+71bwxSQbIwMtnDd0xgS2Dr8cXosQLF/mw8k
	TuO295VJSTTw0rUJbiMuhD1XheLSgDebJ9s9sYdUo6yFik9yot8ICWYKyrZkDdIcNCPr8GvgPFB
	HaouABIZdTJ1xmpak6qAXuXzFeRj3bWpUH9grOY3RKIobXN9Xxm433hM662N4RD/+P8vIS8Ygoy
	pInA0DPsWn9xJNv+3Av2HoMqVNABWVvkMz8FRKat6BRGpOrqghFx7rCZ7qG8148ykwdDOylV52e
	1ASEMiuFu2Q2G9kCi0j0WOytgJlUtcapgeFN3LiRwenosZLs56NJ7didz94Cq5CTEgUetBFSgNa
	yL/xbeqdu16Tr+Yf3F7bF3H+5uuLl6Z/1TwUd9SJZNN6LyKmroJVrup+2NyLP7Mxox3UBVR6mg2
	weLm6+5CrQ==
X-Received: by 2002:a17:903:32c6:b0:2dd:ad74:ac29 with SMTP id d9443c01a7336-2ddb1bae2b9mr101877825ad.27.1789856768286;
        Sat, 19 Sep 2026 15:26:08 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df378440f4sm7398615ad.59.2026.09.19.15.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:07 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] romfs: reject non-advancing nextfh offsets in romfs_lookup() and romfs_readdir()
Date: Sat, 19 Sep 2026 22:26:07 +0000
Message-ID: <20260919222607.3794829-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In romfs_lookup() and romfs_readdir() (fs/romfs/super.c), verify that
the masked nextfh offset strictly advances (or is 0 to terminate the
directory) so a self-referential or backward nextfh link in a corrupted
RomFS image cannot cause an infinite loop in the kernel.

Fixes: da4458bda237 ("NOMMU: Make it possible for RomFS to use MTD devices directly")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 7f783d6173e8..4d787ee06d4a 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -191,6 +191,8 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
 			    romfs_dtype_table[nextfh & ROMFH_TYPE]))
 			goto out;
 
+		if ((nextfh & ROMFH_MASK) && (nextfh & ROMFH_MASK) <= offset)
+			goto out;
 		offset = nextfh & ROMFH_MASK;
 	}
 out:
@@ -223,6 +225,8 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 	len = dentry->d_name.len;
 
 	for (;;) {
+		unsigned long next_offset;
+
 		if (!offset || offset >= maxoff)
 			break;
 
@@ -246,7 +250,12 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
 		}
 
 		/* next entry */
-		offset = be32_to_cpu(ri.next) & ROMFH_MASK;
+		next_offset = be32_to_cpu(ri.next) & ROMFH_MASK;
+		if (next_offset && next_offset <= offset) {
+			ret = -EIO;
+			goto error;
+		}
+		offset = next_offset;
 	}
 
 	return d_splice_alias(inode, dentry);
