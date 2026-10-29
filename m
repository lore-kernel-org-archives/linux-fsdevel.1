Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297398;
	b=M5Nb5iPXiX4uyHJOWMcyqseZxMaT4Rgmcht+gWSXvfocV8GMLJVPqyucll0l0xELdNMM
	 HYRqx8SfVrEiuZjWK8iqthe6j46zPpoVxdxSfxaYEevziHioKxjNTnHzwv68e0BdbiIx1
	 I2mhRR6hGY9U3Ha29hyNZXspyGyO1LHnQYg/V5yhPUW2LIe66S/7IOpFW7lYxGG8nmNWF
	 LB1u0SEl8p+chzQHtIC0XM4+uk5zskrwEGD+RuWySfy9NfH8Q/2/WPcsiiGN5NC7dcfa4
	 An94ZfnmCRKXPMiL0LxD0nbdo9yL/awPoGeqiXQfuvpDSrE0Zvb3CxmUC/6blf6uGKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tclfs7aD3HY8sdJ8tHxJTjAtxyWD0r4lW0/t3QIDAMY=;
	b=X5utCon9GErHfOpQBNk9yJxSyGDvhsNWWM01U9FP6T6OxU10xGJEhb16Tv8Ycse4TIry
	 AJBS+7KWuBxmxxm2hm/j25XvZK191gflnWCzCUlF31AfmxOdZSLQyIhjmLEPpn+Vv+cxY
	 4rFSWFLakgdn68FLig0CeelEn1YYlgh/sz/bipD0b41Yrd+TX7G0hTNESXRt1+hYRoRZ4
	 l+3KeitELCAclgdZlP4mJMP2cTWQZfX8X1TK8rdHbSYThQg54Iihgl6TknCpId5HS3/QS
	 +HXC55ifDdncAZNdxmF2v5SZ7IawLsO1tI4NoP3Rr1LBJLUjmB2KUlH4dFVI6AcXrZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hammerspace.com;
	spf=pass smtp.mailfrom=hammerspace.com;
	dkim=pass header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=iGAHWovN;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16734606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16734606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hammerspace.com header.i=@hammerspace.com header.a=rsa-sha256 header.s=google header.b=iGAHWovN
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a76f0cce5fso1147527fac.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1793297397; x=1793902197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tclfs7aD3HY8sdJ8tHxJTjAtxyWD0r4lW0/t3QIDAMY=;
        b=iGAHWovNn+2sl5tWkYDb3lBYha2/5k8TCtKLtHJN2u1k/jldX2OFob4nAPvgmD2VAu
         N96sInjfr8T3ID0IaZR16V3T8q1OGGjLLZOdbuzNO+rX/IdQpwV/rH8hKHkeoQL62g9B
         KeWA53otKa/Kqabpc1ogImK7X5TakagT34dzJ3p2guC1FGiRQMfNqGg7wtN/qHhlUzCg
         Wv3NLLX2osAAq8FfMLYLLbzwhGUJs6CxhDVObsqpnqRO/fiRXGVqQW2Nfq1gokZkco8Z
         YNMV6O6tJdnvFC0RZzK5pyT26YootDsyWQ6GLClpA5VJOqY2fmgCtsLB+S3j5++cbqLZ
         nM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297397; x=1793902197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tclfs7aD3HY8sdJ8tHxJTjAtxyWD0r4lW0/t3QIDAMY=;
        b=wZTvOWVH9QtScdAUXt7rdOZxo8A1nJ60MdixFHrkySdxbmzPt3gClaUtrdwMU9mn/3
         RfCBmd6jWO2MIC8AohKMVe3M2iRORYTu509EsESmGgoEN47IzwsJMb/irrlJRXGS/Twi
         s3ULxj2ugjU29lzDaU5pDfIqopyR/iSKq6SCdCaATCPqzOUyYF7sJRMR57s6fiJFPebG
         fjWmcb0/2kF3buBtmDqhlRJsY174Xq5QlSVGn+ff8h6xSl0V69OMBg7RrAjFd+MjMfvN
         uj4ZWoz3cGtGEwUeGQy4QtKY5YZJ9u/O10gK9vT1y4CgfPC3IqXTiD4yyR09yeuGNnDm
         HGDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwzio325/Yt9Ru9sxQT8hkjCJsM2ab6/FGETB2ojRzm8BGW4+KGfGWQgb5K9pMuAUbaebaobROz8egkbM1b@vger.kernel.org
X-Gm-Message-State: AFq9FYIA6MOfR5uzlK2qImJbJEJhhXKOXuck7Lwu/ouuF6qWiswotcbe
	mL+yfsWaboRNsqt0LzjOOE1BaiTebnJgnAfYLn1yrztCLYml94eiguGsXUUjNeB0kBc=
X-Gm-Gg: AYBFou0oqKPrjEpYYG1GXEk6n6TufBH0TxBFzYCcIpbd21GfYew7ZDMot6tLak+ipEr
	rPDGZPT1GKhOAIiiDEq4Bh+YxGVHdgYPLxRECBba0h94sQtdRMetbrMJqyYQTIby0sca7rzzp4f
	Lm/gFDuDAkZJcwdPrmMieKNUakxxxDJ1RS54cmUl2uK2WJAAQxH/LsBCflCUxKojVSKdR5hd97f
	EbinhyEuTg0g3h5UCDuTMWYIDGHk0HWl3Jb4lEHpNCbGnLFroMHBRlVWgz5HFyl83hHxB6GVsiT
	jbARCQ5d/wt6PEdzoCo14FgJ/Sz4U1dmjPV5uOw5ceQNKs020aI06rg/3M+bsO0y4ssBnejZRf4
	v1ejMd7O9Mw6O947llFSY8SXzxceyednlJVPP6zF+BxaShbGRGmgGoXfMgnryA2nlWAENjojuI6
	8xWyLr7IElUgdKRhhm3C9phQCauFf21ZkO649zG8KJgDRXayORDF3+4sWGciColAT8NgXzUiZjK
	mlg9RIOQOJWknPihWpSL79zR9nbQo3Y10cJYI0W7WRTo4+dwCtMzup8TCWZY4LfTaY43uDwT2ww
	6nsMU3Tzo0mMEME+zTptNicQurGlRTJFS2zc2dMkuotmto5uzwdIBqr1+mNKeeuuUER/DYWBY68
	02Ugj84IW8wfM3jocvw==
X-Received: by 2002:a05:6870:b3ef:b0:4a6:9418:da4e with SMTP id 586e51a60fabf-4a8bb62e010mr4771690fac.60.1793297396745;
        Thu, 29 Oct 2026 11:09:56 -0700 (PDT)
Received: from localhost (75-163-200-235.clsp.qwest.net. [75.163.200.235])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a904971f2esm110314fac.11.2026.10.29.11.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:09:56 -0700 (PDT)
From: Jonathan Flynn <jonathan.flynn@hammerspace.com>
To: NeilBrown <neil@brown.name>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nfs: take rmdir_sem for a silly-delete only when its REMOVE is sent
Date: Thu, 29 Oct 2026 12:09:50 -0600
Message-ID: <20261029180950.387072-4-jonathan.flynn@hammerspace.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029180950.387072-1-jonathan.flynn@hammerspace.com>
References: <20261028041023.3738553-3-neilb@ownmail.net>
 <20261029180950.387072-1-jonathan.flynn@hammerspace.com>
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

nfs_call_unlink() takes the directory's rmdir_sem for read before it
looks the silly name up, and keeps it until the REMOVE it sends is done
or, when it hands the silly-delete to another cached entry for the name
instead, until it has dropped that alias.  Several things inside that
hold can drop the last reference to a dentry marked DCACHE_NFSFS_RENAMED:
the dput() of an alias that has just been handed the silly-delete; the
dput()s in d_alloc_parallel() of an entry it found but will not return,
after a failed ->d_seq recheck or after waiting for an in-lookup entry
that changed; and ->unlink_setup(), where NFSv4 returns the file's
delegation, putting the open contexts it reclaims and waiting for
writeback whose completion can put others.  Such a dentry is killed at
once: nfs_dentry_delete() asks for that, and nfs_dentry_iput() passes
it to nfs_complete_unlink(), which calls nfs_call_unlink() again, in
this thread or in the one completing the writeback.  That call takes
rmdir_sem for read while the first hold is still taken.  If an rmdir()
of the directory is waiting for rmdir_sem as a writer by then, the
second reader waits behind it, the writer waits for the first reader,
and none of them returns.

Take rmdir_sem only when the REMOVE is about to be submitted, after
->unlink_setup(), and hold it until the REMOVE is done, as before.  The
hand-off sends no REMOVE and needs no hold; the alias sends it later,
through a call of its own.  An rmdir() that runs before the hold is
taken finds the silly-renamed file still there, as it would have a
moment earlier.

The ->unlink_setup() route does not depend on NeilBrown's "nfs: fix
nfs_call_unlink()": it needs a second silly-renamed name of the same
inode in the same directory, such as a hard link removed while open,
and a delegation still held when the silly-delete is sent.  That patch
makes the other two reachable, along with the hand-off itself.  With it
applied, the re-entry through the alias has been reproduced: an unused
second entry for a silly name received the delete when the file was
closed, and nfs_call_unlink() ran again with rmdir_sem held for read.
The deadlock needs a waiting rmdir() and has not been reproduced.
Sashiko's review of that patch reported the alias case; an AI coding
assistant (Claude Code) found the other two while reviewing this fix.

Fixes: 884be175351e ("nfs: per-name sillyunlink exclusion")
Signed-off-by: Jonathan Flynn <jonathan.flynn@hammerspace.com>
---
 fs/nfs/unlink.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 491ebd8582..679ef22637 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -113,6 +113,19 @@ static void nfs_do_call_unlink(struct inode *inode, struct nfs_unlinkdata *data)
 
 	NFS_PROTO(dir)->unlink_setup(&msg, data->dentry, inode);
 
+	/*
+	 * Hold off an rmdir() of the directory from here until the REMOVE
+	 * is done (nfs_async_unlink_release()), and not before.  Until the
+	 * REMOVE is submitted, the lookup in nfs_call_unlink(), its dput()
+	 * of an alias, and ->unlink_setup() (where NFSv4 returns the
+	 * file's delegation, putting open contexts and waiting for
+	 * writeback) can each drop the last reference to a dentry carrying
+	 * a silly-delete.  Its kill calls nfs_call_unlink() again, in this
+	 * thread or in one this thread waits for, and if rmdir_sem were
+	 * held here by then, that call's read hold would wait behind an
+	 * rmdir() waiting for this one.
+	 */
+	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
 	task_setup_data.rpc_client = NFS_CLIENT(dir);
 	task = rpc_run_task(&task_setup_data);
 	if (!IS_ERR(task))
@@ -121,18 +134,14 @@ static void nfs_do_call_unlink(struct inode *inode, struct nfs_unlinkdata *data)
 
 static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nfs_unlinkdata *data)
 {
-	struct inode *dir = d_inode(dentry->d_parent);
 	struct dentry *alias;
 
-	down_read_non_owner(&NFS_I(dir)->rmdir_sem);
 	data->args.name.hash = full_name_hash(dentry->d_parent,
 					      data->args.name.name,
 					      data->args.name.len);
 	alias = d_alloc_parallel(dentry->d_parent, &data->args.name);
-	if (IS_ERR(alias)) {
-		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
+	if (IS_ERR(alias))
 		return 0;
-	}
 	if (!d_in_lookup(alias)) {
 		int ret;
 		void *devname_garbage = NULL;
@@ -170,7 +179,6 @@ static int nfs_call_unlink(struct dentry *dentry, struct inode *inode, struct nf
 			ret = 0;
 		spin_unlock(&alias->d_lock);
 		dput(alias);
-		up_read_non_owner(&NFS_I(dir)->rmdir_sem);
 		/*
 		 * If we'd displaced old cached devname, free it.  At that
 		 * point dentry is definitely not a root, so we won't need
-- 
2.43.0

