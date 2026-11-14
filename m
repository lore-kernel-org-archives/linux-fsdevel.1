Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628267;
	b=fpB5VhZ9sMKlHlHVaUDCl23MpMZ8OHTp6jOrWuHVAJHnuGFkgIgS4agVYy82i44zM2e6
	 8cpL2f8D2SZzYrP0uJbvmdtOYT+NzxaL7jk0KuIthn214nM67WuwXZge5RABo5jaSX6IB
	 vQD4ZJ/kEvcHmu5AzGope6xGURJW9VwmzEIt6XBCnbKkh9ZcTz/o4FloAimVXX6Y6xVIV
	 gnBKZk5KO+nbxgSyrySiEEKOutPF9UJwiHhs3LDuIM1nDlPDdWmYR6wpYaz/He6p/B50V
	 vvBaxEqEEVX/i0aNliG+4nVdzyBhR/4KQhqav1v10YNPA6px3+z+93Ps2sXI0JlEj6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628267;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O6jpi8Un7nxjf1XAfzWP32okLkYI9qZxL3LDVspsjAk=;
	b=LpppscaYi7tcj+3DM4RZ2cbJqJN4XW/AV2Ab7Qzn5KyXbxt8EiGZRR8wOQ1CpZQxG7/Z
	 WVMBj8ouIQKVC8xxkN6fkKrJdaQbPvx4rikvyuRehgqTCLa85gGKHfX1cNC11kBIISEnO
	 Qe9w0gIMZjdHR9tFJSQ68ql7c5Gig+O+QZHrhOydpx+otR1iInrIvKwZ6nK1joP9zgsFM
	 wM83T6HEqwkFFx9XJdS5Sx6d8yNImApYSKBkKOLfKPnNzGZ8K0Uk6ClWCjael1X1rTbbK
	 VWHpxlHYNkbaHLQVn6DuLTDgaGu5e351+vXk9aVE63j6fEQS46wNVGFEXXFp65dRPzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=chSAElFI;
	arc=none smtp.remote-ip=203.205.221.221
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FD606A327;
	Sat, 14 Nov 2026 03:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24FD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=chSAElFI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794628256; bh=O6jpi8Un7nxjf1XAfzWP32okLkYI9qZxL3LDVspsjAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To;
	b=chSAElFIaGEYOP9+CqOm3YuS+bn9f5SGL6ntPNK5+3851Fbqg5+xedhrwpcfcBw3f
	 G6UhdsECsm4Am1fePQjGH+SdnKQk1HLdoaWN9h3x9swMCtZ7trKS2LwhcR3/1BUXpr
	 AK9Q9L80cogYcEqxbWKAVLXd4xGUrU07oM1ruQ1g=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id CB62D434; Sat, 14 Nov 2026 11:50:54 +0800
X-QQ-mid: xmsmtpt1794628254tjwmrzbkn
Message-ID: <tencent_EA39F5EE5B6CC4D989CDD435CACC4731AA05@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb50UofCUAfNsjV2FwHxsX3E/H2idLAef6tTTqwXW/MQz9Ft8J2H9
	 s7dSyEb6t+4eL1RaSLLuvzGKBxBb9wUBK9+uETPy+hOstECATqSbAY7Esu+1VB5JSg7a1KNncfXc
	 G/wRjbr55K1nVWNfvLDMI7vLJt6NcwsWQRW3fV4nAHAshVV//lstVZ/ObenYVO+ykGagAdlNvDIp
	 WNnnGl+C7n+Qh/JLBYtqCSOVGCAWtwE9GNR9r088G1IWEXAisLWfyF8QtMrXEOQV2LO6HuBrc6pa
	 QrtYXOrkUzAH46qUACnuYX/ulpN7yYXgAUvx0caVblIygZg0JMAvPfoPohTjf8LujX7DYgGp/+aJ
	 uMWzBr8s6DLSXh2qrFfiuWmqv4Heut4wt5QqnUZ19+7lyDk49HH44Vq4dfGCUxQFuSb6rEXeRK6p
	 YhMprES1Skpun9ZTaRZSG26DzySmCeTy9WtAafivGA6pQjbBpiR/fHZugwpV62XlxpBTj6YA9b4S
	 6eruCgh/9bTKPzErJW+3VJnk03xGXH0O6EOf7xrRKqYUUl7Hg8mEKTBa6eU+7qYQYi+jndjniucV
	 1hMEdMAm/xdPbjJIEvpXzgR/cnV+7goDnwoGMJUo9gXoaJZnIwFH+q6HvdajSHBIn4WjLsRGAN8x
	 ZBlv0sckROFpPg9ja4oTW2C6B7MgqFKJwuQq3xmI5jQUq+1Xc4rb58pB/mYzbrj31cXiMnZ0kV3Y
	 qi+Soi85QGj6zfhI3KIsZoj4uIw9Fg8t+Ik/ISK9S/otn+pitjbB6pd3395xUUa/dz9nuLQtvP3U
	 GBXTBVd2+KikOqJwe1RWBRNeNLAzIMoJXv19FhaumKCpr51IbLWl9T0K1IN9H8fIr/20bVIx3MKU
	 VSlw/IAEy5qlPbcAc1NLOxF1S4P3D+ixL1xQAOPnEtjraH5RFOKhsaZ/849Snku8V/h3s0h8kjwW
	 IqEZ7o7Bte9UfwX/l9uni4n0UO8IDJC8vF8S3Kw0BNxHWlQ5ej4XguUneojQTZNQ3cscGIgv11wf
	 S/rVOOT/PYkXAwGjCCAvPms/CsAdzcc9kyy5rl0UFILYjZFci/dAknkE9tQ5w=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Guikun Yang <yangguikun19@qq.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: bound hfs_bnode_read_key() against the per-tree key
 buffer size
Date: Sat, 14 Nov 2026 18:00:00 +0800
X-OQ-MSGID: <patch-hfsplus-readkey-bound-20261114@qq.com>
In-Reply-To: <tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

hfs_find_init() sizes the per-tree key buffers from max_key_len:

	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);

which is 24 bytes for the extents tree (max_key_len 10) and 1036 for
the catalog tree. hfs_bnode_read_key() however bounds both the copy
and the reject-path memset against the generic key union:

	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
		memset(key, 0, sizeof(hfsplus_btree_key));
		pr_err("hfsplus: Invalid key length: %u\n", key_len);
		return;
	}

	hfs_bnode_read(node, key, off, key_len);

sizeof(hfsplus_btree_key) is 518 (the catalog key size; the union of
cat/ext/attr keys). For the extents tree the bound is larger than the
24-byte buffer it protects, so the check is inert there: an on-disk
key length between 10 and 516 passes it and the memcpy overflows the
allocation, and a "rejected" key length takes the memset path, which
writes 518 bytes into the same 24-byte allocation. Both paths were
observed as KASAN slab-out-of-bounds writes on the writeback path of
a crafted image:

  BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x30/0x5f0
  Write of size 502 at addr ... by task init/1
   hfsplus_bnode_read -> hfs_bnode_read_key
   hfs_brec_insert -> __hfsplus_ext_write_extent
   hfsplus_ext_write_extent -> hfsplus_write_inode -> hfsplus_file_fsync
  allocated 24-byte region (kmalloc-32) by hfsplus_find_init

Bound both the copy and the memset against the actual buffer size,
tree->max_key_len + 2, which is the natural limit for every tree
(the extents tree can never see a key above HFSPLUS_EXT_KEYLEN on a
well-formed volume; the catalog and attribute trees already allocate
buffers that cover their full key sizes).

Tested with the reproducer from the bug report: the extents-tree
image that previously wrote 502 bytes into the 24-byte allocation now
fails the bound and logs "Invalid key length"; the negative control
(NUL-terminated short key) still parses and writes normally.

Reported-by: Guikun Yang <yangguikun19@qq.com>
Signed-off-by: Guikun Yang <yangguikun19@qq.com>
---
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 3a1a1fa6f..0774b945c 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -84,8 +84,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 2;
 
-	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfsplus_btree_key));
+	if (key_len > tree->max_key_len + 2 || key_len < 1) {
+		memset(key, 0, tree->max_key_len + 2);
 		pr_err("hfsplus: Invalid key length: %u\n", key_len);
 		return;
 	}

