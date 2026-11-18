Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965854;
	b=LEJFhb+VdzM9M8dqRKk3alPtqiaMaF5GOL6a4eaAMHij5GUPC0rDCdeFjWaSQBptl8Ih
	 lvBFeKGJ8A+te/6ugnQ99Im9h9+f2WJdC/SegLc1z+YMqjX5ZMn0VxnmBCbnO2EbyNgyX
	 3w4cpxxCjpUBuzfhOIiJo6IbwnUunb20LQ/FLZ8QLS65f5NmIFez6ZLWPJAPuyrVI0azb
	 wG+wGU0SH7p7ALq00wh/FSVwna5nKEvHHgyKGIbq5FMmZ23ySai2tAzWlq45j1rC2wXrH
	 PkYwTkQo5jOA059wLcf6eaRC44FJu7g2pEo8VdW4Yg878CPqlQaWvnz4xLZIhJEVIrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w+zR/XXDQgDFZvwCaQMa48ck6Vax34QACtIpBS7POtg=;
	b=ZgzUylxaiNwVw7A9dUtxog4sOUxa7iN7rbcJjSR5M2RpLqjZigO2cx181p765shfMALu
	 f/sGtlibuBapD/1U0wJTh3ulI8FjRExp/0qeo7aN5okJbZ36GH99vstOT/+0u1vjTd72T
	 85SERrfu7xCJ/S0lehYDOY5FD5vK1l5CSMsftu0+G/JkrgfZ9SvUcEcUnpQ52hfurXD1w
	 Wxk1fbrV024lxrQ1ZNJxi8CxVR8IcORW8Tw3AxuHuU3OFle2hbHayL9pl1ZJxSjtcOozf
	 VezCCzGo6gNhgkVsMqPwW49G71wH5Mv7D4kLssUsBe/tzyKk4y4QHNF2qut7KmC7ZFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf0vZLHw;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F9606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 01:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 977F9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lf0vZLHw
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-382f4710a17so101343eec.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794965853; x=1795570653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+zR/XXDQgDFZvwCaQMa48ck6Vax34QACtIpBS7POtg=;
        b=Lf0vZLHwzhXehBm7nldSrNvPnXS1yKJ2nz7KC9QThcizXhWXfC9KaYKF4QEuaypLNB
         C709O+oQWPBa4Cpl4Pia8ohr3CcTiMEH9Z6EADOzR7j/5acovhWI2pXgXMaLMojOYd17
         xQkvorgZsjzMQNGU9EZ55dwSHUlbmZ8uZNGr09ea3X+KfAFOhGSDoyb/6m82htJc7t9E
         WgAe3yW5Xf8U373Sun1Xs+CUm95wPXVKIclZgA7nh1oAMVtrCuj/nfmy2WgMu4ETzz2L
         LwADMYkDW5XYtVIb/+v8GsByiTYbjzj6Aes6bQsdL8+vKVommdr29A+p9KfX94or5PWm
         GnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965853; x=1795570653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+zR/XXDQgDFZvwCaQMa48ck6Vax34QACtIpBS7POtg=;
        b=yZ7qScf5UcQXA6Pxfg46+dlIn8ts+ara/xpZTgMPeLQYIdt/euGlk1zm5cq0Br/HW+
         MAQ9XNiDhU9CsKIPk1vxRny2C7/Zq87NrX1CmKn7AbyEJAwwv79Zg0kzEhD/9jeLaNPm
         KWFQEUKaAExmEE9s21gFxjOGUwj7ixhTHR7G0BpZ6Lgeh/K1BQeI1/tp2Z5sRPy7CDjY
         +EZxptH9xZJkrCzn/CE33moThc8c7nzgr0pLTQ0MC1ZvIHLXy45IoXmXWehUZvX5gO7B
         9yxSj2wd7eOBxnDFZ1cBy63mRHRPQHDz9CaN7As1u32Ajo/m0et/8bXoDMwRTWOZYKE1
         Bf0w==
X-Gm-Message-State: APuU4Z+Tqsh45pGzVCuFEqnBCDkF6OAHUhTuax1BvE4Io1NM4e5ylSz8
	Q5t7AM+bTh47Ndb2cLiG5RzXKItodCZ/msHwLMMrJ4ChwAe9OHwRf5Er
X-Gm-Gg: AZFdTZe4H+Zv0wYRRY3RJ4xZ58cxURPg7K+EmN+oFVjWwIY11NYdBHm/gBdrAzdogkC
	hf4D2l7CVuCRQ7pEnqUdhXnXbXt6nO3m9YTgq9LXuiegx8xHcaWL+fNNHXKfDn16E9e0n4twiNU
	d6atC2oEGcipAUjcpLpbGhiY/LZXFcSWBC+ng6MqFbOPWAZJ/VB9lyne/J/b7VpGc9Vlxaba3uN
	uukbIzmEF7w8LqhpwqT/GubDW4o4r6uC8EKefn/49hU/lqJLkO4Gy4NuCzD2wmOzeRHR2Q0o3kI
	pCpC4d0K2YXuc3+Pbob9F8pE+lwVPRHng7VLfe62CG9+CXLYnbgQnkZmQKHMb9ubtJBcIEnrcIf
	hFHER1cOd13P/OuzCGwEMqF81KQ1GjaGwAASEaFswSG38pOviKeJryHdu0H+iNXCx9N/bXjj5rm
	WPWRg2cg6veu1zhGWMT1x5Wvbh49dyHZOiD2faDCUughEIcsUw4AgGmIaVd4ADcUw9zWhCmqL3D
	S3TygR1wkPwOSfBJMMqZbelRBFSZDtrbL81oGx3rx0ceU7kwzunZ0yIhSMwFb0w55ckKff/LI7C
	Mua1t18QaYu9celTvVkV5uE62dmkb4W/Xys5EMBs7EakWHKuRcDUrOU5VSqc+mc8biKFOTr2PGX
	TicNf4BxaO2bEIkCUNdADzgb8ORSI
X-Received: by 2002:a05:7301:1823:b0:379:3c04:2cdd with SMTP id 5a478bee46e88-3828181119cmr1122022eec.31.1794965852451;
        Tue, 17 Nov 2026 17:37:32 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:b1a7:bebf:2fc7:37b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6def9e2sm2094527eec.13.2026.11.17.17.37.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 17:37:32 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v2 0/2] hfs/hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Tue, 17 Nov 2026 17:37:23 -0800
Message-ID: <20261118013725.90985-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114043522.48764-1-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
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

hfs_bnode_read_key() checks the on-disk key length against the size of
the key union, but the buffers from hfs_find_init() are only
max_key_len + 2 bytes each. A crafted extents leaf key overflows them.

Changes since v1:
- hfs_bnode_read_key() takes the size of the destination buffer
  instead of assuming it, as Viacheslav suggested.
- hfs_find_init() stores that size in struct hfs_find_data as key_size
  and allocates the two key buffers from it, replacing
  "tree->max_key_len * 2 + 4".
- Every caller passes fd->key_size. On a too long key the function
  clears key_size bytes and logs the error, as before.
- Added Suggested-by: Viacheslav Dubeyko.

Tested on 7.4-rc3 with KASAN in QEMU: the crafted images are refused
with "Invalid key length: 516" (the unpatched module corrupts memory);
an image made by mkfs.hfsplus survives create, rename, delete, xattrs
and appends that spill into the extents tree, and fsck.hfsplus reports
it clean. hfs is compile-tested only.

v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

ozgun kultekin (2):
  hfsplus: pass the key buffer size to hfs_bnode_read_key()
  hfs: pass the key buffer size to hfs_bnode_read_key()

 fs/hfs/bfind.c          | 6 ++++--
 fs/hfs/bnode.c          | 7 ++++---
 fs/hfs/brec.c           | 9 +++++----
 fs/hfs/btree.h          | 5 ++++-
 fs/hfsplus/bfind.c      | 6 ++++--
 fs/hfsplus/bnode.c      | 7 ++++---
 fs/hfsplus/brec.c       | 9 +++++----
 fs/hfsplus/hfsplus_fs.h | 5 ++++-
 8 files changed, 34 insertions(+), 20 deletions(-)

-- 
2.39.5

