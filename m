Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049989;
	b=sTzRAuo1g4WXD5z0QxOEIt08QRmG72QXzQr2np0QPI+ZpPOZIVa3JklEaF9hR+kIbwdK
	 daEg9eOGsTtXvn61Jk0gNH+Nc8xNCczb7nm3ncU41iZQT7tUUyzMErsBm0ctMAKzNZycY
	 3fU2bE8pmCNLMU+0l/S+AfE2WyCiQ3YP4ClMmSVzVTus/7U2tsVUKxU17W/XxJBw6FUT6
	 090S3y4GeshFmoAMAc9EGdxZNKkN7eUkws8w2jYjxJdxSF+Ld4Y+if+iFAPmUeabN9qOC
	 Cw1EaVHEmguMjkOwrcoDaIgRScp0wonQqWX/72P6GEF7ieIa2TJ8oC6yrXa0m3H1DDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7/26mxUBrsO9g5tcpUtlgYuDJ8aXBYB+exDEsHNKWYQ=;
	b=1mHTRTY5kNdeVcOy/cRl+VNbyYDPUgCETYVQRUnWE0aBmtJfpWNVKe/CUmNIPkF2w+c1
	 5gb22DwTsfhmLIW6lOJHG7mRNVmIy9jxVy69RNN++A4yabqCJ+ZbPlD/EgjOtt4FEb3Qc
	 m35pKNiuvj304vffWKEu8JEVQnGuKQO2tNXpIjl0TL+2P2JyVMXxiXwT6AySby/qaYKnP
	 Zf2iTlJcOhusracbJHgFDoac7TnKkEte9fff3GzV0dbyOsAwOAibl7brInoVoSM5ldYkx
	 HH/jZk8L669dtuOVkzPO9sed7y+5LLNiWrfTrvhiXVueITIgaLjUepNygqkK69HSBfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XEwZFSAt;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C975606A32C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 00:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C975606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XEwZFSAt
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2538945eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049988; x=1795654788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7/26mxUBrsO9g5tcpUtlgYuDJ8aXBYB+exDEsHNKWYQ=;
        b=XEwZFSAtpYwzY2QDMsdsmtR8zrBBmdbYxbZdis5H/XDLh9XZ1XBi/2Q0yV6+MVfvLt
         LjMw6uDlf0Vb2ZarbvaWJeP87th5v87qUMICMrXYZ3x1NpFq7R6fcBmo335gCeP8Uyhm
         8N9m9jc5l75PVuqM/bx2Ftz3zkbfiuFvfKW3RFcVrosJk7Yk3ULcb9PNMg2yH42bccb/
         2y52/qSbeZa9He8I0JwsFaJjpsWnah1Zv/mMQsGi5G/zd0gnHJP2YpAdMu7yYLJqm5Ym
         DYm0hnW+9eZmLwaA9h7UnanCRiCdJLJAgI7ugxz+rgXMzNJnp+2l3tjBv3YvHrTKP51X
         miJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049988; x=1795654788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7/26mxUBrsO9g5tcpUtlgYuDJ8aXBYB+exDEsHNKWYQ=;
        b=KddRQFMepSLT1fXPpIVt6L5s1HFYJlPjqXVBvSeevcpCvZZBaHayRlYW7DKyp3LKyS
         XefNfIiFqOShR6geZDZN/PtwZPcQj/qFGatLIdntcX2AVco3CMiD4ZwaIljOUYWCkWrF
         kEZDA5T7kvzSq53hEaRXgSUq2o+iUY3AASLdT4/BYqwPQzcA+pGSBBW90BlQaK4GzScQ
         XnRrvnR5Ezv6arJj/lnp2zltpxFdUIQEjvNUNuKkS1j8xB2Wb5eXQVqZILY3L1v/+jkC
         n+BeJcUrMETdZswsSHZ6lxH1u8XqicyIFrkTKwWo5bfV+8YCFkhv2bSL8RbBg4ChQy3p
         LMqQ==
X-Gm-Message-State: APuU4Z9ivIewyl60DS5W7njX/027gWqsABOIGIbd9eJ0bqc57DQmIjRl
	zOTU3F8l9SpKBzUwaIjJ2fkRJrZ79E/bNMa7to5v30UO+Bz7/+9REZS1PG3Bx2T2
X-Gm-Gg: AZFdTZdInqRewDPm0ZRukVNqU6Ursat/WTHopFbR8Y6tsoORm9fy87T3R4ojVBA5X24
	X8CR/O6LdMJRxU9iv4Mr9g0H4vIi+ulfndHMC6/bg3GZM8roH/wNmbhSqj6JGSSC/hJ879OpmCj
	NqFx4Ip/7tGCagwe8TAGv99yiuLBDV5NBGGSwyHK73xN4MoJT/e63B5xIgWCfVlXYIlGIpbCcUP
	8yZNO/oVqjquHf2AGmURiSW529oxy+LkPnqPmiCRNYf1wePVX75rrtFrtgHk/It7VQuwAY+DOkS
	Xxk/Ht3rp/sGkOikusXzkwXc48I5sOKIEn4TbYEgT37Es4B4/8ilAmPJ6Ky1di/jtJgSdhh0HX5
	vRaugD1yDJoa6Mxs/D5DO1PvJQME7kRSHTuP/I/m4j1LnJI1qtOfg/ZBn+8VH9zTgXX2odc8DFI
	cE+CXI0dyeDpIwYVbm1YqVG01c6tUz3N6fbujMdvJocEq5mRrCKOxdEra7tyk9XZfIyq4RWlBLa
	baK54OeVtcnVrM5X5Gu8l9k6qkrv7zWvUddaawrWGIhBS/wesEAzSqD0GZosuO2Ek6Lf0IHloLh
	qzHopjkxDyvEmYEYW+VkfrP0zbj40OKGW8XsHNKlSf+jXYoLcH3RX9xF5ncdWYezYHStj889NQ1
	vNMmwc5J0YrrucqeAL7WV40Ap5bs=
X-Received: by 2002:a05:7301:f27:b0:36e:a179:85f2 with SMTP id 5a478bee46e88-38281023d0bmr4364437eec.23.1795049987441;
        Wed, 18 Nov 2026 16:59:47 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:9887:3c66:c29:4859])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm13456446eec.18.2026.11.18.16.59.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 16:59:47 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v3 0/3] hfs/hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Wed, 18 Nov 2026 16:59:40 -0800
Message-ID: <20261119005943.37851-1-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118013337.67813-1-ozgunkultekin@gmail.com>
References: <20261118013337.67813-1-ozgunkultekin@gmail.com>
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

Changes since v2, following Viacheslav's review:
- The literal 14 (node descriptor size) is replaced with
  HFS_BNODE_DESC_SIZE, sizeof(struct hfs_bnode_desc), in a new patch
  1/3 with no functional change.
- "max_key_len * 2 + 4" is written with named constants:
  HFS_FIND_KEY_BUFS * (max_key_len + HFSPLUS_KEY_LEN_SIZE) for hfsplus,
  where HFSPLUS_KEY_LEN_SIZE is the size of the __be16 key_len field,
  and HFS_KEY_LEN_MAX_SIZE for hfs. The allocation size is unchanged.
- struct hfs_find_data has a comment before it and one on every field.
- The new field is in the "filled by caller" section, next to
  search_key and key.
- key_size is renamed to key_buf_size.

Tested on 7.4-rc3 with KASAN in QEMU: the crafted images are refused
with "Invalid key length: 516" and there is no KASAN report. An image
made by mkfs.hfsplus survives create, rename, delete, xattrs, appends
and remount, and fsck.hfsplus reports it clean. hfs is compile-tested
only. The series applies to mainline and to hfs.git for-next.

v2: https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.com/
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

ozgun kultekin (3):
  hfs/hfsplus: add HFS_BNODE_DESC_SIZE for the node descriptor size
  hfsplus: pass the key buffer size to hfs_bnode_read_key()
  hfs: pass the key buffer size to hfs_bnode_read_key()

 fs/hfs/bfind.c             |  5 +++--
 fs/hfs/bnode.c             |  7 ++++---
 fs/hfs/brec.c              | 36 ++++++++++++++++++++++++------------
 fs/hfs/btree.c             |  4 ++--
 fs/hfs/btree.h             | 31 +++++++++++++++++++++++--------
 fs/hfsplus/bfind.c         |  5 +++--
 fs/hfsplus/bnode.c         |  7 ++++---
 fs/hfsplus/brec.c          | 35 +++++++++++++++++++++++------------
 fs/hfsplus/btree.c         |  4 ++--
 fs/hfsplus/hfsplus_fs.h    | 28 ++++++++++++++++++++--------
 include/linux/hfs_common.h |  3 +++
 11 files changed, 111 insertions(+), 54 deletions(-)

-- 
2.39.5

