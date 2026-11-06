Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956488;
	b=MZz0O9O240gd6YdSGPqBYI1r8XuqlPUcJgZmxUIKbhuETbpjd7V09zJmPq71XnP4eHpp
	 4pIP7ghTYKUZFhCT9z3aPjukga1CnY5s7X9BVvxeW8Dbvk33TWTutynQUUZNslbWXcZwj
	 4Gqbh+20raJFb+pBK0RZ+M3kegaA2sfbVbwuf4//k22T23NoYvhAS+1QinSDMbEzA4Mn0
	 AadR5c/kbR60wjxRUsrs8E3DeGRAw1ZKiABkAVdF6qCo386M0YLy7Fl1HRjjJTpkhciTK
	 J8H81aSdXCbfpzdGpwvzxhCgMl8bpFjL640zuIJsGpHzlKtIOdKYXOA3cOqmFrYaXBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956488;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i4Sxkl+QpMR/bLZklf38xS+ljN5KiJdnyEPnXqWkDcc=;
	b=iA7XvAnwiB31uW4B1d1a+XiYcx7DsBxvTlhc87W6FmSxHuBK/472Ph7i7FIzgBrYYmjA
	 o/46NuVeH84lNUObvg2TvxljNtI8rPIWEnJSYyPMFGgGZsm+SD6etAyf2bkxkVgbfON+8
	 Wm3EDgM99O2ynXqGrvN0QA0zfmZjVunodGr46Uf5QSOx+OZTj5ddPqi6ouRU/aEikHL3v
	 nYU278Uo+RmhNXgmoMyJY6dx95AHyW5ZfWQ9aeLpTUxMa0D+r7GqZOcsyN+5D/Zs+CyLG
	 PbF+hEw2w3z86I+uPXgojvmqcYp/4RHLm75NUai9+IkFaO7wHIkBYOhbKCjO7ayVRFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iv86L8++;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A5606A338
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 09:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F21A5606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iv86L8++
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1a2761c69fbso1064346c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 01:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956487; x=1794561287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4Sxkl+QpMR/bLZklf38xS+ljN5KiJdnyEPnXqWkDcc=;
        b=iv86L8++oZrpIW6FdJs/swcZ70DF5PGly8kLTecekhr/aoA1fL8CUSEr40ZPCHM5rI
         YHhaZVAviEcNwnp4Kv2VBs3iTbyDhu+/6SDCyAOcSzBjOSUnfC3jnLTv6HqvXsENED/m
         LzV8Pl8RZ7ltt3VDNLwrjBvHzmS63nY4aib74S98C/KcRakLPZSNzG1RL5gjX47KMuD1
         upNLv8S2wO4F89gIikuyL/szT2kUsxAF5/MNOpxOtWXF3Wr0tXirIOoxhmk76W3a7WYN
         /6iT77IUwoBYtPijj++XEi977rF9nHxX5T6Ewt/xRZSLagMQT9R+WR8Q0H/O8CO+V6mF
         Lbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956487; x=1794561287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i4Sxkl+QpMR/bLZklf38xS+ljN5KiJdnyEPnXqWkDcc=;
        b=Dar7bCSlj4ZFbDhkJqwBt047OTPhr6VecMSH9vy9zPW6EOBpld+SLwepV3zCjCcos3
         vovNlIudOYUlyKYbjk0gU3FkTKirf2VIymriaEYa4rwCMK4A5XcivrEcvr9Hcv0aGvlH
         jU14iQyQl/CN/R6p4iz/6tT18SaTrqwySrVeYkuZyJQQFSSA1CJOKgGGA79XeC3l/+Fe
         T2gterkRjAZsEqm4S+0hc5yK3hcjKA8n0wkzoC0xEF33866ZEppxv8+kCeQkxoNisIvc
         dtdevhG7wKe++Cb3Q+ZQ+0031iuep4KFSrMG1I1dhv6+VmgZsgRhg4raFhwAFoFmnJY7
         lC5g==
X-Forwarded-Encrypted: i=1; AKwUvByLxAwc47zdtW4tqBwsdU9Pm+H9e5+MjmVYPf6OLJCTD1Xv4HTE6v5ckN/fuVU+WISrRJ4PssepEEVOKTYg@vger.kernel.org
X-Gm-Message-State: APuU4Z/y7tuP8ujZf628cF9d/+fqtTeL3u6ztL57VAORDFWOLp9vLKgE
	hwdh/Sv4ZZsV9vFfxGQvGRqr+CVDe6mH4HSZmAri27w0dJ6CMF9ChdSS
X-Gm-Gg: AYBFou0jibFPVEpujasCafNUYLGHbqiNrDl8Q6/0tbqOMZDYjkEJpc9ytJ3iKrjQ6+K
	iGnqJOnOpY9b90NTF9OJM/n+/rmeNeWPj4lDt8CYDCtcuV1j0TJvmNc1c6biNkM0sBi19ZO+V7a
	q03Q/Dyl3/KwsNlglJPX9aqUuqt3Q08RR1oiJm/NMwFy5apqvyL5QsTfYPh42GBCRaG0rDWwiuT
	Qt22cI1kgoGR2+/era3iCbueoLqN+l4PSG88gCvc4uyZFaQEiMUUvSfXvQ2CnvNf5HQDuOvzooX
	TGfGSMXKD+rH/YNu0+Nn/pa57jNONuy9+LCsKEuyTBOf6ngfl78Dn2MGZBkAV/mUVp7F6fWhwv5
	enexWV9JjhqFcfCnMDV0aCRnrsSA1gd7oirt8g9gl5Kuesst6WoEFQefiWgJ28e432OXaYAVDav
	PAUJwjfLC4ENlxUBXbzabwVU+cF+jo96yPCg/R1GE6DEz7E1s90dbZwaN4U7CUO8yvdKLmdeTLz
	xv7iV02bZ3btKUUsti96kS4du8OdroE2NeidNdVzT7ZPn/Z3KpKxeOFR1hl85w/c1CV52fpGi/P
	rfOXfn6uYzOGYwazWRttsxM5P5R6SKbn/0zDDnyo0j7dxcksJUl466EQhR05Eq+HeA==
X-Received: by 2002:a05:701b:4282:20b0:1b2:4e2c:6838 with SMTP id a92af1059eb24-1b25d30af49mr2369009c88.15.1793956486772;
        Fri, 06 Nov 2026 01:14:46 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm4200968c88.7.2026.11.06.01.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:14:46 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ntfs: open the index allocation before reading or writing an index block
Date: Fri,  6 Nov 2026 14:44:19 +0530
Message-ID: <20261106091420.2461683-3-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106091420.2461683-1-wahidzk0091@gmail.com>
References: <20261106091420.2461683-1-wahidzk0091@gmail.com>
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

ntfs_ib_write() and ntfs_ib_read() use icx->ia_ni without checking it.
ntfs_ir_reparent() only opens the index allocation through
ntfs_ia_add() when the root is a small index. For a root that is already
marked as a large index it calls ntfs_ib_write() directly.

The lookup does not open the index allocation either when it ends in the
root. If the last entry of the root has no child node, ia_ni is still
NULL when the root has to be moved into an index block, and the write
dereferences it:

  Oops: general protection fault, KASAN: null-ptr-deref in range
        [0x0000000000000128-0x000000000000012f]
  RIP: 0010:ntfs_inode_attr_pwrite+0x52/0x1600
   ntfs_ir_make_space
   ntfs_ie_add
   ntfs_index_add_filename
   __ntfs_link
   ntfs_link
   vfs_link

A single byte of an image from mkntfs is enough. In a directory that has
one empty index block, clear INDEX_ENTRY_NODE (flags 3 -> 2) of the last
entry of the $INDEX_ROOT and link() a file into the directory.

commit 9365c4a1357e ("ntfs: fix NULL dereference on index allocation
open failure") covers the case where ntfs_ia_open() fails in the lookup.
Here it was never tried. Open the index allocation on demand in both
helpers and fail with -EIO if that does not work.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/index.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 66411a712..f808c887f 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -97,12 +97,25 @@ static s64 ntfs_ib_pos_to_vcn(struct ntfs_index_context *icx, s64 pos)
 	return pos >> icx->vcn_size_bits;
 }
 
+/* Open the index allocation inode if no earlier step of the operation did. */
+static int ntfs_icx_ia_ensure(struct ntfs_index_context *icx)
+{
+	if (icx->ia_ni)
+		return 0;
+	icx->ia_ni = ntfs_ia_open(icx, icx->idx_ni);
+	return icx->ia_ni ? 0 : -EIO;
+}
+
 static int ntfs_ib_write(struct ntfs_index_context *icx, struct index_block *ib)
 {
 	s64 ret, vcn = le64_to_cpu(ib->index_block_vcn);
 
 	ntfs_debug("vcn: %lld\n", vcn);
 
+	ret = ntfs_icx_ia_ensure(icx);
+	if (ret)
+		return ret;
+
 	ret = pre_write_mst_fixup((struct ntfs_record *)ib, icx->block_size);
 	if (ret)
 		return -EIO;
@@ -768,6 +781,10 @@ static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_bl
 
 	ntfs_debug("vcn: %lld\n", vcn);
 
+	ret = ntfs_icx_ia_ensure(icx);
+	if (ret)
+		return ret;
+
 	pos = ntfs_ib_vcn_to_pos(icx, vcn);
 
 	ret = ntfs_inode_attr_pread(VFS_I(icx->ia_ni), pos, icx->block_size, (u8 *)dst);
-- 
2.53.0

