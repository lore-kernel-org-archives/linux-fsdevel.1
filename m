Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DC35A3A9;
	Fri, 19 Jun 2026 09:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861900; cv=none; b=c5povAerG5EPsYoxtThr6yTsJeQkXN7DfgpnSQvwRYDwlUDfZhvpe61jQ8uaG6mccPUl0ndTNWC1OZX+vxLmv/LZvTIEnaOuLtgX3/jwg5bkC1qrFmZAmaxB6D6i3F00+MOzsu+YGmB2k0gcSBah257DLZhuKRRXJn9W6RzDAag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861900; c=relaxed/simple;
	bh=xC3wcnUeClOSfRW2eqNi5KvQoM1t2WCujkSlzbe2wj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VtwIgR+W8ztc6oEDBRowq0q86wWyHH8jxiC2HMyS4eXS/zzgUFXZ/AJXv4PsLNCnn059y4MgqBOu1TWbQJXKSp51LDVVflkoNFfgYVhXJLK9pINvo4O+f4tKMFbKC5/No7eEg3ORzPP+rWX3jfVvBrmCIRmO6ALKr/oD+eatTmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNn/sSgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNn/sSgD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75FE8C2BCB4;
	Fri, 19 Jun 2026 09:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781861900;
	bh=xC3wcnUeClOSfRW2eqNi5KvQoM1t2WCujkSlzbe2wj0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=cNn/sSgDg2DAqiOkO5zwjsKajKsvEPw407i+H1F1HCd+TtheUgw9FBLpbdCFw0f0b
	 cEAoX1ULeNUBOjQ9TKtQgnCYqF9WGYwADlbrn7SpcL9xh524hRNMa0xfEawlTHa0cE
	 jwhz1zoGh4Agzu7nFBWD/yhuDPxdsMX3Nqnb5RwQzHLLRXdhHHsaeK21lJcpCwZBl4
	 xKRoLrEltaYqNBPl3oTtUdEsOPCw/29RWOAATLOABNUSsKgnE+6x608wlG5oRYMUZW
	 6DAHjo0jS/1ygbwb2TjXb9IQJPHnH641dmUcIku88cFOkv98yOcax5Rij+9yXkOZ+8
	 q/tQHuSpmpFZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A2CD98F6;
	Fri, 19 Jun 2026 09:38:20 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 19 Jun 2026 04:38:20 -0500
Subject: [PATCH] orangefs: keep the readdir entry size 64-bit in
 fill_from_part()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-b4-disp-50d2bd59-v1-1-ce332969b4a2@proton.me>
X-B4-Tracking: v=1; b=H4sIAAsONWoC/x3MMQqAMAxA0atIZgNprEq9ijhYGzWLSgsiFO9uc
 XzD/xmSRJUEQ5Uhyq1Jz6PA1BUs+3xsghqKgYk76oxDbzFourClwD60DsmtwtyT9Y2Bkl1RVn3
 +5Ti97wcDJit8YgAAAA==
To: Mike Marshall <hubcap@omnibond.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devel@lists.orangefs.org, Martin Brandenburg <martin@omnibond.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781861899; l=2502;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=RJ8UcS4zpbSFRnrWNSWSdbFKTQ2rtT8iK4yUjj8cqng=;
 b=Vdm6WMjY5JkW7U1XmXeabtMn+i+ZG/DE8OgOh6bSSj+l2snqflHnXtFDsDObEVebkLyoOG92g
 n6C2/ZaUyTzBi5xnEKayytXhj+zr3GYPBd+327c36A5l2woGi+KRL8U
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

fill_from_part() computes the size of a directory entry in size_t but
stores it in a __u32. An entry length near U32_MAX wraps it to a small
value, bypasses the bounds check, and is then used to index the entry,
reading far past the directory part -- an out-of-bounds read that oopses
the kernel.

Compute the size as a u64 so it cannot truncate; the bounds check then
rejects the entry. The trailer is supplied by the userspace client.

Fixes: 480e3e532e31 ("orangefs: support very large directories")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reproduced with an in-kernel module that runs the fill_from_part() loop over
a crafted trailer; the only difference between arms is the size width:

  A (__u32, len 0xfffffffb): page-fault oops at fill_from_part+0x126
    (KASAN shadow load for s[*len], ~4 GiB out).
  B (u64, this patch): the bounds check rejects the entry, no OOB.
  C (small len): unchanged, entry emitted.

Same result under userspace ASan. Tested on a KASAN build at v7.1-rc7.

checkpatch keeps "sizeof *len" to match the rest of the function.

Severity depends on the trust boundary on the userspace client: a remote or
compromised server driving the length is a remote DoS; a trusted client
makes it a local robustness fix. No write, no info leak.
---
 fs/orangefs/dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/orangefs/dir.c b/fs/orangefs/dir.c
index 6e2ebc8b9867..115b2c2f5269 100644
--- a/fs/orangefs/dir.c
+++ b/fs/orangefs/dir.c
@@ -191,7 +191,8 @@ static int fill_from_part(struct orangefs_dir_part *part,
 {
 	const int offset = sizeof(struct orangefs_readdir_response_s);
 	struct orangefs_khandle *khandle;
-	__u32 *len, padlen;
+	__u32 *len;
+	u64 padlen;
 	loff_t i;
 	char *s;
 	i = ctx->pos & ~PART_MASK;
@@ -215,8 +216,8 @@ static int fill_from_part(struct orangefs_dir_part *part,
 		 * len is the size of the string itself.  padlen is the
 		 * total size of the encoded string.
 		 */
-		padlen = (sizeof *len + *len + 1) +
-		    (8 - (sizeof *len + *len + 1)%8)%8;
+		padlen = (u64)sizeof *len + *len + 1;
+		padlen += (8 - padlen % 8) % 8;
 		if (part->len < i + padlen + sizeof *khandle)
 			goto next;
 		s = (void *)part + offset + i + sizeof *len;

---
base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
change-id: 20260619-b4-disp-50d2bd59-09fe22704b31

Best regards,
-- 
bryamzxz <hexlabsecurity@proton.me>


