Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FE5348458
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711931; cv=none; b=bbeV7A5NkeOY9RVritF9P6Ts+R7ADF5BawAJmw00xOKZaBahYJqnAxvT//9FBFeewq/f3vMVdWl66daCLKYkhvfGfm8PW3fdv8BUF3EXoqcsxwYrKfY8n0krZhHdwwoVFmMkvMVkjjzB1DsR6RCQ6YRhERGRSXUjVwNf5BjzEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711931; c=relaxed/simple;
	bh=jKFU9ClukmgrQPWCuZbiDz6loGcaVsfq+0devSW3yqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEjK9k4DWdIx6C53VLgk1K7y4JJEK3QKa8PoXIdUhEp0x31SeSW++/L5+WvOfqERYxyvI/DwkivVzLpS3szoYh2hnP41ANYsK1LqchntKotX84YLqNDUeRn/4ukcXlll4ScXw0Pj2qPZ2pIy310ucDLv6XKVRx40IvF+AW/IFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxgofVFi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxgofVFi"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b9f43a1feso1207385f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 08:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774711928; x=1775316728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSDysc2SqFR5k0dxgouFFuDk3xltDf+gaI9kO7u+6DU=;
        b=dxgofVFikwbbfUGmAV2oys2keYy5+lYHw64IgnkA0JppqOiS73WB9MYU36St/kR9N8
         EjLUljLEry11sj1yQJ6K/bxyeVpuWesbNMsh4oGyZlwFla9C2GQ0cVtDZQI3EOO4xblu
         JMRgCA7tz6EGEgXtOlWJ52PByzofecrhQMCOvr33wv+LB5zfIQJLRsFAQN1L0AlWTDj+
         SQ8SbJaDYMSTC+ZlBiv0tlQJIQqTInWk0oH6epFOj2NEqmyRk4TcY6oj2w6aHXZK/68N
         TgiV+bmwNUPXhPNK2mkVj+G+6FtgoJbiAYzMkkSDTGZQ5JCPpaT8JI7KijF4QVcbPmR9
         Hagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711928; x=1775316728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VSDysc2SqFR5k0dxgouFFuDk3xltDf+gaI9kO7u+6DU=;
        b=r6cHn69Sm40kKLiCyhF+wZgabVzkmgvsVWTo+G05cAg2Lk+zayKoZdnVDzuh7Yo94C
         dXmC4+T4JN5na4eQMDu3WDBtnS2Z8PzPEpiWEB80k4rb3OQ3J85RJtD6tUvXLQFLrts1
         mbq2+OrwNmgqeLvTIUgNXZ21O6bUNK8wSDEiGgfR+xEovvFlZSJzawyZBVPYNdTqwJlN
         qvz9lLJTNtGKiK7HRORUp8e+KCMqMdy22c94wt9hNhh65IcatN9fWT11ORrXqLaCoIzu
         SMoDnFAGQk2c8g45I9AO1G0Sgr+mw4vRtxsEJCY5M36PSKVV6bMpsk3onV49Kr9Srz5p
         Mhog==
X-Forwarded-Encrypted: i=1; AJvYcCUTvfhwU6wdGnsKHcXmnDy7pr9t2+qLSBpi5TYPMu4FsLIk2kr+jSdHw1oCf2nmvo9cyULkregrkCBphyWr@vger.kernel.org
X-Gm-Message-State: AOJu0YyIHji8xPNoUx2IhJjMZ2Pfs+xx7Ud1RrtlCZLb2hbKJ745j5kl
	ZY0969T0S1OugzveUmwWZuurq6WXfEnzufZSZoW3iGxKjvVXh01csp1v
X-Gm-Gg: ATEYQzww1ZB+CfxaQlpbVu6iUzPSxOHgaRkiEVpH34VfHV0tFzETQQ+7Ppi/+f5g0Cq
	ozyhudAMi7gkvatX0ZYio/NsIv8I1EtWCoDk3V9YpTtywRXOXOHATf6+dDaVvbrC0ELKUG7mhuT
	nyAvEQs4GEsBznndBSY0TeHmk49S1AlPEB5p27TwOHDu3l5ZhX5hf945huhQcIDLDThodJ4c/rp
	5AbSflakzP41DihcnBptorF/XYptmvI9Pacra/7CTG5EXu2l5NudDPsV3luU/vOBjM4nnHHWfDp
	9VdM8LkXsI18HqZ/y3hzcS2VdWoiCuej6bKzPGPqPArYKadr74gjooFA3yH84pKcVa7eGhPIanH
	bXRuqCqu2Pa7048MsAtDCpKHVM4SaK7UKRyFy4DvvQDwxHsD0v7Bc5WFzKx3rH/tXUuPCIlW521
	JoHPvCL2EWiR08+JW4Xqa48NDOBBO6iY4urBqq6WWbelO66attQAgFxy8xob+IfHeppFlCbAntl
	w==
X-Received: by 2002:a05:6000:40dd:b0:439:b8b2:fad0 with SMTP id ffacd0b85a97d-43b9e9da56amr10027000f8f.5.1774711928055;
        Sat, 28 Mar 2026 08:32:08 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm6725310f8f.24.2026.03.28.08.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:32:07 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 4/5] fs: handle hypothetical filesystems hich use I_DONTCACHE and drop the lock in ->drop_inode
Date: Sat, 28 Mar 2026 16:31:45 +0100
Message-ID: <20260328153146.3368470-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328153146.3368470-1-mjguzik@gmail.com>
References: <20260328153146.3368470-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs and ntfs play games where they transitiong the refcount 0->1 and release
the inode spinlock, allowing other threads to grab a ref of their own.
They also return 0 in that case, making this problem harmless.

Should they start using the I_DONTCACHE machinery down the road while
retaining the above, iput_final() will get a race where it can proceed
to teardown an inode with references.

Future-proof it.

Developing better ->drop_inode and sanitizing all users is left as en
exercise for the reader.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1f5a383ccf27..fc6045e6d43f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1933,20 +1933,29 @@ static void iput_final(struct inode *inode)
 	else
 		drop = inode_generic_drop(inode);
 
-	if (!drop &&
-	    !(inode_state_read(inode) & I_DONTCACHE) &&
-	    (sb->s_flags & SB_ACTIVE)) {
+	/*
+	 * XXXCRAP: there are ->drop_inode hooks playing nasty games releasing the
+	 * spinlock and temporarily grabbing refs. This opens a possibility someone
+	 * else will sneak in and grab a ref while it happens.
+	 *
+	 * If such a hook returns 0 (== don't drop) this happens to be harmless as long
+	 * as the inode is not marked with I_DONTCACHE. Otherwise we are proceeding with
+	 * teardown despite references being present.
+	 *
+	 * Damage-control the problem by including the count in the decision. However,
+	 * assert no refs showed up if the hook decided to drop the inode.
+	 */
+	if (drop)
+		VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
+
+	if (icount_read(inode) > 0 ||
+	    (!drop && !(inode_state_read(inode) & I_DONTCACHE) &&
+	    (sb->s_flags & SB_ACTIVE))) {
 		__inode_lru_list_add(inode, true);
 		spin_unlock(&inode->i_lock);
 		return;
 	}
 
-	/*
-	 * Re-check ->i_count in case the ->drop_inode() hooks played games.
-	 * Note we only execute this if the verdict was to drop the inode.
-	 */
-	VFS_BUG_ON_INODE(icount_read(inode) != 0, inode);
-
 	if (drop) {
 		inode_state_set(inode, I_FREEING);
 	} else {
-- 
2.48.1

