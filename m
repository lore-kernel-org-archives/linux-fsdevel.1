Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936739;
	b=s4FystEjWCXaBrxjd4XZ+g/S+qJCeRel838MtbnL4V1LOL0wW+trD94U45Ue2tNS7Hs7
	 p+4x/Cmg4iUVdNT2V2lnKpHJjeE3kWThjyGO4rCnrhDQSB+qN9HICf6UXHFghhIvQp1ga
	 shd7fNymZQA/jLzOdLCYH9zh6CmstW4xHOwFEPX2VzjCud/8HpIUr1ogQ3l8K/TNTo80K
	 b1SumTlz3z5WxNn/SRNmSX2ZsxwEswiEFr9rJAmXSfG5ROhvHMO6Js4gCZMNFzwy78/bP
	 8gW7sDxjYzDCCCEnaJ0voqOgZ6Yq8xDXcdYEkXWIHvtyYJvDFE82bJxy3rjoCgAb8HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+7MG30dg71q8VjUv3Kl6iLWy30FheOHfbrKiXTkP1qY=;
	b=bleNokaRXBj3IMOJGV2h71k+6oBeFBUPwclXut/aOU8u7fSEDTocmW13yAjxtnbpWEui
	 Viws+s6hSBA2ACU+O5SYY501eGHLxVITKcyCR/n4tDza3JNyZhG6JfTtdXrgYplkuonOK
	 x5lxd1kIQ+hI+jZm5yrN/IQ5uiBMSP2defnHReWE4RnTvOcdgxBYyKBtDNxTFn4DxuuIV
	 a+bLofG3RSAlO3lXBxhYwZvxuHyyuCZSCgEIKHOHMooOfwe5YbeShE22QjWULg+q3pON/
	 TFjDEKDg7jlhNHOzVygLXqzhW/iJX6xsHQpooEV2iD6nPr19xJvDLqVTkoh8jNfCIIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=th69VWUE;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83354606A333
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83354606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=th69VWUE
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-14394530ec6so108875c88.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936739; x=1795541539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+7MG30dg71q8VjUv3Kl6iLWy30FheOHfbrKiXTkP1qY=;
        b=th69VWUEdtkU9MSclq7EzXZGVeGvm34inXYmxGDENCi3GVGOZUDcq4LjxOLJA9j5ZW
         qKPONBw25aaiT3mOnxcpDS6XHEsDL3OnePqocWe2ijlAiNTOBOgmdX/Vc8z3E2V+7eEs
         2cGd/D4lFMJ8nQefspn5Avh3xNcHrkqUQLzmLWm01CL2MYPFViYh9wZRhXPSmzjBxpCa
         NE158GhK5MvDc8rWwDtWvci9CsImRwzKy/Wy97Y5Bo9e5je+QCa3mfEkzMtJqftcKCvJ
         XFvy6+nnbTJcZw5prTUxGbJm0+TsdBqbkdGwqrhBi0G5LrMc/dhXBGzj5QNj0+7AAXBF
         RdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936739; x=1795541539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+7MG30dg71q8VjUv3Kl6iLWy30FheOHfbrKiXTkP1qY=;
        b=waNpGPoj1qGb9/6vkqNRinm3VxU5CFNciM91bmyLjqYkMETNnodmW9lpdUttMKEcqj
         57ZE09JHmcKn/MkSr9j+ej9QRtu7ItlwuPDr0V2ijvFS1j/DUBns2rm7Bu17wx8c0hjj
         K0LEe61pvmduCDUJF1u30PCpRJ7+YLZ/QQioZ+eJNqCqv8Zl7eFp/qk6sj/MHS4QKic/
         gjnZlFdMhSLBUznrpwUYsYGIeFW8wNnTY5DR+fOBQ07364fcDFxtLJ+NHvx/o/sJyzz8
         V7Z25v2runX+gGfqMZIwLgSp+N6d0TMUPPX7VdZg/+ZzetjKGG/wM4YjozXy+Lne+igi
         te+A==
X-Forwarded-Encrypted: i=1; AL+hErFOQRT7l/YI0WrL2Q2lbD+N/vrRja1RZ9rIQ9wk3r7IfkdZPwdg32fhRkMDff+f7deIkWf2hVDx99JOLcQU@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZWXH4Bs6bw8F01MDghkR4HFO+umk6UCqWCUeUcMmBmHWBUSLu
	PtGcE6gjH+j8ZvHqINje8GUNi3WKt8LDeSoV7VB9LObI+vSWDKyWVZ7l
X-Gm-Gg: AYBFou1rNjf07Gc3NGUaii4Hnsw6T29W/CuVixAwTe3ephCnFOqKI/EejYhw54mmkGZ
	npX3eCjQS8o1MkBfvMo7jZWBhMgVUEDdqCkKmZxUvoMYmBDofw1Glok1m/mtVTR6vOSSPWGA76r
	MT/iDomGa0bW/JDbhP6yJ+9x7UfKSTUfhcpRMhs1xpDbmvnE5DcHQdPd/XnKc67rIV6T8Gy42lc
	zhw5+qa4pkcrLjblNezO/sTcHzuzd+t04iQ6WQOJrMVnB8aYFDr5wwboYiENctfkjAa8d4VYLho
	mpUqYZ3UBBZkoLTblbivfIrNfJzXrxO0P233w7KXR18kc81qAV5hXEwecPGFhlE5xrx6iODi1Wd
	Moz/dhDFqJmUL+cLb6Lz9OPwGbAE5thPA0Oodmi8N6lMjF9TJ/o+CDQ6cJhAk/CeZoeMo7y44V1
	RGabvRE30WWjZ9KyumRxQaPFy40Q2RJoF9wls1z45YL6ViLGu6f3fSpb4nd8mqY+XYd3fzQYwlo
	z2o0EH4iadLdGqBryiv2kPAR5peEqsdTKWfWCnHe4GH3B1PDeuVqEZ+Kf4qSFu/SLyBo6Y7pFtM
	9bwMvjMhERrxaSXpCATGaedcxpSrgNATpiH1omNfNfmv
X-Received: by 2002:a05:7022:ea8a:b0:168:3243:c937 with SMTP id a92af1059eb24-1b543bb56f2mr276351c88.16.1794936719280;
        Tue, 17 Nov 2026 09:31:59 -0800 (PST)
Received: from MacBook-Pro-8.lan ([27.125.146.195])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50319d40asm43450247c88.11.2026.11.17.09.31.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 09:31:58 -0800 (PST)
From: Ding Feng <dingf3ng@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlemoal@kernel.org,
	naohiro.aota@wdc.com,
	jth@kernel.org,
	Ding Feng <dingf3ng@gmail.com>,
	Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in generic_write_check_limits()
Date: Wed, 18 Nov 2026 01:31:28 +0800
Message-ID: <20261117173129.61028-2-dingf3ng@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261117173129.61028-1-dingf3ng@gmail.com>
References: <20261117173129.61028-1-dingf3ng@gmail.com>
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

generic_write_check_limits() stores rlimit(RLIMIT_FSIZE), an unsigned
long, in a loff_t. A soft limit between 2^63 and RLIM_INFINITY becomes
negative there, so "pos >= limit" holds for every position: each write
through generic_write_checks() or copy_file_range() fails with -EFBIG
and raises SIGXFSZ, although no file position can reach such a limit.

Reproducer (bash counts ulimit -f in 1024-byte blocks, so 2^53 blocks
is 2^63 bytes):

  $ bash -c 'ulimit -f 9007199254740991; echo hi > /tmp/f'; echo $?
  0
  $ bash -c 'ulimit -f 9007199254740992; echo hi > /tmp/f'; echo $?
  File size limit exceeded
  153

Before commit 9fd91a90cb98 ("vfs: strengthen checking of file range
inputs to generic_remap_checks") the limit was an unsigned long in
generic_write_checks(), and such limits had no effect.

Keep the limit unsigned and apply it only when it is at most LLONG_MAX.
Smaller limits keep the existing loff_t arithmetic, so their behaviour,
including for negative positions, is unchanged.

Fixes: 9fd91a90cb98 ("vfs: strengthen checking of file range inputs to generic_remap_checks")
Reported-by: Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>
Closes: https://lore.kernel.org/linux-fsdevel/8F9EB913-3AC3-4D89-9DA3-427029F6D211@kba.biglobe.ne.jp/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5 Frama-C
Signed-off-by: Ding Feng <dingf3ng@gmail.com>
---

Notes:
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

 fs/read_write.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b15522c..18a217d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1693,14 +1693,15 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
 {
 	struct inode *inode = file->f_mapping->host;
 	loff_t max_size = inode->i_sb->s_maxbytes;
-	loff_t limit = rlimit(RLIMIT_FSIZE);
+	unsigned long limit = rlimit(RLIMIT_FSIZE);
 
-	if (limit != RLIM_INFINITY) {
-		if (pos >= limit) {
+	/* No file position reaches a limit above LLONG_MAX. */
+	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {
+		if (pos >= (loff_t)limit) {
 			send_sig(SIGXFSZ, current, 0);
 			return -EFBIG;
 		}
-		*count = min(*count, limit - pos);
+		*count = min(*count, (loff_t)limit - pos);
 	}
 
 	if (!(file->f_flags & O_LARGEFILE))
-- 
2.55.0

