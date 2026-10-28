Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211158;
	b=baDCwChaJ1qvUh3zwaCTjs4uonl/czoN8h3rCOYP+HWxHlEFA8QK1K7BkUq4oOT9Wnxs
	 7LT8s06LjiYIAlDGPTxFvMYhKrnPzlN60zDrVfcuSoqd3AybKEXbTVnS/eGifobSK2Q1S
	 wbShJAN5We+7JWtO+ZF05VQMhNsUIZSCAIHA4tz1lEcest66vxP92KWGlybHPYAMz6RLA
	 I+GyRzJbVASJgn31PgKlqOx39YjakqWdI0V6UbCxTeDhCaNhwaxZMmCEOAfrIzAXeOxEI
	 WXonFUEIrc3w8RwGMGea95hMIpPyuSIpSrWzNW5V8ytIFGLT2Ucrs8AwTdfgGPKMmaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q0d6qWi5B+qlp69DsFDkPKiAVkLkzeJOiKS+6AQfdW8=;
	b=fE8GtMDE0OJRaMlTC4vI6+9ZihbRzPTGkhPQtYeA2kN1Fk9G8GJQV3fiYzCT6hlAOsBo
	 fN40zSUHSVLHsqucVgbKGxF9hQmTCyhpCxHJgL+CfgrZGo+pyCP2ufg6YharPktnrN0ia
	 s9JHJL+BfjK+IqakTMolAcO014pNhsO/spwgBjZ/6TKI4HQl4BLb2tG+GstcQkUvCnQ2g
	 1cSIMZsgRLr64iCwTdh1lgB6rSClt1L8IHXFN0LTwVdSTNbtWYC9D4y/rICisvbaJKR3v
	 hp4T1MGAbvKv7LA9wZArOXsPAEkBuvQloQCRiKGAwzAp3z19wkocUj7DhMgTSniOWZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MiYCVVyd;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C660A2625
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E60C660A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MiYCVVyd
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so1810107eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 11:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211157; x=1793815957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q0d6qWi5B+qlp69DsFDkPKiAVkLkzeJOiKS+6AQfdW8=;
        b=MiYCVVyd0iUPLIbBaMBLfjLz9Pyk+GNlyEwErmRvOBMFSxaTqWEMpXfsAAUmbQKZWi
         IgkOLYW4JN/ahhmD2MJ8B1ZoXPhIdvr+R2VqdkldusRPsQw8FRvE9//JsMF+XG41kPOZ
         7E66ijleJQzigTjB4riNeiSPqAAoD949EqH959h6pptjo62UWrauiSITdVT9caxTxoht
         dGBKljUrs1X470XcmMSpgxWJ7MzFfdueUQF8sA4tcnhaYdy4gr5a1AWh65NiWfvygbC+
         oIfgJ2HUxC28k7uBmSqBj3uyXqcX+SwOTfbJRzuJ4uKGjU67wrX8G+4i3R4QSFL200uz
         WN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211157; x=1793815957;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q0d6qWi5B+qlp69DsFDkPKiAVkLkzeJOiKS+6AQfdW8=;
        b=CHpv0xIQTEGiNZ8pkIoFR+g8K8Sgqj0HVGPeA/rQniNkK5KN11yQ29e09lV6LT83Tg
         fBi+O/hD9hFBboDgzww75vfsWYEW3aKVDeV4uEK5V7hAee94iZLw7mo2/3EJjrBbR6cj
         1tDhOw9XGaPPYfIqdiTOYChyeOMyIkfQIzEy7pOMB9gVsr1UtRjM6XpVB6oha86koGHG
         WcLodHNZg2OCQk7wVxJw2+7AjXAxaoIrsgceXxgyf3+6OoLKEeZafXJpSQOJYEgR3RGJ
         p+4gKLyqBiLHHg61ULF0/UKp5VO2mqffhp4Ekeo0zTwaLOuiMSG9Wn8cKdGaXXp4CfZV
         TlfA==
X-Forwarded-Encrypted: i=1; AKwUvBxsC/9iTPFaY5sFHxNPfVL5Z/81uJO45FqOss+wh1J+1VN6VkonCc96MFf7HN48ORMit5XTAUubvDFvw6bH@vger.kernel.org
X-Gm-Message-State: AFq9FYL5h27vxWSlK/HJA7xldbBqHsIzmzY7QBcNxCbeL9YdvHGwSouH
	Tu8MPv+1XjbPhy6iL5uFQAL1EAAQ/i5a2nM6tc1xO+3TFoezHCw5DqV6nJJX2jnGemOfwA==
X-Gm-Gg: AYBFou0Ti3IBE9YCjagxKQpbpqjRvQMDkBQjdw0VniFL0ZDDVfE1xKVnT1VHg2wQT6a
	KnckiOTPBQVrFr1UCBxDhMkXa8etdp4UISiYOZH2XBdyRdxyZ2O7EIeJY3S7KUYSVUvrQV//atY
	mili1Moj9y433HKwPEEkXZh9Kxc5Azmro4sVTo/9UdX3lYxrZmi+13UE8CSzVbQYz8uFsU0S9b4
	19tpja9gr0UZCdqeBb26pOsRsliMfm67edyln1DS+vc+yhDA/nkwO0iD/y2X45ewHDbMbdpjvV+
	y1SHCjT3lDt1xerxKmFA/NTYR6pC3dti+j8qom93eGITVt/Y58R6miSnZLtkKWoa07j8hEg+1k3
	KByYRUruQWm2O1uy4eG5TX2T5AF9/RCzITgU8su1Ry3lZlUDPL7YJya/vBF1XAiAoG3uwmJbeP3
	Zr2GJTYkKINFVRapApmkGr4Kx/sxcadvmgeKtqmbCzd1mUKB8vdv0KgCsh3i1CW9olKW01be3mF
	R74Hjudqe/qyAHEQoyAPuE847WVep70CGPu2qELp2g95zhxBJM3zQNrBKW1ImupMw/afbKMuBjs
	lxYpYO9KkaNeCSJmDsrFQyH5
X-Received: by 2002:a05:7300:a230:b0:369:a113:7578 with SMTP id 5a478bee46e88-36a1ff4734emr3881706eec.1.1793211156240;
        Wed, 28 Oct 2026 11:12:36 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da675sm8309394eec.5.2026.10.28.11.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:12:33 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v1 0/2] preserve prepare_write errno across write reissue
Date: Wed, 28 Oct 2026 15:12:27 -0300
Message-ID: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cifs (and others) may fail in prepare_write() with
netfs_prepare_write_failed() before write_retry calls
netfs_reissue_write().  Since 82e8885bd763, reissue clears
subreq->error to 0 for a clean I/O retry, so a FAILED subreq is
terminated with 0.  The collector then does mapping_set_error(0),
which is a no-op — writeback errno is lost (not an infinite retry).

Patch 1 skips that clear when FAILED is already set.
Patch 2 adds a KUnit stub test: FAIL unpatched, PASS patched.

  ./tools/testing/kunit/kunit.py run --kunitconfig=fs/netfs/.kunitconfig \
	netfs_reissue_write*

No prior lore report found for this interaction; surfaces on top of
Shyam's NEED_RETRY change.

Cc: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Steve French <stfrench@microsoft.com>
Cc: netfs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-cifs@vger.kernel.org

Iván Ezequiel Rodriguez (2):
  netfs: preserve prepare_write errno on reissue
  netfs: add KUnit coverage for reissue prepare_write errno

 fs/netfs/.kunitconfig          |  3 ++
 fs/netfs/Kconfig               |  9 +++++
 fs/netfs/Makefile              |  2 +
 fs/netfs/write_collect.c       |  4 ++
 fs/netfs/write_issue.c         |  4 +-
 fs/netfs/write_reissue_kunit.c | 73 ++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 fs/netfs/.kunitconfig
 create mode 100644 fs/netfs/write_reissue_kunit.c

-- 
2.43.0

