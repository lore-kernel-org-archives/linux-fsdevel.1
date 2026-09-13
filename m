Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA442FD7B1
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311000; cv=none; b=N9N1D2FylY+QRauxG7/X3lg2t0fkDpxirKD0DTTeHOAVPJIjjSMHuWa6wZqVXTRK61662ITFI3Vhzjs1pygNvAuEytXQ9QBZaqcT04XGUnLjRwk1ViS781+jfC07ezrO3ELcyyzl+8AAGphyO0C6nJl6WbDAbO5FDlp62dPIf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311000; c=relaxed/simple;
	bh=u8esOdOTfFzVCI5F3C0EbDh+10B+rPHpIkrnx3VBn7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Br+J6tktEslOeG6VrAuBh3dn0G4dVkqK5Oan1s+LLZ1Guy/2hEPYvRPTLsEDEXab/wBkQyLxh5uLhqwlpke3bC7AVCDXQZ9dF0300EYUQP/7vGF8GVunD/78AP9lZJW4iztzfiCb3k7aanerXrytZi/54lmeLO4t1iTw7fxPvhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2Rg4rnc; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2Rg4rnc"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso10562745e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789310994; x=1789915794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9jwIeBJauvU7aEOo2TsAcRg29a4SIp+GcLjXkxP9CcM=;
        b=l2Rg4rnc9ynki09cRof5KOW5MpHUgwaurdfXxjEaf590/iKfXH1K7dx2enZFxdaFIC
         NgYYSeD9ztQvLGb7GM5F+UfcLWO3CX+fpNbyLSZUtFVCpDMxaX3jhWEMzKd2TamFjAPc
         ubscxUycfgG+vuSEBQaBLD2C/vZtJS8bA/K8C/ln9ENaClBs8WxqTLM/lASyNny8lHg2
         bClzwkDkQL+eVZidk8XAoSATU+YqIzw91LZI3E74o1mqFVy6ZkOURtt4Ssd9IrpVYOkK
         XzTkBzWSz9oRgYhNU6TOnuoObRDyaEJZi4iLBpoeyXETwPOhkgA/MozlOmO4EUFRzK+v
         SYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789310994; x=1789915794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9jwIeBJauvU7aEOo2TsAcRg29a4SIp+GcLjXkxP9CcM=;
        b=Y7I3N6U7N4+G8MdiCxTdFkEjdza2A0ZWVmezbzJ0/u9ZZK6ddebRG6w5UBFR+uRUaU
         AbrJlQp/0jmwUu27ucAzuBlNLORkfJsU6xjIRa0DdGI7m4D4yDKsmv+3r9/z16NRLukx
         QwMmepI9Cp9B+3XzFCshM8MFNTrMTQPJr1n5K1pu4ovGf/GPHk+k+Hp/1Jj/qq174985
         KpmGD1Qj/dELwFzdKbTpZYyKK9SzonchIuYYVLSvkelRNQm+IcWFLLxbqn6NIa7uBkmD
         Kwau6lAMforr9Cz+cYqPAmUy8j2+Qi3Im7pFX+zBed0+1F8cl5491aGlv2lNaPlaOcZU
         cl8g==
X-Forwarded-Encrypted: i=1; AKwUvBxds4ngxXOV4aI4+GqarqIiJunLXds5OC6tpR3gdD4Chb78u64o5+Tb3+U6o8zZtZeMCiF0K4e8X+O7uc1g@vger.kernel.org
X-Gm-Message-State: AFuF++nAg8PgzQ8mnjN8OzmXU1bSU3B+XmkZ2OJYzPqb84uMAujASMsV
	0C9mQWPXTfT+SOJ9Z6d7r3tTW+sEc6txT0RvV9lhVCD9YBvfCwegaP82
X-Gm-Gg: AYBFou2zDICF/T83dkINwScslj7G5nXugLeh3sqDTYmCKU4WKSeX1QwKoCkV3TQIzhv
	ty1Trz0baMMVVb1/zLu8ioCG/1+5RlNP8fY5YtKgGlV6fHzGMF6d5K43FrqAQVolT4pCuhMi9dt
	HjhlDyjHkFa6Q9eCxZ/rCSkEwn3oIfBnK/op1+RYNkqaN9HhXYF+mwgIwY/9Sjt7u7vdMCrTDlI
	cIzUjgC5LZ/iohtqRpNb8KfuqZkGD0Rw98o6BEQdWEtyDHGxP9cWgSFWNtzrHps1xp7IXwG/PBu
	wiDF1s9fDxxM89HZrBjCoZS/qyi+HDqEYwCH/++KxIGC98/ZqYPStZ3HhZj6UU7GgyCsCEWL2Wp
	XH7ctUFPM0wvmGaM7iQgOOT2ydTbIGF2XpMKJKupSkNaSV1XORF/w8YltyP/baVaI+bdObNOfR2
	x7GAVTqT2AufLXeuzJHYBp1D37HslzKPJBe/MXffno0N+m8mLqUzGasbVQs+mxfedS0smt8WtSr
	d2z/kyXrykxuYfw5k6cKXEa9emTDq3YRSl1GUSebtk=
X-Received: by 2002:a05:600c:3491:b0:49c:cee0:f383 with SMTP id 5b1f17b1804b1-49e6cbfc8c1mr64395435e9.16.1789310993998;
        Sun, 13 Sep 2026 07:49:53 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:49:53 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 03/10] fs: use path_clone() in path_init()
Date: Sun, 13 Sep 2026 16:49:10 +0200
Message-ID: <20260913144918.1606123-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913144918.1606123-1-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c8754c7ba8be..11937cfa8c7f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2745,13 +2745,13 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		struct inode *inode = root->d_inode;
 		if (*s && unlikely(!d_can_lookup(root)))
 			return ERR_PTR(-ENOTDIR);
-		nd->path = nd->root;
 		nd->inode = inode;
 		if (flags & LOOKUP_RCU) {
+			nd->path = nd->root;
 			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
 			nd->root_seq = nd->seq;
 		} else {
-			path_get(&nd->path);
+			path_clone(&nd->root, &nd->path);
 		}
 		return s;
 	}
@@ -2801,23 +2801,23 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		if (*s && unlikely(!d_can_lookup(dentry)))
 			return ERR_PTR(-ENOTDIR);
 
-		nd->path = fd_file(f)->f_path;
 		if (flags & LOOKUP_RCU) {
+			nd->path = fd_file(f)->f_path;
 			nd->inode = nd->path.dentry->d_inode;
 			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
 		} else {
-			path_get(&nd->path);
+			path_clone(&fd_file(f)->f_path, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
 	}
 
 	/* For scoped-lookups we need to set the root to the dirfd as well. */
 	if (unlikely(flags & LOOKUP_IS_SCOPED)) {
-		nd->root = nd->path;
 		if (flags & LOOKUP_RCU) {
+			nd->root = nd->path;
 			nd->root_seq = nd->seq;
 		} else {
-			path_get(&nd->root);
+			path_clone(&nd->path, &nd->root);
 			nd->state |= ND_ROOT_GRABBED;
 		}
 	}
-- 
2.53.0

