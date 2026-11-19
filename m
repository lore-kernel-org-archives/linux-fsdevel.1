Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057843;
	b=CRHAQQaAr3GFHqfHKY1ot0JD3RHkOET9aRRDsPqQ8dcxYUARf72n+j+y0zQ0yf8OJ9nS
	 /lAFpLD47lD/bDBxPc+Ykhw8SKJyDpNhDka3tRLMwYaQJrsnm6QzPxHBfnwxC71CFGIox
	 RosBjIY0cw841UmQrGTJsqAVEEghMCpuWn+iUlz4HgbE2j5l5ZXdCWHcCPZ3xZG45BRUF
	 vW+ZtNb+bVbS4Kt2Jj1V6yCDnVS7Ia0IAb+wF6TFESd6K6z3033w2FEeuhy61lm1gVSEn
	 oCwM39pb05KJ688k4rUL74pDfYnxU7lQLmA8jz1cifa/czk7gNp0WsbGbOVbRiQ05JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kxxZFUyefVXfaK48eNDJdsq8mWd4zz3E9krdaJ2VCvM=;
	b=eUYda3C/Qa4xhXSY+PDcAvmWYMNbuwr7KlTm4Gfggjad8CPmt6R93wudA2EDaIGIyDZd
	 zc1/4Y7bzo5h2yuwD9lR8NjhP73GejVGvleTRM07gWlkqFPFfGgdvoekxIxILavua+Mkl
	 027az15s1Vbxba0JNq5ayCdOzVNR4uffEUNvakZEo3i/pemFnJ7CyYYjEtdH95nlelBNV
	 IwWjEgbIHLaI+viYq1BErNTGlX6XsKg3LFMp1sKyTJe3iaH87/Pf4KN04E2SP5z70Swyg
	 qtPnabGNy3MbHbJum28bc3SgVamrXlphdGsOoYqTBMevn3wriIlKYpBvxE8b73v5fpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoRjtDeh;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF653606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 03:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF653606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AoRjtDeh
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-170135e43c7so2730327c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 19:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795057842; x=1795662642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kxxZFUyefVXfaK48eNDJdsq8mWd4zz3E9krdaJ2VCvM=;
        b=AoRjtDehDVC0XDWH/tR9BNWExsVls6W+Weu6wtoQ9SQUraHQsEz8fzv+kRWKnTdLZP
         MdxQJRCk8+x4F4VB41KrqALTCBCYTUF6MswbCP4g3GTFuCZ11g6bUynIPBugaS2v98jx
         1Av+ELt2TXfAVB6LmHANyECDLwP9BxIFjbBqeNhP5IDaI8dPey/12oj3TMITIckx0WQw
         momTyQUTSZg2hAbT0nULo3+ndAs+ywWBYO1A9VyezSfe/J/oKiQP3HUgi3HvSy3xrgbM
         1k8r5liggcf+D73GLaC3FMYPaJt01h+hgFRYRLGFcodlGm6t2xvz9eCz5y5RRyTyxEPL
         36fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795057842; x=1795662642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kxxZFUyefVXfaK48eNDJdsq8mWd4zz3E9krdaJ2VCvM=;
        b=jpFZ9KkcwT8KNdKB08dFqH7MKhEuvIGllRX+HJd+ooyAoTPLTITJi50GleKcAnvD6d
         t7qxq2B0sJ1e1+K3tdcj9F/6FbjXbN8A0dmOFFcsqP/BhV2JfDHHTW6d7TsaJyfpEGVW
         U1ISU6dCDSuoKeVvJI3kT0H2syCbE9o6jsIYE0PkV4bXF4Su3ikvtqJj7vm9tLTlavov
         NRKn3CUPRGJr5l9LvVHcNeQG2vpnmpXkEF63jI5WUHrESvhNcqGOPBN0lT0n6Vuxhsnw
         G5iu2f5wr6pOezFtvGbdYmc+H11xF3J0lO56Ub2MsyQs1tKfOdXsFQmwEckeuAjEQAU5
         ZNdw==
X-Forwarded-Encrypted: i=1; AL+hErEavEmuFgN5BAh7HITbxw1L/w71QNziEvIy9GTgZFB+D12wLCz62AS/q8LNBqs4QWtVXp+hYICkc1SHLUCD@vger.kernel.org
X-Gm-Message-State: APuU4Z80GbuoeI3BS9XWSu8w55JSPkXXIvmcNQYt1gCzzjR2vAD6CCSB
	ePKa4h6dJdNyPdP/MPdS6GAEs+sXfLUqsxyaEKRHdLls/0CNCkL/Hf6x
X-Gm-Gg: AYBFou21r6IbEEN6uy5cUDWZrNGa6MH2Dd+jLh4+Ft0yqBPQne5GOxk+S2axIqhHx3k
	YEQ3n9pBJ92wH3qMqgAvXA3/ESEh7jNNI1bwrYKXIsYYXXgPaRsE6PPrQnFIji6xeP3/JtMbYrJ
	awzdAfO/LELqgnuuWwVuJx3JGOdLilw81D29AHpYdYafgvSwNaCSXTo61xZzs/t93CqtafXVFLa
	DcEw39qx3RmU2eT2b7IFT+sU3djPgvHzsrb3n5LX99U4W4iLZoCm1esmgx8IO7zdkWj+gWFR3Fi
	vw9Cj8M5NfV6usOZfXuxEdSFYDKX5d60r+XGZfyPoAJzMhX5vss8cGstVZ/p5LQa7zLyHxHo61v
	VsFgHOjDNQ4/OWl5chYLuirz9WNuiuyK3GOL7Uo3VWhzIH3eJCy+swpEyzj52LBLNHnwz7FZZIr
	rOWPpxMqXCC9VD9XbYJS9MeGQxvDp5j4W9GngS9gCGES0MfM3s3d8TRFfMWtYGvF/BPs5MkrD1o
	y/MO1uuRx1GditTB5UkZQsuRAB+EE/2mQJFsQgLQe/oVtIbmfR6DVEwd+QzLu2aDLO0kMKFU83O
	SAiPefA+iTEIAK4FavD4+78qVb8D153ETjO4bNFynNgAnajmhA==
X-Received: by 2002:a05:7022:e2a:b0:163:a197:722d with SMTP id a92af1059eb24-1b543b193camr5961447c88.4.1795057841422;
        Wed, 18 Nov 2026 19:10:41 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5447f4e19sm15028118c88.13.2026.11.18.19.10.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 19:10:41 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: Ding Feng <dingf3ng@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] fs, zonefs: ignore RLIMIT_FSIZE values above LLONG_MAX
Date: Thu, 19 Nov 2026 11:10:24 +0800
Message-ID: <20261119031026.7985-1-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
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

generic_write_check_limits() and its zonefs copy store
rlimit(RLIMIT_FSIZE), an unsigned long, in a loff_t. A soft limit
between 2^63 and RLIM_INFINITY turns negative, and every write then
fails with -EFBIG and SIGXFSZ:

  $ bash -c 'ulimit -f 9007199254740992; echo hi > /tmp/f'
  File size limit exceeded

Patch 1 fixes the VFS helper (write, pwrite, writev and copy_file_range
paths). Patch 2 applies the same fix to zonefs.

Changes in v2:
- Hold the limit in a u64 instead of an unsigned long. On 32-bit,
  "limit <= LLONG_MAX" was always true and clang W=1 warned, as the
  kernel test robot reported and Damien pointed out.
- v1 patch 1 was applied to vfs-7.5.misc as bc0dc4379463; v2 patch 1
  replaces it.

v1: https://lore.kernel.org/linux-fsdevel/20261117173129.61028-1-dingf3ng@gmail.com/

Tested on v7.4-rc3 (20eef29b7c84), arm64 tinyconfig in QEMU, with a
static test program that sets the soft RLIMIT_FSIZE, writes 2 bytes
and copies 10 bytes with copy_file_range():

  soft limit            unpatched           patched
  1024, 2^63-1          ok                  ok
  2^63, 2^63+4096,
  2^64-2                EFBIG (both)        ok (both)
  1                     short write, then EFBIG (both kernels)

Built fs/read_write.o and fs/zonefs/file.o with clang 19 and W=1 for
arm (multi_v7_defconfig) and arm64 (defconfig): v1 gives the robot's
warning on arm, v2 gives none. The zonefs change is compile-tested only.

Jun-ichi Takimoto reported this in 2020 [1]; no fix followed. It came up
again while proving pwrite(2) against POSIX with Frama-C/WP.

[1] https://lore.kernel.org/linux-fsdevel/8F9EB913-3AC3-4D89-9DA3-427029F6D211@kba.biglobe.ne.jp/

Ding Feng (2):
  fs: ignore RLIMIT_FSIZE above LLONG_MAX in
    generic_write_check_limits()
  zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in
    zonefs_write_check_limits()

 fs/read_write.c  | 9 +++++----
 fs/zonefs/file.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.55.0

