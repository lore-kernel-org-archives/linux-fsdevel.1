Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936706;
	b=rRvIeKfHPQONtey9oZV0NpGx+97qL8iSjhOikwZC0e75vAk97gSn6+owK5xyaMpqicDp
	 FgfUND2qqWDvPx3gCtJwOy+kjRxJVTEJZ+gM8M87Hey0jPLTdVotGdCS5FWH9LqiQyUxE
	 bytxGchwYQHH74JOzc4ZpTB4vBbUPqUu9+nociIbmuNFF8HRNO1U8q/NOFROJU/jYJS5W
	 pyX2CVY7Ot1RsZ9NdKWoIpBAF4B7MhHUeZ8OEoYaZWwCoyXenj8tJYOXEnL2ZYDnbpEZ/
	 6XLB0rAQF0JCdiFW8aA1lsle74DRpXctTb4YH5clDRWCvUSSpNLbXdmesthrpG2Lg2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gWwNhbtcLalE2PqcCUTg1GPM/R8CUWdz4KeRs9qScNU=;
	b=PKFMEpKUwR48RFbNy5vQc5ARXVCPXaFck0+YeWb6jKcTN6DEBoQkGDNO2B9AS/s37VTF
	 sTaScIl9IMFi1z68qNij8Hfr5zANaMmIJq5RsbhYPSfOj4TdqYvwe8xqizxPaAoewLGcO
	 zw/7RCqI/BSXuhkliDLTf5SxIegT3CKpl6eUCAzzwS/sDevl4HeoK7hq9r2TBV3VbHy4l
	 zKdw4dGuRAgvfbzjNwEvAqoJjNrxpKLDfD+Ngmp3oy1AGZPL0t7y4VWmG4WC4BQiIcAB4
	 QSfHinGImkQnFXBT5lyeLcbRxB3YQ0XBr8L1wVI8Ze5UKstbFo9dtczGsVvkHj6aDDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzvOX1Zj;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67879606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67879606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pzvOX1Zj
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a3c08d6928so106495c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936705; x=1795541505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gWwNhbtcLalE2PqcCUTg1GPM/R8CUWdz4KeRs9qScNU=;
        b=pzvOX1ZjRuGztXjiyCxRHW/9od/kBClMxI2oWyJNSDuL34tQ2PGsDHPNQabR5Z/SSy
         gTuXfvhyqsnBSsNrKDf+JJqN819CfkKZEcvJpfuu2+YMKN/OYg4eb6UyxQip5JPn9vtZ
         BOwSBm0q2ZSSoukT2PVp2y/gwq/WLcoP8Xey1QuA7E+lLt+kJlsl2HiB8Rv16d1AbPNi
         d4YmQnhVHOajoex6vFj4DJgJo2zleVdLWtG3wrD/CdxgHHj1H8Ys/sVyD8+U1xNS8iLg
         COe2G5ZVcsEiA7zY5BeGeRE9nJwHmjAKkQMnMkvFVRlR43pQ+ckHKWU90mCUHyoaWBoN
         Fxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936705; x=1795541505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gWwNhbtcLalE2PqcCUTg1GPM/R8CUWdz4KeRs9qScNU=;
        b=liWWIE+YwJFDSFmwAtfU0aVO0TH/MxI+R8dZNI+xjUn2ZCQcuv5Zdh4dvHdd3kcW44
         X47cbxwcsJNwV+h3x6J5/q83sovVtSY5ngNEAGoFF4z6wNS6XwrAb4lFyCTDni6CCwDi
         bFpXqidUu+qvvlGDSGP7B1986DzQ2gcCQpRnGcmKMXv8j7RkRxwLe+ZgMVzu7kC4YOGK
         3Q5mpC7XTJXHt3ekK6XthAVYDnxAZAw2JI/4J5WO7DNGaQGlAaIIksdX33FYU3E+elwP
         tr020jhezG03DPtAsNbN67LjFwrwX6KFGnPQ9+b8ibkzKRvCoRxiT7AOZcJ0AWjK9BNF
         0cLQ==
X-Forwarded-Encrypted: i=1; AL+hErH//loxaDVZGI8F8SgpEqTG1uSdtNNn0RIFCHw8WuEr5AxpsWoRpezq70zl08vwanTo18rhCA3opLv0AKJm@vger.kernel.org
X-Gm-Message-State: APuU4Z/VoRN7vvu895M3usg0RHj3GyzlUjKMUkVX0LWuA9CvxTuF0dAj
	3PLASidBbMSfIHWNF4KItkL5PvZ/pH4gJrMjIa3fThaAzKSBOjKTBPBL
X-Gm-Gg: AYBFou0QY1myY+FXzfgBfLK0T+e3lhJ1MSBxzbaH6j2kAZo9/cwekhotbf55syx4p+F
	RNE3FX19deuNtZykoUa4p3wYK0IkBlJjHlfhXYfnk+zVt1sIUqWZr5T8l+R+CkLem5elsRs+iWl
	i0grhIQAlcDtuRuBL4LMsCBz7onPBiS92uXTgAQpYHsQ6bEGMrXCEIcoDfUmEl6C0zb7Ee6gR9q
	Qv3vXOXPjWdTIiBPjJkTsviO0CW3Vb3bmO6dAw18p6bC0OEXZtbt8GbCMaFU4x2GYMH9JLBebi2
	QmgdAafa726aLDCocfxiFkkhFPQSCAqtraucf1OW6MFskj8ZksKOMmP1O4VIZgsbkNTMrsBqvFX
	ZbDHXChJGmA1IWCgtmhwabBnX7WjLSw0SkJssoeict4sgpVogbnqvRGJJr9CXpOjhX4Aw45UQV6
	UYMbpFgja9RaGbkvv+A/VHToEbJwH178Kh3OyklWYIVwo8jhNJyQhBDJPaHLtNPXa74LjhEJQvJ
	8VDs3zSHrcrA1xaY7772h8Xcj/ZkHFaYu1XtQCcFPg6vS5orkkvDk/5Y8PK8hugXwKO4ZoTjsJP
	e1U4N/BK897OKTepNDIO7Ne4GfCU43MzgCO7nkDmyhzmIgEz2cahfWaDk1wORdvuZA==
X-Received: by 2002:a05:701b:4509:20b0:1b2:4e29:92f4 with SMTP id a92af1059eb24-1b543d0e211mr209408c88.39.1794936705172;
        Tue, 17 Nov 2026 09:31:45 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm43450247c88.11.2026.11.17.09.31.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 09:31:44 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlemoal@kernel.org,
	naohiro.aota@wdc.com,
	jth@kernel.org,
	Ding Feng <dingf3ng@gmail.com>
Subject: [PATCH 0/2] fs, zonefs: ignore RLIMIT_FSIZE values above LLONG_MAX
Date: Wed, 18 Nov 2026 01:31:27 +0800
Message-ID: <20261117173129.61028-1-dingf3ng@gmail.com>
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

Jun-ichi Takimoto reported this in 2020 [1]; no fix followed. It came up
again while proving pwrite(2) against POSIX with Frama-C/WP.

Tested on v6.12 (arm64 tinyconfig, QEMU virt, initramfs on ramfs) with
a static test program that sets the soft RLIMIT_FSIZE, writes 2 bytes
and copies 10 bytes with copy_file_range():

  soft limit            unpatched           patched
  1024, 2^63-1          ok                  ok
  2^63, 2^63+4096,
  2^64-2                EFBIG (both)        ok (both)
  1                     short write, then EFBIG (both kernels)

Also reproduced on 6.10.14 (arm64) with write(), pwrite() and
copy_file_range() on tmpfs and overlayfs. Compile-tested for x86_64
defconfig with clang; not run on x86_64.

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

