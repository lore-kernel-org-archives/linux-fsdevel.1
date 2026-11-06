Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969171;
	b=WhHaSkUYICr0TGdBOKrw3VpkzZpKs9IcHfTSJ+3RyX402cpabB7GfFmbyrnBmrT5mSk4
	 /O1T2cqB/F8BI0AtdRCepfeNZQv2083EAjvWLkArG/tJzguxKFjh14oJioP06SKNlf4kY
	 /mVc0nKMg5e+BR9vDHQ5hpCaNIUbxZHbdiBEE0MpyDocFy9lHOA3rZwQVJNeyzdYXkiZ/
	 2CveN2u4RiU/uNUZfVdWq7ixY3PyHkmC3U5BuZzYchgdRq1V4+mo1dp1YU9uhDPVAF+Ly
	 q8qsJjANUcfuCRCk+zwOu6Y/m0s41kQQMcdWWEcfP61Lk45vanasUy/h9w1/y0Q9gNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969171;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JNftfiQYVNrVOWb9CroEjxPZDzjxD7afgRSnyOU7AVE=;
	b=bvbKPCqfmghbA0vDGQAvHyHq6aW9ndgWRLthVCw32nlXCgjsqscPdZWWwmwx2RHhpxeC
	 2W9ADOk1HZ1TnoahKlCjEgyNQ3do9W8svl64cI+/EWAW4mWL+u3C2bxXPyaCcv+AmqMlK
	 oc05teRI+ZGkYPQcuUWthFnDqqVQD2jWiYZQ0M8T7N5cWZcqkbkTnU2DB0pNyZy9cvmzh
	 Y2x6A2djvqYPMd7OXy4ozZo8L4nkYDqY/49SNesz2pdtb0WgWCPCIXaE+Y5OWyfhk+A1H
	 wGvbTj1NapiFmY6YpxzEmjPp8rHEE6XAFjVBK7YJRPRPr7+EbFiOVnA6uZdQA9IXRBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KoMcPaAb;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D5606A333
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 12:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD7D5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KoMcPaAb
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1876251eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 04:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793969170; x=1794573970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JNftfiQYVNrVOWb9CroEjxPZDzjxD7afgRSnyOU7AVE=;
        b=KoMcPaAbexCKQpS7dN1txsf8/njskB012eFKiEQpGj3gqecgq5PAIUgUmDia8cSqL8
         C44cb4NnJTdZiSTKt86qJpLxbqUYOV2w792sEsC387W9Ul6vqmayQFme0IZBoDxko10q
         JYhZgKSPsTDKKGJAVix5JGhGgWEjJgx+w3EcwMp6kwk1P2tLWEDOQiH1R+6apRrPM+IA
         DQs4tGERGDkTrBWnofrRQqFNOfma+zcPpmeVNQjJ0uSXNzIhMWw3uvV/Ag+s4rRg6Zrl
         8lTllhb2tSd17+vt4BT/bVvwdYNUkQSgkx8wiJDkB68wS0xTz8fqAmu0Cd0CgGIrL0Ap
         f8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793969170; x=1794573970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JNftfiQYVNrVOWb9CroEjxPZDzjxD7afgRSnyOU7AVE=;
        b=Wkqg3q128C6rKo+Ul7DM/ENzjh3wSytobx31FCsPw3H/IdjyK0lZQf5iipsdtnsGpr
         PjbXVo/nrD+8jJB7jZt15dWVHbRfhmmkXRWomVQROFGO3ImtCXLFHTg7+n/KzNkaS17E
         fp0hKH0Fu1FcIIhVPVgSdnu4kZoCi/HFKuA33D3EAZpYkC98J7rUXNjxToOwlALycQAG
         etMKJWlOBgtUtpo6HfLSkeiy0QPAru89FMQ3YXjBLNI3TVBNqk9NfVRv487ifamZjuL8
         Mj4o4/ZTo4YaGyg1WhjJGsdHl3L2mFj4NNVac12/jklMBq2ZzJT3S+1jIQMOH6o0rtWc
         i2eg==
X-Forwarded-Encrypted: i=1; AL+hErH08gyah+6jDsHeAgrkTNfaP2YudmVol/v5HwIkF1XOF5jxSDJNApNow7LSsJGWqyoLTLWBipCohuJn8+Lw@vger.kernel.org
X-Gm-Message-State: APuU4Z/lm0tJR44PFIeqs35WRB64Y+h+qkx0a6aYv4mKZvTiv8Ifl59z
	Hom1BiBIoga0TuJW5aM417s73aDhLTpMCILNGxESZMtnYdfb66s2yN1S
X-Gm-Gg: AYBFou3Hp9CpPtMfeaZ9+c93LtQ5HPa3psrIISJ7XeBUN+vXVLfZ4qiy6vfVI9RneMd
	u0h+t8NZ3PrG0NGsofkCIuWUS91u5y7vcAgv/IVnqYWqMYCQoN+QRY4+wccDHPBIdttiDToFiOF
	n8zVHxmZdUG2FpVz3hhVZWLT+lQ3iNA+437N5VgMdNkcDkFzBcRgHAHMg7oi28YHeo7nC15K/u+
	GibCU9Z3fnSHasClel0KQN45drNJqUrZjrVhBYFOetrQfCt4HCqo5Ha9YBen1QzNo4hhAEIrkQV
	yhNiaa0wjYv36/Rr2cxSF+Utpji8IsHP8TNo4Z6bTRC2tBUfApC6S2tGd+bHysn71V2iM9xRNl3
	TS2nAZx7FVOXeXk4rTjxCWtMErvPSbhUZ4XmsmuvFGJbx53drsQaVgDX/xx9gCvGsBbYQc0t5Wq
	K5Jqa74o4crk6YIvyhvHy+iccVJLuzcnZVlfG0MnrXM2tJNOdPkYZKy9V/JIZMZotWG6ivgn/YO
	4p0JY523wY8FZCk3gGp7r/zi0cPu2pSYbxN3qbo836I0eBeITFQmGP1ZCUBM99De2hKD7BVQMMr
	9+yaugyT0EAO4GhKgbhkHs76RVh21038y5dS0UO93NYMI5gxwKCoahRE6oF3Qegxrg==
X-Received: by 2002:a05:7300:10c:b0:369:f97f:72c1 with SMTP id 5a478bee46e88-36f771025d2mr3480312eec.36.1793969169592;
        Fri, 06 Nov 2026 04:46:09 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm6802331eec.1.2026.11.06.04.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:46:09 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] ntfs: open the index allocation before reading or writing an index block
Date: Fri,  6 Nov 2026 18:15:52 +0530
Message-ID: <20261106124553.2617026-3-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106124553.2617026-1-wahidzk0091@gmail.com>
References: <20261106124553.2617026-1-wahidzk0091@gmail.com>
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

Commit 9365c4a1357e ("ntfs: fix NULL dereference on index allocation open failure")
covers the case where ntfs_ia_open() fails in the lookup. Here it was
never tried. Open the index allocation on demand in both
helpers and fail with -EIO if that does not work.

ntfs_ia_open() also succeeds for a directory that has no
$INDEX_ALLOCATION attribute. The inode it returns is then an empty resident
stub that does not describe an index allocation, so reject that case too.

Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Wahid Khan <wahidzk0091@gmail.com>
---
 fs/ntfs/index.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
index 322cb371d..74716f916 100644
--- a/fs/ntfs/index.c
+++ b/fs/ntfs/index.c
@@ -99,12 +99,30 @@ static s64 ntfs_ib_pos_to_vcn(struct ntfs_index_context *icx, s64 pos)
 	return pos >> icx->vcn_size_bits;
 }
 
+/* Open the index allocation inode if no earlier step of the operation did. */
+static int ntfs_icx_ia_ensure(struct ntfs_index_context *icx)
+{
+	if (!icx->ia_ni) {
+		icx->ia_ni = ntfs_ia_open(icx, icx->idx_ni);
+		if (!icx->ia_ni)
+			return -EIO;
+	}
+	/* Without $INDEX_ALLOCATION the index inode is an empty resident stub. */
+	if (!NInoNonResident(icx->ia_ni))
+		return -EIO;
+	return 0;
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
@@ -805,6 +823,10 @@ static int ntfs_ib_read(struct ntfs_index_context *icx, s64 vcn, struct index_bl
 
 	ntfs_debug("vcn: %lld\n", vcn);
 
+	ret = ntfs_icx_ia_ensure(icx);
+	if (ret)
+		return ret;
+
 	pos = ntfs_ib_vcn_to_pos(icx, vcn);
 
 	ret = ntfs_inode_attr_pread(VFS_I(icx->ia_ni), pos, icx->block_size, (u8 *)dst);
-- 
2.53.0

