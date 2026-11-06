Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972224;
	b=4OeAVBS91Sz96k3w1cVtnb6V0wBfEpUjU1861BNjc/wRpTkBbo/Y0dwmotfANGWPHLYc
	 iRSexNNu5f0NZq2ouCdEA/Q2LmPOiDT8q18HsiJtocKgVo3UjVOwIEnhq7XKRPRXtgYiR
	 HgslK16kWYgY/+Gv7Un5qvrrUspeGgBAI4RMPrQJRP9I1yq0OjPrVWcNJMDN0gNA5xsiX
	 wN/4Kgjiw474Kodx7c9ubZoSH1U9BjB5wscWLdw7ROen1z+I/4iZ7WqSAYHS8ZkbFhvaY
	 +dzW4bY1sSLM4QagwB7KCMUQRvJEg4XCyfQRc95To1FsjNoSawb24qxZiGM+byqru3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
	b=QfkgiAJF8aUhn/IDIN96rY5Fgg3xkRembWn+su1Lxb7FKU73ypfyGCr6CrvBJAo2WPwA
	 JWUV/cHNTokLtr6U7t+qh64suoMsjwvRrTtgo22EXI2nr2psK9JpYeUSlRpRSgi5hfHjF
	 eXkf4GLl1SqtgW4VsVWVQKAyY7nS6/9w672bFSARUj6z8ySIzJRWtxuwj3gRncwUbL96v
	 dMj1vKZhkrAxHvPrNVWRwLUJsO6Zz/6ed9WonUJdIK2i7u5YmvbP4QWEcw5CdLiH1wpbW
	 EC7gI2zDMV91jt3CfxqvAiF/Ak6ojUlngF8duQXBqzgNRETV+40diVzvkmpxlH7XdyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=aqvwX80A;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF39E606D803
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 13:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF39E606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=aqvwX80A
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53381e53b80so6452921cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 05:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793972223; x=1794577023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
        b=aqvwX80AjGRwxCjKMWgVXyvpVydMW0JPni4tQ1PkFnI19f65ijPwfSv4NDB/dmBLAZ
         sgkHMN75auCP6VUaaFF5xHO57tobC1BYLRCPYW443LRub/mtjmO7r6bSY0rrKVrQSjVA
         6BO0QajzfAHQeqYeSSh8oSaXRKi/qtKCk/3lsy31j2LdB12LgTHUGtj495OjmW6gDnNz
         SutGKU6FQtSDNsEMD243pp3zqskoVz/TO+aHkTsjCNMV8F7WTubCfQZxeYuf5Or67sEj
         NBFHxZs/R0O1jsRtTGMDD2LSo96v+AfmxnOZeJfklC7L0ydlA3DqXXam3GjdYzcx5YAE
         +IFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972223; x=1794577023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
        b=kBGXmQ29i8Y+aDRZH8nV4KIvZulThALLvxjhFxKoXXDGjHrgF2qeYE/sxEfHDefAfj
         JZeoAH56vJ+7WpHjpQ5zgpUTUG/eRlYEHiSt91DTxi7G2QD6qzvRyQdGcrJzLykhng2h
         ytSJcAozjJCLo7lgVdfdu7+lu9V+pL3Sm65+0TVBNu01LXfkW/MorsDUaBMWNtda//l/
         HUfZeaGJvDE3GeLkmEXogWXqQ7fYzQ2/73dBKPzW2Ow5HX3lVUZNSbcfeQtn3IDjvFEy
         GyYbO08Pc43tqi1V/K+zAA9TEn+1hEo2aCnb01onkYRfS3qVo1KuzAjl3sPntYyf4Afr
         HGtw==
X-Forwarded-Encrypted: i=1; AKwUvBxqNcBTUN+bxDCE7WuTGRc+QE2K6UrEi1wPKnZ0ZV3aPOh/nnHmmm5z0IRDuT3idMc7hlER81ySQunDsfHz@vger.kernel.org
X-Gm-Message-State: APuU4Z+EO4O9hI05ODjsdYv/AU80uwGwSpd/sq3CsgwhnBM6aSKVb5DZ
	Aiqd8isl1PQGH8KNV0c2MN4oCzgN+eC55XYKaeHNfE8kSrEDtTHIA6AP0mz5QF/6IKk=
X-Gm-Gg: AYBFou06FH7m7sws3s4oLshkS/QR+wft6pnYNId1iW2Xfqr721RQ/sxDlTdVx/pbLhn
	WqJVmWh/9UBl7CV1Vz3xtIZ66t8nsV3sT+6y8a/ZTq2CBbEj9frt4H4+y8UZGjNhtjR1lBtZO7e
	RrGbhv8tDnZMaJ+bAb+US/urR0wggCfyhQHLXXUF9RsawZOo4jJBhxG6DCyLtu2ECN76w6sbHDl
	2G58e01nx1vpNaniJFXDX8q4M+5gJ/UqOTta7sfo1wRysqPmpilJ1zbq0toFUrMhj11UqEyqjdU
	EsEuFt9emGZbpLU8WxaJq36bJVVzuCNo6CmDM2FD3UZ7vvVWrRb/JLZB+7tI6dEt86+XU+l8hYi
	n+5dGX5XhG1k+fzA8va5gzqCATqQrVQkyi0s3aOHLAp/la8H3dOmm2rxVu2hGMr+/b9M9ybugD3
	Vw44XfDZvBx43cGkkprw1EcFdqFOhGh56NxruFzkR3/6BDGoLgHtLIf4WCMIeaNiyqLckElXQ+1
	SyLKNz3e7W4SxY70yKTyBLB3r3x4K4l1CRBvuTgIvt95JpDR8gboAR5o/WYAqYC6IE6U5doqm/i
	gNJFqvvKRXRHp8CcAjfcm1l+90lWIqmrIXe+1uProjapxg==
X-Received: by 2002:a05:622b:1c6:10b0:535:a5fc:3b58 with SMTP id d75a77b69052e-54e15d687f9mr29797641cf.68.1793972222579;
        Fri, 06 Nov 2026 05:37:02 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c110sm20707636d6.7.2026.11.06.05.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:37:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 06 Nov 2026 13:36:44 +0000
Subject: [PATCH v4 2/8] ovl: setup overlayfs' private bdi
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
Message-Id: <20261106-b4-ovl-containerized-sync-v4-2-6ddde0b7dd8a@toxicpanda.com>
References: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
In-Reply-To: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793972217; l=1000;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=oigsy1vUIPeqGe01IWwnaOrpAKAk76udNuQNtC58Mj4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH2MMGJo3VtO/g4mpjtSeMtfHkOvY5p3MTJJt5D34LL2yuZaYjI4lVmv6voneKKUnxmg7ImbaT6
 mUv/1qHSlZgo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Setup overlayfs' private bdi so that we can collect
overlayfs' own dirty inodes.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
[josef: only for an overlay that tracks dirty inodes]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 81da70fd53a6..22a8d4eb3b7c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1490,6 +1490,16 @@ static int ovl_fill_super_creds(struct fs_context *fc, struct super_block *sb)
 		if (!ofs->workdir)
 			sb->s_flags |= SB_RDONLY;
 
+		/*
+		 * Dirty overlay inodes go on the lists of this bdi.  fsync_mode
+		 * is final once ovl_get_workdir() has returned.
+		 */
+		if (ovl_tracks_dirty(ofs)) {
+			err = super_setup_bdi(sb);
+			if (err)
+				return err;
+		}
+
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}

-- 
2.55.0

