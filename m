Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236174;
	b=Sw2IQm8oAUcFXJ2PJa/zDSdn70TQlIdPvMRQcYf8wCDliINHReQxWAiXhqU7MpkNYgeQ
	 zZiilX2aubrvluuDUrB+tWAp6xucCcbQhgkhlP+jtB/cuZHBxKb5WT2fRBqm4OqNjvylJ
	 jWNVzwwTdiKGVD5ZsuMsxz8tqpRjMQwTTpJ8eu/mio1F5MuQVGcgXRBCoU63f8h+wTjl6
	 XTl5N0s9tN9nvBgQk8e+vz8Z2u6PZJif/bGy+TBgpVT2qF6Dmx//EexbEU75VKajCuIey
	 3p4+pjB3isqMIn+c74kRhU2UnBHn5Yx7cqCKul4V4DblSwn1+W+xTmd37C3ggeh1qkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gFCERTgb72WMlkM+VHwKAwEohFgnnSyuqaJzdLu0lwQ=;
	b=yE9sPZUeqzCc2NoPgQl3BJsjYA+Ysw1VLKaRqqcjC+AG4lvuM/fZH1xzIqVOPhkwSvi6
	 ssxQG9g5n2Gr9ov9PROhEnNkmUBIP67xz1qygGI/odh9cl8JoKauCxuzmfBqyD+upWAA7
	 jI0/yT3PBhHgImLNs8b+pYJxXUi52WtKXdOZCH33nkzBUF9b+251SzCZ0IEtfffWbFAMz
	 XtXkPn3MsnP2S1EoemumSFBsczUA+h7RGjkSHIwAOSqo6GGXbbWues7TqCfnNtQXgj6G+
	 bDDeRHanzVrnNAXEQ5kvvCu5MPGUUm8CKTkWHkad8nLGxvP7WMr1OtQ8nEvP/69A0cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kft7WEya;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433FD60A2605
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 433FD60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=kft7WEya
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f2f2edb19so139380385a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793236173; x=1793840973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gFCERTgb72WMlkM+VHwKAwEohFgnnSyuqaJzdLu0lwQ=;
        b=kft7WEyal6Mtxw+py+3vE2ga2X7efSjbN82dpR6rYuxiWISRg7jlrDj4zu2Km2aJkm
         wUhXSepEUX5xOhs1zLoqx0hQFYT62gKMKeGxiDTNrIBXF42uFk6F/SY4da6vtMNMg+VX
         zsnlx0oGDAmO0sgGAP+1KdvbrjNsWsemGGs16hg4WYGR7L/w/dlaclKV93GPTmUtFWEZ
         +hqe6GiIAOvxAYCdpule9LELf0KNPqh7KTp+L8mxUOi409x+4S5Fg+6FW8iGIdEo+JB/
         gIjBgIAEWI8lOpJHyOEWRp6uA7HIfiFeQED21Rl9Mo29P2C1IOvrSt8OROkNlJxc9YT+
         b91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236173; x=1793840973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gFCERTgb72WMlkM+VHwKAwEohFgnnSyuqaJzdLu0lwQ=;
        b=HJfRZiovS2CoCB5RM21k0mnkg/EdCH9DuO+e4lqYnkWfXq5chTKsxVnv+JBfzh+6Fi
         /89reTK9gU7ySL5ff1JHGzILFsUFr8x0CPrIWL4DLTRHTU0csi5qU9BgGXQnt90y6ngv
         eZXguu1++m0TUDPeMhbzNt6m1a0PUidMRg5nII9rAxAHq2ipCOegpK+VMfx7j1tAFvY8
         VUeEovTyWQGkJrUSqko2xR5W9Bldl+14EnVkCFg5YGyGIGDteF2phKDh4JGolCj1sFZ3
         YJ8bx98cQzoWmMtcnza9wiimlMREcqdUVHPylgeANq6erX+QRhs54bYPeZgaqK09yhdA
         nwyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzuWhVhs0NQXa9JDm/KynL7Gk0639uz/u+/34TBkku3/nj9M4MiKjouaRZ8hFTZ73ZwF0Rt7b+E9G7kC1K1@vger.kernel.org
X-Gm-Message-State: AFq9FYLNMWPndboTy7PNUX5Ia40/5U1Du7MiEDuGjTycZcWqUU3K6mPE
	GpLgAWMedCre776xxTAVOExzmSPWw/adxfX3wAG62r7Z+dqvsA/viW37zPv0cpRLJFc=
X-Gm-Gg: AYBFou1qxpCCnzwKLuXu4gWHGaY0efOP2r3KGy7xY1m38nUeZvTVhslQ7IiJLhrqjNR
	KyuhVsN39PR/BpYxGa97YwBxhsMqWqlbacn9kWj5hl6vJkGHAUTH8YS8X98x/loxOle9kqp6m8A
	uFN4DwoZywKZG5lWHa+9xtviGSNqs4lyTHiLHySRC+GQ6BEpV0p8ktNpMIPfEzawln8Rb0geJrg
	iKhEFNwFDHxj2xiuiC7ghCAIMpU+R3Vxtd9DUX7r8E/+MPrdIhv5X8IURlKHfD8AIeXyNrwcYYa
	J8AS+bf7nKwZiDneI+nJXCFh6+KWlo5SVx/7ox+iHTyF6pQr0JcqkuLVIHRzbfnFA9JQmRT6Wgw
	Ps/gtqStxdXOMhgU6i7AjpEKh8/00qvkZxfPi1T6+9WrHeeG2sC6MAyLxbB2TWgAOwanXOUu6V/
	BS86nS3GZ7YVqa4bgFbEWoQeXtK+FDocJIUboiOeFwmHK6BEIRsJtSSTLpJy2BY4GyP3suzBJQF
	biJZkFOwTyuGdLLK5qnA8xHXadpef/6tDGM4cx3nKID6Pbe896PLiLqRF7S+P3O5vjKmlhm0wX2
	4WqTkL0Bqs78yUYyv5d3SohTI8o3VNHiCjXXVdR5umAGEA==
X-Received: by 2002:a05:620a:4008:b0:93c:6534:d04d with SMTP id af79cd13be357-94408c94a0dmr645547085a.35.1793236173151;
        Wed, 28 Oct 2026 18:09:33 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0669a0fsm1395885185a.8.2026.10.28.18.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:09:32 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 01:09:16 +0000
Subject: [PATCH v2 02/10] ovl: make the root inode appear hashed
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-ovl-containerized-sync-v2-2-4e9f08e4a052@toxicpanda.com>
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
In-Reply-To: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793236165; l=1088;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cstaBtDiRM3QOK1D9GwdkdQtwlI5aVSq+4eziFPxk50=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJHbrHkdY+awlgNdib/Omm+yfXK352B7NAqbwS7F/Xv1OBqEJSniNq3g9BuokhMUHW0pb/B+ByL
 ghELlNiv/twk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__mark_inode_dirty() does not put an unhashed inode on a dirty list, and
the root inode of an overlay is never hashed.  Use inode_fake_hash() on it,
so that the following patches can track it like any other overlay inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index ce3e30235ae9..f0ca1539022d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1366,6 +1366,11 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
+	/*
+	 * Nobody looks the root up by its hash, but __mark_inode_dirty() only
+	 * puts hashed inodes on a dirty list.
+	 */
+	inode_fake_hash(d_inode(root));
 	WARN_ON(!!IS_CASEFOLDED(d_inode(root)) != ofs->casefold);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);
 	/* root keeps a reference of upperdentry */

-- 
2.55.0

