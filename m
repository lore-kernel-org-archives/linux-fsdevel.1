Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824664;
	b=boR8sefAUr30yRHzeo9cqIPTBWfw7NMHrh4UmzOObnn3iIGkr3kTfU/yahsqFO+VlgF2
	 pnGlSXHxRm6Itc6Hgg318IhdriZ99Mdu4XDPvVlyA//hWS+99ILi8FQ9Pl5auZ87aHVMz
	 hK2Bb9zVfWzXjCaojmnb0sdz6JVyznO8g9+2vr9TwV7krlDcgbEAstkguoi5OVSk5t1Ii
	 cg00CWsizk2ua5YlY7+bGuexs6eJQkwGgkn3GvX2LBYHegKRHMotyvWHFU+GiF/23uAGl
	 naXKA63FSoSnydJUvQyO1B+nAt8GFiiGoKWp3GG77K7CC5kBitb6van873bpZJPd3/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9w5+uglXN8MeYO7cbfvDu6Yr/i7whWOWfDCFVUzQ/lI=;
	b=TUvyg8qeoDgRJvX7d4r431fYca/izyiNr2WtpgIDbI9A7epLHnutbTpcgT4H1YJ3dCdN
	 Xp05LvaDyallTQ4TrwY+CNs/h5or7f69RMkgap9coK+9vLKWT5QKtPLC8vQwDxo8yhwKh
	 A+jm27YPpSVOOWnPLlN8ofQufm9K2Q7YEpc3BlLti6U3sr5qUfXVymVW8YjbkYX+i7n6B
	 FNn7jX5qviVvbSue9jE77Vhgic83itmBUYOmN9naGEcJr5vin2vXIJMEzEtiQ3R4b8jv4
	 uRo4nDCtnqoXv+4E+ivrEjs/5Tq2Ijl9nO4/CWnaDZjgKkWwP5luudr/q8yp1fYA9KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7jQ3tuy;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE94606A335
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE94606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e7jQ3tuy
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso10400815e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 02:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824663; x=1795429463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9w5+uglXN8MeYO7cbfvDu6Yr/i7whWOWfDCFVUzQ/lI=;
        b=e7jQ3tuyVlS2RTuK8llltk8GsHFeKcYBPGKIbGVzrTawX4qSYVi1Nncil1+SOrLmCh
         7YBlmuYE/tfh0Vo10s0nnBX1APjph2Iml6CdjQVt5tpuhRDQFzH1UdZ2k+oiIHWhsOTZ
         BEbcKxR83hhr7gsSa/dU4sN2VCyJXxAKcy0tlyjjDO4S/kbLO/Mf0Fcu553gc8Ylhhbi
         8GdtX0AutLEKuFvJIQ8DAq0zgF/uvWjCKiHKu/oXO4uq2xiFigFECwqKKl+72+ICZFxl
         lDaJVWgF79Uan9sMtpB54vo13yh4xxt+iKWfAGpFo3kGl7Qv3FXFMpqdLe+y9rK3j4Lv
         UWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824663; x=1795429463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9w5+uglXN8MeYO7cbfvDu6Yr/i7whWOWfDCFVUzQ/lI=;
        b=mjkhgrzoh5EsbyLy3NV5Z/IBYVwmUyWnIItaUQ59fUwasZay+NKwCx18XHm5t9haMR
         /N2E3yMWSSHTC6lh4/kCXbXNZX9fl642XDDQc/WcafU2pYgYuZ4N4JJdxgKlE6K+zVbU
         L4rfEAVi72PgvPB/LRVWeoV5xILtzaRkk00WK984j/7d5alZZhaMGq4P7EOJZWj6Kgj2
         QKRpXqACg3LlrVd/rIKkYUz/aS+hzRgSqHgCGngFzG1mYncSrdi2WGX5uiTR7n5Td+5E
         SmhPiXS+K55LuWS7D57OuJFgnonz1NtE6sVGJojQHDUMo3NU4ZBMEcvwN0NB9yQVa9sB
         04jA==
X-Forwarded-Encrypted: i=1; AL+hErF+MLkthHzTMKxQc5tcMcOrXuE01JLd/ZEJJZI3oN25+kaRoy4g6x80KFqOUXpLLhCVRNYa0O2udn0mBs9X@vger.kernel.org
X-Gm-Message-State: APuU4Z+kuJ7XiUg0Y36/Wn0aghq/2562GmiI9Pj4MthdWAzOgJPBBwu1
	xOiu1AEGmg+77jPAyj7Ffni2p2HC62UiH27ACEj6OQi2CZ0HyB51tqa0
X-Gm-Gg: AYBFou0L0T6/wM75l4XwrVqx/aC6fqmCMBwYB9ybmKJHF7153/+a/oMFDaBd2d0h+J9
	SVZVd5aAFcqBPYKi1wmS9irgaZueHMwlzUS1HhSVmz6s0lO1wghefORPhuf+zWJah/YAnOBFjUp
	9e92M9GwazCiS8vkI/lM8Ul6X642Nlc8EXGk0563CrQ48KkxzFmGAHmQGK/wHksG1So2b+xO5KK
	uaW5ynPx4phvhHpUVqrLYf5DfO5PYjL/2wNBPi936KKYIVBOs0HQ5/idcIliQQzS4gHCipWsfnV
	nkhn5J0ALw4DZcompXWU1Z+IRMQcVItsFpbTWgRBpd5xsfqQaKLSxdmH7BSzcLVb6oMOTknOkAP
	Iz0PqiqviceVm4F6XbgyFuyAg6TsPKH/0mkAyExXH9KsyPOC3FMpJFv9ZeUA8B0O12JszGnlmzS
	pQR8GqXH5Eqv70Xb1fw8dkJwdYdixNUAPaeWb39govzpjdApMMGzLYElzf6VbZB7JBnelrmk/SD
	Lu2HX3NiVG4mE+LtMTtS+zzaRFv3r6jG13tDTdLtVj9O6hzAP1RQGqVbH4TUyxVcUwS/QjU8xcx
	7OQkLrashedHXaTIlWTn
X-Received: by 2002:a05:600c:1989:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb66fdaeefmr125267505e9.14.1794824662652;
        Mon, 16 Nov 2026 02:24:22 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571d7e87sm191536225e9.3.2026.11.16.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:24:22 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] fs/stat.c: avoid harmless garbage value problem in vfs_statx()
Date: Mon, 16 Nov 2026 17:24:06 +0700
Message-ID: <20261116102407.81232-1-petrvaganoff@gmail.com>
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

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Petr: There is no vfs_statx_path() in this tree. The fix is applied
  directly in vfs_statx() by jumping to path_put() via a new out_path
  label, preserving the reference drop and the ESTALE retry. ]
Fixes: fa2fcf4f1df1 ("statx: add mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 04550c0ba540..74a774dc4eb4 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -195,11 +195,14 @@ static int vfs_statx(int dfd, const char __user *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	if (error)
+		goto out_path;
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
 	if (path.mnt->mnt_root == path.dentry)
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
+out_path:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.55.0

