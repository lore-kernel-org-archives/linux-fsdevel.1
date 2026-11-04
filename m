Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791419;
	b=FJxzokL2ueRmpj1MVO+ejqaMZHOcFGrTf+OQc+ebmW2vfUoyG2jB9XISz7sFdQBt+31A
	 yx0rzq0Xb/mZswbRF+QXxUWkCOqHSZS/hSLDIvyLkvdS5eaRysKsAXoYeUo4d0xDNTJ2k
	 pFI4jgJKzeENHuGCQ94ouabDnMRHAZbXnpoS5XcVq3lzuR2Ic1cUwwzyGQaFCqnwermKH
	 HdeX1NFT0tbECWhDk7VK++cayA1Mi4GD/Ykut5SgbqOvhHQ2T3e5wWpaCaLIxplnT8Cm2
	 vw1fwlo8RQ9fYvCcusBsVVoCSNgpqmQw/hkyEFHBQznPF1ZLBI9a8l8INHbWWWu/SlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791419;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lk9/6hT+VNSIJmASQM87OvbXZ/RteGN+GK78gZKzHZE=;
	b=t6DqloMG6BP8IHg3/lXOnfUP+V4akiFi0JI7YeaSHKFvgryqoawkPeIhgM8aa5avoXyw
	 mXRSWJJfJtXvXRadjFUiYO9s5Cn4mJkejdd1iu+WwoIrLuXlE98ntzPQeHHHeS76Zc9Yu
	 +0V1IWX2ekML0hyd/cUXKeAa6O8NnkCFynK/VtYNzbk0MTGmyFcBPoMwVBOumRNpYe4xl
	 +OU1k195Z9arn3xKXNANHBxpPqHjXBTjYjlLKzhN6DUpA055sFJNBy21OjJ/G5YIrOyHO
	 kPzC9kxrqmKMh0k5OGUFOi2IGHfvjM+uFYbVcE2x7x1aZUl4mJ/Yxy6lXscmpMyeBow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UfGwjTFd;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C8606A32E
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 11:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A5C8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UfGwjTFd
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-36d94af5b9eso939eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 03:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793791418; x=1794396218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lk9/6hT+VNSIJmASQM87OvbXZ/RteGN+GK78gZKzHZE=;
        b=UfGwjTFdJc2f/tcsb4Xgjtx0MV4UR/nA4OIZHI2G3C7kk7WlTFFZhYr0DCwmCwQQOc
         706kQH149rwZCeRGAVCHn55ORHE1Q6CtmH8Ub7X8OPGaHouQWSo7lmgLLrVg/kta3E69
         CLf4YQSjmZXrXWCRKQuISr2JAit5Vuc6QH8RZejYUtcvPUuyNKOYjEYu6lk6IlORlnzx
         6uRjCa8OOV8yJWpXX7Lcl5Y2Rs44pl34byuPTJCZhw2wyuRoquqjud3iFYc0vbXu41ZZ
         eTSNMGDiwthZ/0TRpH8uZeBS18LekhySohteGd9guS4hlj7o5bBfgDLjsYWmg/PpW12o
         Exxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793791418; x=1794396218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lk9/6hT+VNSIJmASQM87OvbXZ/RteGN+GK78gZKzHZE=;
        b=bCVdFUT6SJBS9PAaV2ngN6yI+wNN7oHQ3EGMMlODEbJZByTnHdw0/67UtFlBnHUwYb
         SgdHMUKQlz8O+lf3Nu0PxWqMseBl+NEI6VofygXKJwMgh0Ysn33/N3AOVVYsxp+Bcfwv
         x0VBQpiCzV4PFe2KKNBVnFbv509TAu8fc9XjUnBqxsEx/Fz6dMKCVeelfvku730Pl4Jk
         dbasy/tCVaPoelgBCZG67zzxKg4P61ZssHIgPnBgjoOJlqUJUQo0PQEoNnqTAKRPdsMt
         3B9j6mMbhmZPN+PjnVHraPmpnNyeTH52pWFty2/6Yv5o6vDBvCgQ6aOZ+aDpSI9+Wuy2
         5avA==
X-Forwarded-Encrypted: i=1; AKwUvBwB4p5PdFAsleaJL2l+82i3K1qR1A9gF1BxZznhNUw9RR49xWx1iDUPtjk5+Fb2gC70WRzA5VeprCbv9uDH@vger.kernel.org
X-Gm-Message-State: APuU4Z/iH8jnvVD+F0siwZl8VFYu7z3CfAABl5Ap7umuFXqk6iToOUIh
	o6miOfF/A9bmWMd7FQTT89d5ID05XweR0xLf6b7KloZub+MA86x0wM+z
X-Gm-Gg: AYBFou3ldKP0HAcZL4TalZgYoqtP9GtLa+cZ2GsHmIoyvlKhjAT62Gs7krRdysVk6SV
	/f7N/crQNZNpw/9iZfD8RjDOSwEE/0fLrNqIcLdvyzYPJAq8p775TKbuVXWmv9VirVQ5CX3gl7d
	6BrMbv8cISdKoTpOPovi8zxcn6w2bYz2TwbLGTffdsdbgIPcBREa8Y4BovXE/+RD0Y71O9ownyn
	rpGqApXRnjjHK7xIhFhgUxvnr7riyIxwEHYA2MQOZPjVpuA69jRPV0drL/TPwFkzcafYBwUK3ZK
	vJykOHB0xivOnPzWUIp90sOsfbqUXB8+9IRpbRgkkJHGTraaimTDfJtVgwvfzCMrgYQiIpNu3G7
	KgekIq3JKs1HS+1zP29wnFA+wuEMlQfvoLCbOIQTuhKwv8yaeVdIX4HpaUw7iV+KrGnp4UXXM9v
	/S+C9t6vVF9ka9XEI2aqVYIFrK75AfzfH/zXtYK3ZGnGwDE73mWgZ6X6Rd6UtbHJ7BfFA/j0Lmc
	KhQryDsBRCLNO1r6VvU7HhFzWNVyNQ3SWE2on1KrEgKzU8rk+l0FlNbScXaioqIbc1KhO+RxPL/
	vcD/6aqyHcQkTREyhoGXOJxsdVgsccizRdi/aDiZ4IvbsLloGxnggaX8pmOcMR3GgcZ7uSoK0zx
	TWcd8jfldZR+j6VdBxQu37k0Cv0PzfoHD0Iqedw==
X-Received: by 2002:a05:693c:88c9:20b0:35c:8b96:94d9 with SMTP id 5a478bee46e88-36a42444bf2mr25229379eec.19.1793791418192;
        Wed, 04 Nov 2026 03:23:38 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39c5f0csm6285277eec.29.2026.11.04.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 03:23:37 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: me@bobcopeland.com
Cc: akpm@linux-foundation.org,
	linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] omfs: reject writes starting beyond EOF
Date: Wed,  4 Nov 2026 11:20:52 +0000
Message-ID: <20261104112052.5604-1-dennylin0707@gmail.com>
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
Content-Transfer-Encoding: 8bit

OMFS does not initialize gaps between EOF and a buffered write. When the
requested block lies beyond the allocated extents, omfs_get_block() grows
the last extent and maps the write to the newly allocated block without
accounting for the skipped logical blocks.

A one-byte pwrite() at offset 8192 into an empty file returns success, as
does fsync(), but after remounting the byte is at offset 0 and offset 8192
reads as zero.

Reject writes starting beyond i_size before block_write_begin() can
allocate or map buffers. Overwrites, appends and writes crossing EOF
remain allowed. Gap initialization can be implemented separately.

Fixes: 8f09e98768c1 ("omfs: add file routines")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/omfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 79a413f1dc0..82c15756671 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -317,6 +317,10 @@ static int omfs_write_begin(const struct kiocb *iocb,
 {
 	int ret;
 
+	/* Initializing a gap between EOF and the write is not supported. */
+	if (pos > i_size_read(mapping->host))
+		return -EOPNOTSUPP;
+
 	ret = block_write_begin(mapping, pos, len, foliop, omfs_get_block);
 	if (unlikely(ret))
 		omfs_write_failed(mapping, pos + len);

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.50.1 (Apple Git-155)

