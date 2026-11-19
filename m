Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125000;
	b=EhTdonZ32Xb//yXM+iJ826fBlZpwOzE+dNH3rSO3f1oLt8f+5Tx9Dgxhbjt0LHj2f710
	 Qr4nhp4O97rsMEb9xW9jeQRYUhI8hrPEbcIa8wEJEdAdRCLpAgc1/q9Bd/RQyrTTqZZzK
	 JHlG1Kpk91kwtD+3pDaCphf6C0WusZwW0tkS7YYSQYCbaIZEKnyM5Md/QeYTyK42dziLU
	 Ge/4ouyiq6C0aswY/JFv9D7qVEAj0aE3uXvupKxiytfukHjA7WvYuFyMoKNRq6irlfocs
	 f7bo1r9hi7z70jNYGFOCma0SXGbLOKAob9Di/9fsfI8TKI7mlU4cTdW3dh8e0uGrFwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125000;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=ztAGIxfsJeJeYbrxCepsv8LrburFVrWDTXV5CLSdeyQ=;
	b=drXk4d4x8cKE76InU/VEYnOmkhrkwQRP82zs8BcGOalolMh4d19/cDUz95zIvzXCdLRD
	 0KHdx5msyfii9FzA6/dtttTpOef9A8qgKHJ1THbTtMFQ9sLE+3YqmtBUWJt5MGkDMXt5g
	 Z+tIM+wqXP2CpyWXRNpD+rum0B8p93tYDNUDijJbyp0lWpAytYngisRuvaBRj3YgW3O60
	 QYD6Tw5hQSlqhvuOR9TWAHjo/AVZ0+ua5oCvBDWwDCSCrgLM/SKJJLDEXzFbfB9sblWyt
	 u9d/qNN/U76RPNGAMvVMcpvxNoUeLN/a8+TGDKgwd9M69XIBn6S3301wPFKcbQhXtkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SmKPdUhi;
	arc=none smtp.remote-ip=74.125.82.72
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8997606A326
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 21:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8997606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SmKPdUhi
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1b29df78132so276043c88.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 13:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795124999; x=1795729799; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztAGIxfsJeJeYbrxCepsv8LrburFVrWDTXV5CLSdeyQ=;
        b=SmKPdUhiKG9uwoTev3LkNgOF9UWy4G/Tu/UBqJ0fJr8zuNbxgX8cfLAv7suZKdV/zX
         M4KutBajFKCdgWeBcaV+6+MwvMsJv69o7tANOpqHhrrKOBJUZfNXniKxqMI80fre+A3L
         1UMW06mu3NZj7PdkCnI3A7zWQYtW128SbN7AS3CLYBjPGuJdIqeGHmj+XGkENPUh2LSF
         jug/oOZUE5crY7F0ADf47N0fXq7y5pudGteFFYKyAAtoiKBFFOE3ce4JteikPpdbBkjP
         TFm9D2VY4BrRZlx33jxSZRuIZvWo7osMHZUudaHwZWu4UouSmCWt6XpEvMfrXNx6gJhy
         lEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795124999; x=1795729799;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztAGIxfsJeJeYbrxCepsv8LrburFVrWDTXV5CLSdeyQ=;
        b=h2H/BL7tofi0qZ3quTRHfwIymLZuUKuMh/r7sXi6NpU2zO8ctSWI/sEoY/zLNwfW/W
         BtemeTca2rvsIq1q5xLHkzA7rxk0JzQbEJhSiaIK5njkUSWjJrxbYoLcxyfxa4REaIqF
         CaF4cBpl/9GYEHVro4lw57VQAIHBzzhz2qXSGH4NQSmwsjfbsgwMf1Xv3NcNBN9R6nnd
         La2bILKSFO8kEsYPyvIjFFmwd+Of5EsvnLE2EQ/0l2//OwSRpEvjLyrW+IHMTNJS9k/e
         GkXSOpvgirfUIuur43gYIBO/GWE/Y1MBRU3iMCdmyIraIDqvjATC2WAmNi8/nk90+LUk
         Jzfw==
X-Forwarded-Encrypted: i=1; AL+hErGIwu84L6fwxkAzNqbLggdX/SewXeqYxC6RHlvtHKxlR5Cs8+XNAa6dN8vGRnVczjbxI1atM3DunT/8jsj9@vger.kernel.org
X-Gm-Message-State: APuU4Z+uOkOLUNmC9oe7GIT79qaAZar4ttR0ltgUAyiJzNwa8TcA43lJ
	Wsut12LZgIUol4+U5KbdbWizuj5UHOAlO+MEZ5w2MZmpKy2QvC7jEzeUrnoAeVGBJfSjL6zHH1R
	0MK97ZZzrHmj6CVqupNKD+1nx8El3eBp0kfAmwQ==
X-Received: from dlam10.prod.google.com ([2002:a05:701b:208a:b0:1b5:55a9:d18a])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:42d4:20b0:1b5:43d8:b82a with SMTP id a92af1059eb24-1b55689e7b7mr849071c88.9.1795124998470;
 Thu, 19 Nov 2026 13:49:58 -0800 (PST)
Date: Thu, 19 Nov 2026 13:49:44 -0800
In-Reply-To: <20261119214944.1480596-1-sarthakkukreti@google.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119214944.1480596-1-sarthakkukreti@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119214944.1480596-4-sarthakkukreti@google.com>
Subject: [PATCH v2 3/3] f2fs: reject casefolded names that fold to ".", "..",
 or empty
From: Sarthak Kukreti <sarthakkukreti@google.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, Eric Biggers <ebiggers@kernel.org>, 
	Dmitry Torokhov <dtor@google.com>, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Sarthak Kukreti <sarthakkukreti@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Dmitry Torokhov <dtor@google.com>

Filenames consisting only of ignorable Unicode characters fold to empty
strings, and names with leading dots and ignorable characters can fold
to "." or "..". Allowing such names in casefolded directories can corrupt
directory structure or cause confusion with special entries.

Reject any non-dot names that fold to empty, ".", or ".." during
casefolded name setup, while still allowing invalid UTF-8 sequences to
be handled as opaque byte sequences when strict mode is not enabled.

Fixes: 2c2eb7a300cd ("f2fs: Support case-insensitive file name lookups")
Signed-off-by: Dmitry Torokhov <dtor@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 fs/f2fs/dir.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 97f7fef6b068..f1d40f818b35 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -77,13 +77,17 @@ int f2fs_init_casefolded_name(const struct inode *dir,
 
 		len = utf8_casefold(sb->s_encoding, fname->usr_fname,
 				    buf, F2FS_NAME_LEN);
-		if (len <= 0) {
+		if (len < 0) {
 			kmem_cache_free(f2fs_cf_name_slab, buf);
 			if (sb_has_strict_encoding(sb))
 				return -EINVAL;
 			/* fall back to treating name as opaque byte sequence */
 			return 0;
 		}
+		if (len == 0 || name_is_dot_dotdot(buf, len)) {
+			kmem_cache_free(f2fs_cf_name_slab, buf);
+			return -EINVAL;
+		}
 		fname->cf_name.name = buf;
 		fname->cf_name.len = len;
 	}
-- 
2.56.1.750.gf70dc682cf-goog

