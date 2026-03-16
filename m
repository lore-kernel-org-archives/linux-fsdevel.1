Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3FE3783A4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 22:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701828; cv=none; b=AxVShiAH/Q5FJ1flCMDR4KSjGzfJBi3L3ygh21GUhVEvKHbNq0KK6+HDAWvV0UnzgKcWy71uYzqfeBaQ/U5T/+hxtxvzfg/+zf70iBeeJu7aZKOmFTOj8468bBkhe7aTGoXZhCYhX3Fg1yzbrXfs2N0PrSKValwSbyUQGNUTrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701828; c=relaxed/simple;
	bh=D2NzzyTwqfPUxLwK3Czyu3ExmA8jPl28uSrbKyqzm7M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KX58VyJznWbBu8sTxKmn+qkuCg7x9swI0vUJohvWUlcN3Nu/RfEr+ogK0LoZnzboYEQHQ0KNnpHGt9nOfasDgzTNdlHsplaNiQi71EgBdSqBtWj/NjgBC9F0zgi9ojudY2c2Zl0CoNGkBCED3QAp82hI3KHjxdLMcp7/h314oX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RZ8tc79u; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZ8tc79u"
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-67bb368c757so15898684eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773701824; x=1774306624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SWY1DhzA2c7rypFxByaf4zYw/4rLWHT+gixAZQsr9C8=;
        b=RZ8tc79uHnwGtc5bhYb25ZmHfIQCezoKnpGZBadxLlOQfUwOCvM4/mpubhCGAI+NDY
         eXZdRYq6Uvq81hIgKxhRFRz/BT8z0ODy//U13HcE+cMj6pWYvMIkIS1PTRuPyNjbcEfG
         oQHQ5I6Ghl30Gew/JjtdwxfbU5tuD6N63uf/CVL93yxve1e8Xtj0JEonC2q7BZLpgH3Z
         +mLa07wvbpH7oScvmorGFO8RT+pYcUAzhclPLcXw6dTBB9UBG29ZkKHG4r/vGQpU/sXq
         825Acyr6hOKj+7i+zn2K9dDXYX0tH6SmRmAz/0MW9JO4mwdaYv/aTsVvbFUFJbJegNtV
         q+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701824; x=1774306624;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWY1DhzA2c7rypFxByaf4zYw/4rLWHT+gixAZQsr9C8=;
        b=Fz2Ukeg4AMWqH09YCPmjnBWUGc2IB74mhly+G60aIMdxjrbSM5j6Vh2L5OdbqJH8pH
         kHCKzei9fpBKxTjy6ypJVAlnkqLIsHHhIIEL7iYiT3sN88olsfg8ls0P8aYA/1XaBkBY
         X708AAWzFdUnrePx76RbDS0N3OMs72EaiZQ/IvIINFDTqBZktc8V7l4SfrgoLT9Kpf1N
         xQ8IGngNRu28QrkAR6QVtxYaR9qFYROg8IG0ThAproOAMtg0wih2Ci5OU96CN9vS/o3m
         GZxUYlYZ4ewHwz7NNW7FO5LYipoXhOG8FBMv9giJt0p1XnZsXq20rR3yTeYnnZDUsYxM
         enDw==
X-Gm-Message-State: AOJu0Yx0ZKCybEWX0KQVLZ1aL9LWBDEbTJOkjdOC+Kc9zold6ZTOeg+X
	nAndOs3MUhgBkWZXglWvtqw2BboLHwbuV8q5QiOvuk8x/k0XYnN8q+jZsTtcdOebtYAnwjrfqvj
	vrHa+5g==
X-Received: from jabki8.prod.google.com ([2002:a05:6638:a808:b0:5d1:4982:997e])
 (user=avagin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:4913:b0:67b:d754:951d
 with SMTP id 006d021491bc7-67bdaa36698mr8291085eaf.38.1773701824445; Mon, 16
 Mar 2026 15:57:04 -0700 (PDT)
Date: Mon, 16 Mar 2026 22:56:48 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316225648.1548082-1-avagin@google.com>
Subject: [PATCH] fuse: check for NULL file returned by fget
From: Andrei Vagin <avagin@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Andrei Vagin <avagin@google.com>, 
	syzbot+2a667b3be0ca4b7035ce@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

If an invalid file descriptor is provided in the mount options, fget()
returns NULL. fuse_opt_fd() was dereferencing this NULL pointer when
checking the file operations.

Fixes: 6dcceeb72856 ("fuse: support FSCONFIG_SET_FD for "fd" option")
Reported-by: syzbot+2a667b3be0ca4b7035ce@syzkaller.appspotmail.com
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 fs/fuse/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index af8ad96829fd..95bbc7b28b89 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -862,6 +862,10 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 			return fuse_opt_fd(fsc, param->file);
 		} else {
 			struct file *file __free(fput) = fget(result.uint_32);
+
+			if (!file)
+				return invalfc(fsc, "invalid file descriptor");
+
 			return fuse_opt_fd(fsc, file);
 		}
 
-- 
2.53.0.851.ga537e3e6e9-goog

