Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793461466;
	b=pxx9WW4B0+CjDKG2/mb7BxWfKF+Qu6fjBwGuJfDhkU+Ii4z01sSkVs3Ps0oUEvOyWeRo
	 BF9CBXY1C7b9EUFn6ABu70pDowoSphpkwGffMyPAT6CuvbZXPvEancM27Apudhjpt1L12
	 p4fKnWgC+9R97oMIMiSb60NtRxZxaczeg6kTq0TfkE+aLI2e7S+IvyZ8NQbtXVhitf1J7
	 jjEx/GUKLs93uE2UhDtPJyDcBtqOBggKRSHk5qGFBdd6GgbnZQFK8mtol1D0jP8auGdC0
	 cxW7DEidscgFQMNLAbH0GJpb1W1DlDnWflFD3lOgT4LJVKsF0U+xsh/yaqbz+kjpIEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=56Jp62HZwbl/bs25PK+pXtbwrUN07Joj+4AgiDDMgHU=;
	b=gueJU+HfSEqCRLPYJTKem1/HNGmBIEMAvfF0prWqgSzelxn+bNzQSegKQBV4vUrCPbEa
	 X/FWBlXKF4y61jIEktlOvnkPPsIC0oaC0Z0CawHygmEsuHr4nwaFeZcqt7y22FFebonCy
	 Px3GlpIR/38E+ayc5QFByxOD4Mmpru0RZO2H1pBT0Q00Hb5y9Q4O7Zs1uWjfMu5PlskGw
	 2v4zBIA+DdxUb9leXAdqLJ/oH2JZUKNwcLd15nWXTRt8xDaZHxKYOfGzPiYHMDY8EsYLc
	 bDdr7Gqg2kkNMHblD6P3yXEKnm1J+h8JqD/YKqj+UEu1tu50Sb/lytAGRdobNOgQc0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JlB8oX09;
	arc=none smtp.remote-ip=209.85.221.174
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B7606A31E
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 15:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C11B7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JlB8oX09
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so586153e0c.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793461465; x=1794066265; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=56Jp62HZwbl/bs25PK+pXtbwrUN07Joj+4AgiDDMgHU=;
        b=JlB8oX09+gQ0HkWyOkRuAVVACNCbNqN1h+iW6a9AR/dEqjdMo4CpJs8/c2wMjxEcmv
         MVcQKdECqWy09zVNJNVw/UL9n1lOVxoHChZpXhuTB6ZDt+SUF8IvdzZpIHCGMMmsNuZL
         hlYpdSKkXWy1qm3KlZVVkcJnPmlPvT01IJLy2jTGirQ8vpIpuhHJFJ8MpQ6i+EflmXCF
         ME3BqoyVJbaCtHOl0fcKRIeg0dRQcez2+u2d/SYj3ZScC83t7rsGS6trFbjevxA+by3m
         9X/NYcjXd6PGxwf8MC/yn7ntF16SjRfeE7rj6JvFUf864Rfr3N6PTQMROVum8IE08lzR
         9bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793461465; x=1794066265;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=56Jp62HZwbl/bs25PK+pXtbwrUN07Joj+4AgiDDMgHU=;
        b=dg4JAdRa1y2iBu4+5CEphLNYHgESHIZOy96JdDLb0tZQS1DvV78aevahCNYgDwSfKv
         AefQjQMyMVzYGAmxYYlfpvaPiuf3KXawwoNZCfXzPI+jg4yk6D5MT3Fx8AJQ4QCNUtHm
         Ku5O4ORmZRfXbrGN7i6fT8fWvwkJk0MJ+JsZTMNSZhLMSwUBJl0dSeOBUwzGJnWDJ8wf
         Z5GCOnzJsNfOX3xO/nSFFhAu3i5zMb/rbeoKfnJcFo3DUfzzcM6cgtwHWAPBqWFD1Vef
         CIdZ878t/sVkHKTn4UjpdHbWMwhkffyet7YKUfvfa1r6mCD0Cgl5b4BwmbNnED8cFf3m
         eMGg==
X-Forwarded-Encrypted: i=1; AKwUvByRundD4jc/wbz9jmlrZxIae3cHwde/Wno3RFXq1yJyu0eTUTjknVq4RMK/Xu4ki0pE31tNxdC6c7/hQEHQ@vger.kernel.org
X-Gm-Message-State: AFq9FYKPoLywdIuNFxTbqF3W/GaQfoTeIPi/mQQuXznqsifykNrv78jz
	sPX4R5RmPdYLMfJtyCeLKFBfTpdI2Y79aiGGtSU453W4CtGi7Q6ULB85
X-Gm-Gg: AYBFou2UDncY/2dzlFt/RWIlXXU14EoJanjkV5060/Qy1nHtdP6/A8cxhxtGZ/Rwllm
	AcXzfuqQaX0PSQidZ4/FgTaEikmPZp35CB9HroPDjUJ1rrdduIqvJ1BdfsVM2Kg2vWaSE21FrKW
	R63cY9tDBhrLvRdi14mptmnD0kFHr13AGm/dnLFUO0l33WfSRcRdZS8g0bWioJtXSf311+clGUY
	6SgF3nQQSn+wiOFr137f0pe31X6SaNykzSyCeicgsr7KkHs7MAJWbKoTQ4LCapxroOq9/WU3U/f
	r1VUUuTyI3u1h63eDXloUfEYNvR35PmVkhjj4fkAli5V7dvW5AIicr744K6KNQr0EqdZ2Yh2jou
	7co84qijYrtvwumao6MljG9uMYwcAboWpz1XF6UXCzJlNi/wf92QSu/YL1O/XU9VkB9OS+xUK+h
	vc7BJvzPaQ84oJ1NaVvRT4i9rK98JOiHr49Wl3oOBYJJDWO/yiONdHNyNZcyY6A6NmKPsuK2AH+
	472JkkJNTualvkhplqF1caJ4+kMcSS0ae3NIMxSX49DTlZWRjXlyQDtB22W5k7YTb0bzAmI6PzS
	QxC+63K8OBaIgqXgFqBcjkRELbUIYsCaPJvSTGFnyf4MJiJu552rQfhx1o2JuzmwXN/Fy2Din55
	E8eiAzLAgIQTELvB3oVSZhuu7zvN0x3fyWvtrVatqbR0Djf+6F530dlxJ+sDS3jXkZtdy8yOplG
	OWrMZGC7yatnhQqBQ=
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id ada2fe7eead31-7d072baa484mr2303904137.9.1793461464434;
        Sat, 31 Oct 2026 08:44:24 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2804:7f0:b101:c5e8:f804:4efd:32bc:71d3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d077606b7asm5730837137.8.2026.10.31.08.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:44:24 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, John Groves <john@groves.net>,
 fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: refuse FUSE_NOTIFY_STORE for DAX inodes
Date: Sat, 31 Oct 2026 12:44:19 -0300
Message-ID: <179346145958.61208.701521796030924197@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Since commit 2fbe4586cff3 ("fuse: add support for opening dax device as
backing"), a regular file is marked S_DAX whenever the server sets
FUSE_ATTR_DAX in the attributes. This does not depend on any INIT flag,
so any FUSE server can do it, including an unprivileged one.

fuse_notify_store() does not check for this. It adds ordinary page cache
folios to the mapping of such an inode with filemap_grab_folio(), while
the DAX code expects that mapping to hold only DAX entries. When the
inode is evicted, fuse_evict_inode() calls dax_break_layout_final(), and
dax_layout_busy_page_range() hits WARN_ON_ONCE(!xa_is_value(entry)):

  WARNING: fs/dax.c:825 at dax_layout_busy_page_range+0x394/0x4dc
  CPU: 0 UID: 65534 PID: 93 Comm: fusedax
  Call trace:
   dax_layout_busy_page_range+0x394/0x4dc (P)
   dax_break_layout_final+0x104/0x278
   fuse_evict_inode+0x2cc/0x57c
   evict+0x2b4/0x748
   iput.part.0+0x51c/0x964
   ...
   fuse_kill_sb_anon+0x170/0x268
   deactivate_locked_super+0x98/0x11c

With panic_on_warn set, this lets an unprivileged FUSE server panic the
machine.

DAX mappings do not hold page cache folios, so storing data into one has
no use. Return -EINVAL, as is already done for files that are not
regular. This also covers virtiofs DAX inodes.

Reproduced on current mainline (arm64, CONFIG_FS_DAX=y) with a FUSE
server running as uid 65534 in a new user and mount namespace, answering
INIT with no flags, LOOKUP with FUSE_ATTR_DAX on a regular file, then
sending FUSE_NOTIFY_STORE for it and unmounting. Before: the WARN above,
and a panic with panic_on_warn=1. After: FUSE_NOTIFY_STORE fails with
EINVAL and nothing is logged. FUSE_NOTIFY_STORE on a regular inode
without FUSE_ATTR_DAX still works.

Found by code review of the DAX backing changes and confirmed with the
reproducer above.

Fixes: 2fbe4586cff3 ("fuse: add support for opening dax device as backing")
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
Tool-use note: the code review that found this and the reproducer were
prepared with help from an LLM-based assistant; I reviewed the change
and built and ran the tests myself. Reproducer available on request.

 fs/fuse/notify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/fuse/notify.c b/fs/fuse/notify.c
index 984e4945e..938440474 100644
--- a/fs/fuse/notify.c
+++ b/fs/fuse/notify.c
@@ -167,6 +167,11 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		err = -EINVAL;
 		goto out_iput;
 	}
+	/* DAX mappings do not hold page cache folios */
+	if (IS_DAX(inode)) {
+		err = -EINVAL;
+		goto out_iput;
+	}
 
 	mapping = inode->i_mapping;
 	file_size = i_size_read(inode);
-- 
2.43.0

