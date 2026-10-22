Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792711282;
	b=1wajzDE7qUnvVsYzMwVLGUs5RWQJij7md7l56SULZwSpAJwk6UMLN8x9hblHOAUlkqcG
	 JtpxpR6NwfgX0BwCYeKh4sk2vA0e6FZaqXbjzORVsOaMAHoVLgZnhPYizi0Wo5G6+eAEB
	 TPJAM6qJqkpGK5cEAsdf0GWkA0Cmim1A4rtzGXUZsu/DNVMIo99TvViivZzWN/4ByQRVN
	 sL8f1nHnr2Bgzx1ESg3r27JljJB4YwCHI6472hfnf+5MQLq9A040Y/BsXDwpzjOUef0QL
	 HRpsaz0n021F0fB9rMbIhuplNhEgSamI8gx84A1W6pXt1hKrQy7LbLb6IPANgsXAo3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=xxiy5YwT+t7eFNzTkh9tKx/fcp0szthGkTB2aS2xJKI=;
	b=ce3jpHcl9AjVUwtOj2vAv+hTxeF2rJo6Yl9961jKpD+xSHA6VYmAH7iq7mRHQpASd8vM
	 7S2W8FMgx9e/wOuamlT6vHvx0YmVcCuf3T/PtiIH9WzHSQ6r8HvkzQ96oAiE0lfFcpGCu
	 C0IXndA4+2kKs/miuXQerd3ltEjXb7xijXISlk2GHCI5mu/Wti14jOjFugHH/LWBfId83
	 yt+4dOnsrCcjRLB1ZEF6sfVQp4TfV2t+qPsQKI+1H3r0tXUXK20ascfJyyR97L60oAi6/
	 ZWBuuMAetoTLsBanKHDu4WHbIvhkt7VFld41IQz/d9q+s8gur0b8hV+6VuaLH5Ly9/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=npCtoIQU;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB8606A31F
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 23:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AABB8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dmnk.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=npCtoIQU
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a028616bebso1756225e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792711280; x=1793316080; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xxiy5YwT+t7eFNzTkh9tKx/fcp0szthGkTB2aS2xJKI=;
        b=npCtoIQUKcGoaA3YVhMsfMDpednsvYAqT4GHduzfy6TwJP2/MjFg647m2lCZthU6eT
         +eCCpQltgswM164+pzywMN1D2r/aoNZWvzNM4iYjBAsyNpSe0LpYUGKHYd42hA8Ss6FP
         E6eRP9jvXIk825TjmMWr87g/SRsKXSDEd49sitH1ntNlJjytnZw6pjjGfsfTM2lX+MGB
         Qqq3SQDWaoZAkDJtlqDzTLhoccrezS7WCysk+Q+f4gU2Ph3SpnqbturDzcrKzUd+n+QV
         oCnVuwPhfP1EjSLWk9A86psziY8mqj13tlkSAONVvTdBZ45O7kRm0pfRZ6KYU5Mz0iXW
         5tIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792711280; x=1793316080;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xxiy5YwT+t7eFNzTkh9tKx/fcp0szthGkTB2aS2xJKI=;
        b=C1Pg6M0Ovv9qwyzoVDFiW0ePG3+eNbgxN+XBtrdiha+C+waRAplMrbk0I3HmHz43jg
         j49GDLa6AOs2xbNjyrYLoNwn07+1JfzWNqhyiA0tWY9JH4lSw0tjL9Ay3lQUciOlD0v4
         AsluLW8oyWW3dIx3JZd+59QdIeClW8OoUKDTSRpGZdXDyFCsiDYhEmB7y9jEYZDMP5v6
         f5D65PEZiWUUeBVthdQNO26X0pA/psSgUtNKpOM+kRLOZr27RAMULpSziXUiisbAlIzZ
         czXzNxPmoOQMh1F+4aXHmbnHfOrOcs92sOBqujHUe7/XW1EbuUAii/ndD88Nxs0b2Xd1
         gPZA==
X-Gm-Message-State: AFq9FYLVvMTuI5vkr3PQclNQX72BGhLKtuY7CNPB5q+r11ACIgf+sMkT
	4V5i1LKJ02KeSdqx40qEHrbCDbcIvA+lVCE4Pyks9A/lNqUeQ1HDLy+dMwipB9ZPtR2i65fTkw=
	=
X-Received: from wmbg26.prod.google.com ([2002:a05:600c:a41a:b0:4a1:b000:6501])
 (user=dmnk job=prod-delivery.src-stubby-dispatcher) by 2002:a7b:cbc9:0:b0:4a1:efba:511
 with SMTP id 5b1f17b1804b1-4a211f0493bmr4527945e9.35.1792711280006; Thu, 22
 Oct 2026 16:21:20 -0700 (PDT)
Date: Fri, 23 Oct 2026 01:21:19 +0200
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
Message-ID: <20261022232119.2537209-1-dmnk@google.com>
Subject: [PATCH] xattr: always invoke cap_convert_nscap() for
 security.capability writes
From: Dominik Maier <dmnk@google.com>
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, dmnk+artist@google.com, 
	Dominik Maier <dmnk@google.com>
Content-Type: text/plain; charset="UTF-8"

Commit 8db6c34f1dbc ("Introduce v3 namespaced file capabilities") changed
cap_inode_setxattr() to return 0 unconditionally for XATTR_NAME_CAPS
("security.capability") and moved capability validation into
cap_convert_nscap(), but placed the call inside the "if (size)" block in
setxattr(). Commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
vfs_setxattr()") preserved that "size &&" condition in vfs_setxattr():

	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
		error = cap_convert_nscap(idmap, dentry, &value, size);
		...
	}

For security.* extended attributes, xattr_permission() skips
inode_permission(MAY_WRITE) and leaves permission checks to the security
module, while cap_inode_setxattr() returns 0 for XATTR_NAME_CAPS assuming
cap_convert_nscap() has already validated the write. Because
__vfs_setxattr() treats size == 0 as an empty attribute write (setting
value = "") rather than a removal, calling setxattr(2) on
"security.capability" with size == 0 bypasses cap_convert_nscap() and
allows an unprivileged caller without CAP_SETFCAP or write permission on
the target inode to write a 0-byte security.capability xattr (or
overwrite an existing one).

When that binary is subsequently executed, get_vfs_caps_from_disk() reads
the 0-byte security.capability xattr and fails the
size < sizeof(magic_etc) check with -EINVAL, causing execve(2) to fail
with -EINVAL.

Always invoke cap_convert_nscap() when strcmp(name, XATTR_NAME_CAPS) == 0
regardless of size, so that 0-byte writes hit the existing !*ivalue /
!validheader() checks in cap_convert_nscap() and are rejected with
-EINVAL.

Fixes: 8db6c34f1dbc ("Introduce v3 namespaced file capabilities")
Assisted-by: ARTIST LLM
Signed-off-by: Dominik Maier <dmnk@google.com>
---
 fs/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index d9f035610f0b..0705801a62cc 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -332,7 +332,7 @@ vfs_setxattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 	const void  *orig_value = value;
 	int error;
 
-	if (size && strcmp(name, XATTR_NAME_CAPS) == 0) {
+	if (strcmp(name, XATTR_NAME_CAPS) == 0) {
 		error = cap_convert_nscap(idmap, dentry, &value, size);
 		if (error < 0)
 			return error;
-- 
2.56.0.257.gf7497c7d27-goog

