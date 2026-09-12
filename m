Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033992E718B
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198490; cv=none; b=rAM1W7viJbd1ENjp5CLsT5H/jd00gbRmx6agsf1UhkzaCg4L+AWUB+uzrwmuEbGAvgvFOHaUJj4Pzs6TvFLWKcAeUFYQUetMhVA6BJ5LX5pejJDv+Zsvg+jCnOhumE5QKqdwYlBVNfBG0Hv+AevqaQ2sjMoHL/qiONAa8FJtquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198490; c=relaxed/simple;
	bh=FuiOWbW64EkXmhSCCZESWu46wUZGuIbP+topqzKMfsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HHh8s+uGGRktTwRZXcNsjrSPW3mLJECutEbo9VKDGEA1X2jiiOfDM/GaGMDnI2LJFi3p8HtO5jJSNAWIKVYYJjpea4JoeE4p6z8U0wIhTf/q2Rr+Ph3kDkZ8K14s00SeeYCrC0QRw19RCIYfW39Oydt4zlOfv7jEG2gcJRApvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXhbaisA; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXhbaisA"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccff31419so2462105e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2026 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789198487; x=1789803287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKzOKf39vUQCKlSSJr14iXhgJoohToEd5zg/sTn5zfI=;
        b=JXhbaisApL+UoslNJ2RwfWxvewaX82OBTVTCydSrgN73Bq62uPxbzKMwwwx6b7oa7j
         3mtyUw6MShFcX9mKfKMLmR/nNpF6R2aNK1rHTFE+Cz5AODL1MpUEigMHsWQjjXQHpJow
         +BkZeeTpfAu7XIEIAhgy0aAo0kdBwYM1cOe2ttm3D2Im0B4Jo0AoM8xTjaMM4jS9IxJC
         QGVGykwuxm/XP51HwnFtVTOdW14JPnaQVm5hQnqd/RqAB6FyTkx/aHhhwp73b3GzmDGz
         E5BbI+RojynlmmwWSr9K4Y6cyC71r1BsYsp/fBy+IpkaK/72mQGGkLmqRlSAV0typOLa
         M7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789198487; x=1789803287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKzOKf39vUQCKlSSJr14iXhgJoohToEd5zg/sTn5zfI=;
        b=f970Fs3feYFSxy4ReMvHvA37gjQLVn6eGgnRpf/Bq0UjUM7PCePXtgN0MjuH2w0yxD
         ujni0f3a/7lhgFpFIH7xISM1hSVfgxVC+WC7DMMqx5gISTfOxNm3nMCgwdmjO4V110DA
         jRS8TkAhJfifZhf8ESLeCuRWeYE+8o+DVXd5YdJ4ju+0JMRob1G0AY+RkyZpJ5s1bEfA
         cou41Pe1MxvhtMNpasjai5tKUPYE4aw1VQkvO5stgS1/WJjCW7okCAYspA7ITqI5X3HU
         il9IOBuY2RKlNcnHzNFVRzNI2Ehx2q3TB3Ci5oIePhg0QcbRVb8OzRuRuhGSWr1rbp4C
         6fHA==
X-Forwarded-Encrypted: i=1; AKwUvBxB8viSgbwgGaSjqVbESVRmJ+MCLNeTh9Fnl8FUgDwa+pu1P/0S5tFwzdqMS3iemQN2q88CL0ZVfnUD+BEo@vger.kernel.org
X-Gm-Message-State: AFuF++kcJSg7xIMs/zn5Aw4vawkrl8DmG+XpfOJBYGhQUUHzjD5BUsaL
	BFQX8WEcXMAGHHrhx3mVYz1vHIfWkGn6/7cpaw9+MV+6LW4VhNghFUDB
X-Gm-Gg: AYBFou2mT+0VfXMYgnYwGvaw2/HdmCNFVyKc5+9VW2aEM4e+TtW54HRynm4Y63Gmyuj
	XuKgpVFUMkIkK7AENsj0+E4JwFkNTyuO7GrYF4o5rlHOofXzlH1o7kFVg4t0E+Bt2nL7tj5fzRq
	pxUtBdAvXGm916uc+CwlNnkcvHnJfNoTFS2JLZ5MAexPw7uHURCaEaj5p+pbj2aI7tCxEIrY+cW
	JWXcUJaGbOjENDFl4J8VVTBZmQcCd2PTx6SJN0Di7mk51FB8sLJy1aFqsWUT6qGEgh8h+xLTkQc
	VpV74+NEpL+M0LsI0A1zs31sv463ELqXoEQlFKVC201VvJ7z8AxLLBPO/x9Bbj2dBHCnvR/x1dg
	pnQdiRLzfBUmy0+j92FDvOyLH+6mgbMJPznB+1QgfC5UQVUc24VoDSqk6RfmntAIRQ/kY1vD6/8
	7f2IFe7+FPQU7/h0j9P/ebufYGWOiNCNYece8BR4450aLsRQ+69MA60LnV25ruolB5pY4XSvEHO
	5ox+w7N3TkrbKp4QUTTT4JOF3FyCwA3FQNT9B1kNCtYEqRlLkSwVPrURun5m5jJxMAawgZdpURO
	0g3XrvKfkcxz80wfLh1gZ4yAtOv7sR7IU2Q4DNog7zADRTTIHvjv6ZpNY3omWqoGyScFL9WCFLb
	mfxg/AfQ=
X-Received: by 2002:a05:600c:37c6:b0:49c:fa21:1c8b with SMTP id 5b1f17b1804b1-49e6cc1a4d0mr15498325e9.32.1789198487091;
        Sat, 12 Sep 2026 00:34:47 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b260-f201-9983-e8c4-aff5-7a36.310.pool.telefonica.de. [2a02:3100:b260:f201:9983:e8c4:aff5:7a36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ad0614sm147509485e9.10.2026.09.12.00.34.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Sep 2026 00:34:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Document the remote size member and its accessors
Date: Sat, 12 Sep 2026 09:34:44 +0200
Message-Id: <20260912073444.51152-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netfs_inode.remote_i_size was renamed to _remote_i_size and accessors
were added to prevent torn accesses. The netfs library documentation
still shows the old member name.

Update the struct excerpt and member description. Direct readers to
netfs_read_remote_i_size() and netfs_write_remote_i_size(), and state
that writes require inode->i_lock.

Fixes: 2c8f4742bb76 ("netfs: Fix potential for tearing in ->remote_i_size and ->zero_point")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/filesystems/netfs_library.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
index ddd799df6ce363d9c348b4f1e82d66b1b54bf4fd..0c9786ffe19240233ea0d8b725dd8300b9f57759 100644
--- a/Documentation/filesystems/netfs_library.rst
+++ b/Documentation/filesystems/netfs_library.rst
@@ -195,7 +195,7 @@ structure is defined::
 		struct inode inode;
 		const struct netfs_request_ops *ops;
 		struct fscache_cookie * cache;
-		loff_t remote_i_size;
+		loff_t _remote_i_size;
 		unsigned long flags;
 		...
 	};
@@ -229,11 +229,14 @@ filesystem:
    Local caching cookie, or NULL if no caching is enabled.  This field does not
    exist if fscache is disabled.
 
- * ``remote_i_size``
+ * ``_remote_i_size``
 
    The size of the file on the server.  This differs from inode->i_size if
    local modifications have been made but not yet written back.
 
+   Use netfs_read_remote_i_size() and netfs_write_remote_i_size() to access
+   this field.  Hold inode->i_lock when writing it.
+
  * ``flags``
 
    A set of flags, some of which the filesystem might be interested in:
-- 
2.39.5 (Apple Git-154)

