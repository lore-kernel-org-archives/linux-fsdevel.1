Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541602F12AD
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777678069; cv=none; b=nbg3GEzjAl+qBcKO7DfU0He3upNR3zli3JTBXIwjAQoKPlWsSP+YBdz4QyI0goYKwofLJjHkPsSXIfckh4Adq/66MqIA3mmnk2IhMroVtYbhSGugwUC4HPFpRQGOa638EFt6x44++IDQU+AVIEs4e12dVglVe5xHPJHBqafcirs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777678069; c=relaxed/simple;
	bh=IzsHTZd6P6eYxd9Efo/a+pL4VeFLJKPvFGqGLptMSas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=btTY/A0zSE1nCDGqhLBjDcaCWNQrCJw8TOT0fXgOBdkvlqoTeJHley+7FEv2L1BBA0Z1aPRAtFnrBlIzr4aqkDtbnSFR0smgZ8CsqUzAXhRWG0Gd79P7eXd8QlcELH2Sk6d2u58uSxl8HDRWQmqyZEWpti39cJDBPrnk007rH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com; spf=pass smtp.mailfrom=amlalabs.com; dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b=a5rLOY7H; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlalabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlalabs-com.20251104.gappssmtp.com header.i=@amlalabs-com.20251104.gappssmtp.com header.b="a5rLOY7H"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso374546d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 16:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amlalabs-com.20251104.gappssmtp.com; s=20251104; t=1777678067; x=1778282867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PIMoo2xEXf7dASzi8yK3wgyb6uWnPH179QZ1IGul6o0=;
        b=a5rLOY7HOyhrAzO/IcTwgTXnfYNKbOHSJHVEwCg7pLMv16Ta78Ore9X4ROM6qd/XAB
         bJeQW21ljJAWVs1ALYJZ+Q14T2ERUiiyRKWmNnY1xv1Jw59RJkvraYM15mXIQPZeSDDJ
         9SYUHeuQQetbvww8XuoBMBIpsWNvYtV8XHdBDByzDCpykLRDqK60tyO0yF1o87eZJaYo
         5eKeUz0BTaxi/Irs/xnjzE3MP9MuV5oHPSYc4ZmLReW2joVYvLJ4zmJwtKvfKSiQn224
         oxA3oejr3qmPR5eUf9qe7FS4kXCmDV5MJnOgd6qSjZRxPxxi+46SYj2K0EpOUBPHNbF/
         NqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777678067; x=1778282867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PIMoo2xEXf7dASzi8yK3wgyb6uWnPH179QZ1IGul6o0=;
        b=VBd7v8ksMOG3X7TlIQBGa3AQh2l5qpicQfWkUpN+jJSbLuHQqie3pdCIpJIUn/uF2O
         QKqn38uADRN70Qyq9vrIghbDXWS9Ku0x001nMHDla+cNG8Cx5z3rdtCprlKPaP7b6A90
         IRYEZSia5NPklfBTmPXbrRBaSbTit3LxRxM6cIFaZA0sD7y2mfbmzMZfQpoLXZKYRvrT
         zKf4MI+hBtnRTOxdmy4Z8Mquwr2vJO/8jjAY0AdIna4uFXWGh1MvWrfpT5ohi1YOqI8b
         TE8K2Qf/wVkOgeNL2H7Yx+n9ClrWRhExSKTOaJhZ+HQIhqY0aqd5uMA3jCD567DwVhaG
         WYLA==
X-Forwarded-Encrypted: i=1; AFNElJ8MVgUwciv0l+HtWLHK66Vfu76gziDCOL1hK69emIrYnrZsyVcQ3BNCsUR9DqvC3PtHNuHdpBtUhntQmMEt@vger.kernel.org
X-Gm-Message-State: AOJu0YzDwBqvOeYkUUyeR5LhsJNoe8yjMM+Ty4No0xq4CmX1TSK+DrYD
	TAZ9ujVpzKTQ8bHqAkqJ6E1kcmyRUjB4janevJHWUY4mHx81XHUxRCCDfdhu4XHSb6rXfxeTq0L
	2I9IBjjYC/WEZN8jy/pcuH7+UvR2LUjc8qjP0BBk=
X-Gm-Gg: AeBDiesoXReqv2FNlQA4mxiioxhbtTroVoXjhyLJqJEna6Ht/MUisV/G9XIfU3ODddy
	naRc7QF/umQHRzl8cWOej4lw9aKSts3ld9/ZxEQb/Tc8MM7jZenCUDFdjnqmB9Avhj5sy6w5sc3
	sz8GA4n9TPUotqtDJhoEcy7vpzIr78PwOglOlI8HAx71PTpaq8B/dimBvFWAM0bxuuyuWB4tmPT
	fq6rdFTEnkMzyqVKdKfitNrXaBy3Nlf2DQJghdgZ4f0G632ibwCHmQQ3QFNzCU/3W/wjI9nmGhE
	hOArz36vlR72XOAyRRnjAf0rf+5Mxu8qzm23mdjVf04CTW0SeALtrEsBBMbQ/4v/34pis9SD9BS
	NA/lKUU7k295D/eOToXR0mewn2qQxotUEaC5C+NWt2RzAaJ4K4GOQZoLlRF6KRVyWv1CwDyMoZp
	jUJdy/MFGP
X-Received: by 2002:a0c:e001:0:b0:89c:d50e:b57 with SMTP id 6a1803df08f44-8b6665f1489mr23648016d6.15.1777678067303;
        Fri, 01 May 2026 16:27:47 -0700 (PDT)
Received: from amlalabs.com (104-10-255-95.lightspeed.sntcca.sbcglobal.net. [104.10.255.95])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b53b918281sm3200306d6.19.2026.05.01.16.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:27:47 -0700 (PDT)
X-Relaying-Domain: amlalabs.com
From: Souvik Banerjee <souvik@amlalabs.com>
To: miklos@szeredi.hu,
	amir73il@gmail.com
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Souvik Banerjee <souvik@amlalabs.com>
Subject: [PATCH] ovl: use linked upper dentry in copy-up tmpfile
Date: Fri,  1 May 2026 23:27:35 +0000
Message-ID: <20260501232735.2610824-1-souvik@amlalabs.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ovl_copy_up_tmpfile() stores the disconnected O_TMPFILE dentry as the
overlay's upper dentry reference via ovl_inode_update().  vfs_tmpfile()
allocated this dentry via d_alloc(parentpath->dentry, &slash_name), so
d_name is "/" and d_parent is c->workdir.  Local upper filesystems
(ext4, btrfs, xfs, ...) immediately rename it to "#<inum>" via
d_mark_tmpfile() inside their ->tmpfile() op; FUSE and virtiofs do
not, so both fields stay that way.  Neither identifies the destination
directory and filename where ovl_do_link() actually linked the file.

When the upper filesystem implements ->d_revalidate() (e.g. FUSE or
virtiofs), ovl_revalidate_real() calls it with the dentry's parent
inode and a snapshot of d_name.  The server tries to look up "/" inside
c->workdir, fails, and overlayfs reports -ESTALE.

This causes persistent ESTALE errors for any file that was copied up via
the tmpfile path, breaking dpkg, apt, and other tools that do
rename-over-existing on overlayfs with a FUSE/virtiofs upper.

Before commit 6b52243f633e ("ovl: fold copy-up helpers into callers"),
the tmpfile copy-up path used a dedicated helper ovl_link_tmpfile()
that captured the linked destination dentry returned by ovl_do_link():

    err = ovl_do_link(temp, udir, upper);
    ...
    if (!err)
        *newdentry = dget(upper);

and published it via ovl_inode_update(d_inode(c->dentry), newdentry).
The fold inlined ovl_do_link() into ovl_copy_up_tmpfile() but dropped
the dget(upper) capture, and rewrote the publish line as
ovl_inode_update(d_inode(c->dentry), dget(temp)) — where temp is the
disconnected O_TMPFILE dentry.

Fix by keeping a reference to the linked destination dentry after
ovl_do_link() succeeds, and publishing that dentry at the existing
ovl_inode_update() call site.  The non-tmpfile/workdir path continues to
publish the renamed temporary dentry.

Reproducer:
  - Mount overlayfs with virtiofs (or a FUSE fs whose server advertises
    FUSE_TMPFILE) as upper
  - Run: dpkg -i <any .deb>
  - Observe: "error installing new file '...': Stale file handle"

Fixes: 6b52243f633e ("ovl: fold copy-up helpers into callers")
Cc: stable@vger.kernel.org # v4.20+
Signed-off-by: Souvik Banerjee <souvik@amlalabs.com>
---
 fs/overlayfs/copy_up.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 13cb60b52bd6..e963701b4c87 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -853,7 +853,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 {
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
 	struct inode *udir = d_inode(c->destdir);
-	struct dentry *temp, *upper;
+	struct dentry *temp, *upper, *newdentry = NULL;
 	struct file *tmpfile;
 	int err;
 
@@ -889,6 +889,14 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 	err = PTR_ERR(upper);
 	if (!IS_ERR(upper)) {
 		err = ovl_do_link(ofs, temp, udir, upper);
+		if (!err) {
+			/*
+			 * Record the linked dentry -- not the disconnected
+			 * O_TMPFILE dentry -- so that ->d_revalidate() on
+			 * the upper fs sees the real parent/name.
+			 */
+			newdentry = dget(upper);
+		}
 		end_creating(upper);
 	}
 
@@ -903,7 +911,7 @@ static int ovl_copy_up_tmpfile(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(d_inode(c->dentry));
-	ovl_inode_update(d_inode(c->dentry), dget(temp));
+	ovl_inode_update(d_inode(c->dentry), newdentry);
 
 out:
 	ovl_end_write(c->dentry);
-- 
2.51.1

