Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601249;
	b=aa8qb5CiJz4uS+GRuM0b9dWpTKIx34lMV+5hQuM6Kf+EISqX5PZlurfLMbHaIplwb/Yp
	 hei1scuPAjkBx2ZvQcnYD7PuijevOqzZAsMuyiysWpcrd2bkQPD4cSldAaoSLIQ3ZqIq9
	 cf/AVsD+PsX1Pq3s4W+zsyeVL6MKvFqtEuH4uCTQ1nShi/M5wKMa2jADy8mtabcwU8K4A
	 GYJaBza5ibNluoh2q8aOOTn/RbHsDuOqV11hqtcWY6UFNNq5ZXS7R8jeBlnT6KA1qhjhd
	 dxt3BiGNDRWx0U9se+PJPrwg5qhpmEvaC6twkCz/9xDxMN0bWU5DD2TJ6CPO7jTWWRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3ucwLQhUyHOpZ1AVuMoK9glRySug+tMEaFSniJcEzLw=;
	b=hz4SRAw6FlzgTSMFO5axg/PciVs+pOBiMuDr+0G1ZkwQo2K0RSD+5iyUWbuIdQ7EydmG
	 IR4ybxe5WvMY9SYHVWdRylEU7qFysqZA1K+ceWTx/xcjDTf2yqr6nZLGK2mB+JEl9U8Mz
	 lqohtPHsMKyzF6wjGA8Q+jpj5D37TbUsHNiPHjjRT/dbiJKSAiYuoLwtovGWlvLk3dQ5W
	 VKhVID8OhuKhI/dgsqnWmUK/BbGpQaAtljQtBif7XFgQkV60fTAJ2/Suf48U2JP7F8g6H
	 GK95rIVgijzJnizJvuAy37XBavugQED5sBrUR0t1xC1xscCSzEc8bjyl4WthdJxIpmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=n3ziWuxj;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BB9606A338
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 16:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26BB9606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=n3ziWuxj
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5361e313e63so9746781cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792601248; x=1793206048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ucwLQhUyHOpZ1AVuMoK9glRySug+tMEaFSniJcEzLw=;
        b=n3ziWuxjEYP3TkMRp+InA6lKnwVvotdjMQ755v3pqoaWVOIlqBPjwtOAMHJo2MAlyX
         rBNdc1/b5e2NssFIvDFxXhGMAwy123+ePZZi9j1KdvDO2fvIahuOoFelmHKqLridkXbl
         yxCcxROpm6voZj0HRuMohD0P+yTGYukPfwA3B31oJi+yeB2L6r5fuBhjsTF9b3+Q5PGk
         3uvBhqd9FDcvgKcfM8FpX09GH4eZ+udeISLjT+0gTzpETbhwsAzhxo94RP7E8BaUlFlv
         5RAv+s/vWCMGIniF16p3C+U320f/2v4k2yP0RdF2cHdO4CniAhWMiu0CUfaPcaCASSLZ
         QN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601248; x=1793206048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3ucwLQhUyHOpZ1AVuMoK9glRySug+tMEaFSniJcEzLw=;
        b=DTlzfjSHFVWb1hIEid7B2e+RsXmMACgabcNacwWxeJL11xnlUkncGFqWE9tGsNrjvU
         oAOYAwMf47Ww51T8PRl+8MUg+uECs/MLC3AfRLNHH/oRTndEfan1/CE60Wkq/EpiUqJe
         nKPrzTcJ86DMiQSn0G3KJLjnR8VVrg6nfus6N53aHaBNTFKk350BWZEP9EQ3csDXHTC7
         LYEb3Y4w7b3cBFZ5ninLAm25w4TSbM0+0F6zBiwT2cFA+8Uz3obUBdOt8urokKNBOr67
         lm0flM8YJ9hXMAin7BA2rApndaaRuQVnJkHcTummhdHD6UIzn1UrOtJqF8WaPP3pq1w+
         4DXg==
X-Gm-Message-State: AFq9FYIkaumuoFolxg+FYi0Q2j8jEFwAuVIuORr6Ij+HJpF/mq+1me/c
	5S5BXOBB2olKC/QI2OtO4x4B/+1c/lj0L2qy+uX24m9ErxYeh4JMHJWOPY0tMgwIIMw=
X-Gm-Gg: AYBFou35nHLrpecNRBVSsyLOVlO4hSf/agp2GMbZk667GDk42Co8fYVyrCdmfVpahhO
	oqiU+kSs0XsZ0YNxQuTdr6R3g1Ab5hpgco+4MdYjrp8bBrtFu7b8/qVjXscumU9EAGjxONVAJGM
	1A9E6odOZTvf3neEmO2ganeFbupCMeKf3u2mQ/cCUgJUXIitYa/sG/bxatOQx3eZGJ2LxpLmhvz
	4/ZM2Z7jXdRvAe7/XvX2QploKOTqbQvfvlVGZ5Oe/EHs4WzF9hrvZ5RLFqTyC635sxtYZF6VUZQ
	4JBgGSjeht30Q6iQY1Dupy4gqQdbgDrcJzfJDbZANayK1excp75AQinEQ7fYjvZj0nuw1gNU59l
	BdErkhEFlVtzpwf0bj/u1EmeD+u5A0JZmHwYK5E/mPQhchbARNJ1BHx+80uDPACvNCfc9HghDYr
	4IHCYhxjUVp+N9dlRKb0XQzt0gi40DadCz7FObbQWBl45Ox+lNvQ3Gag5lGA9h3rAT0URUpTDrK
	/WuqYpJt6LI8CO4qIQymOZ+kaxDgCiV9SMFT1MNwdxnnRw/Qk/UADNbVLpKYkuUdPgy2kD3wg==
X-Received: by 2002:ac8:5c92:0:b0:535:7b01:1ac7 with SMTP id d75a77b69052e-5369b43e959mr42232871cf.6.1792601248051;
        Wed, 21 Oct 2026 09:47:28 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536ab7561f4sm3752791cf.18.2026.10.21.09.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:47:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 16:47:00 +0000
Subject: [PATCH 4/5] fs: don't make sync(2) wait for unborn superblocks
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
Message-Id: <20261021-b4-super-lock-unborn-v1-4-0265eddb6dee@toxicpanda.com>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792601235; l=2411;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=swc7nbC0Clpg1auAQ6b5oTcxsIkyJYst+76/QwVgwwA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAICuJi547O1zICszPsndzjv/aqsGPoZhxxJBZn2o9z3kq/Ikk4ou98662mWpu3VK2UwYRiVmvi
 hZhXTr0p06gw=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A mount which is stuck reading from its device or waiting for its server
hangs every sync(2) on the machine, and the emergency sync as well, and
they can't be killed.

A superblock is on the list sync(2) walks from sget_fc() on, but isn't
usable until vfs_get_tree() sets SB_BORN, and super_lock() waits for that
uninterruptibly.

There is nothing in that wait for them.  sync(2) is about what was written
before it was called, and nobody can have written to a filesystem which
isn't mounted yet.  What the filesystem writes on its own while it is being
mounted, replaying a journal say, is the mount's business: it has to get
that to disk whether or not anybody calls sync(2).

Add a flag for __iterate_supers() to skip superblocks without SB_BORN and
pass it from iterate_supers_sync().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index ecba64ed0c2a..b8d6f1c969ce 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1041,6 +1041,7 @@ enum super_iter_flags_t {
 	SUPER_ITER_UNLOCKED	= (1U << 1),
 	SUPER_ITER_REVERSE	= (1U << 2),
 	SUPER_ITER_WAIT_SHUTDOWN = (1U << 3),
+	SUPER_ITER_SKIP_UNBORN	= (1U << 4),
 };
 
 static inline struct super_block *first_super(enum super_iter_flags_t flags)
@@ -1073,6 +1074,10 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
 		if (super_flags(sb, SB_DYING))
 			continue;
 
+		if ((flags & SUPER_ITER_SKIP_UNBORN) &&
+		    !super_flags(sb, SB_BORN))
+			continue;
+
 		if (!refcount_inc_not_zero(&sb->s_passive))
 			continue;
 
@@ -1114,12 +1119,16 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
  * down writes it out.  Wait for that, so that it is on disk as well by the time
  * the walk is over.
  *
+ * A superblock which is still being set up isn't passed to @f either, and
+ * isn't waited for.  Nobody can have written to it yet.
+ *
  * Return: 0 if all the superblocks were seen, -ERESTARTSYS if the task was
  *         killed while it waited for one.
  */
 int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg)
 {
-	return __iterate_supers(f, arg, SUPER_ITER_WAIT_SHUTDOWN);
+	return __iterate_supers(f, arg, SUPER_ITER_WAIT_SHUTDOWN |
+					SUPER_ITER_SKIP_UNBORN);
 }
 
 /**

-- 
2.55.0

