Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E7E28C854
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331101; cv=none; b=rDCo9Sv2awyF5Z7ExqoOHzA2iJqCIh6HFJB7Jf2IPXqP9E13jKx66+3dMqno5HFEgVsJmkuA8esdYbSU659KENulze2fD84cqQwExrCZ4VfZH0ncUz6fRymAGiGe/nJwQ9fCuDboDiLfuXabYKNVAOm5hA6yjlxGv5ezv+4UN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331101; c=relaxed/simple;
	bh=4HOyozKVGyF08br2hcqv/2Z9+HLmqD0qt+QN0pP+knI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqF/MM2ebTVnalUZSKqfePOoIGql62MjTp3GbVAaPfCl7SfMtyQBb3zDHA+aaTgqhW2G22mfPUnr6h4nDA1VTYy9KUCYRxgYVbmRXeOp8UTq+UTAcEWySOE1C6GGzshbB7xh7p/qQk8EURlIrRLDWEMLfgHMv1UIKYZiWSl1KP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Thwavwql; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fb3rEg46; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Thwavwql";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fb3rEg46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780331099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cY1uXoengy1QKd4o3p+NIvdoWhVTneNFcdj5V9k5ZxM=;
	b=ThwavwqlZu11wiTpXyvXEcFVPojpQEq+ZqOlQ73Y50CSznSZTEXXNsIJWTdDJCmlbvZucc
	AUcakIsTzYKabqchpAJPAubWeVGLEOnOaHsF5HEFlzopA2aRAcFFKVUVDjEFXDwKgW7NAk
	FAbY6veomO0E4dnUVy1OLn1wK1skEco=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-LHZ7n9loNUikREh62D6fxw-1; Mon, 01 Jun 2026 12:24:58 -0400
X-MC-Unique: LHZ7n9loNUikREh62D6fxw-1
X-Mimecast-MFC-AGG-ID: LHZ7n9loNUikREh62D6fxw_1780331097
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso1404860f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 09:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780331097; x=1780935897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cY1uXoengy1QKd4o3p+NIvdoWhVTneNFcdj5V9k5ZxM=;
        b=Fb3rEg46u086Fn2nH9DBaEi2HZ1U9oIAzFd+Ry8YMc0kS37O6dmDHeOkgQ6clVg/gA
         xVLjKuo9ylLbWRsvNGxjK+uQN+/6+oayjBDMObG7tVXyI03+LlmW32ZTZatAwxvrWQ4G
         tYqmVTDJP7vWRtjnTp9ZT29Lqbd5+YE2p6DiNn3sgPNkV0sRezRqCc7rUSDNXoKQRRhO
         VDCRZSC05zfzkodYj4OPBSS6MFSpwayQR+iyxiIBpWLr1CGHz7xve7KoaPBWjgkx0bMv
         rejpWP9dnRQOim/itIhToQdLYHTFy5JgUO/9phhkN2Xc61MZdKwiyTgFaxRhIDXadO51
         lWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331097; x=1780935897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY1uXoengy1QKd4o3p+NIvdoWhVTneNFcdj5V9k5ZxM=;
        b=U+1iBjnSjaVvkrYil6uX2t46TUeAQkImJARImf/F9N9Aa3+M4HijYxVFOqIrDYUjrC
         IMYfVn+/J81Lpq97U4zh5cKbKCCJD7rvMxdGSYNei3Z7xK8OCQI4Lnz6WZGSeiKlAw+S
         q/ryVLZZ+VE6HKN7a+2LkzXRZ36LL1y79xALpp9luehS/vYLMUpTBt9kEV4wpPROEutq
         atlvesbSPjh8OC5eh1zofJTAQaGjehPqlJYG6MUDgs8uypNDU2P7Dvc798xgUxSxshB2
         LC8+rcWiOQtR60VVmyVQRB7Nc/skEF33vwjLn8xbnFu20/jVUV8yugdwAXzJ631AhDBd
         b6VA==
X-Gm-Message-State: AOJu0YyF4v3YLmKP2hHw/hXx3NAYWrOLCaQ9alEtGnsxEWCi8Ti78E8s
	pe751q3zryhB3RRUIpvdRYSaJxF+coBfxMxqUrNWjvQUNzQMYF8jDHqh8QADFxNMTQTV0mfWvEb
	DFBbb39hBxMuzVQCPeIqshoXipDkhfB8krWXi9Ul9uk/K1qk55z5oAQ3ksu8CMHfxU4FSA0RFu8
	vYWylcEUBW3J0DNzFVTHEkqDek0WM4XsN2/miyr0mbc1PcNeV/7YY=
X-Gm-Gg: Acq92OExB1vrR4O4xov9I0jp3uYcRQ4QcGarXeYc1rwoeODmG9IJo3wOi/+NJ6+w4qM
	8zGzEj6mgv231/0KIOom1+wokNKNGebLz6JWGLRkUEJ67wipc5HNaV8kOKjZrpPIkKdPukiE4fy
	kttvLVnffvfCNnzJlSMQQBpFaNAALnR/QXlE+OjKBuVFdlBn1yCCutXzePsZaVOSlH/yywAeyi+
	XtboQ01R9/OUWusxrx6S5oGFmQhP/efR+khCQy2FiyANz1Tk2loAQl369duqBXgZI+xSaF9Bz5G
	u7Ax48PEQgG/XHV9ZnbySo4nip0a7yKk576ZJiywu6Gu9Ma5SKlRxI5bMt9r34CFnsiFFOLu2rL
	ulqghdNHM+4BJymaxfKpUYMiwMF6iwLXjwNAIsDVT9+klfwZL/o+DRxSctlAwfcoc64tNqugtQ9
	OpWM5b0ffrnuw=
X-Received: by 2002:a05:6000:c10:b0:44a:b931:f32a with SMTP id ffacd0b85a97d-45ef6b5d61dmr18077830f8f.27.1780331097136;
        Mon, 01 Jun 2026 09:24:57 -0700 (PDT)
X-Received: by 2002:a05:6000:c10:b0:44a:b931:f32a with SMTP id ffacd0b85a97d-45ef6b5d61dmr18077795f8f.27.1780331096714;
        Mon, 01 Jun 2026 09:24:56 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-174-180.pool.digikabel.hu. [85.67.174.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef356b129sm33036213f8f.32.2026.06.01.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 09:24:55 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/3] simple xattr improvements
Date: Mon,  1 Jun 2026 18:24:47 +0200
Message-ID: <20260601162454.2116375-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - don't use xxhash
 - fix lazy alloc concurrency
 - fix rcu freeing on evict
 - fix rcu walk of per-inode list
 - don't double account freed space

Miklos Szeredi (3):
  tmpfs: simplify constructing "security.foo" xattr names
  simple_xattr: change interface to pass struct simple_xattrs **
  simpe_xattr: use per-sb cache

 fs/kernfs/dir.c             |  13 +-
 fs/kernfs/inode.c           |  28 ++--
 fs/kernfs/kernfs-internal.h |   4 +-
 fs/pidfs.c                  |  45 ++-----
 fs/xattr.c                  | 261 +++++++++++++++++++-----------------
 include/linux/shmem_fs.h    |   3 +-
 include/linux/xattr.h       |  35 +++--
 mm/shmem.c                  |  60 +++------
 net/socket.c                |  30 ++---
 9 files changed, 209 insertions(+), 270 deletions(-)

-- 
2.54.0

