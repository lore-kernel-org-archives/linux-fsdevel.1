Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632026;
	b=OxYmNt2ngxWxOL9u7tynZwg2nLhMeqx4GdKoK90nLxYNikPiPVv1u+c8xAIfqnHYJ66n
	 0E1gH6KHdgD1Ejs74FgMIwWdJgyafgaTVwA6mD39BJ5fZnvviZTkihV018/VvWATfqL2W
	 E6Y5BCfHeI1mFHeMbbHVKa/KqHZXZYNUXEzItFORYkRjTroHA3EygE4lNOsCbBU5wNl6v
	 wdsZxAu2143VUi3CLKgFXu0fMJEncd9wdhhADrYNoSnw7z2jvwB7B0ZBrgD8xFJcHEYkP
	 x3x9PqCWhU1yLKtS6eszudMJmGjminlPdIxPkfmjrzmv7HeQJtXQRx1vqoLUnkgWoPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dylFydTJD2AJSyC001lOFTgMCOP2ZnGzBFoGx74ahLY=;
	b=0Y9Lkg2fZlpQm8SpVbqrLxnR0bX9ekTaLaJ1K4oRss5R9Yl3TK2J/ITaUodn05ZdNZpT
	 I8Ib3BqIKQnaRshRf487kMHa4A+6FcxVw5G3cd6fnpK1BH0efPXZ92yYSJ88aOhGalJGt
	 GRYBgtZa0BS2HbPO4PrXW7Npz3wcfVdfeMh6cq1ri3Wqaw1dELcHgWQ1S1Eitkru1E0np
	 CnAnSC9qlgv+VGHCHZxkCV5toF15Z6aNIekMWDwmWfjmQPaQ7eKkQrAb7kT/ng6DsnFCp
	 Kv2v4MN8m5OriyyO8KwUHXRMfHV7EsjmPmczl31RBNLzdEf/20BU05yS4s3ABFyRN9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIFPv+69;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0411B607228A
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 15:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0411B607228A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIFPv+69
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a20bde60a0so24097305e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 07:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632024; x=1794236824; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dylFydTJD2AJSyC001lOFTgMCOP2ZnGzBFoGx74ahLY=;
        b=wIFPv+694wyrg9+1XM8aOK8Wx39dCR+nB6fK+nMApN+7HUpoJctTfpVbDN4G/0e6Gf
         Ah5qfgFWxlmfXMnQSLEI/YRxyDPVKlJm2VSdx0MUI2IzTjd6MYmWs4odw6r+1RqvJ111
         oyjvS/JGjcAYvxtCDBjClRA54yveUkLx9JixEtSNtDW+n4MlrlTKOTULAgm7yUGXv8bO
         XjBFEs/aMJzunIzvTdeb8KX2sTiZseANC1TpH2dObLB+5tib4H3Jdz64+38hMxYSDkSX
         hVCkE2V0tU8fxfUcNr4jlbsmSuX0dMWkdJhcqFM5DX/xalEWo0VTvPyie618MiG85XnR
         wWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632024; x=1794236824;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dylFydTJD2AJSyC001lOFTgMCOP2ZnGzBFoGx74ahLY=;
        b=hgm1yv3X9F5hqJDjoRe9IlYHO9FFj/1V77iMSR3eQ1+PHCE942gACDK0w/n6hARqfm
         +otwDhTQ4UmsDj1sJw7roHhB9bhkYgRWLzAaERPxKVI2ORuB0ed6pS7Rui9w7w1JPR9K
         A6WB8vMWeuJyY6VZ79MGZ1wEokkkRJzDTjChSy0Z4M0fSjrFgfwdkbImBvYPIBennm2H
         Bw0bFpIRemOvQdVvVbelgLUrBoEB9j8eYgjKfVu4ATFMg0+95Ed0zg5GWWcjW2UkWntd
         e/lIx9dnRz6booCQlWEjGF2TmIbMMQy9xcFhl0JhEV0hBoPLsqXtkv4/eGoQUv+3bWgm
         ugnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWC/0k1tVUHnOZ3kXreyGS+tSsqk7/ZZF0QNJalMx+cHYap04gaw52a4GPCycqkg0BoNahLJjin1w4+hUN@vger.kernel.org
X-Gm-Message-State: AFq9FYJVmtjcLCs4XJjzgjdiw0NAKfBHODNrBH0ipxjMc/WpT3zv49ym
	Yl5GoDRKJFSoTdesQvnVrEg+8/zOZl9osjI3sXA87+XT7kH5KCW9PJ67
X-Gm-Gg: AYBFou16+yhMNvE3Nzfmo1O39snjAQE8kDLZ938nj8X5ia1kXZke4c4mW6Y5DCUPQPS
	+haV6Du/0cx39nQRzHNhXXaRieq8foKaeKmq0ZV48al2SKxp6d0Hz/Anpuj7tr4yqATYmV9jr6a
	whz274qhq0iejLA6AU8v5iSH2990uH3/dRJTxdeIKrQwx67anyBbafUu4CZhceybpgkX279dzGL
	f2SRbGVxTmsjIAGdBe/feUTQOua/YAwCr9ikZaZu9bX2QsFY9bYwwAN6Twh2oos8JLs55kk3Q1h
	pY50BgtlGgG4Vb4YgDKaAupPNtGZ1eYyolJRw+zMpFEY50wJ0A/6lEXqnHwXFmx4AuiNZ3Y0Lbk
	q/exY5aOGkwffUwYliQABrQny7GkC2K0fpOG+txSrvSevtXm6Tv485UwEE3KRnhCTavALuR617y
	cdGb5cJJN+y/I987kHMZe2x3vQyCa0SgItRaIoZP4j7sDFjEkV2PB3KASsjVAU8PI0LmlBbZ1WQ
	pP8Wl0HiR1m7m+6MOghDRWI2SKeDDhVUjhjqzJVUZ4skNv1VCq9B8+kG4L73gJ6eqvBjEzMaZP8
	JLUYHIGjY7jN0bo81W+G5XetcTkMollKHgR623VhaXstyA==
X-Received: by 2002:a05:600c:1f8d:b0:4a2:c9b:9b98 with SMTP id 5b1f17b1804b1-4ac177539f6mr227554115e9.17.1793632024294;
        Mon, 02 Nov 2026 07:07:04 -0800 (PST)
Received: from localhost.localdomain ([2800:810:84a:dc6d:d32b:1515:b2a9:c74e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm395629535e9.11.2026.11.02.07.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:07:03 -0800 (PST)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v2 0/2] preserve prepare_write errno across write reissue
Date: Mon,  2 Nov 2026 12:06:53 -0300
Message-ID: <20261102150656.207612-1-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
References: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
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

Changes in v2:
- KUnit: allocate netfs_io_request / netfs_io_subrequest with
  kunit_kzalloc() to fix ARM allyesconfig -Wframe-larger-than=
  (kernel test robot).

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
 fs/netfs/Kconfig               |  9 ++++
 fs/netfs/Makefile              |  2 +
 fs/netfs/write_collect.c       |  4 ++
 fs/netfs/write_issue.c         |  4 +-
 fs/netfs/write_reissue_kunit.c | 80 ++++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 fs/netfs/.kunitconfig
 create mode 100644 fs/netfs/write_reissue_kunit.c

-- 
2.43.0

