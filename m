Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE1178F39
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773967925; cv=none; b=gzrWJuSoviu9oh4Kah7h6xAvmuyDUEBxzm6UzveeOf9csvd/xax3oXjISeVT/l1eWdQjWpFkl+Xj+I1oP4eZpTgr/lw60ONNN2SdSwFQyIiuYraQykOY4SXyou/F4de20L9GzE3HvMqw48EzHTeqHpaMeUXhelmhDqC3gdPRNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773967925; c=relaxed/simple;
	bh=HC7a/uepR7yvM+Hy3L9YmOmBswicpOMbE7n49YtuKAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKjhc1iIWaI28EasmP7hDrrBJopPg25fpKzoRDkr5ep2iI1KKGNHujTF6rj4LWDfrl27aNUdl1pwNSQAil1/ikV9sh5YA5Y9uzHkwhcXr2hBWcJHvTr6lXafHaCo1F0WBn/AsFa2vnswF28kgt9Aq+oaYHs020fNHxrboYZ+Pbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8O9KAo4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8O9KAo4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82a15b44c3cso947096b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 17:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773967924; x=1774572724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=baxsixP3ts7CN2kPTC0RUZ6mfLu0lUxnu4cjazVMzu0=;
        b=Y8O9KAo4bfybBtRDJWsUPenrYdnfINSIC3XzLKqDTRyMzdbE69JOpU+ymE1K/PxBTt
         e/fvD7gE0y9JhflmkA2ULlOSzLBvw2CEyvSgaTk53u0Zu3+yoZKts3SbcEJ0hAhMdc7J
         OCzzZX58IqR1Hz545GGBtQ58mgbvTW3rKQbtHjukRTtQRwziLm1p2RMHyqm/E81Zpc10
         phor+grdv6mdwlNzCTM1niMZwXy1PppN/YnF8as56L63CFBxHkJOrRWGeFESJy2kS8s+
         UroaO05Fu0D4lgKJFk+sDXgE/SruUJM6v9E9G0xT9F9amSpCp7fHfYkcunqBBEqMGu74
         utDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773967924; x=1774572724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baxsixP3ts7CN2kPTC0RUZ6mfLu0lUxnu4cjazVMzu0=;
        b=BK7u3IYXzmNhumqAZSI18YSVMh7L0tbd0M7+qdJ889o9pEC1mUpb4bYEdAfz0otjmg
         21Pr9/3zaDUGxwdMPOeR6rNU+J0GpibxRvTwIm5d2DWLcBsXjUhu9KEusa6tYTCFhfy1
         gJ8FevVaQJRFAa8AOILUQopbpH83oMzTfFOjjcUHQCiXEITkQcK87M4sSlaYlvf1lIM/
         Z2yziYnp6K8I7/K5sEYFy1jP0WrBuWW6r0lzX8jNhbZU9hx1B6WEJSrQiOo6d9PU/jGA
         ZpilDQWlHgdwflt4djIjHICWMBipRCsAgRvHaEKHpbWQfCSM0mlX0aeceX+15nleZZh5
         Zd0Q==
X-Gm-Message-State: AOJu0Yyt2gqHwDTlEelTVtXP9VgPnRRXpeUWuyHpifM4knb+0/70xTPW
	Y9ePF5G+EgbTutYQJXgkf0gcnjo+DbHuxiNiL8RZVHYDv5aFVytmDUJf
X-Gm-Gg: ATEYQzxt6LgZwXbeJ4lkVI2Y4rIBo3DJZ+DMZUm5PqMWhyMWlKoRynSCm/CM1FvOjwR
	hwDwd0eamYyuVxqjhDQI51K+93dOo3b6MCORg4O0PD5ODig78Z1jAbZRJuRjzS8bzZyqIuhVFq2
	eZVhq2dCa4F+udK3/lbBAiy1jwGMwvy9ivHE/JRuQti8Mz7Q8nGk83pib15M8rMu7jDUoy40Ywc
	o/7TDUkZ4qOqjW9xBCVpJRqTevcz7F4XEN4cZkX+Y8UqkkrwzygAfeEIcUK8c3CUvkSDuupkiqQ
	kA7DlvvfXJc47nkFP2/hQLXH+YkYPELcYxAWDj/AKija6Y06hPuEnbtaxyPWqBji4ZK6tXZd+zL
	50afLAsW8MBDlm6u5INm/JLY12WgBzMBGURjoJP02fKa7lBimToDwedvIUmy13QLVHs7c6YuSN0
	/TgaU3lDJBIvEXNYp2EPWjpLL6eCin
X-Received: by 2002:a05:6a00:10c9:b0:82a:60ad:87e with SMTP id d2e1a72fcca58-82a8c289509mr968680b3a.19.1773967923987;
        Thu, 19 Mar 2026 17:52:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da438sm370240b3a.43.2026.03.19.17.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:52:03 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	miklos@szeredi.hu,
	david@kernel.org,
	therealgraysky@proton.me,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 0/1] writeback: don't block sync for filesystems with no data integrity guarantees
Date: Thu, 19 Mar 2026 17:51:44 -0700
Message-ID: <20260320005145.2483161-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog
---------
v2: https://lore.kernel.org/linux-fsdevel/20260319194540.3463371-1-joannelkoong@gmail.com/
v2 -> v3:
* Move SB_I_NO_DATA_INTEGRITY check to sync_inodes_sb() instead of
  sync_inodes_one_sb() (David)
* Move comment block (David)

v1: https://lore.kernel.org/linux-fsdevel/20260318225604.71545-1-joannelkoong@gmail.com/
v1 -> v2:
* Still kick off flusher threads for writeback for SB_I_NO_DATA_INTEGRITY,
  instead of skipping that entirely (Jan)
* Improve commit message (me)

Joanne Koong (1):
  writeback: don't block sync for filesystems with no data integrity
    guarantees

 fs/fs-writeback.c              | 18 ++++++++++++------
 fs/fuse/file.c                 |  4 +---
 fs/fuse/inode.c                |  1 +
 include/linux/fs/super_types.h |  1 +
 include/linux/pagemap.h        | 11 -----------
 5 files changed, 15 insertions(+), 20 deletions(-)

-- 
2.52.0

